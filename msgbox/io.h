#ifndef __IO_H__
#define __IO_H__

#define RC_DEVICE	"/dev/input/nevis_ir"

#include <config.h>

#if defined(HAVE_DUCKBOX_HARDWARE) || defined(BOXMODEL_VUSOLO4K)
#define RC_DEVICE_FALLBACK "/dev/input/event0"
#else
#define RC_DEVICE_FALLBACK "/dev/input/event1"
#endif

int InitRC(void);
int CloseRC(void);
int RCKeyPressed(void);
int GetRCCode(int);
void ClearRC(void);

#endif
