/*  TCPL 2.9. In a two's complement number system, x &= (x-1) deletes the
rightmost 1-bit in x. Explain why. Use this ovservation to write a faster
version of `bitcount`.  */
#include <stdio.h>

int bitcount(unsigned x);

int main() {
    unsigned x;
    printf("x: "); scanf("%u", &x);
    printf("bitcount: %d\n", bitcount(x));
    return 0;
}

/* each increase or decrease by one 'flips' rightmost bit, so by making
conjuction with greater or lesser by 1 values one can count 1-bit */
int bitcount(unsigned x) {
    int b;
    for(b = 0; x != 0; x &= (x-1))
        b++;
    return b;
}