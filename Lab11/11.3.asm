
org 100h
jmp start
string db "Please enter your password", 0
pass db 20 dup(0), '$'

scan_str macro str
    lea di, pass
next_char:
    call read_char
    cmp al, 0Dh
    je exit
    stosb
    jmp next_char
exit:
    lea dx, string
    mov ah, 09h
    int 21h
scan_str endm

start:

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx 
    mov ax, ds
    mov es, ax
    scan_str
    ret   


; Read from keyboard procedure, int 16h, AH=00h
read_char proc near 
    mov ah, 00h
    int 16h
    ret
read_char endp  
  
print_char proc ear
    mov ah, 0Eh
    int 10h
    ret
print_char endp
    




