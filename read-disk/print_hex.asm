; we receive data from dx
print_hex:
    pusha

    mov cx, 0 ; index variable


; Strategy: get the last char of 'dx', then convert to ASCII
; Numeric ASCII values: '0' (ASCII 0x30) to '9' (0x39), so just add 0x30 to byte N.
; For alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (0x46) we'll add 0x40
; Then, move the ASCII byte to the correct position on the resulting string

hex_loop:
    cmp cx, 4 ; should loop 4 times
    je end

    ; 1 - convert the last char of dx to HEX
    mov ax, dx ; mov dx to ax so we can manipulate it
    and ax, 0x000f ; 0x1234 -> 0x0004
    add al, 0x30
    cmp al, 0x39 ; if al > 9 add extra 8 to represent 'A' to 'F'
    jle step2

    add al, 7 ; 'A' is ASCII 65 instead of 58, so 65-58=7

step2:
    ; 2. get the correct position of the string to place our ASCII char
    ; bx <- base address + string length - index of char
    mov bx, hex_out + 5 ; base + length
    sub bx, cx ; subtract from bx using our index
    mov [bx], al ; move the char on al to the position of bx
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    add cx, 1 ; i ++ (increment index and loop)
    jmp hex_loop

end:
    ; prepare the parameter and call function
    ; remember that print receives parameters in 'bx'
    mov bx, hex_out
    call print

    popa
    ret

hex_out:
    db '0x0000', 0 ; reserve memory for our string