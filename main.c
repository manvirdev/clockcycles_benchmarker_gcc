/* 
 * Filename: main.c
 *
 * Description: Microbenchmark driver for comparing loop unrolling
 *
 * Author:
 * Modification date: April 2023
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <sys/resource.h>

//#include <sys/types.h>
//#include <sys/times.h>
//#include <sys/time.h>

int sumPlus(int *A, int n);

#define N 10000
#define NTESTS 5

int A[N];
int P;
int Q;
int cycles_first[NTESTS];
int cycles_second[NTESTS];
long total_first;
long total_second;
int start_time = 150;
int end_time = 125;

void main () {
    srand(time(NULL));
    int i;
    struct rusage start;
    struct rusage end;

    // Init list
    Q = 0;
    for (i = 0; i < N; i++) {
        A[i] = abs(rand() % 1024 - 512);
        if (A[i] > 0) Q += A[i];
    }

    // Run tests
    for (i = 0; i < NTESTS; i++) {
        //   First Approach
        asm volatile (
            "cpuid\n\t"
            "rdtscp\n\t"
            "movl %%eax, %0\n\t"
            : "=r" (start_time)
            :
            : "rax", "rbx", "rcx", "rdx"
        );
        long long sum = 0;
        for(int i =0 ; i < N; i++){
            sum += A[i];
        }

        printf("Sum 1: %lld and Q: %d\n", sum, Q);
        asm volatile (
            "cpuid\n\t"
            "rdtscp\n\t"
            "movl %%eax, %0\n\t"
            : "=r" (end_time)
            :
            : "rax", "rbx", "rcx", "rdx"
        );
    
        cycles_first[i] = end_time - start_time;


         //  Second Approach
        asm volatile (
            "cpuid\n\t"
            "rdtscp\n\t"
            "movl %%eax, %0\n\t"
            : "=r" (start_time)
            :
            : "rax", "rbx", "rcx", "rdx"
        );
        long long sum2 = 0;
        for(int i =0 ; i < N - 7 + 1; i = i + 7){
            sum2 += A[i] + A[i + 1] + A[i + 2] + A[i + 3] + A[i + 4] + A[i + 5] + A[i + 6];
        }

        printf("Sum 2: %lld and Q: %d\n", sum2, Q);
        asm volatile (
            "cpuid\n\t"
            "rdtscp\n\t"
            "movl %%eax, %0\n\t"
            : "=r" (end_time)
            :
            : "rax", "rbx", "rcx", "rdx"
        );
    
        cycles_second[i] = end_time - start_time;
    }

    // Display results
    total_first = 0;
    total_second = 0;
    for (i = 1; i < NTESTS; i++) {
        printf("Sample %d - First Approach completed in %d clock cycles.\n", i, cycles_first[i]);
        printf("Sample %d - Second Approach completed in %d clock cycles.\n\n", i, cycles_second[i]);
        total_first += cycles_first[i];
        total_second += cycles_second[i];
    }
    printf("Average of %ld clock cycles.\n", total_first/NTESTS);
    printf("Average of %ld clock cycles.\n", total_second/NTESTS);

    return;
}
