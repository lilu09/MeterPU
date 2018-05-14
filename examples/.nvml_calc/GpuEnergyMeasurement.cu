

#include <meterpu.h>
#include <stdio.h>

#define GPU_0 0
#define GPU_1 1

int main()
{

#if VERBOSE >=1
	PRINT_FUNC_NAME("Program start..");
#endif


	{
		using namespace MeterPU;

		//Initialize a meter with GPU energy of default device id 0
		Meter< NVML_Energy<GPU_0> > meter;

		meter.test();


		/*meter.start();*/

		/*//Do sth here*/
		/*usleep(1000);  //Minimum time for GPU components, takes about 33 milliJ.*/
		/*[>sleep(1);<]*/

		/*meter.stop();*/

		/*meter.calc();*/

		/*std::cout<<"Energy consumed is: "<<meter.get_value()<<" milliJ."<<std::endl;*/

	}

}
