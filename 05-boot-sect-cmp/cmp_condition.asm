; conditional jump exercise
mov ah, 0x0e

mov bx, 55

cmp bx, 4
jle le_than_4
cmp bx, 40
jl l_than_40
mov al, 'c'
int 0x10
jmp the_end

le_than_4:
mov al, 'a'
int 0x10
jmp the_end

l_than_40:
mov al, 'b'
int 0x10

the_end:

jmp $

times 510-($-$$) db 0
dw 0xaa55
