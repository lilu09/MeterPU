#include <meterpu.h>

int main()
{
	{
		using namespace meterpu;

		meter<CPU_Time> my_meter;

		my_meter.start();

		//Do sth here
		usleep(500000);

		my_meter.stop();

		my_meter.calc();

		std::cout<<"[CPU Time Meter] Time consumed is: "<<my_meter.get_value()<<" micro seconds."<<std::endl;

	}

}

//Output: Time consumed is: 500100 micro seconds.
