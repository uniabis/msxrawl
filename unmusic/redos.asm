
	; reboot dos

	; from Kanji Driver (Un)installer
	; http://www.yo.rim.or.jp/~anaka/AtoC/programs/msx32.htm

	output	"redos.com"

ENASLT	equ	0024h
CALLF	equ	0030h

NEWSTT	equ	4601h

KBUF	equ	0F41Fh
FILTAB	equ	0F860h
NULBUF	equ	0F862h
EXPTBL	equ	0FCC1h


BDOS	equ	0005h
_DOSVER	equ	6Fh

	org	100h

	ld	hl, page2_code
	ld	de, 8000h
	ld	bc, page2_code.end - page2_code

	push	de

	ldir

	push	de

	ld	c, _DOSVER
	call	BDOS

	pop	de

	or	a
	ret	nz

	ld	a, b
	cp	2
	ret	c

	ld	hl,0080h
	ld	a, (hl)
	or	a
	ret	z

	ex	de, hl

	dec	hl
	ld	(hl), '('
	inc	hl
	ld	(hl), 22h
	inc	hl

	ex	de, hl

	inc	hl
	ld	c, a

	ldir

	ex	de, hl

	ld	(hl), 22h
	inc	hl
	ld	(hl), ')'
	inc	hl
	ld	(hl), 00h

	ret

page2_code:

	di

	ld	a, (EXPTBL)
	push	af
	ld	h,40h
	call	ENASLT
	pop	af
	ld	h,00h
	call	ENASLT

	xor	a
	ld	hl, KBUF
	ld	(FILTAB), hl
	ld	hl, KBUF + 4
	ld	(KBUF), hl
	ld	(hl), a
	ld	hl, KBUF + 10Dh
	ld	(KBUF + 2), hl
	ld	(hl), a
	ld	hl, KBUF + 0Dh
	ld	(NULBUF), hl

	ld	hl, .call_system - page2_code + 8000h
	jp	NEWSTT

.call_system:
	db	':',0CAh,'SYSTEM'
.call_system_arg:
	db	00h
.end:
