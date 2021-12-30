
;--------------------------------------
STIVA SEGMENT PARA STACK 'STACK'
DW 256 DUP(?)
STIVA ENDS
;--------------------------------------
;
;--------------------------------------
DATA_S SEGMENT PARA PUBLIC 'DATA'
table DB '0123456789ABCDEF'  ;tabela de conversie
conv DB 'AX='
string DB 0,0,0,0,'$'
DATA_S ENDS
;--------------------------------------
;
;--------------------------------------
;Sectiune CODE
;--------------------------------------
;
CODE SEGMENT PARA PUBLIC 'CODE'

print_char proc    near
    mov ah, 09h ; service to write character and attribute at cursoe position
    mov bl, 1fh ; high nibble - background color, low nibble font color
    mov bh, 0   ; page number
    mov cx, 1
    int 10h
    ret
print_char endp

set_cursor proc near
    ;setting cursor position
    mov bh, 00h   ; video page number
    mov ah, 02h   ; cursor position service
    int 10h       ; trigger interrupt
    ret
set_cursor endp

MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:STIVA,ES:NOTHING
    push ds
    xor ax,ax
    push ax        ;init. pt. return
    mov ax,DATA_S
    mov ds,ax
    mov es, ax
    ;printing first 10 bytes from DATA SEGMENT
    lea si, table
    xor dx, dx  ; row = 0, col = 0
    call set_cursor
    mov bx, 10  ; bytes index
    next_char:
        mov al, [si]
        call print_char
        inc dh     ; each byte on a new row
        call set_cursor
        inc si
        dec bx
        jnz next_char
    hlt
    MAIN ENDP
;--------------------------------------
CODE ENDS
END MAIN

