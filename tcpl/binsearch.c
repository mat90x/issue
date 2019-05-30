/* TPCL 3.1. Write a version of binary search with only one test inside the
loop and measure the difference in run-time. */
#include <stdio.h>
#include <time.h>
#define ARRSZ 100000

int binsearch(int x, int v[], int n);
int binsearch2(int x, int v[], int n);

int main() {
    int x, v[ARRSZ];
    clock_t clk;

    printf("enter x and array:\n");
    scanf("%d", &x);
    int i;
    for(i = 0; i < ARRSZ; ++i) {
        scanf("%d", &v[i]);
    }

    clk = clock();
    printf("found %d at %d by binsearch, ", x, binsearch(x,v,ARRSZ));
    clk = clock() - clk;
    printf(
        "took %ld clocks and %Le seconds\n",
        clk,
        (long double) clk/CLOCKS_PER_SEC
        );

    clk = clock();
    printf("found %d at %d by binsearch2, ", x, binsearch2(x,v,ARRSZ));
    clk = clock() - clk;
    printf("took %ld clocks and %Le seconds\n",
        clk,
        (long double) clk/CLOCKS_PER_SEC
        );

    return 0;
}

int binsearch(int x, int v[], int n) {
    int low = 0, high = n - 1, mid;
    while(low <= high) {
        mid = (low+high) / 2;
        if(x < v[mid])
            high = mid - 1;
        else if(x > v[mid])
            low = mid + 1;
        else
            return mid;
    }
    return -1;
}

int binsearch2(int x, int v[], int n) {
    int low = 0, high = n-1, mid = (low + high)/2;
    while(low <= high && x != v[mid]) {
        mid = (low+high) / 2;
        if(x < v[mid])
            high = mid - 1;
        else
            low = mid + 1;
    }
    if(x == v[mid])
        return mid;
    return -1;
}

/*

The runtime difference can be measured with the following command:

for t in {1..10}; do echo $((RANDOM % 99999)) {1..99999} | ./a.out; done
enter x and array:
found 9503 at 9502 by binsearch, took 6 clocks and 6.000000e-06 seconds
found 9503 at 9502 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 9544 at 9543 by binsearch, took 5 clocks and 5.000000e-06 seconds
found 9544 at 9543 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 16725 at 16724 by binsearch, took 22 clocks and 2.200000e-05 seconds
found 16725 at 16724 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 24526 at 24525 by binsearch, took 8 clocks and 8.000000e-06 seconds
found 24526 at 24525 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 10933 at 10932 by binsearch, took 29 clocks and 2.900000e-05 seconds
found 10933 at 10932 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 7584 at 7583 by binsearch, took 8 clocks and 8.000000e-06 seconds
found 7584 at 7583 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 24191 at 24190 by binsearch, took 6 clocks and 6.000000e-06 seconds
found 24191 at 24190 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 13716 at 13715 by binsearch, took 6 clocks and 6.000000e-06 seconds
found 13716 at 13715 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 30425 at 30424 by binsearch, took 6 clocks and 6.000000e-06 seconds
found 30425 at 30424 by binsearch2, took 1 clocks and 1.000000e-06 seconds
enter x and array:
found 13697 at 13696 by binsearch, took 4 clocks and 4.000000e-06 seconds
found 13697 at 13696 by binsearch2, took 1 clocks and 1.000000e-06 seconds

*/
