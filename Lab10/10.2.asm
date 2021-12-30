
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

text    DB        'Vacation is nice!',0

mov    bh,0      ;page number
mov    bl,1fh    ;color attribute of the text and background 1- blue font F- white background
call    linie
ret

linie    proc      near
    mov     cx,1  ; how many times to print character in AL
    mov    dx,0      ; dl = row, dh = col
    linie_iar:
        mov    si,offset text
        iar:
            mov     ah,2
            int    10h
            lodsb
            cmp    al,0
            jz    endtext
            mov    ah,9
            int    10h
            inc    dl        ; incrementing column
            cmp    dl,80
        jnz    iar
    endtext:
        inc    dh        ; incrementing line
        inc    dh
        cmp    dh,25
        jc    linie_iar
    ret
linie endp




