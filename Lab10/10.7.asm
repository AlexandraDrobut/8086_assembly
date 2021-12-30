;--------------------------------------
;
;--------------------------------------
DATA SEGMENT PARA PUBLIC 'DATA'
table DB '01'  ;tabela de conversie
conv DB 'AX='
string DB 16 DUP(0)
DB '$'
DATA ENDS
;--------------------------------------
;
;--------------------------------------
;Sectiune CODE
;--------------------------------------
;
CODE SEGMENT PARA PUBLIC 'CODE'
MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:STIVA,ES:NOTHING
    push ds
    xor ax,ax
    push ax        ;init. pt. return
    mov ax,DATA
    mov ds,ax
    mov dx, 16
    mov ax,1A2Fh
    mov si,offset string
    mov bx,offset table
    next_bit:
        rcl ax, 1
        jnc zero
        mov al, [bx + 1]
        jmp wr
        zero:
        mov al, [bx]
    wr:
        mov [si],al
        inc si
        dec dx
        jnz next_bit
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov dx,offset conv
    mov ah,09h
    int 21h
    ret
    MAIN ENDP
;--------------------------------------
CODE ENDS
END MAIN

