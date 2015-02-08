section .text
use16
org 0x00
start:
mov ax,cs
mov ds,ax
;настройка сигментных регистров.
mov [mx],dh
mov [my],dl
mov si,msg
call writeln
mov si,msg_sys
call writeln
mov cx,0
mov [icom],cx
;printf msg_sys
mov ax,cs


call new_int30;

mov ah,0x1
int 30h

run:
;call wr_inf
push ax
mov si,rt
call write
call read_key
pop ax  
call cmd
jmp run 

rt:   db '~$ ',0 ;
msg:
db '...done!',0
msg_sys:
db 'the system is booting',0
%include "data.inc"
%include "command.asm"
%include "unit.asm"
%include "util.asm"
%include "disk_fs.asm"
%include "trask.asm"
%include "int_ff.asm"
%include  "mem.asm"
mov si,end_ker
end_ker: times KERNEL_SIZE-end_ker+start db 0 ; выравниваю по ядро 512 байт 
bufer:
