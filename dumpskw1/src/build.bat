@echo off
sjasmplus -DDOSPAGE3 --raw=dumpskw1_dos_page3.bin dumpskw1_bin.asm
zx0 -f dumpskw1_dos_page3.bin dumpskw1_dos_page3.zx0

sjasmplus --raw=..\DUMPSKW1.COM dumpskw1_dos.asm

sjasmplus --raw=..\DUMPSKW1.BIN dumpskw1_bin.asm

del dumpskw1_dos_page3.bin
del dumpskw1_dos_page3.zx0

