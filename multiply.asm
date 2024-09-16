section .data
    num1 dw 5             ; First number to multiply (5)
    num2 dw 4             ; Second number to multiply (4)
    result dw 0           ; To store the result of the multiplication

section .text
    global _start         ; Entry point for the program

_start:
    ; Load num1 into AX and num2 into BX
    mov ax, [num1]        ; AX = num1
    mov bx, [num2]        ; BX = num2
    xor cx, cx            ; Clear CX, will be used for the result

    ; Multiplication by repeated addition
multiply_loop:
    cmp bx, 0             ; Check if BX is zero
    je multiplication_done ; If BX is 0, multiplication is complete

    add cx, ax            ; Add AX (num1) to CX (which stores the result)
    dec bx                ; Decrement BX (decrease the counter)
    jmp multiply_loop     ; Repeat until BX becomes 0

multiplication_done:
    ; Store the result in memory
    mov [result], cx      ; Store the final result in memory

    ; Exit the program
    mov eax, 60           ; syscall: exit
    xor edi, edi          ; status: 0
    syscall
