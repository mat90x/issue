/*
TCPL 1.3. Modify the temperature conversion program to print a heading above
the table.
TCPL 1.4. Write a program to print the corresponding Celcius to Fahrenheit
table
TCPL 1.5. Modify the temperature conversion program to print the table in
reverse order, that is, form 300 degrees to 0.  */
#include <stdio.h>
#include <wchar.h>

int main() {
    int
        grade,
        lower = 0,
        upper = 300,
        step = 20
        ;

    printf("Fahrenheit to Celcius:\n%7s %7s\n", "°F", "°C");
    grade = lower;
    while(grade <= upper) {
        printf("%6d %6.1f\n", grade, 5.0 / 9.0 * (grade - 32));
        grade += step;
    }
    printf("\n");

    printf("Celcius to Fahrenheit:\n%7s %7s\n", "°C", "°F");
    grade = lower;
    while(grade <= upper) {
        printf("%6d %6.1f\n", grade, grade * 5.0 / 9.0 + 32);
        grade += step;
    }
    printf("\n");

    printf("Fahrenheit to Celcius in reverse:\n%7s %7s\n", "°F", "°C");
    for(grade = upper; grade >= 0; grade -= step) {
        printf("%6d %6.1f\n", grade, 5.0 / 9.0 * (grade - 32));
    }

    return 0;
}
