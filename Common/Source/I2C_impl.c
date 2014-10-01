/****************************************************************************
 * (C) Tokyo Cosmos Electric, Inc. (TOCOS) - 2013 all rights reserved.
 *
 * Condition to use: (refer to detailed conditions in Japanese)
 *   - The full or part of source code is limited to use for TWE (TOCOS
 *     Wireless Engine) as compiled and flash programmed.
 *   - The full or part of source code is prohibited to distribute without
 *     permission from TOCOS.
 *
 * 利用条件:
 *   - 本ソースコードは、別途ソースコードライセンス記述が無い限り東京コスモス電機が著作権を
 *     保有しています。
 *   - 本ソースコードは、無保証・無サポートです。本ソースコードや生成物を用いたいかなる損害
 *     についても東京コスモス電機は保証致しません。不具合等の報告は歓迎いたします。
 *   - 本ソースコードは、東京コスモス電機が販売する TWE シリーズ上で実行する前提で公開
 *     しています。他のマイコン等への移植・流用は一部であっても出来ません。
 *
 ****************************************************************************/

/****************************************************************************/
/***        Include files                                                 ***/
/****************************************************************************/
#include <string.h>
#include <AppHardwareApi.h>

//#include "Parent.h"

#include "common.h"
#include "config.h"

#include <utils.h>

// I2C
#include "SMBus.h"
#include "I2C_impl.h"

// Serial options
#include <serial.h>
#include <fprintf.h>
#include <sprintf.h>

#include "sercmd_gen.h"

/****************************************************************************/
/***        実験的な実装定義                                              ***/
/****************************************************************************/

/** @ingroup MASTER
 * I2C LCD モジュールテスト用のコード
 *   本定義が実装されると、I2C 接続の LCD デバイスにテスト文字を表示する
 *   - IO入力を受け取った時そのボタンに応じたメッセージを表示
 *   - インタラクティブモードで 1-4 に対応してメッセージを表示
 */
#define USE_I2C_LCD_TEST_CODE
#ifdef USE_I2C_LCD_TEST_CODE
#warning "EXPERIMENTAL: USE_I2C_LCD_TEST_CODE"
#endif

/****************************************************************************/
/***        Macro Definitions                                             ***/
/****************************************************************************/

/****************************************************************************/
/***        Type Definitions                                              ***/
/****************************************************************************/

/****************************************************************************/
/***        Local Function Prototypes                                     ***/
/****************************************************************************/

/****************************************************************************/
/***        Exported Variables                                            ***/
/****************************************************************************/

/****************************************************************************/
/***        Local Variables                                               ***/
/****************************************************************************/

/****************************************************************************/
/***        FUNCTIONS                                                     ***/
/****************************************************************************/


#ifdef USE_I2C_ACM1620
/** @ingroup MASTER
 * ACM1620 LCD モジュールに文字列を書き出す。
 * - この処理は、一定時間処理をブロックし、IO判定などTIMER_0起点の動作などに影響を及ぼします。
 * - ２つのパラメータを両方とも NULL にすると、画面クリアを行います。
 *
 * @param puUpperRow 上段に書き込む文字列
 * @param puLowerRow 下段に書き込む文字列
 * @return
 */
bool_t bDraw2LinesLcd_ACM1602(const char *puUpperRow,
		const char *puLowerRow) {
	bool_t bOk = TRUE;
	const uint8 *pu8data;
	const uint32 u32delay = 20000;

	// ディスプレーのクリア
	const uint8 au8data[] = { 0x01, 0x38, 0x0c, 0x06, 0x00 };
	pu8data = au8data;
	while (*pu8data) {
		bOk &= bSMBusWrite(0x50, 0x00, 1, (uint8*) pu8data);
		vWait(u32delay);

		pu8data++;
	}

	// 上段への書き込み
	if (puUpperRow) {
		uint8 u8data = 0x80; // 上段のアドレス指定
		int i = 0;

		bOk &= bSMBusWrite(0x50, 0x00, 1, &u8data);
		vWait(u32delay);

		pu8data = (uint8*) puUpperRow;

		while (*pu8data && i < 16) {
			bOk &= bSMBusWrite(0x50, 0x80, 1, (uint8*) pu8data);
			vWait(u32delay);

			pu8data++;
			i++;
		}
	}

	// 下段への書き込み
	if (puLowerRow) {
		uint8 u8data = 0xC0; // 下段のアドレス指定
		int i = 0;

		bOk &= bSMBusWrite(0x50, 0x00, 1, &u8data);
		vWait(u32delay);

		pu8data = (uint8*) puLowerRow;

		while (*pu8data && i < 16) {
			bOk &= bSMBusWrite(0x50, 0x80, 1, (uint8*) pu8data);
			vWait(u32delay);

			pu8data++;
			i++;
		}
	}

	return bOk;
}
#endif

