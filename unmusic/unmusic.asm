
	output	"unmusic.com"
	org	100h

; MSX BIOS

RDSLT	equ	000Ch
IDBYT3	equ	002Eh

; MSX WORK

HIMEM	equ	0FC4Ah
EXPTBL	equ	0FCC1h
SLTWRK	equ	0FD09h

H.TIMI	equ	0FD9Fh
H.MDTM	equ	0FF93h
H.PHYD	equ	0FFA7h
; CP/M

BDOS	equ	0005h
_STROUT	equ	09h

; MSX-DOS

HIMSAV	equ	0F349h
BASBDOS	equ	0F37Dh

DOS1SIZFCB	equ	25h
DOS1NUMFCB	equ	0F345h
DOS1FCB	equ	0F353h
DOS1BLOADCDDE	equ	0F377h

; MSX-DOS2

_DOSVER	equ	6Fh

DOS2MFLAGS	equ	0F2EFh
DOS2BLDCHK	equ	0F2F1h
DOS2PATHNAM	equ	0F33Bh
DOS2SECBUF	equ	0F34Dh
DOS2MAXSEC	equ	0F34Fh
DOS2DIRBUF	equ	0F351h

; Nextor

NEXMFLAGKILL	equ	4
;NEXMAXSEC	equ	0F6ABh

; MSX-MUSIC

MUSSLT	equ	0F97Ch
MUSWRK	equ	0F97Dh
MUSHSV	equ	0F9BBh

MUSWSZ	equ	12*6+12*32+9*39 ; 327h(807)



	call	FREE_DISKBASICWORK

	ld	a, (MUSSLT)
	push	af

	call	FREE_MSXMUSIC

	call	FREE_DISKBASICWORK

	pop	bc

	ld	a, (MUSSLT)
	cp	b
	jr	z, PRINT_ERROR

PRINT_OK:
	ld	de, .ok_msg
.strout:
	ld	c, _STROUT
	jp	BDOS

.ok_msg:
	db	"MSX-MUSIC UNINSTALLED.",0Dh, 0Ah, "$"

PRINT_ERROR:
	ld	de, .error_msg
	jr	PRINT_OK.strout

.error_msg:
	db	"MSX-MUSIC NOT FOUND.",0Dh, 0Ah, "$"


FREE_MSXMUSIC:

	ld	de, (MUSWRK)
	call	CHECK_HIMEM
	ret	nz

	ld	a, (MUSSLT)
	or	a
	ret	z

	call	GET_SLTWRKP1

	bit	0, (hl)
	ret	z

	ld	a, (EXPTBL)
	ld	hl, IDBYT3
	call	RDSLT

	dec	a

	ld	hl, H.TIMI + 1
	jr	nz, .nomidi

	; A1GT
	out	(0E9h), a
	out	(0EAh), a
	ld	hl, H.MDTM + 1

.nomidi:

	ld	a, (MUSSLT)
	cp	(hl)
	ret	nz

	dec	hl

	ex	de, hl
	ld	hl, MUSHSV
	ld	bc, 5

	di

	ldir

	ld	hl, (HIMSAV)
	ld	de, MUSWSZ
	call	ADD_HIMEM

	ld	a, (MUSSLT)
	call	GET_SLTWRKP1

	res	0, (hl)

	ld	a, 0C9h
	ld	(MUSHSV), a

	xor	a
	ld	(MUSSLT), a
	ld	(MUSWRK+0), a
	ld	(MUSWRK+1), a

	ei

	ret


FREE_DISKBASICWORK:

	ld	a, (H.PHYD)
	cp	0C9h
	ret	z

	ld	c, _DOSVER
	call	BASBDOS
	or	a
	ret	nz

	ld	a, b
	cp	2
	jr	c, .dos1
	ret	nz

.dos2:
	ld	de, (DOS2BLDCHK)
	call	CHECK_HIMEM
	ret	nz

	ld	de, 0Dh
	call	ADD_HIMEM

	ld	a, (DOS2MFLAGS)
	bit	NEXMFLAGKILL, a
	ret	nz

	ld	de, (DOS2DIRBUF)
	call	CHECK_HIMEM
	ret	nz

	ld	de, (DOS2PATHNAM)
	call	CHECK_HIMEM
	ret	nz

	ld	de, (DOS2SECBUF)
	ld	(DOS2DIRBUF), de
	ld	(DOS2PATHNAM), de

	ld	de, (DOS2MAXSEC)
	jr	ADD_HIMEM

.dos1:

	ld	de, (DOS1BLOADCDDE+1)
	call	CHECK_HIMEM
	ret	nz

	ld	de, 25
	call	ADD_HIMEM

	ld	de, (DOS1FCB)
	call	CHECK_HIMEM
	ret	nz

	ld	a, (DOS1NUMFCB)
	ld	b, a
	ld	de, DOS1SIZFCB
.lpfcb:
	add	hl, de
	djnz	.lpfcb

	jr	SET_HIMEM

ADD_HIMEM:
	add	hl, de
SET_HIMEM:
	ld	(HIMSAV), hl
	ld	(HIMEM), hl
	ret

CHECK_HIMEM:
	ld	hl, (HIMSAV)
	push	hl
	or	a
	sbc	hl, de
	pop	hl
	ret

	;x000SSPP
GET_SLTWRKP1:
	and	8Fh
	add	a
	jr	c, .extended
	and	06h
.extended:
	;000SSPP0
	ld	c, a
	and	06h
	;00000PP0
	add	a
	add	a
	add	a
	add	a
	;0PP00000
	or	c
	;0PPSSPP0
	and	78h
	;0PPSS000
	ld	c, a
	ld	b, 0
	ld	hl, SLTWRK+2
	add	hl, bc
	ret

