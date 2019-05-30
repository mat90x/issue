/* TCPL 1.18. Write a program to remove trailing blanks and tabs from each line
of input, and to delete entirely blank lines.   */
#include <stdio.h>
#define MAXSIZE 1000

int main() {
    char str[MAXSIZE];
    int len = 0, c;
    while((c = getchar()) != EOF) {
        if(c != '\n') {
            str[len++] = c;
        }
        else if (len) {
            int i;
            for(i = len - 1; i >= 0 && (str[i] == ' ' || str[i] == '\t'); --i);
            if(i != len - 1)
                str[i + 1] = '\0';
            printf("*%s*\n", str);
            len = 0;
        }
    }
}
