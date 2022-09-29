;--------------------------------------
;
; CEaShell Source Code - hooks.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2022
; License: GPL-3.0
;
;--------------------------------------

    assume adl=1

    section .text

include 'include/ti84pceg.inc'

	extern _sortVAT
    extern _showIcons
    public _installGetCSCHook

; CEaShell hook flags stuff
updateProgInfo := 0

_getCSCHookStart:
    db $83
    push bc
    cp a, $1a
    jr nz, .keyPress
    pop bc
    push af
    ld a, (ti.menuCurrent)
    cp a, 3 ; check for program menu
    jr nz, .return
    ld a, (ti.menuCurrentSub)
    cp a, ti.mPrgm_Run ; check for run menu
    jr z, .update
    cp a, ti.mPrgm_Edit
    jr nz, .returnOther

.update:
    bit updateProgInfo, (iy + ti.asm_Flag2)
    jr nz, .return
    call _showIcons
    set updateProgInfo, (iy + ti.asm_Flag2)
    jr .return

.keyPress: ; keypress event
    ld a, ti.skPrgm
    cp a, b
    jr z, .sort
    ld a, ti.skUp
    cp a, b
    jr z, .updateDescription
    ld a, ti.skDown
    cp a, b
    jr z, .updateDescription
    ld a, ti.skLeft
    cp a, b
    jr z, .updateDescription
    ld a, ti.skRight
    cp a, b
    jr nz, .return

.updateDescription:
    res updateProgInfo, (iy + ti.asm_Flag2)
    jr .return

.sort:
    res updateProgInfo, (iy + ti.asm_Flag2)
    call _sortVAT

.return:
    pop bc
    or a, 1
    ld a, b
    ret

.returnOther: ; draw over icons when switching menu
	ld hl, $ffff
	ld (ti.fillRectColor), hl
	ld hl, 144
	ld de, 152
	ld b, 58
	ld c, 234
	call ti.FillRect
	pop bc
	or a, 1
	ld a, b
	ret

_installGetCSCHook:
    ld hl, _getCSCHookStart
    jp ti.SetGetCSCHook
