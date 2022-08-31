[bits 32] ; 32 bit protected mode

; video memory constant
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; the color byte for each character

print_string_pmmode:
    pusha
    mov edx, VIDEO_MEM

print_string_pmmode_loop:
    mov al, [ebx] ; ebx is the address of the character
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je pmmode_print_done

    mov [edx], ax
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp print_string_pmmode_loop


pmmode_print_done:
    popa
    ret
