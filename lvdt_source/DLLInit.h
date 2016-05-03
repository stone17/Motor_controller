/*----------------------------------------------------------------------------
    File: DLLINIT.H
------------------------------------------------------------------------------

    Meilhaus Electronic GmbH

    Header file containing Typedefs for the ME-iDS.  This header is
    for use in projects using dynamic function calls (no library file is
    included in the project)

    Version 1.00:   2008-03-19
-------------------------------------------------------------------------------
    Author: Andreas Bernau
-----------------------------------------------------------------------------*/

#ifndef DLLINIT_H
#define DLLINIT_H

#include "medefines.h"
#include "metypes.h"
#include "meerror.h"

#define SUCCESS             0x01
#define DLLNOTFOUND         0x02
#define FUNCTIONNOTFOUND    0x03
#define DLLNAME             "meIDSmain64.dll"


typedef   int(__cdecl *PF_MEOPEN)(int iFlags);
typedef   int(__cdecl *PF_MECLOSE)(int iFlags);
typedef   int(__cdecl *PF_MELOCKDRIVER)(int iLock,int iFlags);
typedef   int(__cdecl *PF_MELOCKDEVICE)(int iDevice,int iLock,int iFlags);
typedef   int(__cdecl *PF_MELOCKSUBDEVICE)(int iDevice,int iSubdevice,int iLock,int iFlags);
typedef   int(__cdecl *PF_MEERRORGETLASTMESSAGE)(char *pcErrorMsg,int iCount);
typedef   int(__cdecl *PF_MEERRORGETMESSAGE)(int iErrorCode,char *pcErrorMsg,int iCount);
typedef   int(__cdecl *PF_MEERRORSETDEFAULTPROC)(int iSwitch);
typedef   int(__cdecl *PF_MEERRORSETUSERPROC)(meErrorCB_t pErrorProc);
typedef   int(__cdecl *PF_MEIOIRQSETCALLBACK)(int iDevice,int iSubdevice,meIOIrqCB_t pCallback,void *pCallbackContext,int iFlags);
typedef   int(__cdecl *PF_MEIOIRQSTART)(int iDevice,int iSubdevice,int iChannel,int iIrqSource,int iIrqEdge,int iIrqArg,int iFlags);
typedef   int(__cdecl *PF_MEIOIRQSTOP)(int iDevice,int iSubdevice,int iChannel,int iFlags);
typedef   int(__cdecl *PF_MEIOIRQWAIT)(int iDevice,int iSubdevice,int iChannel,int *piIrqCount,int *piValue,int iTimeOut,int iFlags);
typedef   int(__cdecl *PF_MEIORESETDEVICE)(int iDevice,int iFlags);
typedef   int(__cdecl *PF_MEIORESETSUBDEVICE)(int iDevice,int iSubdevice,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMFREQUENCYTOTICKS)(int iDevice,int iSubdevice,int iTimer,double *pdFrequency,int *piTicksLow,int *piTicksHigh,int iFlags);
typedef   int(__cdecl *PF_MEIOSINGLECONFIG)(int iDevice,int iSubdevice,int iChannel,int iSingleConfig,int iRef,int iTrigChan,int iTrigType,int iTrigEdge,int iFlags);
typedef   int(__cdecl *PF_MEIOSINGLE)(meIOSingle_t *pSingleList,int iCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMCONFIG)(int iDevice,int iSubdevice,meIOStreamConfig_t *pConfigList,int iCount,meIOStreamTrigger_t *pTrigger,int iFifoIrqThreshold,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMNEWVALUES)(int iDevice,int iSubdevice,int iTimeOut,int *piCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMREAD)(int iDevice,int iSubdevice,int iReadMode,int *piValues,int *piCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMWRITE)(int iDevice,int iSubdevice,int iWriteMode,int *piValues,int *piCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMSTART)(meIOStreamStart_t *pStartList,int iCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMSTOP)(meIOStreamStop_t *pStopList,int iCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMSTATUS)(int iDevice,int iSubdevice,int iWait,int *piStatus,int *piCount,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMSETCALLBACKS)(int iDevice,int iSubdevice,meIOStreamCB_t pStartCB,void *pStartCBContext,meIOStreamCB_t pNewValuesCB,void *pNewValuesCBContext,meIOStreamCB_t pEndCB,void *pEndCBContext,int iFlags);
typedef   int(__cdecl *PF_MEIOSTREAMTIMETOTICKS)(int iDevice,int iSubdevice,int iTimer,double *pdTime,int *piTicksLow,int *piTicksHigh,int iFlags);
typedef   int(__cdecl *PF_MEQUERYDESCRIPTIONDEVICE)(int iDevice,char *pcDescription,int iCount);
typedef   int(__cdecl *PF_MEQUERYINFODEVICE)(int iDevice,int *piVendorId,int *piDeviceId,int *piSerialNo,int *piBusType,int *piBusNo,int *piDevNo,int *piFuncNo,int *piPlugged);
typedef   int(__cdecl *PF_MEQUERYNAMEDEVICE)(int iDevice,char *pcName,int iCount);
typedef   int(__cdecl *PF_MEQUERYNAMEDEVICEDRIVER)(int iDevice,char *pcName,int iCount);
typedef   int(__cdecl *PF_MEQUERYNUMBERDEVICES)(int *piNumber);
typedef   int(__cdecl *PF_MEQUERYNUMBERSUBDEVICES)(int iDevice,int *piNumber);
typedef   int(__cdecl *PF_MEQUERYNUMBERCHANNELS)(int iDevice,int iSubdevice,int *piNumber);
typedef   int(__cdecl *PF_MEQUERYNUMBERRANGES)(int iDevice,int iSubdevice,int iUnit,int *piNumber);
typedef   int(__cdecl *PF_MEQUERYRANGEBYMINMAX)(int iDevice,int iSubdevice,int iUnit,double *pdMin,double *pdMax,int *piMaxData,int *piRange);
typedef   int(__cdecl *PF_MEQUERYRANGEINFO)(int iDevice,int iSubdevice,int iRange,int *piUnit,double *pdMin,double *pdMax,int *piMaxData);
typedef   int(__cdecl *PF_MEQUERYSUBDEVICEBYTYPE)(int iDevice,int iStartSubdevice,int iType,int iSubtype,int *piSubdevice);
typedef   int(__cdecl *PF_MEQUERYSUBDEVICETYPE)(int iDevice,int iSubdevice,int *piType,int *piSubtype);
typedef   int(__cdecl *PF_MEQUERYSUBDEVICECAPS)(int iDevice,int iSubdevice,int *piCaps);
typedef   int(__cdecl *PF_MEQUERYSUBDEVICECAPSARGS)(int iDevice,int iSubdevice,int iCap,int *piArgs,int iCount);
typedef   int(__cdecl *PF_MEQUERYVERSIONLIBRARY)(int *piVersion);
typedef   int(__cdecl *PF_MEQUERYVERSIONMAINDRIVER)(int *piVersion);
typedef   int(__cdecl *PF_MEQUERYVERSIONDEVICEDRIVER)(int iDevice,int *piVersion);
typedef   int(__cdecl *PF_MEUTILITYEXTRACTVALUES)(int iChannel,int *piAIBuffer,int iAIBufferCount,meIOStreamConfig_t *pConfigList,int iConfigListCount,int *piChanBuffer,int *piChanBufferCount);
typedef   int(__cdecl *PF_MEUTILITYDIGITALTOPHYSICAL)(double dMin,double dMax,int iMaxData,int iData,int iModuleType,double dRefValue,double *pdPhysical);
typedef   int(__cdecl *PF_MEUTILITYDIGITALTOPHYSICALV)(double dMin,double dMax,int iMaxData,int *piDataBuffer,int iCount,int iModuleType,double dRefValue,double *pdPhysicalBuffer);
typedef   int(__cdecl *PF_MEUTILITYPHYSICALTODIGITAL)(double dMin,double dMax,int iMaxData,double dPhysical,int *piData);
typedef   int(__cdecl *PF_MEUTILITYPHYSICALTODIGITALV)(double dMin,double dMax,int iMaxData,double* pdPhysicalBuffer,int iCount,int *piDataBuffer);
typedef   int(__cdecl *PF_MEUTILITYPWMSTART)(int iDevice,int iSubdevice1,int iSubdevice2,int iSubdevice3,int iRef,int iPrescaler,int iDutyCycle,int iFlag);
typedef   int(__cdecl *PF_MEUTILITYPWMSTOP)(int iDevice,int iSubdevice1);



// -------------------- Function Prototypes --------------------------------

void meOpenDynamicAccess (void);
void meCloseDynamicAccess (void);

int meOpen(int iFlags);
int meClose(int iFlags);
int meLockDriver(int iLock,int iFlags);
int meLockDevice(int iDevice,int iLock,int iFlags);
int meLockSubdevice(int iDevice,int iSubdevice,int iLock,int iFlags);
int meErrorGetLastMessage(char *pcErrorMsg,int iCount);
int meErrorGetMessage(int iErrorCode,char *pcErrorMsg,int iCount);
int meErrorSetDefaultProc(int iSwitch);
int meErrorSetUserProc(meErrorCB_t pErrorProc);
int meIOIrqSetCallback(int iDevice,int iSubdevice,meIOIrqCB_t pCallback,void *pCallbackContext,int iFlags);
int meIOIrqStart(int iDevice,int iSubdevice,int iChannel,int iIrqSource,int iIrqEdge,int iIrqArg,int iFlags);
int meIOIrqStop(int iDevice,int iSubdevice,int iChannel,int iFlags);
int meIOIrqWait(int iDevice,int iSubdevice,int iChannel,int *piIrqCount,int *piValue,int iTimeOut,int iFlags);
int meIOResetDevice(int iDevice,int iFlags);
int meIOResetSubdevice(int iDevice,int iSubdevice,int iFlags);
int meIOStreamFrequencyToTicks(int iDevice,int iSubdevice,int iTimer,double *pdFrequency,int *piTicksLow,int *piTicksHigh,int iFlags);
int meIOSingleConfig(int iDevice,int iSubdevice,int iChannel,int iSingleConfig,int iRef,int iTrigChan,int iTrigType,int iTrigEdge,int iFlags);
int meIOSingle(meIOSingle_t *pSingleList,int iCount,int iFlags);
int meIOStreamConfig(int iDevice,int iSubdevice,meIOStreamConfig_t *pConfigList,int iCount,meIOStreamTrigger_t *pTrigger,int iFifoIrqThreshold,int iFlags);
int meIOStreamNewValues(int iDevice,int iSubdevice,int iTimeOut,int *piCount,int iFlags);
int meIOStreamRead(int iDevice,int iSubdevice,int iReadMode,int *piValues,int *piCount,int iFlags);
int meIOStreamWrite(int iDevice,int iSubdevice,int iWriteMode,int *piValues,int *piCount,int iFlags);
int meIOStreamStart(meIOStreamStart_t *pStartList,int iCount,int iFlags);
int meIOStreamStop(meIOStreamStop_t *pStopList,int iCount,int iFlags);
int meIOStreamStatus(int iDevice,int iSubdevice,int iWait,int *piStatus,int *piCount,int iFlags);
int meIOStreamSetCallbacks(int iDevice,int iSubdevice,meIOStreamCB_t pStartCB,void *pStartCBContext,meIOStreamCB_t pNewValuesCB,void *pNewValuesCBContext,meIOStreamCB_t pEndCB,void *pEndCBContext,int iFlags);
int meIOStreamTimeToTicks(int iDevice,int iSubdevice,int iTimer,double *pdTime,int *piTicksLow,int *piTicksHigh,int iFlags);
int meQueryDescriptionDevice(int iDevice,char *pcDescription,int iCount);
int meQueryInfoDevice(int iDevice,int *piVendorId,int *piDeviceId,int *piSerialNo,int *piBusType,int *piBusNo,int *piDevNo,int *piFuncNo,int *piPlugged);
int meQueryNameDevice(int iDevice,char *pcName,int iCount);
int meQueryNameDeviceDriver(int iDevice,char *pcName,int iCount);
int meQueryNumberDevices(int *piNumber);
int meQueryNumberSubdevices(int iDevice,int *piNumber);
int meQueryNumberChannels(int iDevice,int iSubdevice,int *piNumber);
int meQueryNumberRanges(int iDevice,int iSubdevice,int iUnit,int *piNumber);
int meQueryRangeByMinMax(int iDevice,int iSubdevice,int iUnit,double *pdMin,double *pdMax,int *piMaxData,int *piRange);
int meQueryRangeInfo(int iDevice,int iSubdevice,int iRange,int *piUnit,double *pdMin,double *pdMax,int *piMaxData);
int meQuerySubdeviceByType(int iDevice,int iStartSubdevice,int iType,int iSubtype,int *piSubdevice);
int meQuerySubdeviceType(int iDevice,int iSubdevice,int *piType,int *piSubtype);
int meQuerySubdeviceCaps(int iDevice,int iSubdevice,int *piCaps);
int meQuerySubdeviceCapsArgs(int iDevice,int iSubdevice,int iCap,int *piArgs,int iCount);
int meQueryVersionLibrary(int *piVersion);
int meQueryVersionMainDriver(int *piVersion);
int meQueryVersionDeviceDriver(int iDevice,int *piVersion);
int meUtilityExtractValues(int iChannel,int *piAIBuffer,int iAIBufferCount,meIOStreamConfig_t *pConfigList,int iConfigListCount,int *piChanBuffer,int *piChanBufferCount);
int meUtilityDigitalToPhysical(double dMin,double dMax,int iMaxData,int iData,int iModuleType,double dRefValue,double *pdPhysical);
int meUtilityDigitalToPhysicalV(double dMin,double dMax,int iMaxData,int *piDataBuffer,int iCount,int iModuleType,double dRefValue,double *pdPhysicalBuffer);
int meUtilityPhysicalToDigital(double dMin,double dMax,int iMaxData,double dPhysical,int *piData);
int meUtilityPhysicalToDigitalV(double dMin,double dMax,int iMaxData,double* pdPhysicalBuffer,int iCount,int *piDataBuffer);
int meUtilityPWMStart(int iDevice,int iSubdevice1,int iSubdevice2,int iSubdevice3,int iRef,int iPrescaler,int iDutyCycle,int iFlag);
int meUtilityPWMStop(int iDevice,int iSubdevice1);

#endif
