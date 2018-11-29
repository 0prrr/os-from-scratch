; this is the print function which will be called to print regular string
print_string:
; pusha first to save all register data
pusha

; assuming that the string data resides in register bx
; start a loop to loop through all characters by moving
; what's in bx to al, and then check if the character is
; 0
start:
mov al, [bx]
cmp al, 0 ; compare al to 0
je done ; jump to done section if it's already null-byte

; if not null-byte, print the character
mov ah, 0x0e
int 0x10

; increase bx by 1 to get the next character
add bx, 1
; jump to start for a loop
jmp start


done:
; popa and then ret
popa
ret

; this is the print new line function to print a new line
print_nl:
; pusha first to save all register data
pusha

mov ah, 0x0e ; tty mode
; print new line character
mov al, 0x0a
int 0x10

; print carriage return character
mov al, 0x0d
int 0x10

; popa and ret
popa
ret
