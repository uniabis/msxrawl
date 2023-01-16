
skw01_dump_kanji:

;[output]
;	NZ:error
;[work]
;	all

	ld	de,dta
	call	bdos_setdta

	ld	de,.fcb_kanji_font
	call	bdos_fmake

	or	a
	ret	nz


	ld	hl,SIZDTA
	ld	(.fcb_kanji_font+14),hl

	ld	ix,7FC0h
	call	.kanji32k

	ld	ix,7FC2h
	call	.kanji32k

	ld	ix,7FC4h
	call	.kanji32k

	ld	ix,7FC6h
	call	.kanji32k

	call	bdos_fclose
	or	a
	ret

.kanji32k:

	ld	hl,0

.lp_block:

	push	ix
	push	hl

	ld	a,(skwslot)
	ld	h,40h
	call	ENASLT

	pop	hl
	pop	ix

	ld	bc,SIZDTA
	ld	de,dta

.lp_byte:

	ld	(ix+0),l
	ld	(ix+1),h
.lp_wait:
	bit	0,(ix+0)
	bit	0,(ix+0)
	jr	z,.lp_wait

	ld	a,(ix+1)
	ld	(de),a
	inc	de
	inc	hl
	dec	bc

	ld	a,b
	or	c
	jr	nz,.lp_byte

	push	ix
	push	hl

	ld	a,(slotp1)
	ld	h,40h
	call	ENASLT

	call	bdos_wrblk1

	pop	hl
	pop	ix

	or	a
	jr	nz,.errorclose

	bit 7,h
	jr	z,.lp_block

	ret

.errorclose:
	pop	af

	call	bdos_fclose

	call	bdos_fdel

	or	0FFh
	ret


.fcb_kanji_font:
	db	0,'SKW-01KFROM'
	ds	25,0
