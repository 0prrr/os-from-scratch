[org 0x7c00]
mov ah, 0x0e ; trigger scrolling teletype BIOS routine

mov al, "1" ; first attempt to print X
int 0x10
mov al, the_secret
int 0x10

mov al, "2" ; second attempt to print X
int 0x10
mov al, [the_secret]
int 0x10

mov al, "3" ; third attempt to print X
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

mov al, "4" ; fourth attempt to print X
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $

the_secret:
db "X"

times 510-($-$$) db 0
dw 0xaa55
