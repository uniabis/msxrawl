
	output	"mjeinfo.com"

BDOS	equ	0005h
CALSLT	equ	001Ch
ENASLT	equ	0024h

_TERM0	equ	00h
_CONOUT	equ	02h
_STROUT	equ	09h

RAMAD1	equ	0F342H
RAMAD3	equ	0F344H
HOKVLD	equ	0FB20h
EXTBIO	equ	0FFCAh

MJETBL	equ	0C000h

	org	100h

	ld	a, (HOKVLD)
	rra
	jp	nc, ERROR_NOEXTBIO

	ld	de, 1000h
	ld	hl, MJETBL

	ld	a, (RAMAD3)
	ld	b, a
	call	EXTBIO

	or	a
	ld	de, MJETBL
	sbc	hl, de
	jp	z, ERROR_NOMSXJE

	ld	a, h
	or	a
	jp	nz, ERROR_TOOMANYMSXJE

	ld	a, l
	rrca
	rrca
	and	3Fh

	push	af

	call	PRINT_HEADER

	pop	af

	ld	hl, MJETBL
	ld	b, a
.lp:
	push	bc

	ld	de, WORK_MJECV
	ld	bc, 4
	ldir

	push	hl

	;ld	a, (WORK_MJESLOT)
	;ld	h, 40h
	;call	ENASLT

	;Inquiry
	ld	a, 1

	ld	ix, (WORK_MJEENTRY)

	ld	iy, (WORK_MJESLOT-1)
	call	CALSLT

	;call	JPIX

	ld	(WORK_MJEMAX), hl
	ld	(WORK_MJEMIN), de
	ld	(WORK_MJEMIN2), bc

	;ld	a, (RAMAD1)
	;ld	h, 40h
	;call	ENASLT

	ld	a, (WORK_MJESLOT)
	call	PRINT_SLOT
	call	PRINT_SPACE

	ld	hl, (WORK_MJEENTRY)
	call	PRINT_HEXW
	call	PRINT_SPACE

	ld	a, (WORK_MJECV)
	call	PRINT_HEXB
	call	PRINT_SPACE

	ld	hl, (WORK_MJEMIN)
	call	PRINT_HEXW
	call	PRINT_SPACE

	ld	hl, (WORK_MJEMIN2)
	call	PRINT_HEXW
	call	PRINT_SPACE

	ld	hl, (WORK_MJEMAX)

	push	hl

	call	PRINT_HEXW
	call	PRINT_SPACE

	pop	hl

	call	PRINT_TYPE
	call	PRINT_CRLF

	pop	hl
	pop	bc
	djnz	.lp

	jr	EXIT

;JPIX:
;	jp	(ix)

ERROREXIT:
	pop	de
	ld	c, _STROUT
	call	BDOS

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

PRINT_EXTENDED_SLOT:
	push	af
	and	3
	call	PRINT_NUM

	ld	e, 2Dh
	call	PRINT_CHAR

	pop	af
	rrca
	rrca
	and	3
	;jr	PRINT_NUM

PRINT_NUM:
	add	30h
PRINT_CHARA:
	ld	e, a
	jr	PRINT_CHAR

PRINT_SLOT:
	or	a
	jp	M, PRINT_EXTENDED_SLOT
	and	3
	call	PRINT_NUM
	call	PRINT_SPACE
	;jr	PRINT_SPACE

PRINT_SPACE:
	ld	e, 20h
	;jr	PRINT_CHAR

PRINT_CHAR:
	ld	c, _CONOUT
NEAR_BDOS:
	jp	BDOS

PRINT_CRLF:
	ld	de, STR_CRLF
PRINT_STR:
	ld	c, _STROUT
	jr	NEAR_BDOS

PRINT_HEADER:
	ld	de, STR_HEADER
	jr	PRINT_STR

PRINT_TYPE:
	ld	a, l
	or	a
	ret	nz
	ld	a, h
	cp	0Dh
	jr	z, PRINT_TYPE_VJE80
	cp	02h
	jr	z, PRINT_TYPE_VJE80A
	cp	0Ah
	ret	nz

PRINT_TYPE_SONYJFP:
	ld	de, STR_TYPE_SONYJFP
	jr	PRINT_STR

PRINT_TYPE_VJE80A:
	call	PRINT_TYPE_VJE80
	ld	e, 41h
	jr	PRINT_CHAR

PRINT_TYPE_VJE80:
	ld	de, STR_TYPE_VJE80
	jr	PRINT_STR

ERROR_NOEXTBIO:
	call	ERROREXIT
	db	"EXTBIO NOT FOUND.",0Dh,0Ah,"$"

ERROR_NOMSXJE:
	call	ERROREXIT
	db	"MSX-JE NOT FOUND.",0Dh,0Ah,"$"

ERROR_TOOMANYMSXJE:
	call	ERROREXIT
	db	"TOO MANY MSX-JE FOUND.",0Dh,0Ah,"$"

STR_HEADER:
	db	"SLT ENTR CV MIN  MIN2 MAX  TYPE"
STR_CRLF:
	db	0Dh,0Ah,"$"

STR_TYPE_VJE80:
	db	"VJE80$"

STR_TYPE_SONYJFP:
	db	"SONYJFP$"

WORK_MJECV:
	ds	1
WORK_MJESLOT:
	ds	1
WORK_MJEENTRY:
	ds	2
WORK_MJEMIN:
	ds	2
WORK_MJEMIN2:
	ds	2
WORK_MJEMAX:
	ds	2

