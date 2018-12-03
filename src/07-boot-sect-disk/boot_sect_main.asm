[org 0x7c00]

; addr of stack
mov bp, 0x8000
mov sp, bp

; es:bx general segment
mov bx, 0x9000
mov dh, 2

call disk_load

; load the first data, which is 0xadad
mov dx, [0x9000]

call print_hex

call print_nl

; fist word from second loaded sector, which is 0xabcd
mov dx, [0x9000 + 512]

call print_hex

jmp $

%include "../05-boot-sect-functoin-string/boot_sect_print.asm"
%include "../05-boot-sect-functoin-string/boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xadad ; sector 2 = 512 bytes
times 256 dw 0xabcd ; sector 3 = 512 bytes
