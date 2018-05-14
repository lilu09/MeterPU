

#include <meterpu.h>



inline void func1()
{

	{
		using namespace meterpu;



		//Initialize a meter with CPU and GPU energy of the device with id 0
		meter< System_Energy<0> > sys_meter;
		
		sys_meter.start();
		sleep(1);
		sys_meter.stop();
		sys_meter.calc();
		std::cout<<sys_meter.get_value()<<std::endl;
	}

}
