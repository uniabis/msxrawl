
enum_slot:

;[input]
; ix checker callback ([input]A:target slot [output]NZ:found(break),Z not found(continue))
;[output]
; A:slot
; NZ:found,Z:not found
;[work]
; hl
;[require]
; msx_sys_bios_work.inc

	ld	hl,EXPTBL ; 0FCC1h

.master_slot_loop:
	ld	a,(hl)
	and	80h
	add	l
	sub	low EXPTBL ; 0C1h

.extened_slot_loop:

	call	CLPRM1
	ret	nz

	bit	7,a
	jr	nz,.not_extended
	add	4
	bit	4,a
	jr	z,.extened_slot_loop

.not_extended:
	inc	l
	ld	a,l
	cp	low EXPTBL+4 ; 0C5h
	jr	nz,.master_slot_loop
	xor	a
	ret
