
get_slot_page1:

;[output]
; a:slot of page1
;[require]
; msx_sys_bios_work.inc

	push	bc
	push	hl

	in	a,(0A8h)
	and	0Ch
	rrca
	rrca
	ld	c,a

	ld	hl,EXPTBL
	add	l
	ld	l,a

	bit 7,(hl)
	jr	nz,.not_extended

	ld	a,l
	add SLTTBL-EXPTBL

	ld	a,(hl)
	and	0Ch
	or	c
	or	80h

.not_extended:
	pop	hl
	pop	bc
	ret
