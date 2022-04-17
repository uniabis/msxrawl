;sjasm
;option
;F save font HBIJ1KFN.ROM;256KB
;D save driver HBIJ1KDR.ROM:32KB
;J save JE HBIJ1SJE.ROM:1MB
;S save sram HBIJ1SRM.BIN:16KB
;K disable internal font
;1 primary slot 1 for D&J&S(default)
;2 primary slot 2 for D&J&S
;3 primary slot 3 for D&J&S

;CP/M
_BDOS	equ	05h
_TERM0	equ	00h
_STROUT	equ	09h
_CPMVER	equ	0ch

;DOS1
_DOSCPMVER	equ	22h
_RDSLT	equ	0ch
_ENASLT	equ	24h

_RAMAD0	equ	0f341h
_RAMAD1	equ	0f342h
_RAMAD2	equ	0f343h
_RAMAD3	equ	0f344h

;DOS2
_CREATE	equ	44h
_CLOSE	equ	45h
_WRITE	equ	49h
_ERROR	equ	65h
_EXPLAIN	equ	66h
_DOSVER	equ	6fh

_SLTTBL	equ	0fcc5h
_P0_CALL	equ	0f1d9h

;BIOSWORK
HOKVLD equ    0FB20h
EXTBIO equ    0FFCAh

	org	100h

	call	CHKDOS2

	call	CHKOPT

	bit	7,d
	call	nz,PRINTHELP

	bit	4,d
	call	nz,KILLFONT

	bit	0,d
	call	nz,SAVEFONT

	bit	1,d
	call	nz,SAVEDRV

	bit	2,d
	call	nz,SAVEJE

	bit	3,d
	call	nz,SAVESRAM

	;jr	EXIT

EXIT:
	ld	c,_TERM0
	jp	_BDOS

CHKDOS2:
	call	CHKDOS2_1

	ld	de,CHKDOS2_E1_MSG
	;jr	ABORT

ABORT:
	ld	c,_STROUT
	call	_BDOS
	jr	EXIT

BDOS_E:
	call	_BDOS
	or	a
	ret	z

	ld	c,_ERROR
	call	_BDOS

	ld	de,BUF
	push	de
	ld	c,_EXPLAIN
	call	_BDOS
	pop	hl
	push	hl

	xor	a
BDOS_E_LP:
	cp	(hl)
	inc	hl
	jr	nz,BDOS_E_LP

	dec	hl
	ld	(hl),0dh
	inc	hl
	ld	(hl),0ah
	inc	hl
	ld	(hl),'$'

	pop	de
	jr	ABORT

CHKDOS2_1:
	ld	c,_CPMVER
	call	_BDOS

	cp	_DOSCPMVER
	ret	nz
	sub	l
	ret	nz
	or	b
	or	h
	ret	nz

	ld	c,_DOSVER
	call	_BDOS
	or	a
	ret	nz
	ld	a,b
	cp	2
	ret	c

	pop	hl
	ret

SAVEFONT:
	push	de

	ld	de,HBIJ1KFN_N
	xor	a
	ld	b,80h
	ld	c,_CREATE
	call	BDOS_E
	ld	a,b
	ld	(HANDLE),a

	xor	a
	ld	h,a
	ld	l,a

	ld	c,0d9h

SAVEFONT_LP1:
	ld	de,BUF

SAVEFONT_LP2:
	dec	c
	out	(c),l
	inc	c

	out	(c),h

	ld	b,32

SAVEFONT_LP3:
	in	a,(c)
	ld	(de),a
	inc	de
	djnz	SAVEFONT_LP3

	inc	l
	ld	a,l
	and	63
	jr	nz,SAVEFONT_LP2

	push	bc
	push	hl

	call	GETHANDLE
	ld	de,BUF
	ld	hl,32*64
	ld	c,_WRITE
	call	BDOS_E

	pop	hl
	pop	bc

	inc	h
	ld	a,h
	and	63
	jr	nz,SAVEFONT_LP1

	ld	a,c
	cp	0dbh
	jr	z,SAVEFONT_END
	inc	c
	inc	c
	jr	SAVEFONT_LP1

SAVEFONT_END:
	call	GETHANDLE
	ld	c,_CLOSE
	call	BDOS_E

	pop	de

	ret

GETHANDLE:
	push	af
	ld	a,(HANDLE)
	ld	b,a
	pop	af
	ret

