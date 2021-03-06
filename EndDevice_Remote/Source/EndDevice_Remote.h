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

#ifndef  MASTER_H_INCLUDED
#define  MASTER_H_INCLUDED

#if defined __cplusplus
extern "C" {
#endif

/****************************************************************************/
/***        Include Files                                                 ***/
/****************************************************************************/
#include "config.h"
#include "appdata.h"

/****************************************************************************/
/***        Macro Definitions                                             ***/
/****************************************************************************/
#define USE_I2C_AQM0802A
#define USE_I2C_ACM1620

#define DIO_DISP_POWER (PORT_OUT3)
#define DIO_SPEAK_RESET (PORT_OUT4)
/**
 * 定義された場合、親機への問い合わせ待ちの替わりに MessagePool の問い合わせを使う
 */
#define ENDD_USE_MESSAGE_POOL

#define ENDD_SLEEP_PERIOD_s (5) //!< DEEPスリープまでの移行時間
#define ENDD_LED_DISP_DUR_ms (8000) //!< LEDの結果表示時間
#define ENDD_LED_ERROR_DUR_ms (2000) //!< LEDのエラー表示時間
#define ENDD_TIMEOUT_CONNECT_ms (600) //!< 接続タイムアウト
#define ENDD_TIMEOUT_WAIT_MSG_ms (600) //!< 親機からのメッセージの待ち時間
#define ENDD_TIMEOUT_ADC_ms (200) //!< ADCの待ち時間


/**
 * スイッチ状態の一つのみを表示させるリモコンとして動作する
 */
#define ENDD_SINGLE_LED

/**
 * 表示するスイッチの番号
 *   (0) ～ (3)
 */
#define ENDD_SINGLE_LED_ID (0)

/**
 * LCD を使用するか
 */
#undef USE_LCD

/****************************************************************************/
/***        Type Definitions                                              ***/
/****************************************************************************/

/****************************************************************************/
/***        Exported Functions                                            ***/
/****************************************************************************/

/****************************************************************************/
/***        Exported Variables                                            ***/
/****************************************************************************/

#if defined __cplusplus
}
#endif

#endif  /* MASTER_H_INCLUDED */

/****************************************************************************/
/***        END OF FILE                                                   ***/
/****************************************************************************/
