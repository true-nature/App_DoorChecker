/****************************************************************************
 * (C) Tokyo Cosmos Electric, Inc. (TOCOS) - 2013 all rights reserved.
 *
 * Condition to use:
 *   - The full or part of source code is limited to use for TWE (TOCOS
 *     Wireless Engine) as compiled and flash programmed.
 *   - The full or part of source code is prohibited to distribute without
 *     permission from TOCOS.
 *
 ****************************************************************************/

/****************************************************************************/
/***        Include files                                                 ***/
/****************************************************************************/
#include <string.h>

#include <jendefs.h>
#include <AppHardwareApi.h>

#include "AppQueueApi_ToCoNet.h"

#include "config.h"
#include "ccitt8.h"
#include "Interrupt.h"

#include "EndDevice_Remote.h"
#include "Version.h"

#include "utils.h"
#include "flash.h"

#include "common.h"
#include "AddrKeyAry.h"

#include "SMBus.h"

#define USE_I2C_LCD
#ifdef USE_I2C_LCD
#include "I2C_impl.h"
#endif

#define USE_ATP301x
#ifdef USE_ATP301x
#include "atp301x.h"
#endif

// Serial options
#include "serial.h"
#include "fprintf.h"
#include "sprintf.h"

#include "Interactive.h"
#include "sercmd_gen.h"

#ifdef USE_LCD
#include "LcdDriver.h"
#include "LcdDraw.h"
#include "LcdPrint.h"
#endif

/****************************************************************************/
/***        ToCoNet Definitions                                           ***/
/****************************************************************************/
// Select Modules (define befor include "ToCoNet.h")
#define ToCoNet_USE_MOD_NWK_LAYERTREE
#define ToCoNet_USE_MOD_NBSCAN // Neighbour scan module
#define ToCoNet_USE_MOD_CHANNEL_MGR
#define ToCoNet_USE_MOD_NWK_MESSAGE_POOL

// includes
#include "ToCoNet.h"
#include "ToCoNet_mod_prototype.h"

#include "app_event.h"

/****************************************************************************/
/***        Macro Definitions                                             ***/
/****************************************************************************/
#define PWM_IDX_POWER_ALERT 0
#define PWM_IDX_DOOR_ALERT 1
#define PWM_IDX_COMM_ALERT 3



#define LCD_COLUMNS 8	// AQM0802A
#define VOLT_LOW 2400

#ifdef USE_LCD
#define V_PRINTF_LCD(...) vfPrintf(&sLcdStream, __VA_ARGS__)
#define V_PRINTF_LCD_BTM(...) vfPrintf(&sLcdStreamBtm, __VA_ARGS__)
#endif

#define TOCONET_DEBUG_LEVEL 5

/**
 * メッセージプールの複数スロットのテストを行うコードを有効化する。
 * - 起動ごとにスロット番号を１ずつ上げてアクセスします。
 */
#undef MSGPL_SLOT_TEST

/**
 * スリープせずに動作させる
 */
#undef NO_SLEEP

/****************************************************************************/
/***        Type Definitions                                              ***/
/****************************************************************************/

/****************************************************************************/
/***        Local Function Prototypes                                     ***/
/****************************************************************************/
//
static void vProcessEvCore(tsEvent *pEv, teEvent eEvent, uint32 u32evarg);
static void vInitHardware(int f_warm_start);

static void vSerialInit();
void vSerInitMessage();
void vProcessSerialCmd(tsSerCmd_Context *pCmd);
static bool_t vDisplayMessageData(uint8 *pMessageData);

#ifdef USE_LCD
static void vLcdInit(void);
static void vLcdRefresh(void);
#endif

/****************************************************************************/
/***        Exported Variables                                            ***/
/****************************************************************************/
/****************************************************************************/
/***        Local Variables                                               ***/
/****************************************************************************/
// Local data used by the tag during operation
tsAppData_Re sAppData;

PUBLIC tsFILE sSerStream;
tsSerialPortSetup sSerPort;
//tsSerCmd sSerCmd; // serial command parser

// Timer object
tsTimerContext sTimerApp;
tsTimerContext sTimerPWM[4]; //!< タイマー管理構造体(PWM)
/**
 * MessagePool送信用
 * 3bytes/子機 [id][DI bitmap][volt] vold==0なら子機音信不通
 * id==0または配列末尾で終端
 */
uint8 su8MessagePoolData[TOCONET_MOD_MESSAGE_POOL_MAX_MESSAGE + 1];
/**
 * MessagePool受信に失敗した場合に使用するダミーデータ
 */
