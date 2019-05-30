/*  TCPL 1.16. Revise the main routine of the longest-line program so it will
correctly print the length of arbitrarily long input lines, and as much as
possible of the text.   */
#include <stdio.h>
#define MAXSIZE 10

int get_line(char* s, int n);

int main() {
    int len;
    char str[MAXSIZE];
    while(len = get_line(str, MAXSIZE)) {
        printf("%d: %s\n", len, str);
    }

    return 0;
}

int get_line(char* s, int n) {
    int c, i;

    for(i = 0; i < n - 1 && (c = getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;
    s[i] = '\0';

    if(c != '\n' && c != EOF)
        while((c = getchar()) != '\n' && c != EOF)
            ++i;

    return i;
}