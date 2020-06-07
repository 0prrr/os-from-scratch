org 0x7c00

mov ebx, HELLO_WORLD
call print_string_pm

jmp $

%include "pm_32bit_print.asm"

HELLO_WORLD: db "HelloWorld", 0

times 510 - ($ - $$) db 0
dw 0xaa55

