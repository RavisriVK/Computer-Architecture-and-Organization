#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

int a[1024][1024], b[1024][1024], c[1024][1024]={0};

int main() {
    /* We start our clock here */
    struct timeval start, end;
    gettimeofday(&start, NULL);

    /* Seed the random number generator */
    srand(time(0));

    /* Fill a and b with random numbers */
    for(int i=0; i<1024; i++) {
        for(int j=0; j<1024; j++) {
            a[i][j]=rand()%11;
            b[i][j]=rand()%11;
        }
    }

    /* Multiply a and b -> A(i, j)=a[i][j], B(i, j)=b[j][i] */
    for(int i=0; i<1024; i++)
        for(int j=0; j<1024; j++)
            for(int k=0; k<1024; k++)
                c[i][j]+= /**/ a[i][k]*b[j][k];

    /* Obtain the runtime and display */
    gettimeofday(&end, NULL);
    double secs= (end.tv_sec - start.tv_sec)*1.0 + (end.tv_usec - start.tv_usec)*0.000001;
    printf("Time taken (s): %lf\n", secs);
}