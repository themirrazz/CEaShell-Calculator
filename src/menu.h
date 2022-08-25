#ifndef MENU_H
#define MENU_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void menu_Looks(uint8_t *, uint8_t, uint8_t, unsigned int, bool, bool);

void menu_Info(uint8_t *, bool *, uint8_t, unsigned int, uint8_t *, bool);

void menu_Settings(uint8_t);

#ifdef __cplusplus
}
#endif

#endif
