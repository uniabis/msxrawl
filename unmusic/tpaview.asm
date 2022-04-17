
	output	"tpaview.com"

BDOS	equ	0005h
;CALSLT	equ	001Ch
;ENASLT	equ	0024h

_TERM0	equ	00h
_CONOUT	equ	02h
_STROUT	equ	09h

;RAMAD1	equ	0F342H
;RAMAD3	equ	0F344H
;HOKVLD	equ	0FB20h
;EXTBIO	equ	0FFCAh

HIMSAV	equ	0F349h
DOSHIM	equ	0F34Bh
HIMEM	equ	0FC4Ah

	org	100h

	ld	de, STR_TPA
	call	PRINT_STR
	ld	hl, (BDOS+1)
	call	PRINT_HEXW
	call	PRINT_CRLF

	ld	de, STR_HIMSAV
	call	PRINT_STR
	ld	hl, (HIMSAV)
	call	PRINT_HEXW
	call	PRINT_CRLF

	ld	de, STR_DOSHIM
	call	PRINT_STR
	ld	hl, (DOSHIM)
	call	PRINT_HEXW
	call	PRINT_CRLF

	ld	de, STR_HIMEM
	call	PRINT_STR
	ld	hl, (HIMEM)
	call	PRINT_HEXW
	call	PRINT_CRLF

EXIT:
	ld	c, _TERM0
	jr	NEAR_BDOS

PRINT_HEXW:
	push	hl
	ld	a, h
	call	PRINT_HEXB
	pop	hl
	ld	a, l
	;jr	PRINT_HEXB

PRINT_HEXB:
	push	af
	rrca
	rrca
	rrca
	rrca
	call	PRINT_HEX
	pop	af
	;jr	PRINT_HEX

PRINT_HEX:
	and	0Fh
	cp	10
	jr	c, PRINT_NUM
	add	41h-10
	jr	PRINT_CHARA

PRINT_NUM:
	add	30h
PRINT_CHARA:
	ld	e, a
PRINT_CHAR:
	ld	c, _CONOUT
NEAR_BDOS:
	jp	BDOS

PRINT_CRLF:
	ld	de, STR_CRLF
PRINT_STR:
	ld	c, _STROUT
	jr	NEAR_BDOS

STR_CRLF:
	db	0Dh,0Ah,"$"

STR_TPA:
	db	"TPA   :$"
STR_HIMEM:
	db	"HIMEM :$"
STR_HIMSAV:
	db	"HIMSAV:$"
STR_DOSHIM:
	db	"DOSHIM:$"

