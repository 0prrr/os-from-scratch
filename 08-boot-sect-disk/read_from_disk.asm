read_from_disk:
    pusha

    ; we stored how many sectors to read in dh, and because dh is alse used to indictae the head info, we have to push it into the stack for later error checking
    push bx ; for information use
    push dx

    ; set parameters

    mov ah, 0x02 ; read mode
    mov al, dh ; read two sectors (dead...beef...)
    mov ch, 0x00 ; read from first cylinder
    mov cl, 0x02 ; read starts from the second sector (the first is boot sector)
    mov dh, 0x00 ; read the first head, we have so little data on the first platter
    ;mov dl, 0x00 ; read the first whatever drive

    int 0x013 ; raise interrupt to read data

    mov bx, READ_START
    call print
    call print_nl

    jc op_error ; should read operation fail, CF register will be 1, jc will make the jump if carry bit is set

    ; restore dx for error checking
    pop dx
    cmp al, dh
    jne read_error

    mov bx, READ_COMPLETE
    call print 

    ; print out the location of the data in memory
    pop bx
    mov dx, bx
    call print_hex
    call print_nl

    popa
    ret

op_error:
    ; print error string, remember bx is used for print
    mov bx, OP_ERROR
    call print
    call print_nl
    ; rememeber after read operation, ah contains the status code, should any error occur, we want to print out the error code and the drive number that the read operation is carried out upon (dl is the drive number, no need to modify)
    mov dh, ah
    call print_hex
    ; just hang the cpu on error
    jmp disk_loop

read_error:
    mov bx, READ_ERROR
    call print
    jmp disk_loop

disk_loop:
    jmp $

READ_START: db "Reading start...", 0
READ_COMPLETE: db "Reading complete, data loaded to ", 0
OP_ERROR: db "Disk read error...", 0
READ_ERROR: db "Incorrect number of sectors read...", 0

