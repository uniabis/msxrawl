
# r800chk

## 使い方

Z80とR800の動作の違いを確認します。

### r800chk.com

MSX-DOS/DOS2/Nextor版

CPUモード切替機能はありません。

### r800chk.rom

拡張BASIC版

```
CALL R800CHK
```
テストを実行します。

```
CALL CHGCPU(areg)
```
turboRであればBIOSのCHGCPUを呼び出します。
aregはCHGCPUに渡すAレジスタの値です。
128ならZ80モード。
129ならR800ROMモード。
130ならR800DRAMモード。

### r800chk_auto.rom

自動起動ROM版

turboRならR800DRAMモードに切り替わります。

## 詳細

### テスト1

未定義命令SLLは、
Z80では最下位ビットは1になります。
R800ではSLAと同じ動作となり最下位ビットは0になります。

```
	sll	a
	rra
```

### テスト2

```
	ld	l,-1
	defb	0DDh
	inc	ix
	rr	l
```

DD/FDプリフィックスが複数ある場合、
Z80では最後のプリフィックスが有効となります。
R800では2つでNOP扱いとなります。
Z80ではLレジスタは-1から変化しません。
R800ではinc ixがinc hlとなりLレジスタは0となります。

### テスト3

```
	xor	a
	dec	a
	ld	b, a
	mulub	a,b
	ccf
```

R800で追加された8bit掛け算命令は結果が8bitに収まらない場合にCFがセットされます。
Z80ではNOP扱いのためCFは変化しません。

### テスト4

```
	ld	c,-1
	push	bc
	pop	af
	xor	a
	push	af
	pop	bc
	ld	a,c
	rla
	rla
	rla
	ccf
```

R800では未使用フラグはpop afのみで変化します。
Z80ではxor命令については[The Undocumented Z80 Documented](http://www.myquest.nl/z80undocumented/)に記載されているように変化します。
R800ではフラグレジスタに-1をセットした以後、未使用フラグは変化しません。
Z80ではxor aで未使用フラグがクリアされます。
未使用フラグの挙動は[Sinclair Wiki](https://sinclair.wiki.zxnet.co.uk/wiki/Z80)などでさらに詳しく説明されています。

## 結果

FS-A1ST実機ではZ80とR800の双方が想定通りに動作しました。

[WebMSXのMSX2で実行](https://webmsx.org/?CARTRIDGE1_URL=https://github.com/uniabis/msxrawl/raw/main/r800chk/r800chk_auto.rom&MACHINE=MSX2J)

[WebMSXのturboRで実行](https://webmsx.org/?CARTRIDGE1_URL=https://github.com/uniabis/msxrawl/raw/main/r800chk/r800chk_auto.rom&MACHINE=MSXTRJ)

WebMSXのZ80は想定通りに動作しました。
WebMSXのR800はDD/FDプリフィックスと未使用フラグがZ80の場合と同じように動作するようです。

openMSXのZ80は想定通りに動作しました。
openMSXのR800はDD/FDプリフィックスがZ80の場合と同じように動作するようです。

