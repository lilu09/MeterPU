

#include <lib/meterpu.h>



int main()
{
	{
		using namespace meterpu;

		meter<PCM_Energy> meter0;

		meter0.start();

		//Do sth here
		sleep(1);

		meter0.stop();

		meter0.calc();

		//std::cout<<"Energy consumed is: "<<meter.get_value()<<" milli Joules."<<std::endl;
		meter0.show_meter_reading();

	}

}
