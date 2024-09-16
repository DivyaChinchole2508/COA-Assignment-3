section .data
    numbers dw 10, 20, 30, 40, 50, 60, 70, 80, 90, 100    ; Sorted list of 10 numbers
    target dw 70                                          ; Number to search (loaded from X location)
    output dw 0                                           ; Store result (1 if found, 2 if not)
    iterations dw 0                                       ; Store number of iterations (if found)
    index dw 0                                            ; Store index of the found number (if found)

section .text
    global _start

_start:
    ; Load the target number
    mov ax, [target]          ; AX holds the target number

    ; Initialize binary search bounds
    xor cx, cx                ; CX = 0, left index (low)
    mov dx, 9                 ; DX = 9, right index (high)
    xor di, di                ; DI = 0, iteration count
    mov si, numbers           ; SI points to the base address of the array

binary_search:
    ; Increment iteration count
    inc di                    ; DI stores the iteration count

    ; Calculate middle index (mid = (low + high) / 2)
    mov bx, cx                ; BX = low
    add bx, dx                ; BX = low + high
    shr bx, 1                 ; BX = (low + high) / 2, mid index

    ; Compare the middle element with the target
    mov zx, [si + bx*2]       ; Load the number at index mid (array is word-aligned)
    cmp zx, ax                ; Compare the middle element with the target
    je found                  ; If equal, number is found

    ; Adjust search range (binary search logic)
    jl go_right               ; If target > mid element, search in the right half
    mov dx, bx                ; Set high = mid - 1 (search in the left half)
    dec dx
    jmp check_done

go_right:
    mov cx, bx                ; Set low = mid + 1 (search in the right half)
    inc cx

check_done:
    cmp cx, dx                ; Check if low > high
    jle binary_search         ; If not, continue searching

    ; If not found, store output = 2 (not found)
    mov word [output], 2
    jmp end_program           ; End the program

found:
    ; If found, store output = 1
    mov word [output], 1

    ; Store the iteration count
    mov word [iterations], di

    ; Store the index of the found element
    mov word [index], bx

end_program:
    ; Exit the program (syscall)
    mov eax, 60               ; syscall: exit
    xor edi, edi              ; status: 0
    syscall
