;RDSLT version (slow)
;ENASLT of BIOS does not support to change page0.

skw01_dump_rom:

;[output]
;	NZ:error
;[work]
;	all

	ld	de,dta
	call	bdos_setdta

	ld	de,.fcb_rom
	call	bdos_fmake

	or	a
	ret	nz

	ld	hl,SIZDTA
	ld	(.fcb_rom+14),hl

	ld	hl,0

.lp_block:
	ld	bc,SIZDTA
	ld	de,dta

.lp_byte:
	push	bc
	push	de

	ld	a,(skwslot)
	call	RDSLT

	pop	de
	pop	bc

	ld	(de),a
	inc	de
	inc	hl

	dec	bc
	ld	a,c
	or	b
	jr	nz,.lp_byte

	push	hl
	call	bdos_wrblk1
	pop	hl

	or	a
	jr	nz,.errorclose

	bit	7,h
	jr	z,.lp_block

	call	bdos_fclose
	or	a
	ret

.errorclose:
	call	bdos_fclose

	call	bdos_fdel

	or	0FFh
	ret


.fcb_rom:
	db	0,'SKW-01  ROM'
	ds	25,0


