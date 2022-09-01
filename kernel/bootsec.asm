[org 0x7c00]

KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl 
    mov bp, 0x9000
    mov sp, bp
    
    mov bx, MSG_REAL_MODE
    call print
    call print_nl 

    call load_kernel

    jmp $

%include "../read-disk/print.asm"
%include "../read-disk/print_hex.asm"
%include "../read-disk/readdisk.asm"

%include "../32bit/gdt32bit.asm"
%include "../32bit/print32bit.asm"
%include "../32bit/switch32bit.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ;  read from disk in 0x1000
    mov dh, 1
    mov dl, [BOOT_DRIVE]
    call disk_load

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pmmode
    call KERNEL_OFFSET ; give control to the kernel

    jmp $


BOOT_DRIVE db 0 

MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55