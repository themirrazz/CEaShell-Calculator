;--------------------------------------
;
; CEaShell Source Code - appvars.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2022 - 2023
; License: GPL-3.0
;
;--------------------------------------

	assume adl=1

	section .text

include 'include/ti84pceg.inc'

	public _getAppvarType
    public _editCelticAppvar
    extern edit_basic_program

returnCEaShell := ti.appData + 11
isAppvar := returnCEaShell + 1
edit_appvar := $cc
backup_appvar_name := isAppvar + 1

EOF := ti.appData

_getAppvarType:
    push ix
    ld ix, 0
    add ix, sp
    ld hl, (ix + 6) ; get name
    pop ix
    ld a, ti.AppVarObj
    ld (ti.OP1), a ; move type to OP1
    ld de, ti.OP1 + 1
    ld bc, 8
    ldir ; move name to OP1

    call ti.ChkFindSym
    call ti.ChkInRam
    jr z, .inRam ; we can skip this next bit if it's in the RAM
    ; it's in archive, so we need to change the data offset
    ld hl, 10
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    ex de, hl

.inRam:
    ld hl, 0
    ld a, (de)
    ld l, a
    inc de
    ld a, (de)
    ld h, a
    inc de
    call _getEOF
    ex de, hl
    ld a, $3e ; ':' token
    cp a, (hl)
    jr nz, .notCeltic
    inc hl
    ld a, $43 ; 'C' token
    cp a, (hl)
    jr nz, .notCeltic
    inc hl
    ld a, $45 ; 'E' token
    cp a, (hl)
    jr nz, .notCeltic
    inc hl
    ld a, $4c ; 'L' token
    cp a, (hl)
    ld a, 1
    jr nz, .notCeltic
    inc hl
    ld a, $3f ; newline token
    cp a, (hl)
    jr z, .celtic
    push hl
    pop bc
    call _checkEOF
    jr nz, .notCeltic

.celtic:
    ld a, 8 ; Celtic appvar type
    ret

.notCeltic:
    ld a, 6 ; appvar type
    ret

_checkEOF: ; bc = current address being read; destroys hl and a
    ld hl, (EOF)
    inc hl
    or a, a
    sbc hl, bc
    ret nc
    dec de
    cp a, a
    ret

_getEOF: ; args: hl = size of var; de = start of variable; preserves both registers
    push hl
    dec hl
    add hl, de
    ld (EOF), hl
    pop hl
    ret

_editCelticAppvar:
	ld hl, returnCEaShell
	ld (hl), 1
    ld hl, isAppvar
    ld (hl), edit_appvar
	push ix
    ld ix, 0
    add ix, sp
    ld hl, (ix + 6) ; get name
    pop ix
    ld a, ti.AppVarObj
    ld (ti.OP1), a ; move type to OP1
    ld de, ti.OP1 + 1
    ld bc, 8
    ldir ; move name to OP1
    call _backupAppvarName
    call ti.ChkFindSym
    call ti.ChkInRam
    jr z, .inRam
    ld hl, 10
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    ex de, hl

.inRam:
    ld hl, 0
    ld a, (de)
    ld l, a
    inc de
    ld a, (de)
    ld h, a ; get appvar size
    inc de
    push hl ; size
    push de ; appvar data pointer
    push hl
    ld hl, tempProg
    call ti.Mov9ToOP1
    pop hl
    call ti.CreateProg
    pop hl
    pop bc
    inc de
    inc de
    ldir
    call ti.OP4ToOP1
    jp edit_basic_program

_backupAppvarName:
	ld hl, ti.OP1
.entry:
	ld de, backup_appvar_name
	jp ti.Mov9b

tempProg:
    db ti.ProgObj, "appvar", 0