const uint8 su8MessageIfReceiveFailed[] = {0x00, 0x00, 0x00, 0xFF, 0xFF};

uint8 sLcdBuffer[2][LCD_COLUMNS + 1];

// ATP3011に送るメッセージ
static uint8 *pAtpMessages[3];
static uint8 su8AtpMsg[2][128];

#ifdef USE_LCD
static tsFILE sLcdStream, sLcdStreamBtm;
#endif

/****************************************************************************/
/***        FUNCTIONS                                                     ***/
/****************************************************************************/

static void vBlinkLeds(teEvent eEvent)
{
	static uint16 u16dutyWarn;
	static bool_t bBlinkPositive;
	if (eEvent == E_EVENT_NEW_STATE) {
		u16dutyWarn = 0;
		bBlinkPositive = TRUE;
	}
	// 電源警告(PWM1) 正常時は常時点灯
	sTimerPWM[PWM_IDX_POWER_ALERT].u16duty = (sAppData.sDoorState.u32LowBattMap ? 1024 - u16dutyWarn : 0);
	vTimerConfig(&sTimerPWM[PWM_IDX_POWER_ALERT]);
	vTimerStart(&sTimerPWM[PWM_IDX_POWER_ALERT]);
	// 窓空き警告(PWM2) 正常時は消灯
	sTimerPWM[PWM_IDX_DOOR_ALERT].u16duty = (sAppData.sDoorState.u32OpenedMap ? u16dutyWarn : 1024);
	vTimerConfig(&sTimerPWM[PWM_IDX_DOOR_ALERT]);
	vTimerStart(&sTimerPWM[PWM_IDX_DOOR_ALERT]);
	// 通信警告(PWM4) 正常時は消灯
	sTimerPWM[PWM_IDX_COMM_ALERT].u16duty = (sAppData.sDoorState.u32CommErrMap ? u16dutyWarn : 1024);
	vTimerConfig(&sTimerPWM[PWM_IDX_COMM_ALERT]);
	vTimerStart(&sTimerPWM[PWM_IDX_COMM_ALERT]);

	if (bBlinkPositive) {
		u16dutyWarn += 16;
		bBlinkPositive = (u16dutyWarn < 1024);
	} else {
		u16dutyWarn -= 16;
		bBlinkPositive = !(u16dutyWarn >= 16);
	}
}

/****************************************************************************
 *
 * NAME: vProcessEvent
 *
 * DESCRIPTION:
 *   The Application Main State Machine.
 *
 * RETURNS:
 *
 ****************************************************************************/
