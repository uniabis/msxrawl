# MSX boot keys

## MSX2/2+/turboR BIOS(EXTROM)

\[GRAPH\]+\[STOP\] skip password entry.(ignore settings in CMOS memory)

## MSX-DOS/DOS2 kernel

\[CTRL\] disable dual FDD emulation.

\[SHIFT\] disable all DOS/DISK BASIC function.

## MSX-DOS2 kernel 2.30/2.31

\[1\] force DOS1 mode, if that computer is turboR, switches system to Z80 mode.

\[CTRL\] disable dual FDD emulation.

\[SHIFT\] disable all DOS/DISK BASIC function.

## FS-A1GT DOS2 driver

\[ESC\] format SRAM disk.

## Nexter kernel

\[0\] Reset disk emulation mode.(delete pointer in partation table)

\[1\] force DOS1 mode, if that computer is turboR, switches system to Z80 mode.

\[2\] force DOS1 mode, if that computer is turboR, switches system to R800-ROM mode.

\[3\] force DISK BASIC.(ignore IPL on boot sector)

\[4\] if that computer is turboR, set largest mapper to primary ,and switches system R800-ROM mode, and free 4 segemnts for R800-DRAM mode.

\[5\] assign only one drive for each Nextor devices.

\[CTRL\] enable dual drive emulation.(inverted)

\[SHIFT\] disable legacy(DOS1/DOS2) drivers.

\[Q/W/E/R\] skip initalize Nextor kernel on SLOT1-0/1/2/3.

\[A/S/D/F\] skip initalize Nextor kernel on SLOT2-0/1/2/3.

\[Z/X/C/V\] skip initalize Nextor kernel on SLOT3-0/1/2/3.

## MFRSCC+SD

\[UP\] show recovery mode menu.

## Carnivore2

\[F5\] skip boot menu.

## SunriseIDE new Nextor driver(1.1.7)

\[STOP\] stop initailzation of device.

## [Sony HB-11](https://www.msx.org/wiki/Sony_HB-11)

\[S\] mute PSG on firmware.

\[P\] show credit screen.

## [Sony HB-F1](https://www.msx.org/wiki/Sony_HB-F1)

\[P\]+\[N\] show credit screen.

\[DEL\] skip booting of internal firmware.

## [Sony HB-F1II](https://www.msx.org/wiki/Sony_HB-F1II)

\[P\]+\[N\] show credit screen.

\[DEL\] skip booting of internal firmware.

[methods to skip internal firmware on other models](msxbootkeys_firmoff.md)

