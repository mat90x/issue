/* TCPL 1.22. Write a program to "fold" long input lines into two or more
shorter lines after the last non-blank character that occurs before the n-th
column of input. Make sure your program does something intelligent with very
long lones, and if there are no blanks or tabs before the specified column. */
#include <stdio.h>
#define MAXSIZE 1000

int get_line(char* s, int n);

int main() {
    char str[MAXSIZE];
    int wrap_ind = 19;
    int len;
    while(len = get_line(str, MAXSIZE)) {
        
        if(len > wrap_ind) {
            
            int i;
            for(i = wrap_ind; i < len + 1; i += wrap_ind) {

                int nwl_ind;
                if(str[i] != ' ')
                    for(nwl_ind = i; str[nwl_ind] != ' '; --nwl_ind);
                else
                    nwl_ind = i;

                int j;
                for(j = len; j > nwl_ind; --j)
                    str[j] = str[j - 1];

                str[nwl_ind] = '\n';
                ++i;
                ++len;             
            }
        }
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