//
static void vProcessEvCore(tsEvent *pEv, teEvent eEvent, uint32 u32evarg) {
	static uint8 u8SpeakPtr;
	static uint32 u32LastBusyInq;
	switch (pEv->eState) {

	/*
	 * 起動時の状態
	 *   ToCoNetの接続を行う。
	 *   - スリープ復帰時は直前のアドレスに対して復帰をかける。失敗した場合は再探索を行う。
	 */
	case E_STATE_IDLE:
		// start up message
		V_PRINTF(LB "*** ToCoSamp IO Monitor %d.%02d-%d %s ***", VERSION_MAIN, VERSION_SUB, VERSION_VAR, sAppData.bWakeupByButton ? "BTN" : "OTR");
		V_PRINTF(LB "* App ID:%08x Long Addr:%08x Short Addr %04x",
				sToCoNet_AppContext.u32AppId, ToCoNet_u32GetSerial(), sToCoNet_AppContext.u16ShortAddress);

		SERIAL_vFlush(UART_PORT);

		if (eEvent == E_EVENT_START_UP) {
			// リセット解除
			vPortSetHi(DIO_SPEAK_RESET);
			// I2Cバス初期化
			vSMBusInit();
#ifdef USE_I2C_LCD
			bInit2LinesLcd_AQM0802A();
#endif
			if (IS_APPCONF_OPT_SECURE()) {
				bool_t bRes = bRegAesKey(sAppData.sFlash.sData.u32EncKey);
				V_PRINTF(LB "*** Register AES key (%d) ***", bRes);
			}
			// MessagePoolを通信前状態に初期化
			memcpy(su8MessagePoolData, su8MessageIfReceiveFailed, sizeof(su8MessageIfReceiveFailed));
#ifdef USE_LCD
			vLcdInit(); // register sLcd

			// 最下行を表示する
			V_PRINTF_LCD_BTM("*** ToCoSamp IO Monitor %d.%02d-%d ***", VERSION_MAIN, VERSION_SUB, VERSION_VAR);
			vLcdRefresh();
#endif
		}

		if (eEvent == E_EVENT_START_UP && (u32evarg & EVARG_START_UP_WAKEUP_RAMHOLD_MASK)) {
			V_PRINTF(LB "* Warm starting woke by %s.", sAppData.bWakeupByButton ? "DIO" : "WakeTimer");

			/*
			 * 接続復帰（スリープ後）
			 */
			sAppData.eLedState = E_LED_WAIT;

			ToCoNet_Nwk_bResume(sAppData.pContextNwk); // ネットワークの復元

			ToCoNet_Event_SetState(pEv, E_STATE_APP_WAIT_NW_START);

		} else
		if (eEvent == E_EVENT_START_UP) {
			V_PRINTF(LB "* start end device[%d]", u32TickCount_ms & 0xFFFF);

			/*
			 * ネットワークの接続
			 */
			sAppData.sNwkLayerTreeConfig.u8Role = TOCONET_NWK_ROLE_ENDDEVICE; // EndDevice として構成する
			sAppData.sNwkLayerTreeConfig.u8ScanDur_10ms = 4; // 探索時間(中継機の数が数個程度なら 40ms 程度で十分)

			sAppData.pContextNwk = ToCoNet_NwkLyTr_psConfig(&sAppData.sNwkLayerTreeConfig); // 設定
			if (sAppData.pContextNwk) {
				ToCoNet_Nwk_bInit(sAppData.pContextNwk); // ネットワーク初期化
				ToCoNet_Nwk_bStart(sAppData.pContextNwk); // ネットワーク開始
			}

			sAppData.eLedState = E_LED_WAIT;
			ToCoNet_Event_SetState(pEv, E_STATE_APP_WAIT_NW_START);

			break;
		}

		break;

	/*
	 * ネットワークの開始待ち
	 */
	case E_STATE_APP_WAIT_NW_START:
		if (eEvent == E_EVENT_TOCONET_NWK_START) {
			ToCoNet_Event_SetState(pEv, E_STATE_RUNNING);
		}
		if (ToCoNet_Event_u32TickFrNewState(pEv) > 500) {
			// 開始タイムアウト
			ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
		}
		break;

	/*
	 * 実行時の状態
	 *   - ネットワーク開始後、メッセージプール要求を行う
	 *   - ネットワークがエラーになったり、タイムアウトが発生した場合はエラー状態とし、
	 *     再びスリープする
	 */
	case E_STATE_RUNNING:
		if (eEvent == E_EVENT_NEW_STATE) {
			// ネットワーク開始
			V_PRINTF(LB"[NWK STARTED and REQUEST IO STATE:%d]", u32TickCount_ms & 0xFFFF);
			static uint8 u8Ct;
#ifdef MSGPL_SLOT_TEST
			// メッセージプールの複数スロットのテストを行う
			// 起動ごとにスロット番号を変更して取得する
			u8Ct++;
#else
			u8Ct = 0;
#endif
			// メッセージプールの要求
			if (ToCoNet_MsgPl_bRequest(u8Ct % TOCONET_MOD_MESSAGE_POOL_MAX_ENTITY)) {
				ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_WAIT_RX);
			} else {
				ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
			}
		} else
		if (eEvent == E_EVENT_TOCONET_NWK_DISCONNECT) {
			ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
		} else {
			if (ToCoNet_Event_u32TickFrNewState(pEv) > ENDD_TIMEOUT_CONNECT_ms) {
				ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
			}
		}
		break;

	/*
	 * メッセージプールからの伝達待ち。
	 * - メッセージプールは cbToCoNet_vNwkEvent() に通知され、
	 *   その関数中でE_EVENT_APP_GET_IC_INFOイベントを発行する。
	 */
	case E_STATE_APP_IO_WAIT_RX:
		if (eEvent == E_EVENT_NEW_STATE) {
			V_PRINTF(LB"[E_STATE_APP_IO_WAIT_RX:%d]", u32TickCount_ms & 0xFFFF);
		} if (eEvent == E_EVENT_APP_GET_IC_INFO) {
			// メッセージが届いた
			if (u32evarg) {
				V_PRINTF(LB"[E_STATE_APP_IO_WAIT_RX:GOTDATA:%d]", u32TickCount_ms & 0xFFFF);
				ToCoNet_Event_SetState(pEv, E_STATE_APP_WAIT_DISPLAY);
			} else {
				ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
			}
		} else {
			// タイムアウト
			if (ToCoNet_Event_u32TickFrNewState(pEv) > ENDD_TIMEOUT_WAIT_MSG_ms) {
				V_PRINTF(LB"[E_STATE_APP_IO_WAIT_RX:TIMEOUT:%d]", u32TickCount_ms & 0xFFFF);
				ToCoNet_Event_SetState(pEv, E_STATE_APP_IO_RECV_ERROR);
			}
		}
		break;

	case E_STATE_APP_IO_RECV_ERROR:
	case E_STATE_APP_WAIT_DISPLAY:
		if (pEv->eState == E_STATE_APP_WAIT_DISPLAY) {
			V_PRINTF(LB"[E_STATE_APP_WAIT_DISPLAY:%d]", u32TickCount_ms & 0xFFFF);
			sAppData.eLedState = E_LED_RESULT;
		} else {
			V_PRINTF(LB"[E_STATE_APP_IO_RECV_ERROR:%d]", u32TickCount_ms & 0xFFFF);
			sAppData.eLedState = E_LED_ERROR;
		}
		// LCDの表示変更。
		vDisplayMessageData(su8MessagePoolData);
		// 状態に応じてLED点滅
		vBlinkLeds(eEvent);
		// 音声合成で状態通知。
		bAtpPrepareMessage(&sAppData.sDoorState, pAtpMessages[0], pAtpMessages[1]);
		u8SpeakPtr = 0;
		ToCoNet_Event_SetState(pEv, E_STATE_APP_WAIT_SPEAK);
		break;
	case E_STATE_APP_WAIT_SPEAK:
		if (eEvent == E_EVENT_NEW_STATE) {
			V_PRINTF(LB"[E_STATE_APP_WAIT_SPEAK:%d]", u32TickCount_ms & 0xFFFF);
		}
		else if (eEvent == E_EVENT_TICK_TIMER) {
			// 状態に応じてLED点滅
			vBlinkLeds(eEvent);
			if ((u32TickCount_ms - u32LastBusyInq) >= 128) {
				// ATP301xへのポーリング間隔は10ms以上
				u32LastBusyInq = u32TickCount_ms;
				if (!bIsAtpBusy()) {
					if (pAtpMessages[u8SpeakPtr] != NULL && pAtpMessages[u8SpeakPtr][0] != '\0') {
						// ToDo: 電源ONから80ms以上経過している必要がある。
						bAtpSpeak(pAtpMessages[u8SpeakPtr]);
						u8SpeakPtr++;
					} else if (ToCoNet_Event_u32TickFrNewState(pEv) > ENDD_LED_DISP_DUR_ms) {
						ToCoNet_Event_SetState(pEv, E_STATE_APP_SLEEP);
					}
				}
			}
		}
		break;
	/*
	 * 送信完了の処理
	 * - スリープ実行
	 */
	case E_STATE_APP_SLEEP:
		if (eEvent == E_EVENT_NEW_STATE) {
			V_PRINTF(LB"[E_STATE_APP_SLEEP:%d]", u32TickCount_ms & 0xFFFF);
			vPortSetHi(PORT_KIT_LED1);
			vPortSetHi(PORT_KIT_LED2);
#ifdef NO_SLEEP
			ToCoNet_Event_SetState(pEv, E_STATE_APP_PREUDO_SLEEP);
#else
			ToCoNet_Nwk_bPause(sAppData.pContextNwk);

			SERIAL_vFlush(UART_PORT);
			// PWM切り離し
			vAHI_TimerFineGrainDIOControl(0x7F);
			vPortSetHi(sTimerPWM[PWM_IDX_POWER_ALERT].u8Device);
			vPortSetHi(sTimerPWM[PWM_IDX_DOOR_ALERT].u8Device);
			vPortSetHi(sTimerPWM[PWM_IDX_COMM_ALERT].u8Device);

			// 表示デバイス用電源を停止
			vPortDisablePullup(DIO_DISP_POWER);
			vPortSetLo(DIO_DISP_POWER);

			vSleep(0, FALSE, FALSE);
#endif
		}
		break;

	case E_STATE_APP_PREUDO_SLEEP:
		// 指定時間スリープ相当の時間待ちを行う
		if (ToCoNet_Event_u32TickFrNewState(pEv) > ENDD_SLEEP_PERIOD_s * 1000UL) {
			ToCoNet_Event_SetState(pEv, E_STATE_RUNNING);
		}
		break;

	default:
		break;
	}
}


