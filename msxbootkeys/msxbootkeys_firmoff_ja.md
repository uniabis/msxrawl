
# 内蔵ソフトの自動起動を無効にする方法

MSXの一部機種は電源を入れると内蔵ソフトが自動起動されます。
内蔵ソフトは各機種の特徴が表れており魅力でもあります。
しかしながら、DOSなどの起動を妨げたり、DOS2や[Nextor](https://github.com/Konamiman/Nextor)がDOS1モードに強制されるといった不都合が存在する場合があります。

HB-11で[Nextor](https://github.com/Konamiman/Nextor)の[起動を試みた時](https://github.com/uniabis/nextor_patch_for_hb11)に確認した情報をもとに内蔵ソフトの自動起動を無効にする方法をまとめました。

無効化キー情報は [MSX Wiki](https://www.msx.org/wiki/) の各機種の項目から得られたものです。
概ね正しいものと思われますが同一モデル名の機種でもバージョン違いなどにより動作が異なる可能性があります。
無効化してもH.STKEのフックが無効にならない機種ではDOS1モードの強制は回避できません。

## なし

- [Hitachi MB-H1](https://www.msx.org/wiki/Hitachi_MB-H1)
- [Hitachi MB-H2](https://www.msx.org/wiki/Hitachi_MB-H2)
- [Hitachi MB-H21](https://www.msx.org/wiki/Hitachi_MB-H21)
- [Mitubishi ML-F120](https://www.msx.org/wiki/Mitsubishi_ML-F120)
- [National FS-4000](https://www.msx.org/wiki/National_FS-4000)
- [Sony HB-11](https://www.msx.org/wiki/Sony_HB-11)

HB-11は所有機の解析により標準では無効化する手段が存在しない事を確認済みです。

## 不明

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

## スイッチ

- [National FS-4500](https://www.msx.org/wiki/National_FS-4500)
- [National FS-4600F](https://www.msx.org/wiki/National_FS-4600F)
- [National FS-4700](https://www.msx.org/wiki/National_FS-4700)
- [Panasonic FS-A1FX](https://www.msx.org/wiki/Panasonic_FS-A1FX)
- [Panasonic FS-A1WX](https://www.msx.org/wiki/Panasonic_FS-A1WX)
- [Panasonic FS-A1WSX](https://www.msx.org/wiki/Panasonic_FS-A1WSX)
- [Panasonic FS-A1ST](https://www.msx.org/wiki/Panasonic_FS-A1ST)
- [Panasonic FS-A1GT](https://www.msx.org/wiki/Panasonic_FS-A1GT)
- [Sanyo PHC-77](https://www.msx.org/wiki/Sanyo_PHC-77)

未確認ですが[PHC-77の回路図](http://elec-junker-p2.blog.jp/archives/2185676.html)によるとスイッチの信号はROMのCSに接続されているため内蔵ソフトを無効にするとMSX-JEも同時に無効となると思われます。

一部機種しか確認していませんがNational/Panasonicの各機種はMSX-JEを考慮してI/Oポートからスイッチ状態を取得しファームウェアでバンク切替しているため、MSX-JEが有効のまま内蔵ソフトの自動起動が無効となります。

## メモリーの値

ほとんどの機種ではH.STKE(0FEDAh)が0C9h以外の場合、外部カートリッジが存在しているものと判定し内蔵ソフトの自動起動を無効化するはずです。
しかし、この場合互換性のために、NextorのDOS2モード起動は無効化されてしまいます。

Panasonicの一部の機種ではファームウェアからBASICを選択した時にソフトリセットを行いますが、ファームウェアに再度入らないようにメモリの内容で制御しているようです。

- [Panasonic FS-A1](https://www.msx.org/wiki/Panasonic_FS-A1)

\(0CBD8h\) の値が 23h

- [Panasonic FS-A1mk2](https://www.msx.org/wiki/Panasonic_FS-A1mkII)

\(0C3D2h\) の値が 23h

- [Panasonic FS-A1F](https://www.msx.org/wiki/Panasonic_FS-A1F)

\(0C3CEh\) の値が 23h

- [Panasonic FS-A1WX](https://www.msx.org/wiki/Panasonic_FS-A1WX)
- [Panasonic FS-A1ST](https://www.msx.org/wiki/Panasonic_FS-A1ST)

0C010h から JWrite もしくは MSX

PanasonicのMSX2+以降では共通と推測されますが、 JWrite は VJE80/VJE80A の事と思われるため FS-A1FX は仕組みが異なる可能性があります。FS-A1GTはNextorのソースDOS2の起動ドライブをVSHELLのROMディスクにするという別の仕組みのようです。

[Carnivore2](https://github.com/RBSC/Carnivore2) 2.50以降など [Nextor](https://github.com/Konamiman/Nextor) の [Sunrise](http://www.msx.ch/sunformsx/)IDE ドライバーのバージョン 0.1.7 では 起動時に0C010近辺をワークエリアとして利用するためこの仕組みは機能しません。

## その他

[1chipMSX](http://www.msx.d4e.co.jp/1chipmsx.html)の[DOS2カーネルのバグ](https://uniabis.net/pico/msx/ocmfield/)を調べているときに、WX/WSXで「実行」キーが押されていない場合に内蔵ソフトの自動起動を無効化する機能が存在する事を確認しました。この機能は[MEGA-SCSI](http://www.hat.hi-ho.ne.jp/tujikawa/ese/megascsi.html)由来のものと推測されます。

