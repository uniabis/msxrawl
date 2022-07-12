
# How to disable auto-starting of built-in software on MSX

Some MSX models automatically start the built-in software when the power is turned on.
The built-in software is an attractive feature of each model, as it shows the characteristics of each model.
However, there may be some inconveniences such as DOS2 or [Nextor](https://github.com/Konamiman/Nextor) being forced to DOS1 mode.

The following is a summary of how to disable automatic startup of built-in software based on the information found in [hb-11 project](https://github.com/uniabis/nextor_patch_for_hb11) of [Nextor](https://github.com/Konamiman/Nextor) on the HB-11. The following is a summary of how to disable the automatic startup of the built-in software.

The disable key information was obtained from [MSX Wiki](https://www.msx.org/wiki/) for each model.
It is believed to be generally correct, but there is a possibility that different versions of the same model may work differently.
For models that do not disable the H.STKE hook even if it is disabled, DOS1 mode enforcement cannot be avoided.

## None

- [Hitachi MB-H1](https://www.msx.org/wiki/Hitachi_MB-H1)
- [Hitachi MB-H2](https://www.msx.org/wiki/Hitachi_MB-H2)
- [Hitachi MB-H21](https://www.msx.org/wiki/Hitachi_MB-H21)
- [Mitubishi ML-F120](https://www.msx.org/wiki/Mitsubishi_ML-F120)
- [National FS-4000](https://www.msx.org/wiki/National_FS-4000)
- [Sony HB-11](https://www.msx.org/wiki/Sony_HB-11)

Analysis of the HB-11 has confirmed that there is no way to disable it in the standard.

## unknown

- [Gradiente Expert Plus](https://www.msx.org/wiki/Gradiente_Expert_Plus)
- [Mitsubishi ML-TS2](https://www.msx.org/wiki/Mitsubishi_ML-TS2)
- [Talent TPC-310](https://www.msx.org/wiki/Talent_TPC-310)
- [Toshiba HX-20](https://www.msx.org/wiki/Toshiba_HX-20)
- [Toshiba HX-21](https://www.msx.org/wiki/Toshiba_HX-21)
- [Toshiba HX-22](https://www.msx.org/wiki/Toshiba_HX-22)
- [Toshiba HX-23](https://www.msx.org/wiki/Toshiba_HX-23)
- [Toshiba HX-23F](https://www.msx.org/wiki/Toshiba_HX-23F)
- [Toshiba HX-31](https://www.msx.org/wiki/Toshiba_HX-31)
- [Toshiba HX-32](https://www.msx.org/wiki/Toshiba_HX-32)
- [Toshiba HX-33](https://www.msx.org/wiki/Toshiba_HX-33)
- [Toshiba HX-34](https://www.msx.org/wiki/Toshiba_HX-34)
- [Victor HC-7](https://www.msx.org/wiki/Victor_HC-7)

## \[DEL\]

- [Kawai KMC-5000](https://www.msx.org/wiki/Kawai_KMC-5000)
- [Mitubishi ML-G10](https://www.msx.org/wiki/Mitsubishi_ML-G10)
- [Mitubishi ML-G1](https://www.msx.org/wiki/Mitsubishi_ML-G1)
- [Panasonic FS-A1](https://www.msx.org/wiki/Panasonic_FS-A1)
- [Panasonic FS-A1mk2](https://www.msx.org/wiki/Panasonic_FS-A1mkII)
- [Panasonic FS-A1F](https://www.msx.org/wiki/Panasonic_FS-A1F)
- [Panasonic FS-A1FM](https://www.msx.org/wiki/Panasonic_FS-A1FM)
- [Panasonic FS-A1FX](https://www.msx.org/wiki/Panasonic_FS-A1FX)
- [Panasonic FS-A1WX](https://www.msx.org/wiki/Panasonic_FS-A1WX)
- [Sony HB-F1](https://www.msx.org/wiki/Sony_HB-F1)
- [Sony HB-F1II](https://www.msx.org/wiki/Sony_HB-F1II)
- [Sony HB-F5](https://www.msx.org/wiki/Sony_HB-F5)
- [Toshiba FS-TM1](https://www.msx.org/wiki/Toshiba_FS-TM1)
- [Victor HC-80](https://www.msx.org/wiki/Victor_HC-80)

## \[ESC\]

- [Philips NMS-8220](https://www.msx.org/wiki/Philips_NMS_8220)

## \[GRAPH\]

- [Sony HB-F9P](https://www.msx.org/wiki/Sony_HB-F9P)
- [Sony HB-F9S](https://www.msx.org/wiki/Sony_HB-F9S)

## \[CTRL\]+\[STOP\]

- [Hitachi MB-H3](https://www.msx.org/wiki/Hitachi_MB-H3)
- [National CF-3300](https://www.msx.org/wiki/National_CF-3300)

## \[CTRL\]+\[SHIFT\]+\[かな\(KANA/CODE\)\]+\[GRAPH\]

- [Sony HB-101](https://www.msx.org/wiki/Sony_HB-101)
- [Sony HB-101P](https://www.msx.org/wiki/Sony_HB-101P)
- [Sony HB-201](https://www.msx.org/wiki/Sony_HB-201)
- [Sony HB-201P](https://www.msx.org/wiki/Sony_HB-201P)

## Switches

- [National FS-4500](https://www.msx.org/wiki/National_FS-4500)
- [National FS-4600F](https://www.msx.org/wiki/National_FS-4600F)
- [National FS-4700](https://www.msx.org/wiki/National_FS-4700)
- [Panasonic FS-A1FX](https://www.msx.org/wiki/Panasonic_FS-A1FX)
- [Panasonic FS-A1WX](https://www.msx.org/wiki/Panasonic_FS-A1WX)
- [Panasonic FS-A1WSX](https://www.msx.org/wiki/Panasonic_FS-A1WSX)
- [Panasonic FS-A1ST](https://www.msx.org/wiki/Panasonic_FS-A1ST)
- [Panasonic FS-A1GT](https://www.msx.org/wiki/Panasonic_FS-A1GT)
- [Sanyo PHC-77](https://www.msx.org/wiki/Sanyo_PHC-77)

According to [PHC-77 circuit diagram](http://elec-junker-p2.blog.jp/archives/2185676.html), 
the switch signal is connected to the CS of the ROM,
so if you disable the built-in software, the MSX-JE will be disabled at the same time. 

Although we have confirmed only some models, but National/Panasonic models are switching banks by firmware by getting the switch status from I/O port considering MSX-JE,
so MSX-JE is enabled while automatic startup of built-in software is disabled.

## Memory value

In most models, if H.STKE(0FEDAh) is other than 0C9h, it is assumed that an external cartridge is present and auto-start of the built-in software should be disabled.
However, in this case, for compatibility reasons, Nextor's DOS2 mode startup will be disabled.

Some Panasonic models perform a soft reset when BASIC is selected from the firmware, but it seems to be controlled by the memory contents to prevent re-entry into the firmware.

- [Panasonic FS-A1](https://www.msx.org/wiki/Panasonic_FS-A1)

The value of \(0CBD8h\) is 23h

- [Panasonic FS-A1mk2](https://www.msx.org/wiki/Panasonic_FS-A1mkII)

The value of \(0C3D2h\) is 23h.

- [Panasonic FS-A1F](https://www.msx.org/wiki/Panasonic_FS-A1F)

The value of \(0C3CEh\) is 23h.

- [Panasonic FS-A1WX](https://www.msx.org/wiki/Panasonic_FS-A1WX)
- [Panasonic FS-A1ST](https://www.msx.org/wiki/Panasonic_FS-A1ST)

Values of (0C010h)- are 'JWrite' or 'MSX'

FS-A1FX may have different mechanism because JWrite seems to be VJE80/VJE80A. 
FS-A1GT seems to have a different mechanism in Nextor source to use DOS2 boot drive as a VSHELL ROM disk.


With [Carnivore2](https://github.com/RBSC/Carnivore2) 2.50 or later, etc.
this mechanism does not work with [Nextor](https://github.com/Konamiman/Nextor) [Sunrise](http://www.msx.ch/sunformsx/) IDE driver version 0.1.7,
because it uses the area around (0C010h) as work memory at startup.

## Others

While investigating [DOS2 kernel bug](https://uniabis.net/pico/msx/ocmfield/) in [1chipMSX](http://www.msx.d4e.co.jp/1chipmsx.html),
I confirmed that there is a function to disable automatic startup of built-in software when the "実行(Execute)" key is not pressed in WX/WSX.
This function is assumed to be derived from [MEGA-SCSI](http://www.hat.hi-ho.ne.jp/tujikawa/ese/megascsi.html).