/**
 * 設定処理用の状態マシン（未使用）
 */
static void vProcessEvCoreConfig(tsEvent *pEv, teEvent eEvent, uint32 u32evarg) {
	switch (pEv->eState) {
		case E_STATE_IDLE:
			if (eEvent == E_EVENT_START_UP) {
				Interactive_vSetMode(TRUE, 0);
				vSerInitMessage();
				vfPrintf(&sSerStream, LB LB "*** Entering Config Mode ***");
				ToCoNet_Event_SetState(pEv, E_STATE_RUNNING);
			}
			break;

		case E_STATE_RUNNING:
			break;

		default:
			break;
	}
}


/****************************************************************************
 *
 * NAME: AppColdStart
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
PUBLIC void cbAppColdStart(bool_t bAfterAhiInit) {
	if (!bAfterAhiInit) {
		// before AHI initialization (very first of code)

		// check DIO source
		sAppData.bWakeupByButton = FALSE;
		if(u8AHI_WakeTimerFiredStatus()) {
		} else
    	if(u32AHI_DioWakeStatus() & u32DioPortWakeUp) {
			// woke up from DIO events
    		sAppData.bWakeupByButton = 1;
		}

		// Module Registration
		ToCoNet_REG_MOD_ALL();
	} else {
		// clear application context
		memset(&sAppData, 0x00, sizeof(sAppData));
		pAtpMessages[0] = su8AtpMsg[0];
		pAtpMessages[1] = su8AtpMsg[1];
		pAtpMessages[2] = NULL;;


		// SPRINTF
		SPRINTF_vInit128();

		// フラッシュメモリからの読み出し
		//   フラッシュからの読み込みが失敗した場合、ID=15 で設定する
		sAppData.bFlashLoaded = Config_bLoad(&sAppData.sFlash);

		// ToCoNet configuration
		sToCoNet_AppContext.u32AppId = sAppData.sFlash.sData.u32appid;
		sToCoNet_AppContext.u8Channel = sAppData.sFlash.sData.u8ch;
		sToCoNet_AppContext.u32ChMask = sAppData.sFlash.sData.u32chmask;

		sToCoNet_AppContext.u8TxMacRetry = 1;
		sToCoNet_AppContext.bRxOnIdle = TRUE;

		// Other Hardware
		vSerialInit();
		ToCoNet_vDebugInit(&sSerStream);
		ToCoNet_vDebugLevel(TOCONET_DEBUG_LEVEL);

		vInitHardware(FALSE);

		// event machine
		if (sAppData.bConfigMode) {
			ToCoNet_Event_Register_State_Machine(vProcessEvCoreConfig); // デバッグ用の動作マシン
		} else {
			ToCoNet_Event_Register_State_Machine(vProcessEvCore); // main state machine
		}
	}
}

/****************************************************************************
 *
 * NAME: AppWarmStart
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
PUBLIC void cbAppWarmStart(bool_t bAfterAhiInit) {
	if (!bAfterAhiInit) {
		// before AHI init, very first of code.
		//  to check interrupt source, etc.

		sAppData.bWakeupByButton = FALSE;
		if(u8AHI_WakeTimerFiredStatus()) {
		} else
		if(u32AHI_DioWakeStatus() & u32DioPortWakeUp) {
			// woke up from DIO events
			sAppData.bWakeupByButton = TRUE;
		}
	} else {
		// Other Hardware
		vSerialInit(TOCONET_DEBUG_LEVEL);
		ToCoNet_vDebugInit(&sSerStream);
		ToCoNet_vDebugLevel(TOCONET_DEBUG_LEVEL);

		vInitHardware(FALSE);

		if (!sAppData.bWakeupByButton) {
			// タイマーで起床した
		} else {
			// ボタンで起床した
		}

		// アプリケーション処理は vProcessEvCore で実行するので、ここでは
		// 処理は行っていない。
	}
}

/****************************************************************************/
/***        Local Functions                                               ***/
/****************************************************************************/
/****************************************************************************
 *
 * NAME: vMain
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
//
void cbToCoNet_vMain(void) {
	/* handle serial input */
	vHandleSerialInput();
}

