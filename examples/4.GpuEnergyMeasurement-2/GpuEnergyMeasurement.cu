

#include <meterpu.h>
#include <cuda_call.h>
#include <stdio.h>


const int N = 16; 
const int blocksize = 16; 

int main()
{


	char a[N] = "Hello \0\0\0\0\0\0";
	int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	double c[N];

	char *ad;
	int *bd;
	double *cd;
	const int csize = N*sizeof(char);
	const int isize = N*sizeof(int);
	const int dsize = N*sizeof(double);

	printf("Before component call: %s\n", a);

	cudaMalloc( (void**)&ad, csize ); 
	cudaMalloc( (void**)&bd, isize ); 
	cudaMalloc( (void**)&cd, dsize ); 
	cudaMemcpy( ad, a, csize, cudaMemcpyHostToDevice ); 
	cudaMemcpy( bd, b, isize, cudaMemcpyHostToDevice ); 
	cudaMemcpy( cd, c, isize, cudaMemcpyHostToDevice ); 

	dim3 dimBlock( blocksize, 1 );
	dim3 dimGrid( 1, 1 );

	{
		using namespace meterpu;

		//Initialize a meter with GPU energy of default device id 0
		meter< NVML_Energy<> > meter0;
		//Initialize a meter with GPU energy of device id 1
		/*Meter< NVML_Energy<1> > em;*/


		meter0.start();

		//Do sth here
		hello<<<dimGrid, dimBlock>>>(ad, bd, cd);
		cudaDeviceSynchronize();

		meter0.stop();

		meter0.calc();

		cudaMemcpy( a, ad, csize, cudaMemcpyDeviceToHost ); 
		cudaMemcpy( c, cd, dsize, cudaMemcpyDeviceToHost ); 
		cudaFree( ad );
		cudaFree( bd );

		printf("After component call: %s\n", a);

		/*std::cout<<"Energy consumed is: "<<meter.get_value()<<" milliJ."<<std::endl;*/
		meter0.show_meter_reading();



		/* Try again */
		std::cout<<"Try a sleep kernel..."<<std::endl;
		meter+.start();

		//Do sth here
		sleep(1);

		meter0.stop();

		meter0.calc();

		/*std::cout<<"Energy consumed is: "<<meter.get_value()<<" milliJ."<<std::endl;*/
		meter0.show_meter_reading();


	}

}
