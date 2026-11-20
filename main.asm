section .data
    prompt db "What is your name?", 0x0A
    plen equ $ - prompt
    greeting db "Hello, ", 0x0

section .bss
    bytes: resq 8         ; Reserve 64 bytes (2 quadword, one qword is 8 bytes)

section .text
    global _start

_start:
    mov rax, 1            ; normal sys_write code
    mov rdi, 1            ; stdout
    mov rsi, prompt       ; gets the prompt bytes
    mov rdx, plen         ; Gets the len of prompt
    syscall               ; tells linux to do the sys_write

    mov rax, 0            ; it starts sys_read protocol
    mov rdi, 0            ; stdin
    mov rsi, bytes        ; gets the bytes of greeting (or buffer)
    mov rdx, 64           ; Number of bytes NASM reads, it is
    syscall               ; tells linux to do the sys_read 

    mov rax, 1            ; sys_write (1)
    mov rdi, 1            ; you most def know this
    mov rsi, greeting        ; TBH i didnt know sysread was that simple
    mov rdx, 64           ; Number of bytes to read
    syscall
    
    call _exit

_exit:
    mov rax, 60           ; sys_exit (60)
    mov rdi, 0            ; Exit code 0
    syscall