/****************************************************************************
 *
 * NAME: cbvMcRxHandler
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
void cbToCoNet_vRxEvent(tsRxDataApp *pRx) {
	// uint8 *p = pRx->auData;
	return;
}

/****************************************************************************
 *
 * NAME: cbvMcEvTxHandler
 *
 * DESCRIPTION:
 *
 * PARAMETERS:      Name            RW  Usage
 *
 * RETURNS:
 *
 * NOTES:
 ****************************************************************************/
void cbToCoNet_vTxEvent(uint8 u8CbId, uint8 bStatus) {
	return;
}

/****************************************************************************
 *
 * NAME: cbToCoNet_vNwkEvent
 *
 * DESCRIPTION:
 *
 * PARAMETERS:      Name            RW  Usage
 *
 * RETURNS:
 *
 * NOTES:
 ****************************************************************************/
void cbToCoNet_vNwkEvent(teEvent eEvent, uint32 u32arg) {
	switch(eEvent) {
	/*
	 * ネットワークが開始された
	 */
	case E_EVENT_TOCONET_NWK_START:
		V_PRINTF(LB"[E_EVENT_TOCONET_NWK_START:%d,Ch:%d]", u32TickCount_ms & 0xFFFF, sToCoNet_AppContext.u8Channel);
		vDispInfo(&sSerStream, (void*)sAppData.pContextNwk);

		// pass this event to the event machine
		ToCoNet_Event_Process(E_EVENT_TOCONET_NWK_START, u32arg, vProcessEvCore);
		break;

	/*
	 * ネットワークが切断された
	 */
	case E_EVENT_TOCONET_NWK_DISCONNECT:
		V_PRINTF(LB"[E_EVENT_TOCONET_NWK_DISCONNECT]");

		// pass this event to the event machine
		ToCoNet_Event_Process(E_EVENT_TOCONET_NWK_DISCONNECT, u32arg, vProcessEvCore);
		break;

	/*
	 * メッセージプールを受信
	 */
	case E_EVENT_TOCONET_NWK_MESSAGE_POOL:
		if (u32arg) {
			tsToCoNet_MsgPl_Entity *pInfo = (void*)u32arg;
			int i;
			//static uint8 u8seq = 0;

			memcpy(su8MessagePoolData, pInfo->au8Message, pInfo->u8MessageLen); // u8Message にデータ u8MessageLen にデータ長
			su8MessagePoolData[pInfo->u8MessageLen] = 0;

			// UART にメッセージ出力
			if (pInfo->bGotData) { // empty なら FALSE になる
				V_PRINTF(LB"---MSGPOOL sl=%d ln=%d msg=",
						pInfo->u8Slot,
						pInfo->u8MessageLen
						);

				SPRINTF_vRewind();
				for (i = 0; i < pInfo->u8MessageLen; i++) {
					vfPrintf(SPRINTF_Stream, "%02X", su8MessagePoolData[i]);
				}
				V_PRINTF("%s", SPRINTF_pu8GetBuff());

#ifdef USE_LCD
				V_PRINTF_LCD("%02x:%s\r\n", u8seq++, SPRINTF_pu8GetBuff());
				vLcdRefresh();
#endif

				V_PRINTF("---");
			} else {
				V_PRINTF(LB"---MSGPOOL sl=%d EMPTY ---",
						pInfo->u8Slot
						);
#ifdef USE_LCD
				V_PRINTF_LCD("%02x: EMPTY\r\n", u8seq++);
				vLcdRefresh();
#endif
			}

			ToCoNet_Event_Process(E_EVENT_APP_GET_IC_INFO, pInfo->bGotData, vProcessEvCore); // vProcessEvCore にイベント送信
		}
		break;

	default:
		break;
	}
}

