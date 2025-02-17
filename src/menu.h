/**
 * --------------------------------------
 * 
 * CEaShell Source Code - menu.h
 * By RoccoLox Programs and TIny_Hacker
 * Copyright 2022 - 2023
 * License: GPL-3.0
 * 
 * --------------------------------------
**/

#ifndef MENU_H
#define MENU_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void menu_Looks(uint8_t *colors, void **programPtrs, void **appvarPtrs, unsigned int *fileSelected, const unsigned int fileCount, unsigned int *fileStartLoc, bool *is24Hour, uint8_t *transitionSpeed, const uint8_t directory, bool *displayCEaShell, bool *showHiddenProg, bool *showFileCount, const uint8_t apdTimer, bool *showApps, bool *showAppvars);

void menu_Info(uint8_t *colors, void **programPtrs, void **appvarPtrs, bool *infoOps, unsigned int fileSelected, const unsigned int fileStartLoc, unsigned int *fileNumbers, const uint8_t directory, const bool displayCEaShell, const bool editLockedProg, const bool showHiddenProg, const uint8_t apdTimer, const bool showApps, const bool showAppvars);

void menu_Settings(uint8_t *colors, uint8_t *getCSCHook, bool *editArchivedProg, bool *editLockedProg, bool *hideBusyIndicator, bool *lowercase, uint8_t *apdTimer);

#ifdef __cplusplus
}
#endif

#endif
