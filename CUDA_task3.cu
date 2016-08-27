// Name: H.G. Manesha Washani
// Student Id: 1432289


#include <stdio.h>

/* this one of the header file. in this code need 
dynamically allocated array function. library code can use
malloc, free option */

#include <stdlib.h>

#define N 4
 
/* The __global__ indicates that this is an entry-point function running on the device. is called from host code  */
 __global__ void Matrixadd(int A[][N], int B[][N], int C[][N]){
           int g = threadIdx.x;
           int h = threadIdx.y;

           C[g][h] = A[g][h] + B[g][h];
}

/* This is randam function of assessment gave*/

void randmatfunc(int newmat[N][N]){ //int change to void mode and added newmate parameter to the function
  int i, j, k; 
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
          k = rand() % 100 + 1;;
            printf("%d ", k);
            newmat[i][j] =k;
        }
        printf("\n");
    }
}
/*Remove matrix numbers and, insert function to A and B matrix and create number automatically */
int main()
{

  int A[N][N];
  randmatfunc(A);

  int B[N][N];
  randmatfunc(B);

  int C[N][N];

//device copies of A, B,C
 int (*d_A)[N], (*d_B)[N], (*d_C)[N];


/* Device copies of A, B and C allovated space for device aopies of A, B and C. in lecture CUDA part 1 explanation have allocate memory on the device. */

  cudaMalloc((void**)&d_A, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_B, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_C, (N*N)*sizeof(int));

/* Copy input to device. the memory areas may not overlap calling cuda Memcpy()*/
  cudaMemcpy(d_A, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_C, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);

//Launch add() kernel on GPU
  int numBlocks = 1;
  dim3 threadsPerBlock(N,N);
  Matrixadd<<<numBlocks,threadsPerBlock>>>(d_A,d_B,d_C);

  // Copy result back to the host
  cudaMemcpy(C, d_C, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);

  int g, h; printf("C = \n");
    for(g=0;g<N;g++){
        for(h=0;h<N;h++){
            printf("%d ", C[g][h]);
        }
        printf("\n");
    }

// This is cleanup 
  cudaFree(d_A); 
  cudaFree(d_B); 
  cudaFree(d_C);

  printf("\n");
 
   return 0;
}

