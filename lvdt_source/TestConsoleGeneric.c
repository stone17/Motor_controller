#include "mex.h"

int TestConsoleMEIDSProlog(void)
{
	// Increase the size of the console buffer
	HANDLE  h_console = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD coord;
	coord.X = 120;
	coord.Y = 2000;
	SetConsoleScreenBufferSize(h_console, coord);
	char sz_buffer[1024];
	// Enable the default error procedure
	meErrorSetDefaultProc(ME_SWITCH_ENABLE);

	// Print the library version

	int i_version_library;
	
	int i_me_error = meQueryVersionLibrary(&i_version_library);

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meQueryVersionLibrary - Error: %d    ****\n\n", i_me_error);
		
		//printf("Press any key to terminate\n\n");
		
		//_getch();

		return(-1);
	}

	//printf("Library version: %d.%d.%d.%d\n", (i_version_library >> 24) & 0x000000FF, (i_version_library >> 16) & 0x000000FF, (i_version_library >> 8) & 0x000000FF, i_version_library & 0x000000FF);

	// Open the driver system

	i_me_error = meOpen(0);

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meOpen - Error: %d    ****\n\n", i_me_error);
		
		//printf("Press any key to terminate\n\n");
		
		//_getch();

		return(-1);
	}

	// Print the main driver version

	int i_version_main_driver;

	i_me_error = meQueryVersionMainDriver(&i_version_main_driver);

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meQueryVersionMainDriver - Error: %d    ****\n\n", i_me_error);
		
		//printf("Press any key to terminate\n\n");
		
		meClose(0);
		
		//_getch();

		return(-1);
	}

	//printf("Main driver version: %d.%d.%d.%d\n", (i_version_main_driver >> 24) & 0x000000FF, (i_version_main_driver >> 16) & 0x000000FF, (i_version_main_driver >> 8) & 0x000000FF, i_version_main_driver & 0x000000FF);

	// Query the number of devices

	int i_number_of_devices;
	
	i_me_error = meQueryNumberDevices(&i_number_of_devices);

	if(i_me_error != ME_ERRNO_SUCCESS)
	{
		printf("****    meQueryNumberDevices - Error: %d    ****\n\n", i_me_error);
		
		//printf("Press any key to terminate\n\n");
		
		meClose(0);
		
		//_getch();

		return(-1);
	}

	if(i_number_of_devices == 0)
	{
		printf("****    No ME-IDS devices found in system    ****\n\n");
		
		//printf("Press any key to terminate\n\n");
		
		meClose(0);
		
		//_getch();

		return(-1);
	}

	//printf("Number of Devices: %d\n\n", i_number_of_devices);

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

		i_me_error = meQueryInfoDevice(index_device, &i_vendor_id, &i_device_id, &i_serial_no, 
												&i_bus_type, &i_bus_no, &i_dev_no, &i_func_no, &i_plugged);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryInfoDevice - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		/*printf(	"%sDevice: %-2d - %s\n"
				"----------\n\n",
				(i_plugged == ME_PLUGGED_IN) ? "" : "! ", 
				index_device, 
				(i_plugged == ME_PLUGGED_IN) ? "Plugged in" : "NOT plugged in");*/

		i_me_error = meQueryNameDevice(index_device, &sz_buffer[0], 1024);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryNameDevice - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		//printf("    Device name: %s\n", &sz_buffer[0]);

		i_me_error = meQueryDescriptionDevice(index_device, &sz_buffer[0], 1024);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryNameDevice - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		//printf("    Device description: %s\n", &sz_buffer[0]);

		i_me_error = meQueryNameDeviceDriver(index_device, &sz_buffer[0], 1024);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryNameDeviceDriver - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		//printf("    Device driver name: %s\n", &sz_buffer[0]);

		int i_version_device_driver;

		i_me_error = meQueryVersionDeviceDriver(index_device, &i_version_device_driver);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryVersionDeviceDriver - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		//printf("    Device driver version: %d.%d.%d.%d\n", (i_version_device_driver >> 24) & 0x000000FF, (i_version_device_driver >> 16) & 0x000000FF, (i_version_device_driver >> 8) & 0x000000FF, i_version_device_driver & 0x000000FF);

		int i_number_of_subdevices;

		i_me_error = meQueryNumberSubdevices(index_device, &i_number_of_subdevices);

		if(i_me_error != ME_ERRNO_SUCCESS)
		{
			printf("****    meQueryNumberSubdevices - Error: %d    ****\n", i_me_error);
			
			//printf("Press any key to continue\n\n");
			
			//_getch();
			
			continue;
		}
		
		//printf("    Number of Subdevices: %d\n\n", i_number_of_subdevices);

		/*for(int index_subdevice = 0; index_subdevice < i_number_of_subdevices; index_subdevice++)
		{
			printf(	"    Subdevice: %-2d\n"
					"    ------------\n\n",
					index_subdevice			);

			int i_subdevice_type;
			int i_subdevice_subtype;

			i_me_error = meQuerySubdeviceType(index_device, index_subdevice, &i_subdevice_type, &i_subdevice_subtype);

			if(i_me_error != ME_ERRNO_SUCCESS)
			{
				printf("****    meQuerySubdeviceType - Error: %d    ****\n", i_me_error);
				
				printf("Press any key to continue\n\n");
				
				_getch();
				
				continue;
			}

			printf("        Subdevice type:     0x%08X\n", i_subdevice_type);
			printf("        Subdevice subtype:  0x%08X\n", i_subdevice_subtype);
			
			int i_number_of_channels;
			
			i_me_error = meQueryNumberChannels(index_device, index_subdevice, &i_number_of_channels);

			if(i_me_error != ME_ERRNO_SUCCESS)
			{
				printf("****    meQueryNumberChannels - Error: %d    ****\n", i_me_error);
				
				printf("Press any key to continue\n\n");
				
				_getch();
				
				continue;
			}

			printf("        Number of channels: %d\n\n", i_number_of_channels);
		}

		printf("\n\n");*/
	}

	return(i_number_of_devices);
}
