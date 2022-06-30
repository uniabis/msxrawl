
# r800chk

## �g����

Z80��R800�̓���̈Ⴂ���m�F���܂��B

### r800chk.com

MSX-DOS/DOS2/Nextor��

CPU���[�h�ؑ֋@�\�͂���܂���B

### r800chk.rom

�g��BASIC��

```
CALL R800CHK
```
�e�X�g�����s���܂��B

```
CALL CHGCPU(areg)
```
turboR�ł����BIOS��CHGCPU���Ăяo���܂��B
areg��CHGCPU�ɓn��A���W�X�^�̒l�ł��B
128�Ȃ�Z80���[�h�B
129�Ȃ�R800ROM���[�h�B
130�Ȃ�R800DRAM���[�h�B

### r800chk_auto.rom

�����N��ROM��

turboR�Ȃ�R800DRAM���[�h�ɐ؂�ւ��܂��B

## �ڍ�

### �e�X�g1

����`����SLL�́A
Z80�ł͍ŉ��ʃr�b�g��1�ɂȂ�܂��B
R800�ł�SLA�Ɠ�������ƂȂ�ŉ��ʃr�b�g��0�ɂȂ�܂��B

```
	sll	a
	rra
```

### �e�X�g2

```
	ld	l,-1
	defb	0xDD
	inc	ix
	rr	l
```

DD/FD�v���t�B�b�N�X����������ꍇ�A
Z80�ł͍Ō�̃v���t�B�b�N�X���L���ƂȂ�܂��B
R800�ł�2��NOP�����ƂȂ�܂��B
Z80�ł�L���W�X�^��-1����ω����܂���B
R800�ł�inc ix��inc hl�ƂȂ�L���W�X�^��0�ƂȂ�܂��B

### �e�X�g3

```
	xor	a,a
	dec	a
	ld	b, a
	mulub	a,b
	ccf
```

R800�Œǉ����ꂽ8bit�|���Z���߂͌��ʂ�8bit�Ɏ��܂�Ȃ��ꍇ��CF���Z�b�g����܂��B
Z80�ł�NOP�����̂���CF�͕ω����܂���B

### �e�X�g4

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

R800�ł͖��g�p�t���O��pop af�݂̂ŕω����܂��B
Z80�ł�xor���߂ɂ��Ă�Z80 undocumented documented�ɋL�ڂ���Ă���悤�ɕω����܂��B
