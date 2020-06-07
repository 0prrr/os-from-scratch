; this is the print function which wil be called to print hex value
print_hex:
; print whatever is in dx
; seperate into two steps
; first, receive the value in dx using ax
; masking the first three bit
; transform the last bit into hex
; if it's digital, 0-9 (0x31-0x39), add 30 to it
; if it's alpabetical, A-F (0x41-0x46), add 40 to it

; pusha first
pusha

mov cx, 0 ; this is the index variable

hex_loop:
; loop 4 times
cmp cx, 4
je end

; move dx to ax
mov ax, dx
; mask the fist three bits
and ax, 0x000f
; add al 0x30
add al, 0x30
; check if the result is greater than 0x39, if it doesn't, go step 2
cmp al, 0x39
jle step_2
; if it's greater than 0x39, it's a character, add 7 to it
; ASCII code for A is 65, 0x39 is decimal 58
add al, 7

step_2:
; move that digital character into the memory place pre-allocated
mov bx, HEX_STRING + 5 ; base address plus the length of the string
sub bx, cx ; minus index variable so the char will be in position
mov [bx], al ; move what's in al to the place bx points to

; ror dx, 4 ; rotate right
shr dx, 4

add cx, 1 ; increase cx by 1
jmp hex_loop

end:
mov bx, HEX_STRING
call print_string

popa
ret


HEX_STRING:
db '0x0000', 0
