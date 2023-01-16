
	include	"msx_sys_bios_entry.inc"
	include	"msx_sys_bios_work.inc"
	include	"msx_sys_dos_work.inc"
	include	"msx_sys_slot_entry.inc"

BDOS	equ	0F37Dh

SIZDTA	equ	800h
dta	equ	0C800h
fcb_ptr	equ	dta-2;0C7FEh
skwslot	equ	dta-3;0C7FDH
slotp1	equ	dta-4;0C7FCH

	IFNDEF DOSPAGE3

;olddta	equ	dta-6;0C7FAH

	org	0C400h-7

; BLOAD header

	db	0feh
	dw	binstart
	dw	binend-1
	dw	binentry

	ELSE

slotp0	equ	dta-5;0C7FBH
enasltx	equ	dta-8;0C7F8H

	org	0C400h

	jp	binentry

	ENDIF

binstart:

	include	"bdos_lib_file.inc"

	include	"msx_lib_enum_slot.inc"

	include	"msx_lib_skw01_get_slot.inc"

	include	"msx_lib_skw01_dump_kanji.inc"

	include	"msx_lib_skw01_dump_romp4.inc"

	include	"msx_lib_skw01_dump_sram.inc"

	IFNDEF DOSPAGE3

	include	"msx_lib_skw01_dump_rom_rdslt.inc"

	include	"msx_lib_bios_puts.inc"

	include	"msx_lib_get_slot_page1.inc"

binentry:

	;push	ix
	;ld	ix,0
	;add	ix,sp
	;ld	sp,slotp1

	;ld	hl,(DMAADD)
	;ld	(olddta),hl

	call	get_slot_page1
	ld	(slotp1),a

	ELSE

	include	"msx_lib_skw01_dump_rom_enaslt.inc"

	include	"bdos_lib_puts.inc"

binentry:

	ld	hl,(RAMAD0)
	ld	(slotp0),hl

	ld	hl,ENASLT
	ld	de,enasltx
	ld	bc,3
	ldir

	ENDIF

	ld	de,.msg_title
	call	.putsx

	call	skw01_get_slot
	jr	z,.not_found

.found:
	ld	(skwslot),a

	ld	de,.msg_rom
	call	.putsx

	call	skw01_dump_rom
	call	.result

	ld	de,.msg_kanji
	call	.putsx

	call	skw01_dump_kanji
	call	.result

	ld	de,.msg_romp4
	call	.putsx

	call	skw01_dump_romp4
	call	.result

	ld	de,.msg_sram
	call	.putsx

	call	skw01_dump_sram
	call	.result

	jr	.term0

.result:
	jr	nz,.failed
	ld	de,.msg_ok
	jp	puts

.failed:
	pop	de
	ld	de,.msg_bad
	jr	.termm

.not_found:
	ld	de,.msg_notfound
.termm:
	call	.putsx
.term0:
	IFNDEF DOSPAGE3

	;ld	hl,(olddta)
	;ld	(DMAADD),hl

	;ld	sp,ix
	;pop	ix

	ret

	ELSE

	jp	bdos_term0

	ENDIF

.putsx:
	push	de
	ld	de,.msg_skw01
	call	puts
	pop	de
	jp	puts

.msg_skw01:
	db	'SKW-01$'

.msg_title:
	db	' dumper v0.3',0Dh,0Ah,'$'

.msg_notfound:
	db	' not found.',0Dh,0Ah,'$'

.msg_ok:
	db	' dumped.',0Dh,0Ah,'$'

.msg_bad:
	db	' failed.',0Dh,0Ah,'$'

.msg_rom:
	db	'.ROM$'

.msg_kanji:
	db	'KF.ROM$'

.msg_romp4:
	db	'P4.ROM$'

.msg_sram:
	db	'.SRM$'

binend:
