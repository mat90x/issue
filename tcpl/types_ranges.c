/* TCPL 2.1. Write a program to determine the ranges of char, short, int, and
long variables, both signed and unsigned, by printing appropriate values from
standard headers and by direct computation. Determine the ranges of the various
floating-point types */
#include <limits.h>
#include <stdio.h>
#include <float.h>
#include <math.h>

int main() {
    // signed data types
    printf("char: {min: %hhd, max: %hhd}, comp: {min: %hhd, max: %hhd}\n",
        CHAR_MIN, CHAR_MAX, 0x80, 0x7f);
    printf("short: {min: %hd, max: %hd}, comp: {min: %hd, max: %hd}\n",
        SHRT_MIN, SHRT_MAX, 0x8000, 0x7fff);
    printf("int: {min: %d, max: %d}, comp: {min: %d, max: %d}\n",
        INT_MIN, INT_MAX, 0x80000000, 0x7fffffff);
    printf("long: {min: %ld, max: %ld}, comp: {min: %ld, max: %ld}\n",
        LONG_MIN, LONG_MAX, 0x8000000000000000, 0x7fffffffffffffff);
    
    // unsigned data types
    printf("uchar: {min: %hhu, max: %hhu}, comp: {min: %hhu, max: %hhu}\n",
        0, UCHAR_MAX, 0x00, 0xff);
    printf("ushort: {min: %hu, max: %hu}, comp: {min: %hu, max: %hu}\n",
        0, USHRT_MAX, 0x0000, 0xffff);
    printf("uint: {min: %u, max: %u}, comp: {min: %u, max: %u}\n",
        0, UINT_MAX, 0x00000000, 0xffffffff);
    printf("ulong: {min: %lu, max: %lu}, comp: {min: %lu, max: %lu}\n",
        0L, ULONG_MAX, 0x0000000000000000L, 0xffffffffffffffff);

    // float or IEEE754 binary32
    printf(
        "float: {min: %e, max: %e}, comp: {min: %e, max: %e}\n",
        FLT_MIN, FLT_MAX, pow(2,-126), pow(2,127) * (2 - pow(2,-23))
        );
    // double or IEEE754 binary64
    printf(
        "double: {min: %e, max: %e}, comp: {min: %e, max: %e}\n",
        DBL_MIN, DBL_MAX, pow(2,-1022), pow(2,1023) * (2 - pow(2,-52))
        );
    // long double or IEEE754 binary 128
    printf(
        "long double: {min: %Le, max: %Le}, comp: {min: %Le, max: %Le}\n",
        LDBL_MIN, LDBL_MAX, powl(2,-16382), powl(2,16383) * (2 - powl(2,-112))
        );

    return 0;
}