CHKOPT:
	ld	de,8001h
	ld	hl,0080h
	ld	a,(hl)
	or	a
	ret	z

	ld	d,h
	ld	b,a
	inc	hl

CHKOPT_LP:
	inc	hl
	ld	a,(hl)
	cp	'1'
	jr	nz,CHKOPT_S1
	ld	e,01h
CHKOPT_S1:
	cp	'2'
	jr	nz,CHKOPT_S2
	ld	e,02h
CHKOPT_S2:
	cp	'3'
	jr	nz,CHKOPT_S3
	ld	e,03h
CHKOPT_S3:
	or	20h
	cp	'f'
	jr	nz,CHKOPT_SF
	set	0,d
CHKOPT_SF:
	cp	'd'
	jr	nz,CHKOPT_SD
	set	1,d
CHKOPT_SD:
	cp	'j'
	jr	nz,CHKOPT_SJ
	set	2,d
CHKOPT_SJ:
	cp	's'
	jr	nz,CHKOPT_SS
	set	3,d
CHKOPT_SS:
	cp	'k'
	jr	nz,CHKOPT_SK
	set	4,d
CHKOPT_SK:
	cp	'h'
	jr	nz,CHKOPT_SH
	set	7,d
CHKOPT_SH:
	djnz	CHKOPT_LP
	ld	a,d
	or	a
	ret	nz
	set	7,d
	ret

PRINTHELP:
	push	de
	ld	de,PRINTHELP_MSG
	ld	c,_STROUT
	call	_BDOS
	pop	de
	ret

KILLFONT:
	ld	a,0fch
	out	(0f5h),a
	ret

DI_INT:
	push	de
	di
	ld	a,(HOKVLD)
	rrca
	jr	nc,DI_INT_S
	ld	de,2
	call	EXTBIO
DI_INT_S:
	pop	de
	ret

EN_INT:
	push	de
	ld	a,(HOKVLD)
	rrca
	jr	nc,EN_INT_S
	ld	de,3
	call	EXTBIO
EN_INT_S:
	ei
	pop	de
	ret

SAVEDRV:
	push	de

	ld	de,HBIJ1KDR_N
	xor	a
	ld	b,80h
	ld	c,_CREATE
	call	BDOS_E
	ld	a,b
	ld	(HANDLE),a

	pop	de

	push	de
	ld	a,084h
	or	e
	ld	h,040h
	call	_ENASLT

	ld	bc,04000h
	ld	hl,04000h
	ld	de,08000h
	ldir

	ld	a,(_RAMAD1)
	ld	h,040h
	call	_ENASLT

	pop	de

	push	de
	ld	a,084h
	or	e
	ld	h,080h
	call	_ENASLT

	ld	bc,04000h
	ld	hl,08000h
	ld	de,04000h
	ldir

	ld	a,(_RAMAD2)
	ld	h,080h
	call	_ENASLT

	call	GETHANDLE
	ld	de,08000h
	ld	hl,04000h
	ld	c,_WRITE
	call	BDOS_E

	call	GETHANDLE
	ld	de,04000h
	ld	hl,04000h
	ld	c,_WRITE
	call	BDOS_E

	call	GETHANDLE
	ld	c,_CLOSE
	call	BDOS_E

	pop	de
	ret

SAVEJE:
	push	de

	ld	de,HBIJ1SJE_N
	xor	a
	ld	b,80h
	ld	c,_CREATE
	call	BDOS_E
	ld	a,b
	ld	(HANDLE),a

	pop	de

	ld	b,0

SAVEJE_LP:

	push	de
	push	bc

	ld	a,080h
	or	e
	ld	h,040h
	call	_ENASLT

	pop	bc

	push	bc
	ld	a,b
	add	a

	ld	(04fffh),a
	inc	a
	ld	(06fffh),a

	ld	bc,04000h
	ld	hl,04000h
	ld	de,08000h
	ldir

	xor	a
	ld	(04fffh),a
	inc	a
	ld	(06fffh),a

	ld	a,(_RAMAD1)
	ld	h,040h
	call	_ENASLT


	call	GETHANDLE
	ld	de,08000h
	ld	hl,04000h
	ld	c,_WRITE
	call	BDOS_E

	pop	bc
	pop	de

	inc	b
	ld	a,b
	and	03fh

	jr	nz,SAVEJE_LP

	push	de

	call	GETHANDLE
	ld	c,_CLOSE
	call	BDOS_E

	pop	de
	ret

