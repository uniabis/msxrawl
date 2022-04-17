
# MSX-MUSIC uninstaller

## 概要

```CALL MUSIC```で確保されたメモリを開放します。

MSX-DOS/DOS2/Nextorで動作します。

```CALL MUSIC```後に```CALL KANJI```などでメモリを追加で確保されたり、タイマー割り込みなどがフックされた場合は解放できません。

```CALL MUSIC```はHIMEM(FC4Ah)からメモリを確保するため、```CLEAR```などでHIMEM(FC4Ah)を移動した後に```CALL MUSIC```を実行した場合、```CLEAR```で指定したアドレスからメモリが確保されるため、MSX-MUSICのメモリを開放しても```CLEAR```で指定したアドレス以降は解放されず空きメモリが減少します。

```CALL MUSIC:CALL SYSTEM```でDOSに移動後に本プログラムでMSX-MUSICを解放せずに、再度BASICを起動すると、DISK BASICのワークが二重に確保され空きメモリが減少します。


## 詳細

DISK BASIC起動時のメモリマップは次の表の状態です。

|DISK BASIC<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>(DOSHIM)=(HIMSAV)|
|DISKBASIC WORK<br>(HIMEM)|
|BASIC FREE AREA<br>**8000h**|
|BASIC/DOS KERNEL ROM<br>**4000h**|
|BIOS/BASIC ROM<br>**0000h**|

(HIMEM)はベーシックのフリーエリアの境界を指します。
```CLEAR```の第2パラメーターで任意の値を指定できます。
ワークを破壊するような値も指定可能な場合があるため注意が必要です。

```CALL SYSTEM```でDOSを起動すると(HIMSAV)の値を(DOSHIM)に格納し、(DOSHIM)からMSXDOS.SYS(MSXDOS2.SYS/NEXTOR.SYS)を常駐します。
(HIMEM)は無視されます。

|MSX-DOS<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>(DOSHIM)=(HIMSAV)|
|MSXDOS.SYS<br>(BDOS+1)|
|TPA<br>**0100h**|
|SYSTEM SCRATCH AREA<br>**0000h**|

```BASIC```コマンドでベーシックを起動すると(HIMSAV)からディスクベーシックのワークサイズを引き(HIMEM)に格納します。
通常はDISK BASIC起動時のメモリマップと同じ状態になります。

ベーシックで```CALL MUSIC```を実行すると(HIMEM)からMSX-MUSICのワークサイズを引いた値を(HIMEM)に格納し、MSX-MUSICワークメモリを確保します。さらに(HIMSAV)にも同じ値をセットします。

|DISK BASIC<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>(DOSHIM)|
|DISKBASIC WORK<br>|
|MSX-MUSIC WORK<br>(HIMEM)=(HIMSAV)|
|BASIC FREE AREA<br>**8000h**|
|BASIC/DOS KERNEL ROM<br>**4000h**|
|BIOS/BASIC ROM<br>**0000h**|

事前に```CLEAR```で(HIMEM)を移動していた場合、その位置からMSX-MUSICワークメモリが確保されてしまうため注意が必要です。

この状態で```CALL SYSTEM```でDOSを起動すると(HIMSAV)の値を(DOSHIM)に格納し、(DOSHIM)からMSXDOS.SYS(MSXDOS2.SYS/NEXTOR.SYS)を常駐するため、ディスクベーシックのワークとMSX-MUSICワークの分、TPAが減少します。

|MSX-DOS<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>|
|*UNUSED(OLD DISKBASIC WORK)*<br>|
|*MSX-MUSIC WORK*<br>(DOSHIM)=(HIMEM)=(HIMSAV)|
|MSXDOS.SYS<br>(BDOS+1)|
|TPA<br>**0100h**|
|SYSTEM SCRATCH AREA<br>**0000h**|

この状態で```BASIC```コマンドでベーシックを起動すると(HIMSAV)からディスクベーシックのワークを再度確保するため、さらにメモリの空きが減少します。

|DISK BASIC<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>|
|*UNUSED(OLD DISKBASIC WORK)*<br>|
|*MSX-MUSIC WORK*<br>(DOSHIM)=(HIMSAV)|
|DISKBASIC WORK<br>(HIMEM)|
|BASIC FREE AREA<br>**8000h**|
|BASIC/DOS KERNEL ROM<br>**4000h**|
|BIOS/BASIC ROM<br>**0000h**|

本プログラムでは(HIMSAV)をディスクベーシックのワークとMSX-MUSICワークのサイズだけ移動させてメモリを解放します。
DOSは(HIMEM)を関知しないのですがkduなどが(HIMEM)を参照するため、移動後の(HIMSAV)の値を(HIMEM)にもセットします。

安全のため解放時には各ワークのアドレスと(HIMSAV)の値が一致していることを確認するため、他の機能によりメモリが確保され(HIMSAV)の値が変更された場合は解放できません。
ディスクベーシックワークが二重に確保された場合も、古い方のディスクベーシックワークのアドレスが失われるているため、古い方のディスクベーシックワークは解放されません。

(HIMSAV)を移動させても、MSXDOS.SYS等を再ロードしない限り、直ちにTPAが拡がるわけではありません。

|MSX-DOS<br>MemoryMap|
|---|
|SECONDARY SLOT SELECTOR<br>**FFFFh**|
|BIOS WORK<br>**F380h**|
|DOS WORK<br>(HIMEM)=(HIMSAV)|
|**UNUSED(OLD DISKBASIC WORK)**<br>|
|**UNUSED(OLD MSX-MUSIC WORK)**<br>(DOSHIM)|
|MSXDOS.SYS<br>(BDOS+1)|
|TPA<br>**0100h**|
|SYSTEM SCRATCH AREA<br>**0000h**|

解放後にBASICに移動して再度DOSに移動するといった対応が必要です。
このままでは使い勝手が非常に悪いため、[Nextor patcher for HB-11(HiTBiT-U)](https://github.com/uniabis/nextor_patch_for_hb11)に同等の機能を組み込みました。
