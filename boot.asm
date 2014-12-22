section .text
 use16
org 0x7C00
; наша программа загружается по адресу 0x7C00
start:
mov ax, cs
mov ds, ax ; выбираем сегмент данных
mov ax, 0x0003
int 0x10
;jmp puts_loop_exit
mov si, message
cld ; направление для строковых команд
mov ah, 0x0E
; номер функции BIOS
mov bh, 0x00 ; страница видеопамяти
puts_loop:
lodsb ; загружаем очередной символ в al
test al, al ; нулевой символ означает конец строки
jz puts_loop_exit
int 0x10 ; вызываем функцию BIOS
jmp puts_loop

puts_loop_exit:
load:
mov ax,es
mov ds,ax
mov di,0x100
mov es,di
xor bx,bx
mov ch,0x00
mov cl,0x02
mov dl,0
mov dh,0
mov ah,2
mov al,7
int 0x13

jmp 0x1000             
cld ; направление для строковых команд
mov ah, 0x0E
; номер функции BIOS
mov bh, 0x00 ; страница видеопамяти
puts_loop1:
lodsb ; загружаем очередной символ в al
test al, al ; нулевой символ означает конец строки
jz puts_loop_exit1
int 0x10 ; вызываем функцию BIOS
jmp puts_loop1
puts_loop_exit1:
message: 
db 'loading Kernel',0
finish:
times 0x1FE-finish+start db 0
db 0x55, 0xAA ; сигнатураs загрузочного сектора
incbin "kernel.bin"
