section .text
use16

command: times 16 db 0 ; командная строка 

mx:   db 0;
my:   db 0; Координаты
icom: dw 0; счетчик команд

write:
 cld ; направление для строковых команд
 mov ah, 0x0E
 ; номер функции BIOS
 mov bh, 0x00 ; страница видеопамяти
 puts_loop:
 lodsb ; загружаем очередной символ в al
 test al, al ; нулевой символ означает конец строки
 jz exit
 int 0x10 ; вызываем функцию BIOS
 mov [mx],dh
 mov [my],dl
 jmp write
 exit:
 ret 

; процедура перевода строки 
writeln:
 call write
 mov dh,[mx]
 mov dl,[my]
 inc dh
 xor dl,dl
 mov ah,0x02 
 int 0x10
 mov [mx],dh
 mov [my],dl 
ret

;читаем комманду
read_key:
mov di,[icom]

mov si,0
xor al,al
cn:
 mov [command+si],al
 inc si
 cmp si,16
 jne cn

com_:
  cmp di,15
 jg exit_k ;если длина комманды больше 15 выходим 

 mov ah,0x00
 int 0x16 ;чтение символа

 cmp al,0x61
 jge com1
 jmp enter 
com1:
 cmp al,0x7a
 
jle com0
 jmp enter

com0:
 mov [command+di],al
 mov si,command
 inc di
 mov dl,3
 mov ah,0x2
 int 0x10
call write
cmp di,15
 jl com_
  
jmp exit_k
enter:
 cmp ah,0x1c
 jne enter_
 mov dh,[mx]
 mov dl,[my]
inc dh

 xor dl,dl
 mov ah,0x02 
 int 0x10 
 mov [mx],dh
 mov [my],dl

jmp exit_k
enter_:
 jmp com0
esc_:

exit_k:
mov cx,di
mov [icom],cx
ret 


