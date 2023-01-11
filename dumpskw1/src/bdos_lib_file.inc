
bdos_term0:
	ld	c,00h
	jp	BDOS

bdos_fclose:
	ld	c,10h
	jr	bdos_fcb

bdos_fdel:
	ld	c,13h
	jr	bdos_fcb

bdos_fmake:
	ld	c,16h
	ld	(fcb_ptr),de
	jp	BDOS

bdos_setdta:
	ld	c,1ah
	jp	BDOS

bdos_wrblk1:
	ld	hl,1
bdos_wrblk:
	ld	c,26h
bdos_fcb:
	ld	de,(fcb_ptr)
	jp	BDOS

