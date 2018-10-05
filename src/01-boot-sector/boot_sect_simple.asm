; Infinite loop (e9 fd ff)
loop:
jmp loop

;
; od tells me that the first two bytes is eb fe
; but it should be e9 fd ff in the tutorial
; so instead of using direct instruction
; write the half word data into mem to see if
; it still works
;
;db 0xe9
;db 0xfd
;db 0xff

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
