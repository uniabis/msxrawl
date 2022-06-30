
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
	defb	0xDD
	inc	ix
	rr	l
```

DD/FDプレフィックスが複数ある場合、
Z80では最後のプレフィックスが有効となります。
R800では2つでNOP扱いとなります。
Z80ではLレジスタは-1から変化しません。
R800ではinc ixがinc hlとなりLレジスタは0となります。

### テスト3

```
	xor	a,a
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
	xor	a,a
	push	af
	pop	bc
	ld	a,c
	rla
	rla
	rla
	ccf
```

R800では未使用フラグはpop afのみで変化します。
Z80ではxor命令についてはZ80 undocumented documentedに記載されているように変化します。
