

#include <meterpu.h>
#include <stdio.h>



int main()
{

	{
		using namespace meterpu;



		//Initialize a meter with CPU and GPU energy of the device with id 0
		meter< System_Energy<0> > sys_meter;
		//Empty device id means no GPU available on the system
		//Meter< System_Energy<> > sys_meter;
		meter< PCM_Energy > cpu_meter;
		meter< NVML_Energy<0> > gpu_meter;


		std::cout<<"SleepNum, CPU, GPU, Sum, CPU_Concurent, GPU_Concurent, Sum_Concurent, System"<<std::endl;
		for(int i=1;i<3;i=i*2)
		{
			std::cout<<i<<", ";
			//Monitor CPU Energy
			cpu_meter.start();

			//Do sth here
			/*usleep(10000);*/
			sleep(i);

			cpu_meter.stop();

			cpu_meter.calc();

			std::cout<<cpu_meter.get_value()<<", ";

			//Monitor GPU Energy, while CPU part is not monitored
			gpu_meter.start();

			//Do sth here
			/*usleep(10000);*/
			sleep(i);

			gpu_meter.stop();

			gpu_meter.calc();

			std::cout<<gpu_meter.get_value()<<", "
				<<cpu_meter.get_value()+gpu_meter.get_value()<<", ";

			//Monitor CPU and GPU
			cpu_meter.start();
			gpu_meter.start();

			//Do sth here
			/*usleep(10000);*/
			sleep(i);

			gpu_meter.stop();
			cpu_meter.stop();

			cpu_meter.calc();
			gpu_meter.calc();

			std::cout<<cpu_meter.get_value()<<", "
				 <<gpu_meter.get_value()<<", "
				 <<cpu_meter.get_value()+gpu_meter.get_value()<<", ";
			


			//Monitor the whole system
			sys_meter.start();

			//Do sth here
			/*usleep(10000);*/
			sleep(i);

			sys_meter.stop();

			sys_meter.calc();

			std::cout<<sys_meter.get_value()<<std::endl;
		}

	}

}
