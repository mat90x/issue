/* TCPL 3.5. Write the function itob(n,s,b) that converts the integer `n` into
a base `b` character representation in the string `s`. In particular,
itob(n,s,16) formats `n` as hexademical integer in `s`. */
#include <stdio.h>

void itob(int n, char s[], int base);

int main() {
    int n, base;
    char s[100];
    printf("n base: ");
    scanf("%d %d", &n, &base);
    itob(n, s, base);
    printf("converted: %s\n", s);
    return 0;
}

void itob(int n, char s[], int base) {
    int i, maxn = base;
    for(i = 0; maxn < n; maxn *= base, ++i);
    s[i+1] = '\0';
    for(; i != -1; --i) {
        int d = n % base;
        n /= base;
        if(d >= 0 && d <= 9)
            s[i] = '0' + d;
        else
            s[i] = 'a' + d - 10;
    }
}
