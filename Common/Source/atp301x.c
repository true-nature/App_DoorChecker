
/****************************************************************************/
/***        Include files                                                 ***/
/****************************************************************************/
#include <string.h>
#include <AppHardwareApi.h>

#include "common.h"
#include "config.h"

#include <utils.h>

#include "appdata.h"
#include "SMBus.h"
#include "atp301x.h"

// Serial options
#include "serial.h"
#include "fprintf.h"
#include "sprintf.h"
extern tsFILE sSerStream;
#include "Interactive.h"

// ATP3011 I2C addr
static const uint8 u8addr = 0x2E;

// 戸締りオーケーです。
const char su8AtpMsg_Ok[] = "toji'mari;o'-ke-de_su.\r";
// 戸締りを確認してください。
const char su8AtpMsg_Pre_Door[] = "toji'mario/kakuninn_shitekudasa'i.\r";
// の窓があいています。
const char su8AtpMsg_Post_Door[] = "no/ma'doga/aiteima'_su.\r";
// 電圧が低下しています。
const char su8AtpMsg_Pre_Batt[] = "dennatsu/ga/teika_shiteima'_su.\r";
// の電池を交換してください。
const char su8AtpMsg_Post_Batt[] = "no/de'nnchio/ko-kann_shitekudasa'i.\r";
// 通信エラーです。
const char su8AtpMsg_Pre_Comm[] = "tsu-shinn;e'ra-de_su.\r";
// の窓からの応答がありません。
const char su8AtpMsg_Post_Comm[] = "no/ma'dokarano/o-to-ga/arimase'nn.\r";

// アクセスポイントの応答がありません。
const char su8AtpMsg_Accesspoint[] = "a_kuse_supo'inntono/o-to-ga/arimase'nn.\r";
// この端末
const char su8AtpMsg_Name_Remote[] = "kono/tannmatsu";

bool_t bAtpSpeak(uint8 *command)
{
	if (command == NULL) {
		return FALSE;
	}
	bool_t bOk = TRUE;
	uint16 len = strlen((const char*)command);
	bOk &= bSMBusWrite(u8addr, command[0], len - 1, command + 1);
	if (!bOk) {
		V_PRINTF(LB"[bSpeakAtp(%s)] not OK", command);
	}
	return bOk;
}

bool_t bAtpAbort() {
	bool_t bOk = TRUE;
	// ATP301x should return 'E255>', but don't wait it.
	bOk &= bSMBusWrite(u8addr, '$', 0, NULL);
	if (!bOk) {
		V_PRINTF(LB"[bAtpAbort()] not OK");
	}
	return bOk;
}

bool_t bIsAtpBusy() {
	bool_t bBusy = FALSE;
	uint8 au8ReadBuf[1];
	if (bSMBusSequentialRead(u8addr, 1, au8ReadBuf)) {
		if (au8ReadBuf[0] == '*') {
			bBusy = TRUE;
		}
	}
	return bBusy;
}

static void vBuildLidList(uint32 u32bitmap, uint8 *msg)
{
	uint8 *q = msg;
	uint8 chr = 'A';
	int i;
	for (i = 1; i <= 16; i++)
	{
		if (u32bitmap & (1 << i)) {
			if (msg < q) {
				S_OCTET(' ');
			}
			S_OCTET(chr);
		}
		chr++;
	}
	S_OCTET('\0');
}

/**
 *
 * @param pDoorState
 * @param msg1
 * @param msg2
 * @return
 */
bool_t bAtpPrepareMessage(tsDoorStateData *pDoorState, uint8 *msg1, uint8 *msg2) {
	if (pDoorState == NULL || msg1 == NULL || msg2 == NULL) {
		return FALSE;
	}
	uint8 au8LidList[33];

	// 親機不通では話にならない
	if (pDoorState->u32CommErrMap & 1) {
		strcpy((char*)msg1, su8AtpMsg_Pre_Comm);
		strcpy((char*)msg2, su8AtpMsg_Accesspoint);
	} else {
		// 以降、即時解決できる問題を優先して報告
		// 開放された窓は閉めなくてはならない
		if (pDoorState->u32OpenedMap != 0) {
			strcpy((char*)msg1, su8AtpMsg_Pre_Door);
			vBuildLidList(pDoorState->u32OpenedMap, au8LidList);
			sprintf((char*)msg2, "<ALPHA VAL=\"%s\">%s", au8LidList, su8AtpMsg_Post_Door);
		} else if (pDoorState->u32LowBattMap != 0) {
			// バッテリー警告
			strcpy((char*)msg1, su8AtpMsg_Pre_Batt);
			if (pDoorState->u32LowBattMap & 1) {
				vBuildLidList(pDoorState->u32LowBattMap, au8LidList);
				sprintf((char*)msg2, "%s%s", su8AtpMsg_Name_Remote, su8AtpMsg_Post_Batt);
			} else {
				vBuildLidList(pDoorState->u32LowBattMap, au8LidList);
				sprintf((char*)msg2, "<ALPHA VAL=\"%s\">%s", au8LidList, su8AtpMsg_Post_Batt);
			}
		} else if (pDoorState->u32CommErrMap != 0) {
			// 通信障害は解決に時間がかかる
			strcpy((char*)msg1, su8AtpMsg_Pre_Comm);
			vBuildLidList(pDoorState->u32CommErrMap, au8LidList);
			sprintf((char*)msg2, "<ALPHA VAL=\"%s\">%s", au8LidList, su8AtpMsg_Post_Comm);
		} else {
			// 問題なし
			strcpy((char*)msg1, su8AtpMsg_Ok);
			msg2[0] = 0;
		}
	}
	return TRUE;
}

