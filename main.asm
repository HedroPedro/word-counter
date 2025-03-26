bits 64

%define ENDL 0xA, 0x0

section .data
error_string: db 'TRY CALLING: ./main file_name', ENDL

section .text
global _start

exit:
 ; rdi - exit code
 mov rax, 60
 syscall

print_string:
 ; rdi - null terminated string
 xor rdx, rdx
 .str_len:
 cmp byte[rdi+rdx], 0
 je short .end_len
 inc rdx
 jmp short .str_len
 .end_len:
 mov rax, 1
 mov rsi, rdi
 mov rdi, 1
 syscall
 ret



_start:
 cmp qword[rsp], 
 je .continue
 mov rdi, error_string
 call print_string
 mov rdi, 1
 call exit
 .continue:
  

 call exit
