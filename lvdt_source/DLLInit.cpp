/*----------------------------------------------------------------------------
    File: DLLINIT.CPP
------------------------------------------------------------------------------ 

    Meilhaus Electronic GmbH

    C source file containing wrapper for all DLL functions.  This file is
    for use in projects using dynamic function calls (no library file is
    included in the project)

    Version 1.00:   2008-03-19
-------------------------------------------------------------------------------
    Author: Andreas Bernau
-----------------------------------------------------------------------------*/

#include <stdio.h>
#include <windows.h>
#include <conio.h>

#include ".\medefines.h"
#include ".\DLLInit.h"

/*  Definitions  used for Borland C only */
#ifdef __BORLANDC__
#include "condefs.h"
#include ".\medefines.h";
#include ".\DLLInit.h";
#endif




PF_MEOPEN pf_meOpen;
PF_MECLOSE pf_meClose;
PF_MELOCKDRIVER pf_meLockDriver;
PF_MELOCKDEVICE pf_meLockDevice;
PF_MELOCKSUBDEVICE pf_meLockSubdevice;
PF_MEERRORGETLASTMESSAGE pf_meErrorGetLastMessage;
PF_MEERRORGETMESSAGE pf_meErrorGetMessage;
PF_MEERRORSETDEFAULTPROC pf_meErrorSetDefaultProc;
PF_MEERRORSETUSERPROC pf_meErrorSetUserProc;
PF_MEIOIRQSETCALLBACK pf_meIOIrqSetCallback;
PF_MEIOIRQSTART pf_meIOIrqStart;
PF_MEIOIRQSTOP pf_meIOIrqStop;
PF_MEIOIRQWAIT pf_meIOIrqWait;
PF_MEIORESETDEVICE pf_meIOResetDevice;
PF_MEIORESETSUBDEVICE pf_meIOResetSubdevice;
PF_MEIOSTREAMFREQUENCYTOTICKS pf_meIOStreamFrequencyToTicks;
PF_MEIOSINGLECONFIG pf_meIOSingleConfig;
PF_MEIOSINGLE pf_meIOSingle;
PF_MEIOSTREAMCONFIG pf_meIOStreamConfig;
PF_MEIOSTREAMNEWVALUES pf_meIOStreamNewValues;
PF_MEIOSTREAMREAD pf_meIOStreamRead;
PF_MEIOSTREAMWRITE pf_meIOStreamWrite;
PF_MEIOSTREAMSTART pf_meIOStreamStart;
PF_MEIOSTREAMSTOP pf_meIOStreamStop;
PF_MEIOSTREAMSTATUS pf_meIOStreamStatus;
PF_MEIOSTREAMSETCALLBACKS pf_meIOStreamSetCallbacks;
PF_MEIOSTREAMTIMETOTICKS pf_meIOStreamTimeToTicks;
PF_MEQUERYDESCRIPTIONDEVICE pf_meQueryDescriptionDevice;
PF_MEQUERYINFODEVICE pf_meQueryInfoDevice;
PF_MEQUERYNAMEDEVICE pf_meQueryNameDevice;
PF_MEQUERYNAMEDEVICEDRIVER pf_meQueryNameDeviceDriver;
PF_MEQUERYNUMBERDEVICES pf_meQueryNumberDevices;
PF_MEQUERYNUMBERSUBDEVICES pf_meQueryNumberSubdevices;
PF_MEQUERYNUMBERCHANNELS pf_meQueryNumberChannels;
PF_MEQUERYNUMBERRANGES pf_meQueryNumberRanges;
PF_MEQUERYRANGEBYMINMAX pf_meQueryRangeByMinMax;
PF_MEQUERYRANGEINFO pf_meQueryRangeInfo;
PF_MEQUERYSUBDEVICEBYTYPE pf_meQuerySubdeviceByType;
PF_MEQUERYSUBDEVICETYPE pf_meQuerySubdeviceType;
PF_MEQUERYSUBDEVICECAPS pf_meQuerySubdeviceCaps;
PF_MEQUERYSUBDEVICECAPSARGS pf_meQuerySubdeviceCapsArgs;
PF_MEQUERYVERSIONLIBRARY pf_meQueryVersionLibrary;
PF_MEQUERYVERSIONMAINDRIVER pf_meQueryVersionMainDriver;
PF_MEQUERYVERSIONDEVICEDRIVER pf_meQueryVersionDeviceDriver;
PF_MEUTILITYEXTRACTVALUES pf_meUtilityExtractValues;
PF_MEUTILITYDIGITALTOPHYSICAL pf_meUtilityDigitalToPhysical;
PF_MEUTILITYDIGITALTOPHYSICALV pf_meUtilityDigitalToPhysicalV;
PF_MEUTILITYPHYSICALTODIGITAL pf_meUtilityPhysicalToDigital;
PF_MEUTILITYPHYSICALTODIGITALV pf_meUtilityPhysicalToDigitalV;
PF_MEUTILITYPWMSTART pf_meUtilityPWMStart;
PF_MEUTILITYPWMSTOP pf_meUtilityPWMStop;


