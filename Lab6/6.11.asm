#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

mov al, 32h
mov bl, 37h
add al,bl ; al 69h
aaa; AH = 06, AL = 09h
