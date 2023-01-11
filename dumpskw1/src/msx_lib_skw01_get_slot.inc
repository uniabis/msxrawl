
skw01_get_slot:

;[output]
; A:slot
; NZ:found,Z:not found
;[work]
; hl,ix
;[require]
; msx_sys_slot_entry.inc
; msx_lib_enum_slot.inc

	ld	ix,.callback
	jp	enum_slot

.callback:
	push	bc
	push	de
	push	hl

	ld	c,a
	ld	b,.magic_end-.magic
	ld	hl,.magic
	ld	de,4010h

.lp:
	ex	de, hl
	push	bc
	push	de

	ld	a, c
	call	RDSLT

	pop	de
	pop	bc
	ex	de, hl

	inc	de

	cp	(hl)
	inc	hl
	jr	nz,.notfound

	djnz	.lp

.found:
	;or	1
	;jr	.exit
	db	0F6h ; OR 0AFh to reset ZF (0F6h opcode OR n,0AFh opcode XOR A)

.notfound:
	xor	a
.exit:
	ld	a, c
	pop	hl
	pop	de
	pop	bc
	ret

.magic:
	db	'YAMAHA-MSX-JWP-SYSTEM'
.magic_end:
