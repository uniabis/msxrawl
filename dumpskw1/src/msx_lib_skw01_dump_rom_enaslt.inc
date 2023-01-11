;ENASLT version
;ENASLT of DOS supports to change page0

skw01_dump_rom:

;[output]
;	NZ:error
;[work]
;	all

	ld	de,dta
	call	bdos_setdta

	ld	de,fcb_rom
	call	bdos_fmake

	or	a
	ret	nz


	ld	hl,SIZDTA
	ld	(fcb_rom+14),hl


	ld	hl,0

.lp:

	push	hl

	ld	a,(skwslot)
	call	enasltx

	pop	hl

	push	hl

	ld	bc,SIZDTA
	ld	de,dta
	ldir

	ex	(sp),hl

	ld	a,(slotp0)
	bit	6,h
	jr	z,.page0
	ld	a,(slotp1)
.page0:
	call	enasltx

	call	bdos_wrblk1

	pop	hl

	or	a
	jr	nz,.errorclose

	bit	7,h
	jr	z,.lp

	call	bdos_fclose
	or	a
	ret

.errorclose:
	call	bdos_fclose

	call	bdos_fdel

	or	0FFh
	ret

fcb_rom:
	db	0,'SKW-01  ROM'
	ds	25,0


