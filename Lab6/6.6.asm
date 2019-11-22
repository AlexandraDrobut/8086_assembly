
; Standard header:
	#make_COM#
        ORG  100H  
	JMP START
START:
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx

; initialization of the memory
mov ax, 3331h
mov si, 2004d
mov DS: WORD PTR[SI], ax

mov ax, DS: WORD PTR [SI]
sub al, 30h
sub ah, 30h

; AH = 03 ; AL = 01
xchg al, ah
mov bl, 10
mul bl
add al, ah
mov DS: WORD PTR [2006d] , ax
; DS: [2006d] = 001Fh