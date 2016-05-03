/*  Borland C demo                                  */
/*                                                  */
/*  Please see Visual C samples for more details    */
/*  and Visual C++ programs                         */
/*                                                  */


#include <stdio.h>
#include <windows.h>
#include <conio.h>
#include <memory.h>



#include "medefines.h"
#include "DLLInit.h"           // for using with dynamic DLL accessing

#ifdef __BORLANDC__
#include "condefs.h"
#include "medefines.h";
#include "DLLInit.h";
#include "DLLInit.cpp";
#endif

#include "TestConsoleGeneric.c"


int lvdt_stream(double v[], double channel[], double subdevice[], double frequency[], double values[])
{
    	meOpenDynamicAccess();
    
	
	int i_number_of_devices = TestConsoleMEIDSProlog();

	if(i_number_of_devices <= 0)
	{
		return(-1);
	}
	

	// ---------------------------------------------------------------------
	int i_me_error;
	
	int i_stream_read_device    = -1;
	int i_stream_read_subdevice = -1;


	for(int index_device = 0; index_device < i_number_of_devices; index_device++)
	{
		int i_vendor_id;
		int i_device_id;
		int i_serial_no;
		int i_bus_type;
		int i_bus_no;
		int i_dev_no;
		int i_func_no;
		int i_plugged;
		
		i_me_error = meQueryInfoDevice(	index_device,	// Device index
						&i_vendor_id,	// Vendor ID returned here - not required				
						&i_device_id,	// Device ID returned here - not required
						&i_serial_no,	// Serial number returned here - not required
						&i_bus_type,	// Bus type returned here - not required
						&i_bus_no,	// Bus number returned here - not required
						&i_dev_no,	// Bus device number returned here - not required
						&i_func_no,	// Bus function number returned here - not required
						&i_plugged);	// Plugged status returned hee - not required

		if(i_plugged != ME_PLUGGED_IN)
		{
			continue;
		}

		i_me_error = meQuerySubdeviceByType(	index_device,			// Device
							0,				// Begin search at this sub-device 
							ME_TYPE_AI,			// Type of sub-device to search for
							ME_SUBTYPE_STREAMING,		// Sub-type of sub-device to search for
							&i_stream_read_subdevice);	// sub-device index returned here

		if(i_me_error == ME_ERRNO_SUCCESS)
		{
			i_stream_read_device = index_device;

			break;
		}
	}

	if(i_stream_read_device == -1)
	{
		printf("****    No AI-Streaming sub-device found in system    ****\n\n");
		meClose(0);
		return -1;
	}


	i_stream_read_subdevice = subdevice[0];

	//printf("Device: %d, Subdevice: %d is an AI-Streaming device\n\n", i_stream_read_device, i_stream_read_subdevice);
	
	int i_acq_ticks_low = 0;
	int i_acq_ticks_high = 0;

	double d_time = 0.0;

	i_me_error = meIOStreamTimeToTicks(	i_stream_read_device,			// Device index
						i_stream_read_subdevice,		// Subdevice indexe, 
						ME_TIMER_ACQ_START,			// Timer used 
						&d_time,				// Required time seconds, Achieved time returned here	 
						&i_acq_ticks_low,			// Lower 32 bits of the corresponding tick value returned here
						&i_acq_ticks_high,			// Upper 32 bits of the corresponding tick value returned here
						ME_IO_FREQUENCY_TO_TICKS_NO_FLAGS); 	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamTimeToTicks - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	double d_required_freq = frequency[0];
	double d_achieved_freq = d_required_freq;

	int i_scan_ticks_low = 0;
	int i_scan_ticks_high = 0;

	i_me_error = meIOStreamFrequencyToTicks(i_stream_read_device,			// Device index
						i_stream_read_subdevice,		// Subdevice indexe, 
						ME_TIMER_SCAN_START,			// Timer used 
						&d_achieved_freq,			// Required frequency Hz, Achieved frequency returned here	 
						&i_scan_ticks_low,			// Lower 32 bits of the corresponding tick value returned here
						&i_scan_ticks_high,			// Upper 32 bits of the corresponding tick value returned here
						ME_IO_FREQUENCY_TO_TICKS_NO_FLAGS); 	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamFrequencyToTicks - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	//printf("meIOStreamFrequencyToTicks - Required Freq: %f Achieved Freq: %f Ticks low: %d Ticks high: %d\n\n", d_required_freq, d_achieved_freq, i_scan_ticks_low, i_scan_ticks_high);

	int i_conv_ticks_low = 0;
	int i_conv_ticks_high = 0;

	d_time = 0.0;

	i_me_error = meIOStreamTimeToTicks(	i_stream_read_device,			// Device index
						i_stream_read_subdevice,		// Subdevice indexe, 
						ME_TIMER_CONV_START,			// Timer used 
						&d_time,				// Required time seconds, Achieved time returned here	 
						&i_conv_ticks_low,			// Lower 32 bits of the corresponding tick value returned here
						&i_conv_ticks_high,			// Upper 32 bits of the corresponding tick value returned here
						ME_IO_FREQUENCY_TO_TICKS_NO_FLAGS); 	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamTimeToTicks - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	meIOStreamConfig_t arr_stream_config[1];



	arr_stream_config[0].iChannel = channel[0];



	arr_stream_config[0].iStreamConfig = 0;
	arr_stream_config[0].iRef = ME_REF_AI_GROUND;
	arr_stream_config[0].iFlags = ME_IO_STREAM_CONFIG_TYPE_NO_FLAGS;

	meIOStreamTrigger_t stream_trigger;

	memset( &stream_trigger, 0, sizeof(meIOStreamTrigger_t) );

	stream_trigger.iAcqStartTrigType = ME_TRIG_TYPE_SW;
	
	stream_trigger.iAcqStartTrigChan = ME_TRIG_CHAN_DEFAULT;
	stream_trigger.iAcqStartTicksLow = i_acq_ticks_low;
	stream_trigger.iAcqStartTicksHigh = i_acq_ticks_high;
	stream_trigger.iScanStartTrigType = ME_TRIG_TYPE_TIMER;
	stream_trigger.iScanStartTicksLow = i_scan_ticks_low;
	stream_trigger.iScanStartTicksHigh = i_scan_ticks_high;
	stream_trigger.iConvStartTrigType = ME_TRIG_TYPE_TIMER;
	stream_trigger.iConvStartTicksLow = i_conv_ticks_low;
	stream_trigger.iConvStartTicksHigh = i_conv_ticks_high;

	stream_trigger.iFlags = ME_IO_STREAM_TRIGGER_TYPE_NO_FLAGS;
	
	i_me_error = meIOStreamConfig(	i_stream_read_device,			// Device index
					i_stream_read_subdevice,		// Subdevice index, 
 					&arr_stream_config[0],			// Pointer to an array of meIOStreamConfig_t structures
					1,					// Number of elements in the stream config array above
					&stream_trigger,			// Pointer to an meIOStreamTrigger_t structure
					2,					// FIFO IRQ threshold
					ME_IO_STREAM_CONFIG_NO_FLAGS	);	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamConfig - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	double d_phys_min;

	double d_phys_max;

	int i_digital_max;
	
	i_me_error = meQueryRangeInfo(	i_stream_read_device,		// Device index
					i_stream_read_subdevice,	// Subdevice index, 
					0,				// Range index
					NULL,				// Unit returned here - not require
					&d_phys_min,			// Physical minimum returned here
					&d_phys_max,			// Physical maximum returned here
					&i_digital_max		);	// Digital maximum value returned here

	//printf("d_phys_min: %lf d_phys_max: %lf i_digital_max: %d\n\n", d_phys_min,	d_phys_max,	i_digital_max);
	
	meIOStreamStart_t arr_stream_start[1];

	arr_stream_start[0].iDevice = i_stream_read_device;
	arr_stream_start[0].iSubdevice = i_stream_read_subdevice;
	arr_stream_start[0].iStartMode = ME_START_MODE_BLOCKING;
	arr_stream_start[0].iTimeOut = 5;
	arr_stream_start[0].iFlags = ME_IO_STREAM_START_TYPE_NO_FLAGS;
	arr_stream_start[0].iErrno = 0;
	
	i_me_error = meIOStreamStart(	&arr_stream_start[0],		// Pointer to an array of meIOStreamStart_t structures 
					1,				// Number of elements in the stream start array above
					ME_IO_STREAM_START_NO_FLAGS);	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamStart - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	//printf("Acquisition started\n\n");


	int i_count = values[0];
	//const size = values[0];
	
	if( i_count > 100000 ) 
	{
		printf("****    Creating Buffer - Error: Amount of values to big (max. is 100000)   ****\n\n");
		meClose(0);
		return -1;
	}
		
	int i_buffer[100000];	//4096

	i_me_error = meIOStreamRead(	i_stream_read_device,		// Device index
					i_stream_read_subdevice,	// Subdevice index, 
					ME_READ_MODE_BLOCKING,		// Read mode 
					&i_buffer[0],			// Acquired data values returned in this buffer
					&i_count,			// Size of buffer in data values - Number of data values returned here
					ME_IO_STREAM_READ_NO_FLAGS);	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamRead - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return -1;
	}

	v[0] = 0;

	for(int index_value = 0; index_value < i_count; index_value++)
	{
		double d_volt;
			
		i_me_error =  meUtilityDigitalToPhysical(d_phys_min,			// Min physical value
							d_phys_max,			// Max physical value
							i_digital_max,			// Maximum digital value
							i_buffer[index_value],		// Digital value to convert
							ME_MODULE_TYPE_MULTISIG_NONE,	// Module type - not used
							0.0,				// Reference value - not used
							&d_volt	);			// Converted physical value returned here

		v[0] += i_buffer[index_value];
		//v[0] += i_buffer[index_value]/i_count;
		//printf("%5d  -  %5.2lf V\n", i_buffer[index_value], d_volt);
	}

	v[0] /= i_count;


	meIOStreamStop_t arr_stream_stop[1];

	arr_stream_stop[0].iDevice = i_stream_read_device;
	arr_stream_stop[0].iSubdevice = i_stream_read_subdevice;
	arr_stream_stop[0].iStopMode = ME_STOP_MODE_IMMEDIATE;
	arr_stream_stop[0].iFlags = ME_IO_STREAM_STOP_TYPE_NO_FLAGS;
	arr_stream_stop[0].iErrno = 0;

	i_me_error = meIOStreamStop(	&arr_stream_stop[0],		// Pointer to an array of meIOStreamStop_t structures  
					1,				// Number of elements in the stream stop array above
					ME_IO_STREAM_STOP_NO_FLAGS);	// No flags

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meIOStreamStop - Error: %d    ****\n\n", i_me_error);
		meClose(0);
		return(-1);
	}

	//printf("Acquisition ended\n\n");
	// ---------------------------------------------------------------------

	meClose(0);
	meCloseDynamicAccess();
	return 0;
}



void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
  double *channel, *subdevice, *frequency, *values, *v;
  mwSize mrows,ncols;
  
  /* Check for proper number of arguments. */
  if(nrhs!=4) {
    mexErrMsgTxt("Three inputs required.");
  } else if(nlhs!=1) {
    mexErrMsgTxt("Too many output arguments");
  }
  
  /* The input must be a noncomplex scalar double.*/
  mrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[0]);
  if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !(mrows==1 && ncols==1) ) {
    mexErrMsgTxt("Input must be a noncomplex scalar double.");
  }
  
  /* Create matrix for the return argument. */
  plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  
  /* Assign pointers to each input and output. */
  channel   = mxGetPr(prhs[0]);
  subdevice = mxGetPr(prhs[1]);
  frequency = mxGetPr(prhs[2]);
  values    = mxGetPr(prhs[3]);

  // Output should be physical_value | volt
  v = mxGetPr(plhs[0]);

  lvdt_stream(v,channel,subdevice,frequency,values);
}