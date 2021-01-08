#include <utils.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "utils.h"

#if defined( RPI0 ) || defined( RPI1 )
    #define GPIO_BASE       0x20200000UL
#elif defined( RPI2 ) || defined( RPI3 )
    #define GPIO_BASE       0x3F200000UL
#elif defined( RPI4 )
    #define GPIO_BASE       0xFE200000UL
#else
    #error Unknown RPI Model!
#endif

void mem_test()
{
    int loop;
    unsigned int* buffer;
    buffer = (unsigned int*)malloc( 1024 * sizeof( unsigned int ) );
    for( loop=0; loop<1024; loop++ )
        buffer[loop] = 0;
    free(buffer);
}

volatile unsigned int* gpio = (unsigned int*)GPIO_BASE;

extern "C" void app_main()
{
    gpio[1] |= (1 << 18); // GPIO init for rpi1 Ack LED
    mem_test();
    while(1)
    {
        gpio[7] = (1 << 16); // Turn LED on
        delay(500);
        gpio[10] = (1 << 16); // Turn LED off
        delay(500);
    }
}