section .text
use16
cclr:   db 'clr',0
cexit:  db 'exit',0
crun:   db 'run',0
cfrmd:  db 'format',0
cnf:    db 'nf',0
cfind:  db 'find',0
chelp:  db 'error command',0
cmd: ; обработка команд
 xor cx,cx
 mov si,cx
 push ax


inf: 
 mov al,[command+si]
 mov ah,[cnf+si]
 cmp al,ah
 jne irun;
 inc si
 cmp si,2
 jl inf
 call new_file
jmp exit_cmd  

irun: 
 mov al,[command+si]
 mov ah,[crun+si]
 cmp al,ah
 jne iclr;
 inc si
 cmp si,3
 jl irun
pop ax 
mov ax,0xffff
push ax 
jmp exit_cmd  

iclr: 
 mov al,[command+si]
 mov ah,[cclr+si]
 cmp al,ah
 jne iexit;
 inc si
 cmp si,3
 jl iclr
 mov ax, cs
 mov ds, ax ; выбираем сегмент данных
 mov ax, 0x0003
 int 0x10
 xor dx,dx
 mov [mx],dx 
 jmp exit_cmd

iexit:
 mov al,[command+si]
 mov ah,[cexit+si]
 cmp al,ah
 jne ifind;
 inc si
 cmp si,4
 jl iexit
 mov ax,0x5307
 mov bx,0x0003
 mov cx,0x0001
 int 0x15 ; переривание биос выключение ПК
 jmp exit_cmd

ifind: 
 mov al,[command+si]
 mov ah,[cfind+si]
 cmp al,ah
 jne ifrmd;
 inc si
 cmp si,4
 jl ifind
call find_fil 
jmp exit_cmd


ifrmd: 
 mov al,[command+si]
 mov ah,[cfrmd+si]
 cmp al,ah
 jne ihelp;
 inc si
 cmp si,6
 jl ifrmd
 call form_fs
 jmp exit_cmd  


ihelp:
mov si,chelp
call writeln
exit_cmd:
pop ax
xor dl,dl
mov [icom],dl 
ret;

