/* TCPL 3.3. Write a fucntion expand(s1,s1) that expands shorthand notations
like a-z in the string s1 into the equivalent complete list abc...xyz in s2.
Allow for letter of either case and digits, and be prepared to handle cases
like a-b-c and a-z0-9 and -a-z. Arrange that a leading or trailing - is taken
literally. */
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define SZ 1000

void expand(char s1[], char s2[]);

int main() {
    char s1[SZ], s2[SZ];
    printf("enter s1: "); scanf("%s", s1);
    expand(s1, s2);
    printf("expanded s1: %s\n", s2);
    return 0;
}

void expand(char s1[], char s2[]) {
    int i, j;
    s2[0] = s1[0];
    
    for(i = 1, j = 1; i < strlen(s1)-1; ++i) {
        
        int curr = s1[i-1], next = s1[i+1];
        if(
            s1[i] == '-' && curr != next
            && (
                islower(curr) && islower(next)
                || isupper(curr) && isupper(next)
                || isdigit(curr) && isdigit(next)
                ) 
            )
        {
            if(curr < next) for(++curr; curr < next; ++curr, ++j) s2[j] = curr;
            else            for(--curr; next < curr; --curr, ++j) s2[j] = curr;
            
            s2[j++] = next;
            ++i;
        }
        else
            s2[j++] = s1[i];
    }
    
    s2[j++] = s1[i];
    s2[j] = '\0';
}