/****************************************************************************
 *
 * NAME: cbToCoNet_vHwEvent
 *
 * DESCRIPTION:
 * Process any hardware events.
 *
 * PARAMETERS:      Name            RW  Usage
 *                  u32DeviceId
 *                  u32ItemBitmap
 *
 * RETURNS:
 * None.
 *
 * NOTES:
 * None.
 ****************************************************************************/
void cbToCoNet_vHwEvent(uint32 u32DeviceId, uint32 u32ItemBitmap) {
	switch (u32DeviceId) {
	case E_AHI_DEVICE_ANALOGUE:
		break;

	case E_AHI_DEVICE_SYSCTRL:
		break;

	case E_AHI_DEVICE_TICK_TIMER:
		break;

	case E_AHI_DEVICE_TIMER0:
		break;

	default:
		break;
	}
}

/****************************************************************************
 *
 * NAME: cbToCoNet_u8HwInt
 *
 * DESCRIPTION:
 *   called during an interrupt
 *
 * PARAMETERS:      Name            RW  Usage
 *                  u32DeviceId
 *                  u32ItemBitmap
 *
 * RETURNS:
 *                  FALSE -  interrupt is not handled, escalated to further
 *                           event call (cbToCoNet_vHwEvent).
 *                  TRUE  -  interrupt is handled, no further call.
 *
 * NOTES:
 *   Do not put a big job here.
 ****************************************************************************/
uint8 cbToCoNet_u8HwInt(uint32 u32DeviceId, uint32 u32ItemBitmap) {
	uint8 u8handled = FALSE;

	switch (u32DeviceId) {
	case E_AHI_DEVICE_ANALOGUE:
		break;

	case E_AHI_DEVICE_SYSCTRL:
		break;

	case E_AHI_DEVICE_TIMER0:
		break;

	case E_AHI_DEVICE_TICK_TIMER:
		break;

	default:
		break;
	}

	return u8handled;
}

