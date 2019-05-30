/* TCPL 1.19. Write a function reverse(s) that reverses the character string s.
Use it to write a program that reverses its input a line at a time.
TCPL 4.13. Write a recursive version if the function reverse(s), which reverses
the string `s` in place. */
#include <stdio.h>
#define MAXSIZE 1000

int get_line(char* s, int n);
void reverse(char* s);

int main() {
    char str[MAXSIZE];
    int len;
    while(len = get_line(str, MAXSIZE)) {
        reverse(str);
        printf("%s\n", str);
    }
    return 0;
}

int get_line(char* s, int n) {
    int c, i;

    for(i = 0; i < n -1 && (c = getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;
    s[i] = '\0';

    return i;
}

void reverse(char *s) {
    int i, j;
    for(i = 0; s[i] != '\0'; ++i);
    --i;
    for(j = 0; j < i; ++j, --i) {
        s[i] = s[i] - s[j];
        s[j] = s[j] + s[i];
        s[i] = s[j] - s[i];
    }
}