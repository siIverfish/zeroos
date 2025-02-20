#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "terminal.h"

void outb(uint8_t data, uint16_t port)
{
    __asm__ volatile (
        "outb %0, %1"
        :
        : "a" (data), "Nd" (port) 
    );
}

// void outw(uint16_t data, uint16_t port)
// {
//     __asm__ volatile (
//         "outw %0, %1"
//         :
//         : "0" (port), "1" (data) 
//     );
// }

// void outl(uint32_t data, uint16_t port)
// {
//     __asm__ volatile (
//         "outl %0, %1"
//         :
//         : "0" (port), "1" (data) 
//     );
// }

void test_serial_COM1_output()
{
    char *message = "Hello, World!\n";
    for (size_t i = 0; i < strlen(message); i++)
    {
        outb(message[i], 0x03F8); // COM1
    }
}

void init_network()
{
    test_serial_COM1_output();
}

void kernel_main(void)
{
    terminal_initialize();
    terminal_writestring("Hello, World!\nNext line\nInitializing with a very long sequence of characters that will go over the limit and onto the next line...");

    init_network();
}  