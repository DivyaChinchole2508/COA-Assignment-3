section .data
    num1 dw 36           ; First number
    num2 dw 60           ; Second number
    gcd_result dw 0      ; To store the GCD
    lcm_result dw 0      ; To store the LCM

section .text
    global _start         ; Entry point for the program

_start:
    ; Load the two numbers from memory into AX and BX
    mov ax, [num1]
    mov bx, [num2]

    ; Store the original values of num1 and num2 for later LCM calculation
    mov cx, ax            ; CX = num1
    mov dx, bx            ; DX = num2

    ; Find the GCD using the Euclidean algorithm
gcd_loop:
    cmp bx, 0             ; If BX == 0, GCD is in AX
    je gcd_done           ; If BX is zero, jump to gcd_done
    xor dx, dx            ; Clear DX before division
    div bx                ; AX = AX / BX, DX = remainder
    mov ax, bx            ; AX = BX (new dividend)
    mov bx, dx            ; BX = remainder (new divisor)
    jmp gcd_loop          ; Repeat the process

gcd_done:
    ; AX now holds the GCD, store it in memory
    mov [gcd_result], ax

    ; Now calculate the LCM using the formula: (num1 * num2) / GCD
    ; num1 is stored in CX and num2 is stored in DX
    ; GCD is in AX

    ; Multiply num1 and num2
    mov ax, cx            ; AX = num1
    mul dx                ; DX:AX = num1 * num2 (64-bit result)

    ; Now divide by GCD
    div [gcd_result]      ; AX = LCM (LCM = (num1 * num2) / GCD)

    ; Store the LCM in memory
    mov [lcm_result], ax

    ; Exit the program
    mov eax, 60           ; syscall: exit
    xor edi, edi          ; status: 0
    syscall