HINSTANCE hDll;


void meOpenDynamicAccess(void)
{
    hDll = LoadLibrary(DLLNAME);
    if (hDll == NULL)
    {
        MessageBox( NULL, "DLL not Found", "Error", MB_OK | MB_ICONINFORMATION );
        exit(1);
    }
    
    
  pf_meOpen=  (PF_MEOPEN )
  			(GetProcAddress (hDll,"meOpen"));
  
  pf_meClose=  (PF_MECLOSE )
  			(GetProcAddress (hDll,"meClose"));
  
  pf_meLockDriver=  (PF_MELOCKDRIVER )
  			(GetProcAddress (hDll,"meLockDriver"));
  
  pf_meLockDevice=  (PF_MELOCKDEVICE )
  			(GetProcAddress (hDll,"meLockDevice"));
  
  pf_meLockSubdevice=  (PF_MELOCKSUBDEVICE )
  			(GetProcAddress (hDll,"meLockSubdevice"));
  
  pf_meErrorGetLastMessage=  (PF_MEERRORGETLASTMESSAGE )
  			(GetProcAddress (hDll,"meErrorGetLastMessage"));
  
  pf_meErrorGetMessage=  (PF_MEERRORGETMESSAGE )
  			(GetProcAddress (hDll,"meErrorGetMessage"));
  
  pf_meErrorSetDefaultProc=  (PF_MEERRORSETDEFAULTPROC )
  			(GetProcAddress (hDll,"meErrorSetDefaultProc"));
  
  pf_meErrorSetUserProc=  (PF_MEERRORSETUSERPROC )
  			(GetProcAddress (hDll,"meErrorSetUserProc"));
  
  pf_meIOIrqSetCallback=  (PF_MEIOIRQSETCALLBACK )
  			(GetProcAddress (hDll,"meIOIrqSetCallback"));
  
  pf_meIOIrqStart=  (PF_MEIOIRQSTART )
  			(GetProcAddress (hDll,"meIOIrqStart"));
  
  pf_meIOIrqStop=  (PF_MEIOIRQSTOP )
  			(GetProcAddress (hDll,"meIOIrqStop"));
  
  pf_meIOIrqWait=  (PF_MEIOIRQWAIT )
  			(GetProcAddress (hDll,"meIOIrqWait"));
  
  pf_meIOResetDevice=  (PF_MEIORESETDEVICE )
  			(GetProcAddress (hDll,"meIOResetDevice"));
  
  pf_meIOResetSubdevice=  (PF_MEIORESETSUBDEVICE )
  			(GetProcAddress (hDll,"meIOResetSubdevice"));
  
  pf_meIOStreamFrequencyToTicks=  (PF_MEIOSTREAMFREQUENCYTOTICKS )
  			(GetProcAddress (hDll,"meIOStreamFrequencyToTicks"));
  
  pf_meIOSingleConfig=  (PF_MEIOSINGLECONFIG )
  			(GetProcAddress (hDll,"meIOSingleConfig"));
  
  pf_meIOSingle=  (PF_MEIOSINGLE )
  			(GetProcAddress (hDll,"meIOSingle"));
  
  pf_meIOStreamConfig=  (PF_MEIOSTREAMCONFIG )
  			(GetProcAddress (hDll,"meIOStreamConfig"));
  
  pf_meIOStreamNewValues=  (PF_MEIOSTREAMNEWVALUES )
  			(GetProcAddress (hDll,"meIOStreamNewValues"));
  
  pf_meIOStreamRead=  (PF_MEIOSTREAMREAD )
  			(GetProcAddress (hDll,"meIOStreamRead"));
  
  pf_meIOStreamWrite=  (PF_MEIOSTREAMWRITE )
  			(GetProcAddress (hDll,"meIOStreamWrite"));
  
  pf_meIOStreamStart=  (PF_MEIOSTREAMSTART )
  			(GetProcAddress (hDll,"meIOStreamStart"));
  
  pf_meIOStreamStop=  (PF_MEIOSTREAMSTOP )
  			(GetProcAddress (hDll,"meIOStreamStop"));
  
  pf_meIOStreamStatus=  (PF_MEIOSTREAMSTATUS )
  			(GetProcAddress (hDll,"meIOStreamStatus"));
  
  pf_meIOStreamSetCallbacks=  (PF_MEIOSTREAMSETCALLBACKS )
  			(GetProcAddress (hDll,"meIOStreamSetCallbacks"));
  
  pf_meIOStreamTimeToTicks=  (PF_MEIOSTREAMTIMETOTICKS )
  			(GetProcAddress (hDll,"meIOStreamTimeToTicks"));
  
  pf_meQueryDescriptionDevice=  (PF_MEQUERYDESCRIPTIONDEVICE )
  			(GetProcAddress (hDll,"meQueryDescriptionDevice"));
  
  pf_meQueryInfoDevice=  (PF_MEQUERYINFODEVICE )
  			(GetProcAddress (hDll,"meQueryInfoDevice"));
  
  pf_meQueryNameDevice=  (PF_MEQUERYNAMEDEVICE )
  			(GetProcAddress (hDll,"meQueryNameDevice"));
  
  pf_meQueryNameDeviceDriver=  (PF_MEQUERYNAMEDEVICEDRIVER )
  			(GetProcAddress (hDll,"meQueryNameDeviceDriver"));
  
  pf_meQueryNumberDevices=  (PF_MEQUERYNUMBERDEVICES )
  			(GetProcAddress (hDll,"meQueryNumberDevices"));
  
  pf_meQueryNumberSubdevices=  (PF_MEQUERYNUMBERSUBDEVICES )
  			(GetProcAddress (hDll,"meQueryNumberSubdevices"));
  
  pf_meQueryNumberChannels=  (PF_MEQUERYNUMBERCHANNELS )
  			(GetProcAddress (hDll,"meQueryNumberChannels"));
  
  pf_meQueryNumberRanges=  (PF_MEQUERYNUMBERRANGES )
  			(GetProcAddress (hDll,"meQueryNumberRanges"));
  
  pf_meQueryRangeByMinMax=  (PF_MEQUERYRANGEBYMINMAX )
  			(GetProcAddress (hDll,"meQueryRangeByMinMax"));
  
  pf_meQueryRangeInfo=  (PF_MEQUERYRANGEINFO )
  			(GetProcAddress (hDll,"meQueryRangeInfo"));
  
  pf_meQuerySubdeviceByType=  (PF_MEQUERYSUBDEVICEBYTYPE )
  			(GetProcAddress (hDll,"meQuerySubdeviceByType"));
  
  pf_meQuerySubdeviceType=  (PF_MEQUERYSUBDEVICETYPE )
  			(GetProcAddress (hDll,"meQuerySubdeviceType"));
  
  pf_meQuerySubdeviceCaps=  (PF_MEQUERYSUBDEVICECAPS )
  			(GetProcAddress (hDll,"meQuerySubdeviceCaps"));
  
  pf_meQuerySubdeviceCapsArgs=  (PF_MEQUERYSUBDEVICECAPSARGS )
  			(GetProcAddress (hDll,"meQuerySubdeviceCapsArgs"));
  
  pf_meQueryVersionLibrary=  (PF_MEQUERYVERSIONLIBRARY )
  			(GetProcAddress (hDll,"meQueryVersionLibrary"));
  
  pf_meQueryVersionMainDriver=  (PF_MEQUERYVERSIONMAINDRIVER )
  			(GetProcAddress (hDll,"meQueryVersionMainDriver"));
  
  pf_meQueryVersionDeviceDriver=  (PF_MEQUERYVERSIONDEVICEDRIVER )
  			(GetProcAddress (hDll,"meQueryVersionDeviceDriver"));
  
  pf_meUtilityExtractValues=  (PF_MEUTILITYEXTRACTVALUES )
  			(GetProcAddress (hDll,"meUtilityExtractValues"));
  
  pf_meUtilityDigitalToPhysical=  (PF_MEUTILITYDIGITALTOPHYSICAL )
  			(GetProcAddress (hDll,"meUtilityDigitalToPhysical"));

  pf_meUtilityDigitalToPhysicalV=  (PF_MEUTILITYDIGITALTOPHYSICALV )
  			(GetProcAddress (hDll,"meUtilityDigitalToPhysicalV"));
  
  pf_meUtilityPhysicalToDigital=  (PF_MEUTILITYPHYSICALTODIGITAL )
  			(GetProcAddress (hDll,"meUtilityPhysicalToDigital"));
  
  pf_meUtilityPhysicalToDigitalV=  (PF_MEUTILITYPHYSICALTODIGITALV )
  			(GetProcAddress (hDll,"meUtilityPhysicalToDigitalV"));

  pf_meUtilityPWMStart=  (PF_MEUTILITYPWMSTART )
  			(GetProcAddress (hDll,"meUtilityPWMStart"));

  pf_meUtilityPWMStop=  (PF_MEUTILITYPWMSTOP )
  			(GetProcAddress (hDll,"meUtilityPWMStop"));
}




//   -------------------- Wrappers for all Functions -------------------------


/* ----------------------- General Functions ----------------------------- */

int meOpen(int iFlags)
{
    if (pf_meOpen)
        return (pf_meOpen)(iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meClose(int iFlags)
{
    if (pf_meClose)
        return (pf_meClose)(iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meLockDriver(int iLock,int iFlags)
{
    if (pf_meLockDriver)
        return (pf_meLockDriver)(iLock,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meLockDevice(int iDevice,int iLock,int iFlags)
{
    if (pf_meLockDevice)
        return (pf_meLockDevice)(iDevice,iLock,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meLockSubdevice(int iDevice,int iSubdevice,int iLock,int iFlags)
{
    if (pf_meLockSubdevice)
        return (pf_meLockSubdevice)(iDevice,iSubdevice,iLock,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meErrorGetLastMessage(char *pcErrorMsg,int iCount)
{
    if (pf_meErrorGetLastMessage)
        return (pf_meErrorGetLastMessage)(pcErrorMsg,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meErrorGetMessage(int iErrorCode,char *pcErrorMsg,int iCount)
{
    if (pf_meErrorGetMessage)
        return (pf_meErrorGetMessage)(iErrorCode,pcErrorMsg,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meErrorSetDefaultProc(int iSwitch)
{
    if (pf_meErrorSetDefaultProc)
        return (pf_meErrorSetDefaultProc)(iSwitch);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meErrorSetUserProc(meErrorCB_t pErrorProc)
{
    if (pf_meErrorSetUserProc)
        return (pf_meErrorSetUserProc)(pErrorProc);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOIrqSetCallback(int iDevice,int iSubdevice,meIOIrqCB_t pCallback,void *pCallbackContext,int iFlags)
{
    if (pf_meIOIrqSetCallback)
        return (pf_meIOIrqSetCallback)(iDevice,iSubdevice,pCallback,pCallbackContext,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOIrqStart(int iDevice,int iSubdevice,int iChannel,int iIrqSource,int iIrqEdge,int iIrqArg,int iFlags)
{
    if (pf_meIOIrqStart)
        return (pf_meIOIrqStart)(iDevice,iSubdevice,iChannel,iIrqSource,iIrqEdge,iIrqArg,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOIrqStop(int iDevice,int iSubdevice,int iChannel,int iFlags)
{
    if (pf_meIOIrqStop)
        return (pf_meIOIrqStop)(iDevice,iSubdevice,iChannel,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOIrqWait(int iDevice,int iSubdevice,int iChannel,int *piIrqCount,int *piValue,int iTimeOut,int iFlags)
{
    if (pf_meIOIrqWait)
        return (pf_meIOIrqWait)(iDevice,iSubdevice,iChannel,piIrqCount,piValue,iTimeOut,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOResetDevice(int iDevice,int iFlags)
{
    if (pf_meIOResetDevice)
        return (pf_meIOResetDevice)(iDevice,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOResetSubdevice(int iDevice,int iSubdevice,int iFlags)
{
    if (pf_meIOResetSubdevice)
        return (pf_meIOResetSubdevice)(iDevice,iSubdevice,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamFrequencyToTicks(int iDevice,int iSubdevice,int iTimer,double *pdFrequency,int *piTicksLow,int *piTicksHigh,int iFlags)
{
    if (pf_meIOStreamFrequencyToTicks)
        return (pf_meIOStreamFrequencyToTicks)(iDevice,iSubdevice,iTimer,pdFrequency,piTicksLow,piTicksHigh,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOSingleConfig(int iDevice,int iSubdevice,int iChannel,int iSingleConfig,int iRef,int iTrigChan,int iTrigType,int iTrigEdge,int iFlags)
{
    if (pf_meIOSingleConfig)
        return (pf_meIOSingleConfig)(iDevice,iSubdevice,iChannel,iSingleConfig,iRef,iTrigChan,iTrigType,iTrigEdge,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOSingle(meIOSingle_t *pSingleList,int iCount,int iFlags)
{
    if (pf_meIOSingle)
        return (pf_meIOSingle)(pSingleList,iCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamConfig(int iDevice,int iSubdevice,meIOStreamConfig_t *pConfigList,int iCount,meIOStreamTrigger_t *pTrigger,int iFifoIrqThreshold,int iFlags)
{
    if (pf_meIOStreamConfig)
        return (pf_meIOStreamConfig)(iDevice,iSubdevice,pConfigList,iCount,pTrigger,iFifoIrqThreshold,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamNewValues(int iDevice,int iSubdevice,int iTimeOut,int *piCount,int iFlags)
{
    if (pf_meIOStreamNewValues)
        return (pf_meIOStreamNewValues)(iDevice,iSubdevice,iTimeOut,piCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamRead(int iDevice,int iSubdevice,int iReadMode,int *piValues,int *piCount,int iFlags)
{
    if (pf_meIOStreamRead)
        return (pf_meIOStreamRead)(iDevice,iSubdevice,iReadMode,piValues,piCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamWrite(int iDevice,int iSubdevice,int iWriteMode,int *piValues,int *piCount,int iFlags)
{
    if (pf_meIOStreamWrite)
        return (pf_meIOStreamWrite)(iDevice,iSubdevice,iWriteMode,piValues,piCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamStart(meIOStreamStart_t *pStartList,int iCount,int iFlags)
{
    if (pf_meIOStreamStart)
        return (pf_meIOStreamStart)(pStartList,iCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamStop(meIOStreamStop_t *pStopList,int iCount,int iFlags)
{
    if (pf_meIOStreamStop)
        return (pf_meIOStreamStop)(pStopList,iCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamStatus(int iDevice,int iSubdevice,int iWait,int *piStatus,int *piCount,int iFlags)
{
    if (pf_meIOStreamStatus)
        return (pf_meIOStreamStatus)(iDevice,iSubdevice,iWait,piStatus,piCount,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamSetCallbacks(int iDevice,int iSubdevice,meIOStreamCB_t pStartCB,void *pStartCBContext,meIOStreamCB_t pNewValuesCB,void *pNewValuesCBContext,meIOStreamCB_t pEndCB,void *pEndCBContext,int iFlags)
{
    if (pf_meIOStreamSetCallbacks)
        return (pf_meIOStreamSetCallbacks)(iDevice,iSubdevice,pStartCB,pStartCBContext,pNewValuesCB,pNewValuesCBContext,pEndCB,pEndCBContext,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meIOStreamTimeToTicks(int iDevice,int iSubdevice,int iTimer,double *pdTime,int *piTicksLow,int *piTicksHigh,int iFlags)
{
    if (pf_meIOStreamTimeToTicks)
        return (pf_meIOStreamTimeToTicks)(iDevice,iSubdevice,iTimer,pdTime,piTicksLow,piTicksHigh,iFlags);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryDescriptionDevice(int iDevice,char *pcDescription,int iCount)
{
    if (pf_meQueryDescriptionDevice)
        return (pf_meQueryDescriptionDevice)(iDevice,pcDescription,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryInfoDevice(int iDevice,int *piVendorId,int *piDeviceId,int *piSerialNo,int *piBusType,int *piBusNo,int *piDevNo,int *piFuncNo,int *piPlugged)
{
    if (pf_meQueryInfoDevice)
        return (pf_meQueryInfoDevice)(iDevice,piVendorId,piDeviceId,piSerialNo,piBusType,piBusNo,piDevNo,piFuncNo,piPlugged);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNameDevice(int iDevice,char *pcName,int iCount)
{
    if (pf_meQueryNameDevice)
        return (pf_meQueryNameDevice)(iDevice,pcName,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNameDeviceDriver(int iDevice,char *pcName,int iCount)
{
    if (pf_meQueryNameDeviceDriver)
        return (pf_meQueryNameDeviceDriver)(iDevice,pcName,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNumberDevices(int *piNumber)
{
    if (pf_meQueryNumberDevices)
        return (pf_meQueryNumberDevices)(piNumber);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNumberSubdevices(int iDevice,int *piNumber)
{
    if (pf_meQueryNumberSubdevices)
        return (pf_meQueryNumberSubdevices)(iDevice,piNumber);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNumberChannels(int iDevice,int iSubdevice,int *piNumber)
{
    if (pf_meQueryNumberChannels)
        return (pf_meQueryNumberChannels)(iDevice,iSubdevice,piNumber);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryNumberRanges(int iDevice,int iSubdevice,int iUnit,int *piNumber)
{
    if (pf_meQueryNumberRanges)
        return (pf_meQueryNumberRanges)(iDevice,iSubdevice,iUnit,piNumber);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryRangeByMinMax(int iDevice,int iSubdevice,int iUnit,double *pdMin,double *pdMax,int *piMaxData,int *piRange)
{
    if (pf_meQueryRangeByMinMax)
        return (pf_meQueryRangeByMinMax)(iDevice,iSubdevice,iUnit,pdMin,pdMax,piMaxData,piRange);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryRangeInfo(int iDevice,int iSubdevice,int iRange,int *piUnit,double *pdMin,double *pdMax,int *piMaxData)
{
    if (pf_meQueryRangeInfo)
        return (pf_meQueryRangeInfo)(iDevice,iSubdevice,iRange,piUnit,pdMin,pdMax,piMaxData);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQuerySubdeviceByType(int iDevice,int iStartSubdevice,int iType,int iSubtype,int *piSubdevice)
{
    if (pf_meQuerySubdeviceByType)
        return (pf_meQuerySubdeviceByType)(iDevice,iStartSubdevice,iType,iSubtype,piSubdevice);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQuerySubdeviceType(int iDevice,int iSubdevice,int *piType,int *piSubtype)
{
    if (pf_meQuerySubdeviceType)
        return (pf_meQuerySubdeviceType)(iDevice,iSubdevice,piType,piSubtype);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQuerySubdeviceCaps(int iDevice,int iSubdevice,int *piCaps)
{
    if (pf_meQuerySubdeviceCaps)
        return (pf_meQuerySubdeviceCaps)(iDevice,iSubdevice,piCaps);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQuerySubdeviceCapsArgs(int iDevice,int iSubdevice,int iCap,int *piArgs,int iCount)
{
    if (pf_meQuerySubdeviceCapsArgs)
        return (pf_meQuerySubdeviceCapsArgs)(iDevice,iSubdevice,iCap,piArgs,iCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryVersionLibrary(int *piVersion)
{
    if (pf_meQueryVersionLibrary)
        return (pf_meQueryVersionLibrary)(piVersion);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryVersionMainDriver(int *piVersion)
{
    if (pf_meQueryVersionLibrary)
        return (pf_meQueryVersionLibrary)(piVersion);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meQueryVersionDeviceDriver(int iDevice,int *piVersion)
{
    if (pf_meQueryVersionDeviceDriver)
        return (pf_meQueryVersionDeviceDriver)(iDevice,piVersion);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityExtractValues(int iChannel,int *piAIBuffer,int iAIBufferCount,meIOStreamConfig_t *pConfigList,int iConfigListCount,int *piChanBuffer,int *piChanBufferCount)
{
    if (pf_meUtilityExtractValues)
        return (pf_meUtilityExtractValues)(iChannel,piAIBuffer,iAIBufferCount,pConfigList,iConfigListCount,piChanBuffer,piChanBufferCount);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityDigitalToPhysical(double dMin,double dMax,int iMaxData,int iData,int iModuleType,double dRefValue,double *pdPhysical)
{
    if (pf_meUtilityDigitalToPhysical)
        return (pf_meUtilityDigitalToPhysical)(dMin,dMax,iMaxData,iData,iModuleType,dRefValue,pdPhysical);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityDigitalToPhysicalV(double dMin,double dMax,int iMaxData,int *piDataBuffer,int iCount,int iModuleType,double dRefValue,double *pdPhysicalBuffer)
{
    if (pf_meUtilityDigitalToPhysicalV)
        return (pf_meUtilityDigitalToPhysicalV)(dMin,dMax,iMaxData,piDataBuffer,iCount,iModuleType,dRefValue,pdPhysicalBuffer);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}
int meUtilityPhysicalToDigital(double dMin,double dMax,int iMaxData,double dPhysical,int *piData)
{
    if (pf_meUtilityPhysicalToDigital)
        return (pf_meUtilityPhysicalToDigital)(dMin,dMax,iMaxData,dPhysical,piData);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityPhysicalToDigitalV(double dMin,double dMax,int iMaxData,double* pdPhysicalBuffer,int iCount,int *piDataBuffer)
{
    if (pf_meUtilityPhysicalToDigitalV)
        return (pf_meUtilityPhysicalToDigitalV)(dMin,dMax,iMaxData,pdPhysicalBuffer,iCount,piDataBuffer);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityPWMStart(int iDevice,int iSubdevice1,int iSubdevice2,int iSubdevice3,int iRef,int iPrescaler,int iDutyCycle,int iFlag)
{
    if (pf_meUtilityPWMStart)
        return (pf_meUtilityPWMStart)(iDevice,iSubdevice1,iSubdevice2,iSubdevice3,iRef,iPrescaler,iDutyCycle,iFlag);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}

int meUtilityPWMStop(int iDevice,int iSubdevice1)
{
    if (pf_meUtilityPWMStop)
        return (pf_meUtilityPWMStop)(iDevice,iSubdevice1);
    else
    {
        printf("Error on call function in line %d\n", __LINE__);
        return FUNCTIONNOTFOUND;
    }
}




/* -------------------------  Close Function ----------------------------*/
void meCloseDynamicAccess (void)
{
    if (hDll)
    {
        FreeLibrary(hDll);
    }
}
