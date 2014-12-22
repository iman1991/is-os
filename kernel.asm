section .text
use16
org 0x1000
start:
mov [mx],dh
mov [my],dl
mov si,msg
call writeln
mov si,msg_sys
call writeln
mov cx,0
mov [icom],cx

run:
 call wr_inf
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
db 'the system is running',0
;%include "data.inc"
%include "command.asm"
%include "unit.asm"
%include "util.asm"
%include "disk_fs.asm"
%include "trask.asm"
%include "int_ff.asm"
