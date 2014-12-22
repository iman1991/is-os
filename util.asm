info: db 0,0
      db 0
bin_dec: 
push ax
 xor ah,ah

 mov bl,16
 div bl
 cmp al,10
 jge hex1
 add al,0x30
 jmp bin2
 hex1:add al,0x37
 bin2:
 cmp ah,10
 jge hex2
 add ah,0x30
 jmp ex_
 hex2: add ah,0x37
  ex_: 
  mov [info],ah
  mov [info+1],al
  pop ax
 ret
 
wr_inf:
 push  dx
 mov dh,23
 mov [my],dl
 mov ah,0x02
 int 0x10
  push ax 
 mov al,ah 
 call bin_dec
 mov si,info
 call write
 pop ax

 call bin_dec
 mov si,info
 call writeln
  pop dx
 mov [mx],dh
 mov [my],dl
 mov ah,0x02
 int 0x10
ret 





 
 
