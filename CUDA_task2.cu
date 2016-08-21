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

int main()
{
   int i, j =0;

  int A[N][N] =
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

  int B[N][N] = 
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

  int C[N][N] = 
     {
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0}
   };

 
     for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            C[i][j] = A[i][j] + B[i][j];
        }
    }
 
   printf("Sum of entered matrices:-\n");
 
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }
 
   return 0;
}
