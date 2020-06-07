[org 0x7c00]

; we have to use the stack to store some data, so set the stack away from boot sector
mov ax, 0x8000
mov bp, ax
mov sp, bp
; as said, the data will be loaded to address [ES:BX] => 0x8000
mov ax, 0x0
mov es, ax
mov bx, 0x9000

; read two sectors from disk
mov dh, 0x2

; call read_from_disk function
call read_from_disk

; print the first word on second sector => 0xdead
mov dx, [es:bx]
call print_hex
; print the first word on third sector => 0xbeef
mov dx, [es:bx + 512]
call print_hex

jmp $

%include "print.asm"
%include "print_hex.asm"
%include "read_from_disk.asm"

; zero padding
times 510 - ($ - $$) db 0x0
; boot sector magic word
dw 0xaa55

; write data to the second sector (first sector is our boot sector)
times 256 dw 0xdead
; write data to our third sector, dw write a word, a word is tow bytes
times 256 dw 0xbeef


