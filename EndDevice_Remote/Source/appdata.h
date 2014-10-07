/*
 * appdata.h
 *
 *  Created on: 2014/03/14
 *      Author: seigo13
 */

#ifndef APPDATA_H_
#define APPDATA_H_

#include <jendefs.h>
#include "ToCoNet.h"
#include "flash.h"
#include "appsave.h"
#include "adc.h"

/**
 * LED 制御状態
 */
typedef enum {
	E_LED_OFF,  //!< E_LED_OFF
	E_LED_WAIT, //!< E_LED_WAIT
	E_LED_ERROR,//!< E_LED_ERROR
	E_LED_RESULT//!< E_LED_RESULT
} teLedState;

typedef struct {
	uint32 u32OpenedMap;  //!< 解放窓ビットマップ b0:不使用, b1...b16:センサー子機 1ならば窓開放
	uint32 u32LowBattMap; //!< 低電圧ビットマップ b0:リモート子機, b1...b16:センサー子機 1ならば低電圧
	uint32 u32CommErrMap; //!< 通信エラービットマップ b0:親機, b1...b16:センサー子機 1ならば無応答
} tsDoorStateData;

typedef struct {
	// sensor data
	uint8 u8Batt;
	uint16 u16Adc1, u16Adc2;
	uint16 u16PC1, u16PC2;
	uint16 u16Temp, u16Humid;
} tsSensorData;

/**
 * アプリケーション基本データ構造体
 */
typedef struct {
	// Network context
	tsToCoNet_Nwk_Context *pContextNwk;
	tsToCoNet_NwkLyTr_Config sNwkLayerTreeConfig;

	// その他
	tsFlash sFlash; //!< フラッシュの情報
	bool_t bFlashLoaded; //!< フラッシュにデータが有れば TRUE
	uint8 u8DebugLevel; //!< ToCoNet デバッグレベル

	// wakeup status
	bool_t bWakeupByButton; //!< DIO で RAM HOLD Wakeup した場合 TRUE

	// config mode
	bool_t bConfigMode; //! CONFIG で起動した場合（インタラクティブモードを使用するため)

	// ADC
	tsObjData_ADC sObjADC; //!< ADC管理構造体（データ部）
	tsSnsObj sADC; //!< ADC管理構造体（制御部）
	// センサ情報
	tsSensorData sSns;

	// state
	teLedState eLedState; //!< LED表示状態
	tsDoorStateData sDoorState;
} tsAppData_Re;
extern tsAppData_Re sAppData_Re;

#endif /* APPDATA_H_ */
