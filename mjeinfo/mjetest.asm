
	output	"mjetest.com"

BDOS	equ	0005h
CALSLT	equ	001Ch
ENASLT	equ	0024h
CALLF	equ	0030h
CHPUT	equ	00A2h

_TERM0	equ	00h
_CONOUT	equ	02h
_STROUT	equ	09h

RAMAD1	equ	0F342H
RAMAD3	equ	0F344H
HOKVLD	equ	0FB20h
EXPTBL	equ	0FCC1h
EXTBIO	equ	0FFCAh

MJETBL	equ	0C000h
MJEWORK	equ	0B000h

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


	ld	hl, MJETBL
	ld	de, WORK_MJECV
	ld	bc, 4
	ldir

	;Inquiry
	ld	a, 1

	ld	ix, (WORK_MJEENTRY)

	ld	iy, (WORK_MJESLOT-1)
	call	CALSLT

	ex	de, hl

	;Invoke
	ld	a, 2
	ld	hl, MJEWORK

	ld	ix, (WORK_MJEENTRY)

	ld	iy, (WORK_MJESLOT-1)
	call	CALSLT

	;Release
	ld	a, 3
	ld	hl, MJEWORK

	ld	ix, (WORK_MJEENTRY)

	ld	iy, (WORK_MJESLOT-1)
	call	CALSLT

	ld	a, (0F37Ah)
	cp	0C3h
	jr	z, ERROR_OK

	call	ERROR_DISKWORKBROKEN

.lp:	jr	.lp

ERROREXIT:
	pop	de
	jr	PRINT_STR

EXIT:
	ret
	;ld	c, _TERM0
	;jr	NEAR_BDOS

PRINT_CRLF:
	ld	de, STR_CRLF
PRINT_STR:

	ld		a, (EXPTBL)
	ld		(.slt), a

.lp:
	ld	a, (de)
	cp	'$'
	ret	z
	push	de

	rst	CALLF
.slt:
	db	0
	dw	CHPUT

	pop	de
	inc	de
	jr	.lp

ERROR_NOEXTBIO:
	call	ERROREXIT
	db	"EXTBIO NOT FOUND.",0Dh,0Ah,"$"

ERROR_NOMSXJE:
	call	ERROREXIT
	db	"MSX-JE NOT FOUND.",0Dh,0Ah,"$"

ERROR_TOOMANYMSXJE:
	call	ERROREXIT
	db	"TOO MANY MSX-JE FOUND."

STR_CRLF:
	db	0Dh,0Ah,"$"

ERROR_DISKWORKBROKEN:
	call	ERROREXIT
	db	"DISK WORK CORRUPTED.",0Dh,0Ah,"$"

ERROR_OK:
	call	ERROREXIT
	db	"OK.",0Dh,0Ah,"$"

WORK_MJECV:
	ds	1
WORK_MJESLOT:
	ds	1
WORK_MJEENTRY:
	ds	2
