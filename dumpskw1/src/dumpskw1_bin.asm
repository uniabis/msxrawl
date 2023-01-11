
	include	"msx_sys_bios_entry.inc"
	include	"msx_sys_bios_work.inc"
	include	"msx_sys_dos_work.inc"
	include	"msx_sys_slot_entry.inc"

BDOS	equ	0F37Dh

slotp1	equ	0C7FCH
skwslot	equ	0C7FDH
fcb_ptr	equ	0C7FEh
dta	equ	0C800h

SIZDTA	equ	800h

	org	0C0F9h

	db	0feh
	dw	binstart
	dw	binend-1
	dw	binentry

binstart:

	include	"msx_lib_enum_slot.inc"

	include	"msx_lib_skw01_get_slot.inc"

	include	"bdos_lib_file.inc"

	include	"msx_lib_bios_puts.inc"

	include	"msx_lib_skw01_dump_rom_rdslt.inc"

	include	"msx_lib_skw01_dump_kanji.inc"

	include	"msx_lib_skw01_dump_romp4.inc"

	include	"msx_lib_skw01_dump_sram.inc"

	include	"msx_lib_get_slot_page1.inc"

binentry:

	ld	de,.msg_title
	call	puts

	call	skw01_get_slot
	jr	nz,.found

	ld	de,.msg_error
.termm:
	call	puts
.term0:
	ret

.failed_rom:
	ld	de,.msg_badrom
	jr	.termm

.failed_kanji:
	ld	de,.msg_badkanji
	jr	.termm

.failed_romp4:
	ld	de,.msg_badromp4
	jr	.termm

.failed_sram:
	ld	de,.msg_badsram
	jr	.termm

.found:
	ld	(skwslot),a

	call	get_slot_page1
	ld	(slotp1),a

	call	skw01_dump_rom
	jr	nz,.failed_rom

	ld	de,.msg_okrom
	call	puts

	call	skw01_dump_kanji
	jr	nz,.failed_kanji

	ld	de,.msg_okkanji
	call	puts

	call	skw01_dump_romp4
	jr	nz,.failed_romp4

	ld	de,.msg_okromp4
	call	puts

	call	skw01_dump_sram
	jr	nz,.failed_sram

	ld	de,.msg_oksram
	call	puts

	jr	.term0

.msg_title:
	db	'SKW-01 dumper v0.2',0Dh,0Ah,'$'

.msg_error:
	db	'SKW-01 not found.',0Dh,0Ah,'$'

.msg_okrom:
	db	'SKW-01.ROM dumped.',0Dh,0Ah,'$'

.msg_badrom:
	db	'SKW-01.ROM failed.',0Dh,0Ah,'$'

.msg_okkanji:
	db	'SKW-01KF.ROM dumped.',0Dh,0Ah,'$'

.msg_badkanji:
	db	'SKW-01KF.ROM failed.',0Dh,0Ah,'$'

.msg_okromp4:
	db	'SKW-01P4.ROM dumped.',0Dh,0Ah,'$'

.msg_badromp4:
	db	'SKW-01P4.ROM failed.',0Dh,0Ah,'$'

.msg_oksram:
	db	'SKW-01.SRM dumped.',0Dh,0Ah,'$'

.msg_badsram:
	db	'SKW-01.SRM failed.',0Dh,0Ah,'$'

binend:
