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

#include "utils.h"

#include "Parent.h"
#include "config.h"
#include "Version.h"

#include "serial.h"
#include "fprintf.h"
#include "sprintf.h"

#include "btnMgr.h"

#include "Interactive.h"
#include "sercmd_gen.h"

#include "common.h"
#include "AddrKeyAry.h"

/****************************************************************************/
/***        ToCoNet Definitions                                           ***/
/****************************************************************************/
#define ToCoNet_USE_MOD_NWK_LAYERTREE // Network definition
#define ToCoNet_USE_MOD_NBSCAN // Neighbour scan module
#define ToCoNet_USE_MOD_NBSCAN_SLAVE // Neighbour scan slave module
//#define ToCoNet_USE_MOD_CHANNEL_MGR
#define ToCoNet_USE_MOD_NWK_MESSAGE_POOL
#define ToCoNet_USE_MOD_DUPCHK

// includes
#include "ToCoNet.h"
#include "ToCoNet_mod_prototype.h"

#include "app_event.h"

/****************************************************************************/
/***        Macro Definitions                                             ***/
/****************************************************************************/
#define TOCONET_DEBUG_LEVEL 0
//#define USE_LCD

#ifdef USE_LCD
#include "LcdDriver.h"
#include "LcdDraw.h"
#include "LcdPrint.h"
#define V_PRINTF_LCD(...) vfPrintf(&sLcdStream, __VA_ARGS__)
#define V_PRINTF_LCD_BTM(...) vfPrintf(&sLcdStreamBtm, __VA_ARGS__)
#endif

/****************************************************************************/
/***        Type Definitions                                              ***/
/****************************************************************************/

/****************************************************************************/
/***        Local Function Prototypes                                     ***/
/****************************************************************************/
static void vProcessEvCore(tsEvent *pEv, teEvent eEvent, uint32 u32evarg);
static void vInitHardware(int f_warm_start);
static void vSerialInit(uint32 u32Baud, tsUartOpt *pUartOpt);

void vSerOutput_Standard(tsRxPktInfo *pRxPktInfo, uint8 *p);
void vSerOutput_SmplTag3(tsRxPktInfo *pRxPktInfo, uint8 *p);
void vSerOutput_Uart(tsRxPktInfo *pRxPktInfo, uint8 *p);

void vSerOutput_Secondary();

void vSerInitMessage();
void vProcessSerialCmd(tsSerCmd_Context *pCmd);

void vLED_Toggle(void);
void vLED_asDisplay(void);

static uint8 vRescanDoorStatus();

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
tsAppData_Pa sAppData; // application information
tsFILE sSerStream; // serial output context
tsSerialPortSetup sSerPort; // serial port queue

tsSerCmd_Context sSerCmdOut; //!< シリアル出力用

tsAdrKeyA_Context sEndDevList; // 子機の発報情報を保存するデータベース
/**
 * MessagePool送信用
 * 3bytes/子機 [id][DI bitmap][volt] vold==0なら子機音信不通
 * id==0または配列末尾で終端
 */
uint8 su8MessagePoolData[TOCONET_MOD_MESSAGE_POOL_MAX_MESSAGE + 1];

#define ADDRKEY_NO_DATA 0xFF
#define AddrKey2Id(k) ((k)&0xFF)
#define AddrKey2Button(k) (((k)>>8)&0xFF)
#define AddrKey2Batt(k) (((k)>>16)&0xFF)

#ifdef USE_LCD
static tsFILE sLcdStream, sLcdStreamBtm;
#endif

static uint32 u32sec;
static uint32 u32TempCount_ms = 0;

/****************************************************************************/
/***        ToCoNet Callback Functions                                    ***/
/****************************************************************************/
/**
 * アプリケーションの起動時の処理
 * - ネットワークの設定
 * - ハードウェアの初期化
 */
void cbAppColdStart(bool_t bAfterAhiInit) {
	if (!bAfterAhiInit) {
		// before AHI init, very first of code.

		// Register modules
		ToCoNet_REG_MOD_ALL();

	} else {
		// disable brown out detect
		vAHI_BrownOutConfigure(0, //0:2.0V 1:2.3V
				FALSE, FALSE, FALSE, FALSE);

		// clear application context
		memset(&sAppData, 0x00, sizeof(sAppData));
		ADDRKEYA_vInit(&sEndDevList);
		SPRINTF_vInit128();

		// フラッシュメモリからの読み出し
		//   フラッシュからの読み込みが失敗した場合、ID=15 で設定する
		sAppData.bFlashLoaded = Config_bLoad(&sAppData.sFlash);

		// ToCoNet configuration
		sToCoNet_AppContext.u32AppId = sAppData.sFlash.sData.u32appid;
		sToCoNet_AppContext.u8Channel = sAppData.sFlash.sData.u8ch;
		sToCoNet_AppContext.u32ChMask = sAppData.sFlash.sData.u32chmask;

		sToCoNet_AppContext.bRxOnIdle = TRUE;
		sToCoNet_AppContext.u8TxMacRetry = 1;

		// ToDo: M2を押しながら起動したら子機再登録モード。
		// Register
		ToCoNet_Event_Register_State_Machine(vProcessEvCore);

		// Others
		vInitHardware(FALSE);
		Interactive_vInit();

		// シリアルの書式出力のため
		if (IS_APPCONF_OPT_UART_BIN()) {
			SerCmdBinary_vInit(&sSerCmdOut, NULL, 128); // バッファを指定せず初期化
		} else {
			SerCmdAscii_vInit(&sSerCmdOut, NULL, 128); // バッファを指定せず初期化
		}
	}
}

/**
 * スリープ復帰時の処理（本アプリケーションでは処理しない)
 * @param bAfterAhiInit
 */
void cbAppWarmStart(bool_t bAfterAhiInit) {
	cbAppColdStart(bAfterAhiInit);
}

/**
 * メイン処理
 * - シリアルポートの処理
 */
void cbToCoNet_vMain(void) {
	/* handle uart input */
	vHandleSerialInput();
}

/**
 * ネットワークイベント。
 * - E_EVENT_TOCONET_NWK_START\n
 *   ネットワーク開始時のイベントを vProcessEvCore に伝達
 *
 * @param eEvent
 * @param u32arg
 */
void cbToCoNet_vNwkEvent(teEvent eEvent, uint32 u32arg) {
	switch (eEvent) {
	case E_EVENT_TOCONET_NWK_START:
		// send this event to the local event machine.
		ToCoNet_Event_Process(eEvent, u32arg, vProcessEvCore);
		break;
	case E_EVENT_TOCONET_NWK_MESSAGE_POOL_REQUEST:
		{
			// vRescanDoorStatus()で構築した共有情報（メッセージプール）の送信
			uint8 msglen = vRescanDoorStatus();
			ToCoNet_MsgPl_bSetMessage(0, 0, msglen, su8MessagePoolData);
		}
		break;
	default:
		break;
	}
}

/**
 * 子機または中継機を経由したデータを受信する。
 *
 * - アドレスを取り出して、内部のデータベースへ登録（メッセージプール送信用）
 * - UART に指定書式で出力する
 *   - 出力書式\n
 *     ::(受信元ルータまたは親機のアドレス):(シーケンス番号):(送信元アドレス):(LQI)<CR><LF>
 *
 * @param pRx 受信データ構造体
 */
void cbToCoNet_vRxEvent(tsRxDataApp *pRx) {
	tsRxPktInfo sRxPktInfo;

	uint8 *p = pRx->auData;

	// 暗号化対応時に平文パケットは受信しない
	if (IS_APPCONF_OPT_SECURE()) {
		if (!pRx->bSecurePkt) {
			return;
		}
	}

	// パケットの表示
	if (pRx->u8Cmd == TOCONET_PACKET_CMD_APP_DATA) {
		// Turn on LED
		sAppData.u32LedCt = u32TickCount_ms;

		// LED の点灯を行う
		sAppData.u16LedDur_ct = 125;

		// 基本情報
		sRxPktInfo.u8lqi_1st = pRx->u8Lqi;
		sRxPktInfo.u32addr_1st = pRx->u32SrcAddr;

		// データの解釈
		uint8 u8b = G_OCTET();

		// 受信機アドレス
		sRxPktInfo.u32addr_rcvr = TOCONET_NWK_ADDR_PARENT;
		if (u8b == 'R') {
			// ルータからの受信
			sRxPktInfo.u32addr_1st = G_BE_DWORD();
			sRxPktInfo.u8lqi_1st = G_OCTET();

			sRxPktInfo.u32addr_rcvr = pRx->u32SrcAddr;
		}

		// ID などの基本情報
		sRxPktInfo.u8id = G_OCTET();
		sRxPktInfo.u16fct = G_BE_WORD();

		// パケットの種別により処理を変更
		sRxPktInfo.u8pkt = G_OCTET();

#if 0
		// 戸締りチェッカーとしては不要な動作
		if( sRxPktInfo.u8pkt == PKT_ID_BUTTON ){
			vLED_Toggle();
		}
#endif

		// 出力用の関数を呼び出す
		if (IS_APPCONF_OPT_SHT21()) {
			vSerOutput_SmplTag3(&sRxPktInfo, p);
		} else if (IS_APPCONF_OPT_UART()) {
			vSerOutput_Uart(&sRxPktInfo, p);
		} else {
			vSerOutput_Standard(&sRxPktInfo, p);
		}

		// データベースへ登録（線形配列に格納している）
		if (sRxPktInfo.u8pkt == PKT_ID_BUTTON) {
			// ID,状態,電源電圧を登録
			uint32 u32key = (sRxPktInfo.u8id|sRxPktInfo.u8btn<<8|sRxPktInfo.u8batt<<16);
			ADDRKEYA_vAdd(&sEndDevList, sRxPktInfo.u32addr_1st, u32key);
			// 窓が開いていたらパイロットランプ消灯。
			vRescanDoorStatus();
			vLED_asDisplay();
		} else {
			ADDRKEYA_vAdd(&sEndDevList, sRxPktInfo.u32addr_1st, 0); // アドレスだけ登録。
		}
	}
}

/**
 * 送信完了時のイベント
 * @param u8CbId
 * @param bStatus
 */
void cbToCoNet_vTxEvent(uint8 u8CbId, uint8 bStatus) {
	return;
}

/**
 * ハードウェア割り込みの遅延実行部
 *
 * - BTM による IO の入力状態をチェック\n
 *   ※ 本サンプルでは特別な使用はしていない
 *
 * @param u32DeviceId
 * @param u32ItemBitmap
 */
