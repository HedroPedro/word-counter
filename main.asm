bits 64

%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2
%define ENDL 0xA, 0x0
%assign PAGE_SIZE 1024*4

%macro close 1-2 0 
 pop rdi
 mov rax, %1
 %if %2 != 0
 mov rsi, %2
 %endif
 syscall
%endmacro

section .data
error_string: db 'TRY CALLING: ./main file_name', ENDL
content_string: db 'FILE CONTENT: ', 0x0

section .text
global _start

exit:
 ; rdi - exit code
 mov rax, 60
 syscall

print_string:
 ; rsi - null terminated string
 ; rdi - fd
 push rdx
 xor rdx, rdx
 .str_len:
 cmp byte[rsi+rdx], 0
 je .end_len
 inc rdx
 jmp .str_len
 .end_len:
 mov rax, 1
 syscall
 pop rdx
 ret

get_word_and_characters:
 ; rdi - pointer to page with file contents
 ; rax - word amount
 ; rdx - character amount
 push rdi
 mov rsi, content_string 
 mov rdi, 1
 call print_string
 mov rsi, [rsp] 
 mov rdi, 1
 call print_string
 mov rdi, [rsp]
 xor rdx, rdx
 xor rax, rax
 .automata:
 mov sil, [rdi]
 cmp sil, 0
 je .end
 
 
 .word_counter:
 
 .character_counter:
 
 .end:
 add rsp, 8
 ret

_start:
 push rbp
 mov rbp, rsp
 cmp qword[rsp+8], 2 
 je .continue
 mov rdi, 2 ; err stream
 mov rsi, error_string
 call print_string
 pop rbp
 mov rdi, 1
 call exit

 .continue:
 mov rax, 2
 mov rdi, [rsp+24]
 mov rsi, O_RDONLY
 syscall
 push rax

 xor rdi, rdi
 mov rsi, PAGE_SIZE
 mov r8, rax
 mov rdx, PROT_READ 
 mov r10, MAP_PRIVATE
 xor r9, r9 
 mov rax, 9
 syscall
 push rax
 
 mov rdi, rax
 call get_data 
 
 close 11, PAGE_SIZE
 close 3
 pop rbp
 call exit
