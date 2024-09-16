section .data
    string db "Hello, World!", 0    ; The null-terminated string
    target db 'W'                   ; The character to search for
    output db 0                     ; To store the result (1 if found, 2 if not)
    index db 0                      ; To store the index of the found character

section .text
    global _start

_start:
    ; Load the starting address of the string and target character
    mov si, string          ; SI points to the start of the string
    mov al, [target]        ; Load the target character into AL

    ; Initialize index and result
    xor cx, cx              ; CX = 0 (index counter)
    mov bl, 2               ; Assume not found (BL = 2)

search_loop:
    ; Compare the current character with the target
    mov dl, [si]            ; Load the current character into DL
    cmp dl, 0               ; Check if the current character is the null terminator
    je not_found            ; If null terminator, character was not found

    cmp dl, al              ; Compare the current character with the target
    je found                ; If equal, jump to "found"

    ; Move to the next character
    inc si                  ; Increment SI to point to the next character
    inc cx                  ; Increment the index counter
    jmp search_loop         ; Repeat the search loop

found:
    ; Store result = 1 (found) and the index
    mov bl, 1               ; BL = 1 (character found)
    mov [index], cx         ; Store the index where the character was found

not_found:
    ; Store the result (1 if found, 2 if not) in output
    mov [output], bl

    ; Exit the program
    mov eax, 60             ; syscall: exit
    xor edi, edi            ; status: 0
    syscall
