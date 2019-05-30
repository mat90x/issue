/* TCPL 1.23. Write a program to remove all comments from a C program. Don't
forget to handle quoted strings and character constants properly. C comments do
not nest. */
#include <stdio.h>

int main() {
    while(1) {              // this oneliner should be removed
        int c = getchar();
        if(c == '/') {
            int t = c;
            c = getchar();
            if(c == '/') {
                while((c = getchar()) != EOF && c != '\n');
                if(c == '\n')
                    putchar(c);
                continue;
            }
            else if(c == '*') {
                while(
                    ((c = getchar()) != EOF && c != '*')
                    || ((c = getchar()) != EOF && c != '/')
                    );
                continue;   // this oneliner is also to be removed
            }
            else
                putchar(t);
        }
        else if(c == '"')
            while((c = getchar()) != EOF && c != '"')
                putchar(c);
        if(c != EOF)
            putchar(c);
        else
            break;
    }
    return 0;               /* this multiline should be removed */
}
