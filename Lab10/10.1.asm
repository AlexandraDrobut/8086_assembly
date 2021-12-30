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


set_cursor proc near     
    ;setting cursor position
    mov bh, 00h   ; video page number
    mov ah, 02h   ; cursor position service
    int 10h       ; trigger interrupt
    ret
set_cursor endp 
       
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
    mov dx, 0303h ; setting row and column for printing, DH = row, DL = col
    call set_cursor

next_char:
    mov al, [si]
    cmp al, '$'
    je exit 
    call print_char
    inc si 
    inc dl ;increase column index
    call set_cursor
    jmp next_char
exit:
    ret
color_print endp

start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    call color_print
ends

end start ; set entry point and stop the assembler.
