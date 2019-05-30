/* TCPL 2.3. Write the function htoi(s), which converts a string of hexademical
digits (including an optional 0x or 0X) into its equivalent integer value. The
allowable digits are `0` through `9`, `a` through `f`, and `A` through `F`. */
#include <stdio.h>
#include <math.h>

int ishex(char c);
unsigned long htoi(char* hex);

int main() {
    int c, len = 0;
    char hex[1000];

    printf("enter hex: ");
    
    if((c = getchar()) != EOF && c == '0') {
        if((c = getchar()) != 'x' && c != 'X') {
            printf("invalid prefix");
            return 1;        
        }
    }
    else if(!ishex(c)) {
        printf("non-hex number");
        return 1;
    }
    else
        hex[len++] = c;

    while((c = getchar()) != '\n') {
        if(!ishex(c)) {
            printf("non-hex number");
            return 1;
        }
        hex[len++] = c;
    }
    hex[len] = '\0';

    printf("hex '%s' in dec: %lu\n", hex, htoi(hex));

    return 0;
}

unsigned long htoi(char* hex) {
    unsigned long dec = 0;
    int i, len;
    for(len = 0; hex[len] != '\0'; ++len);
    for(i = len-1; i >= 0; --i) {
        char offset = '0';
        if(hex[i] >= 'a' && hex[i] <= 'f')
            offset = 'a' - 10;
        else if(hex[i] >= 'A' && hex[i] <= 'F')
            offset = 'A' - 10;
        dec += (hex[i] - offset) * pow(16,len-i-1);
    }
    return dec;
}

int ishex(char c) {
    return
        (c >= '0' && c <= '9')
        || (c >= 'a' && c <= 'f')
        || (c >= 'A' && c <= 'F')
        ;
}
