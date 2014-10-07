
#ifndef ATP_H_INCLUDED
#define ATP_H_INCLUDED
#if defined __cplusplus
extern "C" {
#endif


/**** Message String ***/

bool_t bAtpAbort();
bool_t bIsAtpBusy();
bool_t bAtpSpeak(uint8 *command);
bool_t bAtpPrepareMessage(tsDoorStateData *pDoorState, uint8 *msg1, uint8 *msg2);

#if defined __cplusplus
}
#endif
#endif
