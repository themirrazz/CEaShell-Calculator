#ifndef UI_H
#define UI_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#define UI_BATTERY	0
#define UI_CHARGING	1
#define UI_PAINT	2
#define UI_INFO		3
#define UI_SETTINGS	4
#define UI_LARROW	5
#define UI_RARROW	6
#define UI_DARROW   7
#define UI_CHECK    8

void ui_DrawUISprite(uint8_t, uint8_t, int, uint8_t);

void ui_DrawFile(bool, bool, bool, bool, uint8_t *, char *, uint8_t, uint8_t, int, uint8_t);

void ui_CheckBox(uint8_t, uint8_t, bool, int, uint8_t);

void ui_Clock(bool);

void ui_Battery(uint8_t, uint8_t, bool);

void ui_StatusBar(uint8_t, bool, uint8_t, char *);

void ui_DescriptionWrap(char *, uint8_t, int, uint8_t);

void ui_BottomBar(uint8_t);

void ui_DrawAllFiles(uint8_t *, uint8_t, uint8_t, unsigned int, bool);

#ifdef __cplusplus
}
#endif

#endif
