# SKW-01 dumper

## How to use

### MSX DISK BASIC BLOAD version

```
BLOAD"DUMPSKW1.BIN",R
```

### MSX-DOS1/2/Nextor version

```
DUMPSKW1.COM
```

### Outputs

|FILENAME|LENGTH|DESCRIPTION|
|---|---|---|
|SKW-01.ROM|32KB|PLAIN ROM(0000-7FFFH)|
|SKW-01KF.ROM|128KB|PORT0,1,2,3(0000-7FFFH) KANJI FONT IMAGE|
|SKW-01P4.ROM|32KB|PORT4(0000-7FFFH) ROM IMAGE|
|SKW-01.SRM|2KB|PORT4(8000-87FFH) SRAM IMAGE|

## SKW-01 hardware

### SKW-01 MEMORY MAPPED I/O

|ADDRESS|R/W|NAME|DESCRIPTION|
|---|---|---|---|
|7FC0|W|PORT0 ADDRESS L|set low 8bits of address and become not ready|
|7FC0|R|PORT0 STATUS|bit0=1:ready to read,0:not ready|
|7FC1|W|PORT0 ADDRESS H|set high 8bits of address|
|7FC1|R|PORT0 DATA|data value|
|7FC2|W|PORT1 ADDRESS L|set low 8bits of address and become not ready|
|7FC2|R|PORT1 STATUS|bit0=1:ready to read,0:not ready|
|7FC3|W|PORT1 ADDRESS H|set high 8bits of address|
|7FC3|R|PORT1 DATA|data value|
|7FC4|W|PORT2 ADDRESS L|set low 8bits of address and become not ready|
|7FC4|R|PORT2 STATUS|bit0=1:ready to read,0:not ready|
|7FC5|W|PORT2 ADDRESS H|set high 8bits of address|
|7FC5|R|PORT2 DATA|data value|
|7FC6|W|PORT3 ADDRESS L|set low 8bits of address and become not ready|
|7FC6|R|PORT3 STATUS|bit0=1:ready to read,0:not ready|
|7FC7|W|PORT3 ADDRESS H|set high 8bits of address|
|7FC7|R|PORT3 DATA|data value|
|7FC8|W|PORT4 ADDRESS L|set low 8bits of address|
|7FC9|W|PORT4 ADDRESS H|set high 8bits of address|
|7FCA|R/W|PORT4 DATA|data value|
|7FCB|R/W?|PORT4 DATA|mirror value|
|7FCC|W|LPT CONTROL|write 00h,FFh to output one data byte|
|7FCC|R|LPT STATUS|bit1=0:ready to write,1:not ready|
|7FCE|W|LPT DATA|data value|


### SKW-01 PORT ASSIGN

|NAME|R/W|DESCRIPTION|
|---|---|---|
|PORT0|R|0000-7FFF:jis1 kanji(1/4),8000-FFFF mirror|
|PORT1|R|0000-7FFF:jis1 kanji(2/4),8000-FFFF mirror|
|PORT2|R|0000-7FFF:jis1 kanji(3/4),8000-FFFF mirror|
|PORT3|R|0000-7FFF:jis1 kanji(4/4),8000-FFFF mirror|
|PORT4|R/W|0000-7FFF:ROM,8000-87FF:SRAM,8800-FFFF:SRAM mirror|
