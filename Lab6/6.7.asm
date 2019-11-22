#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

#make_COM#

reset_reg MACRO
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
ENDM
; COM file is loaded at CS:0100h
ORG 100h

reset_reg
mov dl, 85h
test dl, 80h ; test MSB = SIGN BIT
pushf ; store FLAGS REGISTER
jnz negative_number ; if positive number continue
mov al, dl
jmp store_dec_digits

negative_number:
	dec dl ; C2 -1 = C1
	mov al, dl
	not al ;

store_dec_digits:
	mov cl, 100
	div cl
	mov bh, al
	mov al, ah
	mov ah, 0
	mov cl, 10
	div cl
	mov bl, al
	shl bl, 4
	add bl, ah
	popf ; restore flags register
	hlt
