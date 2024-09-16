section .data
    num1 dw 1234h        ; First 16-bit number (in hexadecimal)
    num2 dw 0ABC4h       ; Second 16-bit number (to be subtracted)
    result dw 0          ; To store the result

section .text
    global _start        ; Entry point for the program

_start:
    ; Load the first 16-bit number into AX
    mov ax, [num1]

    ; Load the second 16-bit number into BX
    mov bx, [num2]

    ; Perform two's complement of the second number (negate it)
    not bx             ; Take 1's complement of BX
    add bx, 1          ; Add 1 to make it 2's complement

    ; Add AX (first number) with BX (two's complement of second number)
    add ax, bx

    ; Store the result back into memory
    mov [result], ax

    ; To output the result, we need to convert it to a string
    ; This will output the result in hexadecimal format for simplicity
    call print_hex

    ; Exit the program
    mov eax, 60         ; syscall: exit
    xor edi, edi        ; status: 0
    syscall

; Subroutine to print a 16-bit value in hexadecimal
print_hex:
    pusha               ; Save all registers
    mov cx, 4           ; There are 4 hexadecimal digits in a 16-bit number

print_loop:
    rol ax, 4           ; Rotate left by 4 bits to get the next hex digit in AL
    mov bl, al          ; Copy AL to BL
    and bl, 0Fh         ; Mask the upper 4 bits, leaving the lower 4 bits (hex digit)
    cmp bl, 9
    jbe digit_is_number ; If BL <= 9, it's a number
    add bl, 'A' - 10    ; Convert 10-15 to A-F
    jmp print_digit

digit_is_number:
    add bl, '0'         ; Convert 0-9 to ASCII

print_digit:
    ; Output the digit (in BL)
    mov eax, 0x04       ; syscall: sys_write
    mov edi, 1          ; file descriptor: stdout
    mov rsi, rsp        ; point to digit on stack
    push bx             ; push the digit to the stack
    mov edx, 1          ; write 1 byte
    syscall
    pop bx              ; restore BX

    loop print_loop     ; Repeat for each digit

    popa                ; Restore all registers
    ret                 ; Return from the subroutine
