#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

;a solution
cmc
stc 
clc
;b complement zero flag
mov al, 10
cmp al, 10
mov al, 20
cmp al, 10
