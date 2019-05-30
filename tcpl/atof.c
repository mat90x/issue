/* TCPL 4.2. Extend `atof` to handle scientific notation of the form

    123.45e-6

where a floating-point number may be followed by `e` or `E` and an optionally
signed exponent. */
#include <ctype.h>
#include <stdio.h>

double atof(char s[]);

int main() {
    char s[100];
    printf("enter string of float number: "); scanf("%s", s);
    printf("converted to float: %f\n", atof(s));
    return 0;
}

double atof(char s[]) {
    int i, sign, val;
    double pow;

    for(i = 0; isspace(s[i]); ++i);

    sign = 1;
    if(s[i] == '-') sign = -1, ++i;

    for(val = 0; isdigit(s[i]); ++i) val = val*10 + s[i] - '0';
    
    if(s[i] == '.') ++i;
    
    for(pow = 1.0; isdigit(s[i]); ++i) {
        val = val*10 + s[i] - '0';
        pow /= 10.0;
    }

    if(s[i] == 'e' || s[i] == 'E') {
        ++i;

        int sign = 1;
        if(s[i] == '-')      ++i, sign = -1;
        else if(s[i] == '+') ++i;

        int exp = atof(&s[i]);
        if(sign > 0) for(i = 0; i < exp; ++i, pow *= 10.0);
        else         for(i = 0; i < exp; ++i, pow /= 10.0);
    }
    
    return sign * val * pow;
}