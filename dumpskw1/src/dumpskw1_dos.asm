
	org	100h

CODEBASE_PAGE3	equ	0C400h

	ld	de,CODEBASE_PAGE3
	ld	hl,codezx0

	push	de

	include	"dzx0_standard.asm"

codezx0:
	incbin	"dumpskw1_dos_page3.zx0"

