� � 	� k��g�@��͕�@�����@C��6�@�L�Z�result:NC

$result:C

$�7�TEST1:CB 37 1F
sll a:rra
Z80:C R800:NC $.���#��TEST2:2E FF DD DD 23 CB 1D
ld l,-1:db 0DDh:inc ix:rr l
Z80:C R800:NC $�=G��?�TEST3:AF 3D 47 ED C1 3F
xor a:dec a:ld b,a:mulub a,b:ccf
Z80:C R800:NC $�����y?�TEST4:0E FF C5 F1 AF F5 C1 79 17 17 17 3F
ld c,-1:push bc:pop af:xor a:push af:pop bc:ld a,c:rla:rla:rla:ccf
Z80:C R800:NC $