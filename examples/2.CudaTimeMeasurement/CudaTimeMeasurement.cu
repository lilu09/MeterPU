

#include <meterpu.h>

	__global__ 
void hello(char *a, int *b) 
{
	a[threadIdx.x] += b[threadIdx.x];
}


inline void hello_world()
{
	// This is the REAL "hello world" for CUDA!
	// It takes the string "Hello ", prints it, then passes it to CUDA with an array
	// of offsets. Then the offsets are added in parallel to produce the string "World!"
	// By Ingemar Ragnemalm 2010

	using namespace meterpu;

	meter<CUDA_Time> gpu_meter;


	const int N = 16; 
	const int blocksize = 16; 


	char a[N] = "Hello \0\0\0\0\0\0";
	int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

	char *ad;
	int *bd;
	const long unsigned int csize = N*sizeof(char);
	const long unsigned int isize = N*sizeof(int);

	/*printf("%s", a);*/

	cudaMalloc( (void**)&ad, csize ); 
	cudaMalloc( (void**)&bd, isize ); 
	cudaMemcpy( ad, a, csize, cudaMemcpyHostToDevice ); 
	cudaMemcpy( bd, b, isize, cudaMemcpyHostToDevice ); 

	dim3 dimBlock( blocksize, 1 );
	dim3 dimGrid( 1, 1 );
	gpu_meter.start();
	hello<<<dimGrid, dimBlock>>>(ad, bd);
	cudaDeviceSynchronize();
	gpu_meter.stop();
	gpu_meter.calc();
	gpu_meter.show_meter_reading();
	cudaMemcpy( a, ad, csize, cudaMemcpyDeviceToHost ); 
	cudaFree( ad );
	cudaFree( bd );

	/*printf("%s\n", a);*/

}



int main()
{


	hello_world();

	return 0;

}