void cbToCoNet_vHwEvent(uint32 u32DeviceId, uint32 u32ItemBitmap) {

	switch (u32DeviceId) {
	case E_AHI_DEVICE_TICK_TIMER:
		// LED の点灯消灯を制御する
		if (sAppData.u16LedDur_ct) {
			sAppData.u16LedDur_ct--;
			if (sAppData.u16LedDur_ct) {
				vPortSet_TrueAsLo(PORT_OUT2, TRUE);
			}
		} else {
			vPortSet_TrueAsLo(PORT_OUT2, FALSE);
		}

		break;

	default:
		break;
	}

}

/**
 * ハードウェア割り込み
 * - 処理なし
 *
 * @param u32DeviceId
 * @param u32ItemBitmap
 * @return
 */
uint8 cbToCoNet_u8HwInt(uint32 u32DeviceId, uint32 u32ItemBitmap) {
	return FALSE;
}

/****************************************************************************/
/***        Local Functions                                               ***/
/****************************************************************************/

/**
 * ハードウェアの初期化
 * @param f_warm_start
 */
static void vInitHardware(int f_warm_start) {
	// BAUD ピンが GND になっている場合、かつフラッシュの設定が有効な場合は、設定値を採用する (v1.0.3)
	tsUartOpt sUartOpt;
	memset(&sUartOpt, 0, sizeof(tsUartOpt));
	uint32 u32baud = UART_BAUD;
	if (sAppData.bFlashLoaded && bPortRead(PORT_BAUD)) {
		u32baud = sAppData.sFlash.sData.u32baud_safe;
		sUartOpt.bHwFlowEnabled = FALSE;
		sUartOpt.bParityEnabled = UART_PARITY_ENABLE;
		sUartOpt.u8ParityType = UART_PARITY_TYPE;
		sUartOpt.u8StopBit = UART_STOPBITS;

		// 設定されている場合は、設定値を採用する (v1.0.3)
		switch(sAppData.sFlash.sData.u8parity & APPCONF_UART_CONF_PARITY_MASK) {
		case 0:
			sUartOpt.bParityEnabled = FALSE;
			break;
		case 1:
			sUartOpt.bParityEnabled = TRUE;
			sUartOpt.u8ParityType = E_AHI_UART_ODD_PARITY;
			break;
		case 2:
			sUartOpt.bParityEnabled = TRUE;
			sUartOpt.u8ParityType = E_AHI_UART_EVEN_PARITY;
			break;
		}

		// ストップビット
		if (sAppData.sFlash.sData.u8parity & APPCONF_UART_CONF_STOPBIT_MASK) {
			sUartOpt.u8StopBit = E_AHI_UART_2_STOP_BITS;
		} else {
			sUartOpt.u8StopBit = E_AHI_UART_1_STOP_BIT;
		}

		// 7bitモード
		if (sAppData.sFlash.sData.u8parity & APPCONF_UART_CONF_WORDLEN_MASK) {
			sUartOpt.u8WordLen = 7;
		} else {
			sUartOpt.u8WordLen = 8;
		}

		vSerialInit(u32baud, &sUartOpt);
	} else {
		vSerialInit(u32baud, NULL);
	}

	ToCoNet_vDebugInit(&sSerStream);
	ToCoNet_vDebugLevel(TOCONET_DEBUG_LEVEL);

	// IO の設定
	vPortSetHi( PORT_OUT1 );
	vPortAsOutput( PORT_OUT1 );

	vPortSetHi( PORT_OUT2 );
	vPortAsOutput( PORT_OUT2 );

	// LCD の設定
#ifdef USE_LCD
	vLcdInit();
#endif
}

/**
 * UART の初期化
 */
static void vSerialInit(uint32 u32Baud, tsUartOpt *pUartOpt) {
	/* Create the debug port transmit and receive queues */
	static uint8 au8SerialTxBuffer[1532];
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
	SERIAL_vInitEx(&sSerPort, pUartOpt);

	sSerStream.bPutChar = SERIAL_bTxChar;
	sSerStream.u8Device = UART_PORT;
}

/**
 * アプリケーション主要処理
 * - E_STATE_IDLE\n
 *   ネットワークの初期化、開始
 *
 * - E_STATE_RUNNING\n
 *   - データベースのタイムアウト処理
 *   - 定期的なメッセージプール送信
 *
 * @param pEv
 * @param eEvent
 * @param u32evarg
 */
