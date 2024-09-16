section .data
    numbers dw 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150  ; 15 numbers
    total dw 0            ; Variable to store the sum
    count equ 15          ; The number of elements
    average dw 0          ; To store the calculated average

section .text
    global _start         ; Entry point for the program

_start:
    ; Initialize registers
    xor ax, ax            ; Clear AX (will hold current number)
    xor bx, bx            ; Clear BX (will hold sum)
    mov cx, count         ; Load the count (15 numbers)
    mov si, numbers       ; Load the starting address of the numbers array

sum_loop:
    ; Load each number and add it to the sum
    add bx, [si]          ; Add the number at memory location [si] to BX
    add si, 2             ; Move to the next number (2 bytes for each word)
    loop sum_loop         ; Repeat for all 15 numbers

    ; After summing, BX contains the total sum of the numbers
    mov [total], bx       ; Store the total sum in memory

    ; Now calculate the average by dividing the sum by 15
    mov ax, bx            ; Move the total sum into AX
    mov cx, count         ; Load the count (15) into CX
    xor dx, dx            ; Clear DX (necessary for division)

    div cx                ; Divide AX by CX (15)
                          ; Result (quotient) is in AX, remainder in DX

    ; Store the result (average) in memory
    mov [average], ax

    ; Exit the program
    mov eax, 60           ; syscall: exit
    xor edi, edi          ; status: 0
    syscall
