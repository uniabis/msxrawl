
skw01_dump_sram:

;[output]
;	NZ:error
;[work]
;	all

	ld	de,dta
	call	bdos_setdta

	ld	de,.fcb_sram
	call	bdos_fmake

	or	a
	ret	nz


	ld	hl,SIZDTA
	ld	(.fcb_sram+14),hl

	ld	hl,8000h

.lp_block:

	push	hl

	ld	a,(skwslot)
	ld	h,40h
	call	ENASLT

	pop	hl

	ld	bc,SIZDTA
	ld	de,dta

.lp_byte:

	ld	a,h
	ld	(7FC9h),a
	ld	a,l
	ld	(7FC8h),a

	ld	a,(7FCAh)
	ld	(de),a
	inc	de
	inc	hl
	dec	bc

	ld	a,b
	or	c
	jr	nz,.lp_byte

	push	hl

	ld	a,(slotp1)
	ld	h,40h
	call	ENASLT

	call	bdos_wrblk1

	pop	hl

	or	a
	jr	nz,.errorclose

	bit	3,h
	jr	z,.lp_block

	call	bdos_fclose
	or	a
	ret

.errorclose:

	call	bdos_fclose

	call	bdos_fdel

	or	0FFh
	ret


.fcb_sram:
	db	0,'SKW-01  SRM'
	ds	25,0
