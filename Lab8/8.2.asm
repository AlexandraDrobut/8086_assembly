
.code
jmp main
sum macro SI_OFF, DI_OFF, CX_VAL
	mov si, SI_OFF
	mov DI, DI_OFF
	mov cx, CX_VAL
	cld
	xor ax, ax
	xor dx, dx
next_byte:
	lodsb
	mul ES : BYTE PTR [DI]
	add dx, ax
	inc DI
	loop next_byte
	mov ax, dx
endm

main:
	sum 0100h, 0200h , 0Ah
	hlt
	
.data
	org 100h
	ARR_1 DB 10 DUP('A')
	org 200h
	ARR_2 DB 10 DUP('B')
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Solution to b using macro
DATA SEGMENT PARA PUBLIC 'DATA'
	org 100h
	ARR_1 DB 10 DUP('A')
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
jmp main
create macro SI_VAL, DI_VAL, CX_VAL
	mov SI, SI_VAL
	mov DI, DI_VAL
	mov cx, CX_VAL
	cld
	xor ax, ax
	xor dx, dx
next_byte:
	lodsb
	stosb
	mov ES : BYTE PTR [DI], 00h
	inc DI
	loop next_byte
endm
	create 0100h, 0300h, 0Ah
	hlt
;;;; solution to 1.c using macro
CODE ENDS
.data
	org 100h
	ARR_1 DB 10 DUP('A')

.code
jmp main
intersect macro SI_VAL, DI_VAL, CX_VAL
	mov si, SI_VAL
	mov di, DI_VAL
	mov CX, CX_VAL
	mov ax, @data
	mov ds, ax
	mov es, ax
	cld
	xor ax, ax
	xor dx, dx
	mov bx, di
	mov di, 0300h
next_byte:
	lodsb
	search
	cmp dx, 0001h
	jnz next
	stosb
next:
	loop next_byte
endm

search macro
	push di
	push cx
	lea di, ARR_2
	cld
next:
	scasb
	jz found	
	loop next
	jmp finish		
found:
	mov dx,1h
finish:
	pop di
	pop cx
endm

main:
	mov SI, offset ARR_1
	mov DI, 0200h
	mov cx, 000Ah
	push cx
	push di
init_es:
	mov al, 'b'
	rep
	stosb
	intersect 0100h, 0200h, 0Ah
	hlt
	
