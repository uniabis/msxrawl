
puts:

;[INPUT]
; DE:address of string
;[work]
; A
;[require]
; msx_sys_bios_entry.inc

	ld	a,(de)
	cp	'$'
	ret	z
	call	CHPUT
	inc	de
	jr	puts
