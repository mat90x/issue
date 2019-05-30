/* TCPL 1.20. Write a program `detab` that replaces tabs in the input with the
proper number of blanks to space to the next tab stop. Assume a fixed set of
tab stops, say every n columns. Should n be a variable or a symbolic
parameter? */
#include <stdio.h>

int main() {
    char c;
    int tab_sz = 4;
    int col = 0;
    while((c = getchar()) != EOF) {
        if(c == '\n')
            col = 0;
        else if(c == '\t') {
            int i;
            for(i = tab_sz - col % tab_sz; i > 0; --i) {
                putchar(' ');
                ++col;
            }
        }
        else {
            putchar(c);
            ++col;
        }
    }
    return 0;
}
