#include <stddef.h>

#ifndef ZEROOS_TERMINAL_H
#define ZEROOS_TERMINAL_H

void terminal_initialize();
void terminal_writestring(const char *data);
size_t strlen(const char *str);

#endif