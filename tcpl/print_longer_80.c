/*  TCPL 1.17. Write a program to print all input lines that are longer than 80
characters. */
#include <stdio.h>
#define MAXSIZE 1000

int get_line(char *s, int n);

int main() {
    char str[MAXSIZE];
    int len;
    while(len = get_line(str, MAXSIZE)) {
        if(len >= 79) {
            printf("%s\n", str);
        }
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