static void vProcessEvCore(tsEvent *pEv, teEvent eEvent, uint32 u32evarg) {

	if (eEvent == E_EVENT_TICK_SECOND) {
		u32sec++;
	}

	switch (pEv->eState) {
	case E_STATE_IDLE:
		if (eEvent == E_EVENT_START_UP) {
			vSerInitMessage();

			V_PRINTF(LB"[E_STATE_IDLE]");

			if (IS_APPCONF_OPT_SECURE()) {
				bool_t bRes = bRegAesKey(sAppData.sFlash.sData.u32EncKey);
				V_PRINTF(LB "*** Register AES key (%d) ***", bRes);
			}

			// Configure the Network
			sAppData.sNwkLayerTreeConfig.u8Layer = 0;
			sAppData.sNwkLayerTreeConfig.u8Role = TOCONET_NWK_ROLE_PARENT;
			sAppData.pContextNwk =
					ToCoNet_NwkLyTr_psConfig(&sAppData.sNwkLayerTreeConfig);
			if (sAppData.pContextNwk) {
				ToCoNet_Nwk_bInit(sAppData.pContextNwk);
				ToCoNet_Nwk_bStart(sAppData.pContextNwk);
			}

		} else if (eEvent == E_EVENT_TOCONET_NWK_START) {
			ToCoNet_Event_SetState(pEv, E_STATE_RUNNING);
		} else {
			;
		}
		break;

	case E_STATE_RUNNING:
		if (eEvent == E_EVENT_NEW_STATE) {
			V_PRINTF(LB"[E_STATE_RUNNING]");
		} else if (eEvent == E_EVENT_TICK_SECOND) {
			static uint8 u8Ct_s = 0;

			// 毎秒ごとのシリアル出力
			vSerOutput_Secondary();

			// 定期クリーン（タイムアウトしたノードを削除する）
			ADDRKEYA_bFind(&sEndDevList, 0, 0);

			// 戸締り状態をMessagePoolのペイロードとして用意
			uint8 msglen = vRescanDoorStatus();

			// vRescanDoorStatus()で構築した共有情報（メッセージプール）の送信
			if (++u8Ct_s > PARENT_MSGPOOL_TX_DUR_s) {
				// 最大3byte×16台+1(sentinel)=49bytes
				ToCoNet_MsgPl_bSetMessage(0, 0, msglen, su8MessagePoolData);
				u8Ct_s = 0;
			}
		} else {
			;
		}
		break;

	default:
		break;
	}
}

/**
 * 初期化メッセージ
 */
void vSerInitMessage() {
	if (!IS_APPCONF_OPT_UART()) {
		A_PRINTF(LB "*** " APP_NAME " (Parent) %d.%02d-%d ***", VERSION_MAIN, VERSION_SUB, VERSION_VAR);
		A_PRINTF(LB "* App ID:%08x Long Addr:%08x Short Addr %04x LID %02d" LB,
				sToCoNet_AppContext.u32AppId, ToCoNet_u32GetSerial(), sToCoNet_AppContext.u16ShortAddress,
				sAppData.sFlash.sData.u8id);
	} else {
		uint8 u8buff[32], *q = u8buff;

		memset(u8buff, 0, sizeof(u8buff));
		memcpy(u8buff, APP_NAME, sizeof(APP_NAME));
		q += 16;

		S_OCTET(VERSION_MAIN);
		S_OCTET(VERSION_SUB);
		S_OCTET(VERSION_VAR);
		S_BE_DWORD(sToCoNet_AppContext.u32AppId);
		S_BE_DWORD(ToCoNet_u32GetSerial());

		sSerCmdOut.u16len = q - u8buff;
		sSerCmdOut.au8data = u8buff;

		sSerCmdOut.vOutput(&sSerCmdOut, &sSerStream);

		sSerCmdOut.au8data = NULL;
	}

#ifdef USE_LCD
	// 最下行を表示する
	V_PRINTF_LCD_BTM(" ToCoSamp IO Monitor %d.%02d-%d ", VERSION_MAIN, VERSION_SUB, VERSION_VAR);
	vLcdRefresh();
#endif
}

/**
 * 標準の出力
 */
