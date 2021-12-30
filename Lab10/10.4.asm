; multi-segment executable file template.

data segment
; add your data here!
string db "Vacation is nice!$"
ends

code segment
jmp start

reset MACRO
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
reset endm

; F = 10 MHZ=> Tck = 100 ns
; T delay = 1ms =  N x Tck(for loop + nop) => 1 ms = N x 2,1 microseconds => N = 500
delay proc near
    mov cx, 500
    for:
        nop      ; 3 Tck
        loop for ; 19 Tck
    ret
delay endp

set_cursor proc near
;setting cursor position
    mov bh, 00h   ; video page number
    mov ah, 02h   ; cursor position service
    int 10h       ; trigger interrupt
    ret
set_cursor endp

clear_screen proc near
    mov al, 00h
    mov ah, 06h
    int 10h
    ret
clear_screen endp

print_char proc    near
    mov ah, 09h ; service to write character and attribute at cursoe position
    mov bl, 1fh ; high nibble - background color, low nibble font color
    mov bh, 0   ; page number
    mov cx, 1
    int 10h
    ret
print_char endp

color_print proc near
    reset
    mov dx, 0300h ; setting row and column for printing, DH = row, DL = col
    call set_cursor

    next_char:
        mov al, [si]
        cmp al, '$'
        je exit
        call print_char
        inc si
        cmp dl, 80    ; limit of video screen column
        je reset_col
        inc dl ;increase column index
        call set_cursor
    jmp next_char

    reset_col:
        mov dl, 0
        call set_cursor
        jmp next_char
        exit:
        lea si, string
        call clear_screen
        call delay
        jmp next_char
color_print endp

    start:
    ; set segment registers:
        mov ax, data
        mov ds, ax
        mov es, ax
        call color_print

ends

end start ; set entry point and stop the assembler.