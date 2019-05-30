/*
TCPL 1.8. Write a program to count blanks, tabs, and newlines.
TCPL 1.9. Write a program to copy its input to its output, replacing each
string of one or more blanks by a single blank.
TCPL 1.10. Write a program to copy its input to its output, replacing each tab
by \t, each backspace by \b, and each backlash by \\. This makes tabs and
backspace visible in an unambiguous way.    */
#include <stdio.h>

int main () {
    int c;
    long
        char_cnt = 0,
        lin_cnt = 0,
        tab_cnt = 0,
        blank_cnt = 0
        ;

    while((c = getchar()) != EOF) {
        if(c == '\t') {
            putchar('\\');
            putchar('t');
            ++tab_cnt;
        }
        else if(c == '\\') {
            putchar('\\');
            putchar('\\');
        }
        else {
            putchar(c);
        }

        ++char_cnt;
        if(c == ' ') {
            ++blank_cnt;
        }
        else if(c == '\n') {
            ++lin_cnt;
        }
        else if(c == '\t') {
            ++tab_cnt;
        }
    }

    printf("got %ld characters!\n", char_cnt);
    printf("got %ld blanks!\n", blank_cnt);
    printf("got %ld tabs!\n", tab_cnt);
    printf("got %ld lines!\n", lin_cnt);

    return 0;
}
