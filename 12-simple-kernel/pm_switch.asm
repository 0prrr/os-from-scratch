[bits 16]
switch_to_pm:
    cli ; disable interrupts
    lgdt [gdt_descriptor] ; hand over GDTD to CPU
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax ; set cr0 first bit, cannot be written directly, use eax
    jmp CODE_SEG:init_pm ; far jump, clear CPU pipeline

[bits 32] ; enter 32-bit pm
init_pm:
    mov ax, DATA_SEG ; update other segement registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9000 ; new stack address
    mov esp, ebp

    call BEGIN_PM ; print msg