SAVESRAM:
	push	de

	ld	de,HBIJ1SRM_N
	xor	a
	ld	b,80h
	ld	c,_CREATE
	call	BDOS_E
	ld	a,b
	ld	(HANDLE),a

	ld	bc,PAGE2CODE_LEN
	ld	hl,PAGE2CODE
	ld	de,08000h
	ldir

	pop	de

	call	SELECT_SRAM
	call	08000h
	call	SELECT_BANK0

	push	de

	call	GETHANDLE
	ld	de,04000h
	ld	hl,04000h
	ld	c,_WRITE
	call	BDOS_E

	call	GETHANDLE
	ld	c,_CLOSE
	call	BDOS_E

	pop	de
	ret


SELECT_BANK0:
	push	de

	ld	a,080h
	or	e
	ld	h,040h
	call	_ENASLT

	xor	a
	ld	(04fffh),a
	inc	a
	ld	(06fffh),a

	jr	SELECT_EXIT

SELECT_SRAM:
	push	de

	ld	a,080h
	or	e
	ld	h,040h
	call	_ENASLT

	ld	a,080h
	ld	(04fffh),a

SELECT_EXIT:
	ld	a,(_RAMAD1)
	ld	h,040h
	call	_ENASLT

	pop	de
	ret


RAMAD0_P2	equ	08000h
RAMAD3_P2	equ	08001h
SAVEPS_P2	equ	08002h
SAVESS_P2	equ	08003h
PAGE2CODE:

	push	de

	ld	a,(_RAMAD0)
	ld	(RAMAD0_P2),a
	ld	a,(_RAMAD3)
	ld	(RAMAD3_P2),a

	in	a,(0a8h)
	ld	(SAVEPS_P2),a
	and	03ch
	rlca
	rlca
	or	e
	rrca
	rrca
	or	e

	di
	out	(0a8h),a

	ld	a,(0ffffh)
	cpl
	ld	(SAVESS_P2),a
	and	03ch
	ld	(0ffffh),a

	ld	bc,04000h
	ld	hl,00000h
	ld	de,04000h
	ldir

	ld	a,(SAVESS_P2)
	ld	(0ffffh),a

	ld	a,(RAMAD0_P2)
	and	3
	ld	e,a

	in	a,(0a8h)
	and	03ch
	rlca
	rlca
	or	e
	rrca
	rrca
	or	e
	out	(0a8h),a

	ld	a,(RAMAD0_P2)
	rlca
	jr	nc,SKIP1_P2
	rrca
	rrca
	rrca
	and	3
	ld	e,a

	ld	a,(0ffffh)
	cpl
	and	0fch
	or	e
	ld	(0ffffh),a

SKIP1_P2:

	ld	a,(RAMAD3_P2)
	and	3
	ld	e,a

	in	a,(0a8h)
	and	03fh
	rlca
	rlca
	or	e
	rrca
	rrca
	out	(0a8h),a

	ld	a,(RAMAD3_P2)
	rlca
	jr	nc,SKIP2_P2
	rlca
	rlca
	rlca
	and	0c0h
	ld	e,a

	ld	a,(0ffffh)
	cpl
	and	03fh
	or	e
	ld	(0ffffh),a

SKIP2_P2:
	ei

	pop	de

	ret

PAGE2CODE_LEN	EQU	$-PAGE2CODE

CHKDOS2_E1_MSG:
	DB	"Invalid OS version$"

PRINTHELP_MSG:
	DB	"HBIJ1S.COM v1.0",0dh,0ah
	DB	"usage: HBIJ1S.COM [options]",0dh,0ah
	DB	"options:",0dh,0ah
	DB	" h show this help.",0dh,0ah
	DB	" f save font image.",0dh,0ah
	DB	" d save driver image.",0dh,0ah
	DB	" j save je image.",0dh,0ah
	DB	" s save jesram image.",0dh,0ah
	DB	" k disable internal font.",0dh,0ah
	DB	" 1 slot 1(default).",0dh,0ah
	DB	" 2 slot 2.",0dh,0ah
	DB	" 3 slot 3.",0dh,0ah
	DB	"$"

HBIJ1KFN_N:
	DB	"HBIJ1KFN.ROM",0
HBIJ1KDR_N:
	DB	"HBIJ1KDR.ROM",0
HBIJ1SJE_N:
	DB	"HBIJ1SJE.ROM",0
HBIJ1SRM_N:
	db	"HBIJ1SRM.BIN",0

HANDLE:
BUF	EQU	HANDLE + 1

