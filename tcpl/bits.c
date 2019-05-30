/* TCPL 2.6. Write a function setbits(x,p,n,y) that returns `x` with the `n`
bits that begin at position `p` set to the rightmost `n` bits of `y`, leaving
the other bits unchanged.
TCPL 2.7. Write a function invert(x,p,n) that return `x` with the `n` bits that
begin at position `p` inverted, leaving the others unchanged.
TCPL 2.8. Write a function rightrot(x,n) that returns the value of the integer
`x` rotated to the right by `n` bit positions. */
#include <stdio.h>

unsigned setbits(unsigned x, int p, int n, unsigned y);
unsigned invert(unsigned x, int p, int n);
unsigned rightrot(unsigned x, int n);
void bin_repr(unsigned n, char s[]);

int main() {
    unsigned x, y;
    int p, n;
    printf("x p n y: "); scanf("%u%d%d%u", &x, &p, &n, &y);

    char buf[sizeof(int) + 1];
    bin_repr(x, buf); printf("`x` bin repr: %10s\n", buf);
    bin_repr(y, buf); printf("`y` bin repr: %10s\n", buf);

    bin_repr(setbits(x,p,n,y), buf); printf("setbits:  %10s\n", buf);
    bin_repr(invert(x,p,n), buf);    printf("invert:   %10s\n", buf);
    bin_repr(rightrot(x,n), buf);    printf("rightrot: %10s\n", buf);
    return 0;
}

// get `n` rightmost bits of `x` starting from position `p`
unsigned getbits(unsigned x, int p, int n) {
    return x >> p+1-n & ~(~0 << n);
}

unsigned setbits(unsigned x, int p, int n, unsigned y) {
    return x & ~(~(~0 << n) << p+1-n) | (~(~0 << n) & y) << p+1-n;
}

unsigned invert(unsigned x, int p, int n) {
    return x ^ ~(~0 << n) << p+1-n;
}

unsigned rightrot(unsigned x, int n) {
    return x >> n | (x & ~(~0 << n)) << 8-n;
}

void bin_repr(unsigned n, char s[]) {
    int i = 0;
    unsigned mask = ~0 ^ (~0u >> 1);
    for(; mask != 0 && !(n & mask); mask >>= 1);
    if(mask) {
        s[i] = '1';
        for(; mask != 0; mask >>= 1, ++i)
            if(n & mask)
                s[i] = '1';
            else
                s[i] = '0';
    }
    s[i] = '\0';
}