/****************************************************************************
 *
 * NAME: vInitHardware
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
static void vInitHardware(int f_warm_start) {
	// インタラクティブモードの初期化
	Interactive_vInit();

	// LED's
	vPortAsOutput(PORT_KIT_LED1);
	vPortAsOutput(PORT_KIT_LED2);
//	vPortAsOutput(PORT_KIT_LED3);
//	vPortAsOutput(PORT_KIT_LED4);
	vPortSetHi(PORT_KIT_LED1);
	vPortSetHi(PORT_KIT_LED2);
//	vPortSetHi(PORT_KIT_LED3);
//	vPortSetHi(PORT_KIT_LED4);

	// 表示デバイス用電源を投入
	vPortAsOutput(DIO_DISP_POWER);
	vPortSetHi(DIO_DISP_POWER);
	vPortDisablePullup(DIO_DISP_POWER);
	// ATP301xリセット開始
	vPortAsOutput(DIO_SPEAK_RESET);
	vPortSetLo(DIO_SPEAK_RESET);
	vPortDisablePullup(DIO_SPEAK_RESET);

	if (!f_warm_start && bPortRead(PORT_CONF2)) {
		sAppData.bConfigMode = TRUE;
	}

	// ToDo: Tick Timerが猛烈に遅いようだけど問題無いか？
	// activate tick timers
	memset(&sTimerApp, 0, sizeof(sTimerApp));
	sTimerApp.u8Device = E_AHI_DEVICE_TIMER0;
	sTimerApp.u16Hz = 1;
	sTimerApp.u8PreScale = 10;
	vTimerConfig(&sTimerApp);
	vTimerStart(&sTimerApp);

# ifdef JN516x
	{
		vAHI_TimerFineGrainDIOControl(0x7); // bit 0,1,2 をセット (TIMER0 の各ピンを解放する, PWM1..4 は使用する)

		// PWM
		const uint8 au8TimTbl[] = {
			E_AHI_DEVICE_TIMER1,
			E_AHI_DEVICE_TIMER2,
			E_AHI_DEVICE_TIMER3,
			E_AHI_DEVICE_TIMER4
		};
		int i;
		for (i = 0; i < 4; i++) {
			memset(&sTimerPWM[i], 0, sizeof(tsTimerContext));
			sTimerPWM[i].u16Hz = 1000;
			sTimerPWM[i].u8PreScale = 0;
			sTimerPWM[i].u16duty = 1024; // 1024=Hi, 0:Lo
			sTimerPWM[i].bPWMout = TRUE;
			sTimerPWM[i].bDisableInt = TRUE; // 割り込みを禁止する指定
			sTimerPWM[i].u8Device = au8TimTbl[i];
		}
		vAHI_TimerSetLocation(E_AHI_TIMER_1, TRUE, TRUE); // IOの割り当てを設定
		for (i = 0; i < 4; i++) {
			vTimerConfig(&sTimerPWM[i]);
			//vTimerStart(&sTimerPWM[i]);
		}
	}
# endif

}

/****************************************************************************
 *
 * NAME: vSerialInit
 *
 * DESCRIPTION:
 *
 * RETURNS:
 *
 ****************************************************************************/
void vSerialInit(void) {
	/* Create the debug port transmit and receive queues */
	static uint8 au8SerialTxBuffer[1024];
	static uint8 au8SerialRxBuffer[512];

	/* Initialise the serial port to be used for debug output */
	sSerPort.pu8SerialRxQueueBuffer = au8SerialRxBuffer;
	sSerPort.pu8SerialTxQueueBuffer = au8SerialTxBuffer;
	sSerPort.u32BaudRate = UART_BAUD;
	sSerPort.u16AHI_UART_RTS_LOW = 0xffff;
	sSerPort.u16AHI_UART_RTS_HIGH = 0xffff;
	sSerPort.u16SerialRxQueueSize = sizeof(au8SerialRxBuffer);
	sSerPort.u16SerialTxQueueSize = sizeof(au8SerialTxBuffer);
	sSerPort.u8SerialPort = UART_PORT;
	sSerPort.u8RX_FIFO_LEVEL = E_AHI_UART_FIFO_LEVEL_1;
	SERIAL_vInit(&sSerPort);

	sSerStream.bPutChar = SERIAL_bTxChar;
	sSerStream.u8Device = UART_PORT;
}

/**
 * 初期化メッセージ
 */
void vSerInitMessage() {
	V_PRINTF(LB "*** " APP_NAME " (EndDev Remote) %d.%02d-%d ***", VERSION_MAIN, VERSION_SUB, VERSION_VAR);
	V_PRINTF(LB "* App ID:%08x Long Addr:%08x Short Addr %04x LID %02d",
			sToCoNet_AppContext.u32AppId, ToCoNet_u32GetSerial(), sToCoNet_AppContext.u16ShortAddress,
			sAppData.sFlash.sData.u8id);
}

/**
 * コマンド受け取り時の処理
 * @param pCmd
 */
void vProcessSerialCmd(tsSerCmd_Context *pCmd) {
	V_PRINTF(LB "! cmd len=%d data=", pCmd->u16len);
	int i;
	for (i = 0; i < pCmd->u16len && i < 8; i++) {
		V_PRINTF("%02X", pCmd->au8data[i]);
	}
	if (i < pCmd->u16len) {
		V_PRINTF("...");
	}

	return;
}

static void vInitLcdBuffer() {
	memset(&sLcdBuffer[0][0], ' ', LCD_COLUMNS);
	memset(&sLcdBuffer[1][0], ' ', LCD_COLUMNS);
	sLcdBuffer[0][LCD_COLUMNS] = '\0';
	sLcdBuffer[1][LCD_COLUMNS] = '\0';
}

static void vUpdateLcdBufferById(uint8 id, uint8 chr) {
	if (id <= ADDRKEYA_MAX_HISTORY)
	{
		uint8 row = (id > LCD_COLUMNS ? 1 : 0);
		uint8 column = ((id - 1) % LCD_COLUMNS);
		sLcdBuffer[row][column] = chr;
	}
}

/**
 * MessagePoolを戸締り状態の構造体にコピー。
 * LCDに戸締り状態、電源または通信の問題を表示。
 * @param pMessageData
 * @return
 */
static bool_t vDisplayMessageData(uint8 *pMessageData) {
	bool_t ret = TRUE;
	uint8 u8id;
	uint8 *p;
	uint8 *tail;
	tsDoorStateData sDoorState;

	memset(&sDoorState, 0, sizeof(tsDoorStateData));
	vInitLcdBuffer();
	p = pMessageData;
	tail = pMessageData + TOCONET_MOD_MESSAGE_POOL_MAX_MESSAGE;
	u8id = G_OCTET();
	while (u8id != DOORCHECKER_MSGPOOL_SENTINEL && p < tail) {
		uint8 u8btn = G_OCTET();
		uint8 u8batt = G_OCTET();
		uint16 volt = DECODE_VOLT(u8batt);
		uint8 chr = '-';
		if (u8batt == 0) {
			// 0V(電圧確認できない)は子機通信エラーで小文字
			sDoorState.u32CommErrMap |= (1<<u8id);
			chr = u8id + '`';
		} else {
			if ((u8btn & 1) == 0) {
				// 窓開放は大文字表示
				chr = u8id + '@';
				sDoorState.u32OpenedMap |= (1<<u8id);
			}
			else if (volt < VOLT_LOW) {
				// 低電圧は小文字表示
				chr = u8id + '`';
				sDoorState.u32LowBattMap |= (1<<u8id);
			}
		}
		vUpdateLcdBufferById(u8id, chr);
		u8id = G_OCTET();
	}
	// 結果をsAppDataへコピー。LED点滅はｖProcessEvCoreで行う。
	memcpy(&sAppData.sDoorState, &sDoorState, sizeof(tsDoorStateData));
#ifdef USE_I2C_LCD
	ret &= bDraw2LinesLcd_AQM0802A((const char *)sLcdBuffer[0], (const char *)sLcdBuffer[1]);
#endif
	return ret;
}


#ifdef USE_LCD
/**
 * LCDの初期化
 */
static void vLcdInit(void) {
	/* Initisalise the LCD */
	vLcdReset(3, 0);

	/* register for vfPrintf() */
	sLcdStream.bPutChar = LCD_bTxChar;
	sLcdStream.u8Device = 0xFF;
	sLcdStreamBtm.bPutChar = LCD_bTxBottom;
	sLcdStreamBtm.u8Device = 0xFF;
}

/**
 * LCD を描画する
 */
static void vLcdRefresh(void) {
	vLcdClear();
	vDrawLcdDisplay(0, TRUE); /* write to lcd module */
	vLcdRefreshAll(); /* display new data */
}
#endif

/****************************************************************************/
/***        END OF FILE                                                   ***/
/****************************************************************************/