void vSerOutput_Standard(tsRxPktInfo *pRxPktInfo, uint8 *p) {
	// 受信機のアドレス
	A_PRINTF("::rc=%08X", pRxPktInfo->u32addr_rcvr);

	// LQI
	A_PRINTF(":lq=%d", pRxPktInfo->u8lqi_1st);

	// フレーム
	A_PRINTF(":ct=%04X", pRxPktInfo->u16fct);

	// 送信元子機アドレス
	A_PRINTF(":ed=%08X:id=%X", pRxPktInfo->u32addr_1st, pRxPktInfo->u8id);

	switch(pRxPktInfo->u8pkt) {
	case PKT_ID_BUTTON:
		_C {
			pRxPktInfo->u8batt = G_OCTET();

			pRxPktInfo->u16adc1 = G_BE_WORD();
			pRxPktInfo->u16adc2 = G_BE_WORD();

			uint8 u8mode = G_OCTET();(void)u8mode;
			pRxPktInfo->u8btn = G_OCTET();

			// センサー情報
			A_PRINTF(":ba=%04d:bt=%04d" LB,
					DECODE_VOLT(pRxPktInfo->u8batt), pRxPktInfo->u8btn );

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:P:%04d:%04d:\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					sAppData.u8DO_State
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_STANDARD:
		_C {
			uint8 u8batt = G_OCTET();

			uint16 u16adc1 = G_BE_WORD();
			uint16 u16adc2 = G_BE_WORD();
			uint16 u16pc1 = G_BE_WORD();
			uint16 u16pc2 = G_BE_WORD();

			// センサー情報
			A_PRINTF(":ba=%04d:a1=%04d:a2=%04d:p0=%03d:p1=%03d" LB,
					DECODE_VOLT(u8batt), u16adc1, u16adc2, u16pc1, u16pc2);

#ifdef USE_LCD
			// LCD への出力:
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:A:%04d:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					u16adc1,
					u16adc2
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_LM61:
		_C {
			uint8 u8batt = G_OCTET();

			uint16	u16adc1 = G_BE_WORD();
			uint16	u16adc2 = G_BE_WORD();
			uint16	u16pc1 = G_BE_WORD();(void)u16pc1;
			uint16	u16pc2 = G_BE_WORD();(void)u16pc2;
			int		bias = G_BE_WORD();

			// LM61用の温度変換
			//   Vo=T[℃]x10[mV]+600[mV]
			//   T     = Vo/10-60
			//   100xT = 10xVo-6000
			int32 iTemp = 10 * (int32)u16adc2 - 6000L + bias;

			// センサー情報
			A_PRINTF(":ba=%04d:te=%04d:a0=%04d:a1=%03d" LB,
					DECODE_VOLT(u8batt), iTemp, u16adc1, u16adc2);

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:L:%04d:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					u16adc1,
					u16adc2
					);
			vLcdRefresh();
#endif
		}
		break;
	case PKT_ID_SHT21:
		_C {
			uint8 u8batt = G_OCTET();

			uint16 u16adc1 = G_BE_WORD();
			uint16 u16adc2 = G_BE_WORD();
			int16 i16temp = G_BE_WORD();
			int16 i16humd = G_BE_WORD();

			// センサー情報
			A_PRINTF(":ba=%04d:a1=%04d:a2=%04d:te=%04d:hu=%04d" LB,
					DECODE_VOLT(u8batt), u16adc1, u16adc2, i16temp, i16humd);

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:S:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					i16temp,
					i16humd
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_LIS3DH:
		_C {
			uint8 u8batt = G_OCTET();

			uint16 u16adc1 = G_BE_WORD();
			uint16 u16adc2 = G_BE_WORD();
			int16 i16x = G_BE_WORD();
			int16 i16y = G_BE_WORD();
			int16 i16z = G_BE_WORD();

			// センサー情報
			A_PRINTF(":ba=%04d:a1=%04d:a2=%04d:x=04%d:y=%04d:z=%04d" LB,
					DECODE_VOLT(u8batt), u16adc1, u16adc2, i16x, i16y, i16z );

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:I:%04d:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					i16x,
					i16y,
					i16z
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_ADT7410:
		_C {
			uint8 u8batt = G_OCTET();

			uint16	u16adc1 = G_BE_WORD();
			uint16	u16adc2 = G_BE_WORD();
			int16 i16temp = G_BE_WORD();

			// センサー情報
			A_PRINTF(":ba=%04d:a1=%04d:a2=%04d:te=%04d" LB,
					DECODE_VOLT(u8batt), u16adc1, u16adc2, i16temp);

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:D:%04d:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					u16adc1,
					u16adc2
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_MPL115A2:
		_C {
			uint8 u8batt = G_OCTET();

			uint16	u16adc1 = G_BE_WORD();
			uint16	u16adc2 = G_BE_WORD();
			int16 i16atmo = G_BE_WORD();

			// センサー情報
			A_PRINTF(":ba=%04d:a1=%04d:a2=%04d:at=%04d" LB,
					DECODE_VOLT(u8batt), u16adc1, u16adc2, i16atmo);

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:M:%04d:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					u16atmo,
					u16adc1
					);
			vLcdRefresh();
#endif
		}
		break;


	case PKT_ID_IO_TIMER:
		_C {
			uint8 u8stat = G_OCTET();
			uint32 u32dur = G_BE_DWORD();

			A_PRINTF(":btn=%d:dur=%d" LB, u8stat, u32dur / 1000);

#ifdef USE_LCD
			// LCD への出力
			V_PRINTF_LCD("%03d:%08X:%03d:%02X:B:%04d:%04d\n",
					u32sec % 1000,
					pRxPktInfo->u32addr_1st,
					pRxPktInfo->u8lqi_1st,
					pRxPktInfo->u16fct & 0xFF,
					u8stat,
					u32dur / 1000
					);
			vLcdRefresh();
#endif
		}
		break;

	case PKT_ID_UART:
		_C {
			uint8 u8len = G_OCTET();

			sSerCmdOut.u16len = u8len;
			sSerCmdOut.au8data = p;

			sSerCmdOut.vOutput(&sSerCmdOut, &sSerStream);

			sSerCmdOut.au8data = NULL; // p は関数を抜けると無効であるため、念のため NULL に戻す
		}
		break;

	default:
		break;
	}
}

/**
 * SimpleTag v3 互換 (SHT21 用) の出力
 */
void vSerOutput_SmplTag3( tsRxPktInfo *pRxPktInfo, uint8 *p) {
	//	押しボタン
	if ( pRxPktInfo->u8pkt == PKT_ID_BUTTON ) {
		pRxPktInfo->u8batt = G_OCTET();
		pRxPktInfo->u16adc1 = G_BE_WORD();
		pRxPktInfo->u16adc2 = G_BE_WORD();
		uint8 u8mode = G_OCTET();
		uint8 u8DI_Bitmap = G_OCTET();

		//	Bitmapを二進数に変換
		uint16 u16bitmap=0;
		//	DI4に入力があるかどうか
		if( u8DI_Bitmap & 8 ){
			u16bitmap += 1000;
		}
		//	AI3に入力があるかどうか
		if( u8DI_Bitmap & 4 ){
			u16bitmap += 100;
		}
		//	DI2に入力があるかどうか
		if( u8DI_Bitmap & 2 ){
			u16bitmap += 10;
		}
		//	AI1に入力があるかどうか
		if( u8DI_Bitmap & 1 ){
			u16bitmap += 1;
		}
		pRxPktInfo->u8btn = u8DI_Bitmap;

		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// ADC1
				"%04d;"			// ADC2
				"%04d;"			// 立ち上がりモード
				"%04d;"			// DIのビットマップ
				"%c;"			// 押しボタンフラグ
				"%04d;"			// ボタンの状態(LEDが光れば1、消えれば0)
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(pRxPktInfo->u8batt),
				pRxPktInfo->u16adc1,
				pRxPktInfo->u16adc2,
				u8mode,
				u16bitmap,
				'P',
				sAppData.u8DO_State
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:P:%04d:%04d:\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
//				u8btn
				sAppData.u8DO_State
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_SHT21) {
		uint8 u8batt = G_OCTET();
		uint16 u16adc1 = G_BE_WORD();
		uint16 u16adc2 = G_BE_WORD(); (void)u16adc2;
		int16 i16temp = G_BE_WORD();
		int16 i16humd = G_BE_WORD();

		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// SHT21 TEMP
				"%04d;"			// SHT21 HUMID
				"%04d;"			// adc1
				"%04d;"			// adc2
				"%c;"			// パケット識別子
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
				i16temp,
				i16humd,
				u16adc1,
				u16adc2,
				'S'
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:S:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				i16temp,
				i16humd
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_LIS3DH) {
		uint8 u8batt = G_OCTET();
		uint16 u16adc1 = G_BE_WORD();
		uint16 u16adc2 = G_BE_WORD(); (void)u16adc2;
		int16 i16x = G_BE_WORD();
		int16 i16y = G_BE_WORD();
		int16 i16z = G_BE_WORD();
		uint8 u8bitmap = G_OCTET();

		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04x;"			//
				"%04d;"			//
				"%04d;"			// adc1
				"%04d;"			// adc2
				"%0c;"			// パケット識別子
				"%04d;"			// x
				"%04d;"			// y
				"%04d;"			// z
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
				u8bitmap,
				0,
				u16adc1,
				u16adc2,
				'I',
				i16x,
				i16y,
				i16z
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:I:%04d:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				i16x,
				i16y,
				i16z
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_ADT7410) {
		uint8 u8batt = G_OCTET();
		uint16 u16adc1 = G_BE_WORD();
		uint16 u16adc2 = G_BE_WORD(); (void)u16adc2;
		int16 i16temp = G_BE_WORD();

		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// SHT21 TEMP
				"%04d;"			//
				"%04d;"			// adc1
				"%04d;"			// adc2
				"%c;"			// パケット識別子
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
				i16temp,
				0,
				u16adc1,
				u16adc2,
				'D'
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:S:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				i16temp,
				i16humd
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_MPL115A2) {
		uint8 u8batt = G_OCTET();
		uint16 u16adc1 = G_BE_WORD();
		uint16 u16adc2 = G_BE_WORD();;
		int16 i16atmo = G_BE_WORD();

		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// ATMOSPHERIC
				"%04d;"			//
				"%04d;"			// adc1
				"%04d;"			// adc2
				"%c;"			// パケット識別子
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
				i16atmo,
				0,
				u16adc1,
				u16adc2,
				'M'
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:M:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				i16atmo
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_STANDARD) {
		uint8 u8batt = G_OCTET();

		uint16 u16adc1 = G_BE_WORD();
		uint16 u16adc2 = G_BE_WORD();
		uint16 u16pc1 = G_BE_WORD(); (void)u16pc1;
		uint16 u16pc2 = G_BE_WORD(); (void)u16pc2;

		// センサー情報
		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// LM61温度(100x ℃)
				"%04d;"			// SuperCAP 電圧(mV)
				"%04d;"			// ADC1
				"%04d;"			// ADC2
				"%c;"			// 識別子
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
//				iTemp,
				u16adc2,
				u16adc1 * 2 * 3, // 3300mV で 99% 相当
				u16adc1,
				u16adc2,
				'S'
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:S:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				u16adc2,
				u16adc1 * 2
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_LM61) {
		uint8 u8batt = G_OCTET();

		uint16	u16adc1 = G_BE_WORD();
		uint16	u16adc2 = G_BE_WORD();
		uint16	u16pc1 = G_BE_WORD(); (void)u16pc1;
		uint16	u16pc2 = G_BE_WORD(); (void)u16pc2;
		int	bias = G_BE_WORD();
		uint8 minus = G_OCTET();

		//	マイナスフラグが立ってたら符号を入れ替える。
		if( minus == 1 ){
			bias *= -1;
		}

		// LM61用の温度変換
		//   Vo=T[℃]x10[mV]+600[mV]
		//   T     = Vo/10-60
		//   100xT = 10xVo-6000
		int32 iTemp = 10 * (int32)u16adc2 - 6000L + bias;

		// センサー情報
		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%04d;"			// 電源電圧 (0-3600, mV)
				"%04d;"			// LM61温度(100x ℃)
				"%04d;"			// SuperCAP 電圧(mV)
				"%04d;"			// もともとの電圧
				"%04d;"			// バイアスをかけた電圧
				"%c;"			// 識別子
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				DECODE_VOLT(u8batt),
				iTemp,
				u16adc1 * 2 * 3, // 3300mV で 99% 相当
				u16adc1,
				u16adc2,
				'L'
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:L:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				iTemp,
				u16adc1 * 2
				);
		vLcdRefresh();
#endif
	}

	if (pRxPktInfo->u8pkt == PKT_ID_IO_TIMER) {
		uint8 u8stat = G_OCTET();
		uint32 u32dur = G_BE_DWORD();

		// センサー情報
		A_PRINTF( ";"
				"%d;"			// TIME STAMP
				"%08X;"			// 受信機のアドレス
				"%03d;"			// LQI  (0-255)
				"%03d;"			// 連番
				"%07x;"			// シリアル番号
				"%s;"			// 取りえない値
				"%s;"			//
				"%s;"			//
				"%s;"			//
				"%s;"			//
				"%c;"			// ドアフラグ
				"%04d;"			// OPEN=1, CLOSE=0
				"%04d;"			// 開いている時間(開いていた時間)
				LB,
				u32TickCount_ms / 1000,
				pRxPktInfo->u32addr_rcvr & 0x0FFFFFFF,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct,
				pRxPktInfo->u32addr_1st & 0x0FFFFFFF,
				"",
				"",
				"",
				"",
				"",
				'B',
				u8stat,
				u32dur / 1000
		);

#ifdef USE_LCD
		// LCD への出力
		V_PRINTF_LCD("%03d:%08X:%03d:%02X:B:%04d:%04d\n",
				u32sec % 1000,
				pRxPktInfo->u32addr_1st,
				pRxPktInfo->u8lqi_1st,
				pRxPktInfo->u16fct & 0xFF,
				u8stat,
				u32dur / 1000
				);
		vLcdRefresh();
#endif
	}
}


/**
 * UART形式の出力
 *
 * バイナリ形式では以下のような出力が得られる
 * A5 5A       <= ヘッダ
 * 80 12       <= ペイロード長 (XOR チェックサム手前まで)
 * 80 00 00 00 <= 受信機のアドレス (80000000 は親機)
 * 84          <= 最初に受信した受信機のLQI
 * 00 11       <= フレームカウント
 * 81 00 00 38 <= 送信機のアドレス
 * 00          <= 送信機の論理アドレス
 * 04          <= パケット種別 04=UART
 * 04          <= ペイロードのバイト数
 * 81 00 00 38 <= データ部 (たまたま送信機のアドレスをそのまま送信した)
 * 15          <= XOR チェックサム
 * 04          <= 終端
 */
void vSerOutput_Uart(tsRxPktInfo *pRxPktInfo, uint8 *p) {
	uint8 u8buff[256], *q = u8buff; // 出力バッファ

	// 受信機のアドレス
	S_BE_DWORD(pRxPktInfo->u32addr_rcvr);

	// LQI
	S_OCTET(pRxPktInfo->u8lqi_1st);

	// フレーム
	S_BE_WORD(pRxPktInfo->u16fct);

	// 送信元子機アドレス
	S_BE_DWORD(pRxPktInfo->u32addr_1st);
	S_OCTET(pRxPktInfo->u8id);

	// パケットの種別により処理を変更
	S_OCTET(pRxPktInfo->u8pkt);

	switch(pRxPktInfo->u8pkt) {
	//	温度センサなど
	case PKT_ID_STANDARD:
	case PKT_ID_LM61:
	case PKT_ID_SHT21:
		_C {
			// S_OCTET(G_OCTET()) ではコピー結果が化ける
			pRxPktInfo->u8batt = G_OCTET();
			pRxPktInfo->u16adc1 = G_BE_WORD();
			pRxPktInfo->u16adc2 = G_BE_WORD();
			pRxPktInfo->u16PC1 = G_BE_WORD();
			pRxPktInfo->u16PC2 = G_BE_WORD();

			S_OCTET(pRxPktInfo->u8batt);
			S_BE_WORD(pRxPktInfo->u16adc1);
			S_BE_WORD(pRxPktInfo->u16adc2);
			S_BE_WORD(pRxPktInfo->u16PC1);
			S_BE_WORD(pRxPktInfo->u16PC2);
		}
		break;

	case PKT_ID_ADT7410:
	case PKT_ID_MPL115A2:
		_C {
			S_OCTET(G_OCTET()); // batt

			S_BE_WORD(G_BE_WORD());		//	ADC1
			S_BE_WORD(G_BE_WORD());		//	ADC2
			S_BE_WORD(G_BE_WORD());		//	Result
		}
		break;

	case PKT_ID_LIS3DH:
		_C {
			S_OCTET(G_OCTET()); // batt

			S_BE_WORD(G_BE_WORD());		//	ADC1
			S_BE_WORD(G_BE_WORD());		//	ADC2
			S_BE_WORD(G_BE_WORD());		//	x
			S_BE_WORD(G_BE_WORD());		//	y
			S_BE_WORD(G_BE_WORD());		//	z
		}
		break;

	//	磁気スイッチ
	case PKT_ID_IO_TIMER:
		_C {
			S_OCTET(G_OCTET()); // batt
			S_OCTET(G_OCTET()); // stat
			S_BE_DWORD(G_BE_DWORD()); // dur
		}
		break;

	case PKT_ID_UART:
		_C {
			uint8 u8len = G_OCTET();
			S_OCTET(u8len);

			while (u8len--) {
				S_OCTET(G_OCTET());
			}
		}
		break;

	//	押しボタン
	case PKT_ID_BUTTON:
		_C {
			pRxPktInfo->u8batt = G_OCTET();
			pRxPktInfo->u16adc1 = G_BE_WORD();
			pRxPktInfo->u16adc2 = G_BE_WORD();
			uint8 u8mode = G_OCTET();(void)u8mode;
			pRxPktInfo->u8btn = G_OCTET();
			S_OCTET(pRxPktInfo->u8batt);
			S_BE_WORD(pRxPktInfo->u16adc1);
			S_BE_WORD(pRxPktInfo->u16adc2);
			S_OCTET(u8mode);
			S_OCTET(pRxPktInfo->u8btn);
		}
		break;

	default:
		break;
	}

	sSerCmdOut.u16len = q - u8buff;
	sSerCmdOut.au8data = u8buff;

	sSerCmdOut.vOutput(&sSerCmdOut, &sSerStream);

	sSerCmdOut.au8data = NULL;
}


void vSerOutput_Secondary() {
	//	オプションビットで設定されていたら表示しない
	if(!IS_APPCONF_OPT_PARENT_OUTPUT()){
		// 出力用の関数を呼び出す
		if (IS_APPCONF_OPT_SHT21()) {
			A_PRINTF(";%d;"LB, u32sec);
		} else if (IS_APPCONF_OPT_UART()) {
			// 無し
		} else {
			A_PRINTF("::ts=%d"LB, u32sec);
		}
	}
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

/**
 * DO1をトグル動作させる
 */
void vLED_Toggle( void )
{

	if( u32TickCount_ms-u32TempCount_ms > 500 ||	//	前回切り替わってから500ms以上たっていた場合
		u32TempCount_ms == 0 ){						//	初めてここに入った場合( u32TickTimer_msが前回切り替わった場合はごめんなさい )
		sAppData.u8DO_State = !sAppData.u8DO_State;
		//	DO1のLEDがトグル動作する
		vPortSet_TrueAsLo( PORT_OUT1, sAppData.u8DO_State );
		u32TempCount_ms = u32TickCount_ms;
	}
}

/**
 * 1箇所でも窓が開いていたらDO1のLEDを消灯させる。
 */
void vLED_asDisplay(void) {
	uint32 bit = 1;
	uint8 u8id = 1;
	uint8 u8Opened = 0;
	while (bit != 0 && u8id <= ADDRKEYA_MAX_HISTORY)
	{
		if (sAppData.sFlash.sData.u32idmask & bit) {
//			A_PRINTF("vLED_asDisplay: ID=%d %2x ***"LB, u8id, su8MessagePoolData[3 * (u8id - 1) + 1]);
			if (su8MessagePoolData[3 * (u8id - 1) + 1] == 0) {
				u8Opened = TRUE;
				break;
			}
		}
		bit <<= 1;
		u8id++;
	}
	// 1箇所以上開いていたらDO1のLEDを消灯させる
	vPortSet_TrueAsLo( PORT_OUT1, !u8Opened );
}

/**
 * 子機の発報情報データベース(sEndDevList)をスキャンしてMessagePool用データを再構築する。
 * @return Accumulated data length.
 */
static uint8 vRescanDoorStatus() {
	uint8 length = 0;
	uint8 ret = TRUE;
	uint32 bit = 1;
	uint8 u8id = 1;
	uint8 *q = &su8MessagePoolData[0];	// message pool index
	uint8 u8AddrKeyIndex[ADDRKEYA_MAX_HISTORY]; // 論理IDからデータベースへの索引
	int i;

	memset(u8AddrKeyIndex, ADDRKEY_NO_DATA, ADDRKEYA_MAX_HISTORY);
	while (bit != 0 && u8id <= ADDRKEYA_MAX_HISTORY)
	{
		if (sAppData.sFlash.sData.u32idmask & bit) {
			for (i = 0; i < ADDRKEYA_MAX_HISTORY; i++) {
				uint32 u32key = sEndDevList.au32ScanListKey[i];
				if (AddrKey2Id(u32key) == u8id) {
					if (u8AddrKeyIndex[u8id - 1] == ADDRKEY_NO_DATA) {
						u8AddrKeyIndex[u8id - 1] = i;
						S_OCTET(u8id);
						S_OCTET(AddrKey2Button(u32key));
						S_OCTET(AddrKey2Batt(u32key));
					} else {
						ret = FALSE;
						if (u8AddrKeyIndex[u8id - 1] < ADDRKEYA_MAX_HISTORY) {
							A_PRINTF("*** DUPLICATED: ID=%d ADDR1=%08x ADDR2=%08x ***"LB, u8id, sEndDevList.au32ScanListAddr[u8AddrKeyIndex[u8id - 1]], sEndDevList.au32ScanListAddr[i]);
						} else {
							A_PRINTF("*** DUPLICATED: ID=%d ADDR1=INVALID ADDR2=%08x ***"LB, u8id, sEndDevList.au32ScanListAddr[i]);
							u8AddrKeyIndex[u8id - 1] = i;
						}
					}
					break;
				}
			}
			if (i == ADDRKEYA_MAX_HISTORY) {
				// 非検出は電圧0
				S_OCTET(u8id);
				S_OCTET(0);
				S_OCTET(0);
			}
		}
		bit <<= 1;
		u8id++;
	}
	S_OCTET(DOORCHECKER_MSGPOOL_SENTINEL);
	if (ret) {
		length = q - su8MessagePoolData;
	}

	return length;
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
