� � 	� s��o�L��͝�L�����LD��7�L��͹�L�X�d�result:NC
$result:C
$�7�[TEST1]:CB371F
sll a:rra
Z80:C R800:NC $.���#��[TEST2]:2EFFDDDD23CB1D
ld l,-1:db 0DDh:inc ix:rr l
Z80:C R800:NC $�=G��?�[TEST3]:AF3D47EDC13F
xor a:dec a:ld b,a:mulub a,b:ccf
Z80:C R800:NC $�����y?�[TEST4]:0EFFC5F1AFF5C1791717173F
ld c,-1:push bc:pop af:xor a:push af:pop bc:ld a,c:rla:rla:rla:ccf
Z80:C R800:NC $�>�O �_?��[TEST5]:3E7FED4F00ED5F173F
ld a,07fh:ld r,a:nop:ld a,r:rla:ccf
Z80:C R800:NC $