#ifdef USE_I2C_AQM0802A
static bool_t bInit_AQM0802A = FALSE;

bool_t bInit2LinesLcd_AQM0802A() {
	bool_t bOk = TRUE;
	const uint8 *pu8data;
	const uint32 u32delay = 2000;
	const uint8 u8addr = 0x3E;

	// ディスプレーのクリア
	const uint8 au8data[] = { 0x38, 0x39, 0x14, 0x70, 0x56, 0x6c, 0x00 };
	pu8data = au8data;
	while (*pu8data && bOk) {
		bOk &= bSMBusWrite(u8addr, 0x00, 1, (uint8*) pu8data);
		vWait(u32delay);

		pu8data++;
	}
	vWait(400000);

	bInit_AQM0802A = TRUE;
	return bOk;
}

void bDeinit2LinesLcd_AQM0802A() {
	bInit_AQM0802A = FALSE;
}

/** @ingroup MASTER
 * ACM1620 LCD モジュールに文字列を書き出す。
 * - この処理は、一定時間処理をブロックし、IO判定などTIMER_0起点の動作などに影響を及ぼします。
 * - ２つのパラメータを両方とも NULL にすると、画面クリアを行います。
 *
 * @param puUpperRow 上段に書き込む文字列
 * @param puLowerRow 下段に書き込む文字列
 * @return
 */
bool_t bDraw2LinesLcd_AQM0802A(const char *puUpperRow,
		const char *puLowerRow) {
	bool_t bOk = TRUE;
	const uint8 *pu8data;
	const uint32 u32delay = 2000;
	const uint8 u8addr = 0x3E;


	// ディスプレーのクリア
	if (!bInit_AQM0802A) {
		bOk &= bInit2LinesLcd_AQM0802A();
	}

	const uint8 au8data2[] = { 0x38, 0x0c, 0x01, 0x06, 0x00 };
	pu8data = au8data2;
	while (*pu8data && bOk) {
		bOk &= bSMBusWrite(u8addr, 0x00, 1, (uint8*) pu8data);
		vWait(u32delay);

		pu8data++;
	}

	// 上段への書き込み
	if (puUpperRow && bOk) {
		uint8 u8data = 0x80; // 上段のアドレス指定
		int i = 0;

		bOk &= bSMBusWrite(u8addr, 0x00, 1, &u8data);
		vWait(u32delay);

		pu8data = (uint8*) puUpperRow;

		while (*pu8data && i < 8 && bOk) {
			bOk &= bSMBusWrite(u8addr, 0x40, 1, (uint8*) pu8data);
			vWait(u32delay);

			pu8data++;
			i++;
		}
	}

	// 下段への書き込み
	if (puLowerRow && bOk) {
		uint8 u8data = 0xC0; // 下段のアドレス指定
		int i = 0;

		bOk &= bSMBusWrite(u8addr, 0x00, 1, &u8data);
		vWait(u32delay);

		pu8data = (uint8*) puLowerRow;

		while (*pu8data && i < 8 && bOk) {
			bOk &= bSMBusWrite(u8addr, 0x40, 1, (uint8*) pu8data);
			vWait(u32delay);

			pu8data++;
			i++;
		}
	}

	return bOk;
}
#endif

/****************************************************************************/
/***        END OF FILE                                                   ***/
/****************************************************************************/
