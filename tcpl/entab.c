/* TCPL 1.21. Write a program `entab` that replaces strings of blanks by the
minimum number of tabs and blanks to achieve the same spacing. When either a
tab or a single blank would suffice to reach a tab stop, whick should be given
preference? */
#include <stdio.h>
#define MAXSIZE 1000

int get_line(char* s, int n);

int main() {
    int len;
    int tab_sz = 4;
    char str[MAXSIZE];
    while(len = get_line(str, MAXSIZE)) {
        int i;
        for(i = 0; i < len && str[i] == ' '; ++i);
        if(i == len) {
            int j;
            for(j = 0; j < len / tab_sz; ++j)
                printf("%s", "\\t");
            for(j = 0; j < len % tab_sz; ++j)
                printf("_");
            printf("\n");
        }
        else {
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