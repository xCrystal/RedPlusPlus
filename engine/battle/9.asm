; [wd0b5] = pokemon ID
; hl = dest addr
PrintMonType: ; 27d6b (9:7d6b)
	call GetPredefRegisters
	push hl
	call GetMonHeader
	pop hl
	push hl
	ld a, [W_MONHTYPE1]
	call PrintType
	ld a, [W_MONHTYPE1]
	ld b, a
	ld a, [W_MONHTYPE2]
	cp b
	pop hl
	jr z, EraseType2Text
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

; a = type
; hl = dest addr
PrintType: ; 27d89 (9:7d89)
	push hl
	jr PrintType_

; erase "TYPE2/" if the mon only has 1 type
EraseType2Text: ; 27d8c (9:7d8c)
	ld a, " "
	ld bc, $13
	add hl, bc
	ld bc, $6
	jp FillMemory

PrintMoveType: ; 27d98 (9:7d98)
	call GetPredefRegisters
	push hl
	ld a, [W_PLAYERMOVETYPE]
; fall through

PrintType_: ; 27d9f (9:7d9f)
	add a
	ld hl, TypeNames
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "text/type_names.asm"

FocusEnergyEffect_: ; 27f86 (9:7f86)
	ld hl, W_PLAYERBATTSTATUS2
	ld a, [H_WHOSETURN]
	and a
	jr z, .notEnemy
	ld hl, W_ENEMYBATTSTATUS2
.notEnemy
	bit GettingPumped, [hl] ; is mon already using focus energy?
	jr nz, .alreadyUsing
	set GettingPumped, [hl] ; mon is now using focus energy
	callab PlayCurrentMoveAnimation
	ld hl, GettingPumpedText
	jp PrintText
.alreadyUsing
	ld c, $32
	call DelayFrames
	ld hl, PrintButItFailedText_
	ld b, BANK(PrintButItFailedText_)
	jp Bankswitch

GettingPumpedText: ; 27fb3 (9:7fb3)
	db $0a
	TX_FAR _GettingPumpedText
	db "@"
