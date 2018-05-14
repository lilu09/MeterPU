#include <meterpu.h>

#define GPU_0 0

int main()
{
	{
		using namespace meterpu;

		//Initialize a meter with GPU energy of default device id 0
		meter< NVML_Energy<GPU_0> > meter0;

		for(int i=0;i<5;++i){

			meter0.start();

			//Do sth here, typically a cuda call, here simplified.
			sleep(2);

			meter0.stop();

			meter0.calc();

			/*std::cout<<"Energy consumed is: "<<meter.get_value()<<" milliJ."<<std::endl;*/
			meter0.show_meter_reading();
		}

	}

}

//Output: Energy consumed is: 87516.9 milliJ.
