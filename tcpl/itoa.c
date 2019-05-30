/* TCPL 3.4. In a two's complement number representation, our version of `itoa`
does not handle the largest negative number, that is, the value of `n` equal
to -(2^(wordsize-1)). Explain why not. Modify it to print that value correctly,
regardless of the machine on which it runs.
TCPL 3.6. Write a version of `itoa` that accepts three arguments instead of
two. The third argument is a minimum field width; the converted number must be
padded with blanks on the left if necessary to make it wide enough. */
#include <stdio.h>
#include <stdlib.h>

void reverse(char s[]);
void itoa(int n, char s[]);
void itoa2(int n, char s[], int pads_cnt);

int main() {
    int n, pads_cnt;
    char s[100];
    printf("enter n and paddings count: "); scanf("%d%d",&n,&pads_cnt);
    itoa(n, s);             printf("itoa  string repr: %s\n", s);
    itoa2(n, s, pads_cnt);  printf("itoa2 strings repr: %s\n", s);
    return 0;
}

/*
In two's complement number representation, to get negative number one should
invert all the bits in the positive number and add one, so

 5 is represented by 0101
-5 is represented by 1011

In two's complement number representaiotn the range of values is from -(2^n)-1
to 2^n, where `n` is the variables size. So, the absolute value of the largest
negative number cannot be presented.

So, original itoa() negates passed values, deducing whether to put minus sign
in front of the string. To make the representation machine independent, the
passed value shouldn't be negated, and the sign definition should be carried
out at the end, and absolute values of modulus product should be used, and the
division by ten of originla value should be used.
*/
void itoa(int n, char s[]) {
    int i, sign;
    sign = n;   // just remember the passed value for sign deduction

    i = 0;    
    do {
        s[i++] = abs(n % 10) + '0'; // use only absolute values
    } while (n /= 10);              // smarter loop control
    
    if(sign < 0) s[i++] = '-';      // deduce whether to put minus sign
    s[i] = '\0';
    
    reverse(s);
}

void reverse(char s[]) {
    int i, j;
    for(i = 0; s[i] != '\0'; ++i);
    --i;
    for(j = 0; j < i; ++j, --i) {
        s[i] = s[i] - s[j];
        s[j] = s[j] + s[i];
        s[i] = s[j] - s[i];
    }
}

void itoa2(int n, char s[], int pads_cnt) {
    int i;
    for(i = 0; i < pads_cnt; s[i++] = ' ');

    // find nearest greater round number and count digits
    int rnd = 1, absn = abs(n);
    for(i = 1; absn % rnd != absn; rnd *= 10, ++i);

    int sign = n < 0 ? 1 : 0;
    if(i + sign < pads_cnt) i = pads_cnt - i + 1 - sign;
    else                    i = 0;
    
    if(sign) s[i++] = '-';
    
    for(rnd /= 10; rnd != 0; rnd /= 10) {  // start selecting digits
        s[i++] = absn/rnd + '0';
        absn -= rnd*(absn/rnd);
    }
    s[i] = '\0';
}
