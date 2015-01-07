
section .text
 use16
 org 0x7C00
; наша программа загружается по адресу 0x7C00
start:
jmp sstart
osname: db 'IS_OS  ',0; имя 8 байт 
sizeSec: dw 512       ; размер сектора
countSecKlast: db 4   ; число секторов в кластере 
countSecRes:  dw 10   ; размер системной области 
countTab: db 1        ; число фат таблиц
countDesFile: dw 0    ; число файлов в корневом каталоге
countSecDisk: dw 2880 ; общее количество секторов на диске 
typeDisk: db 0x80     ; тип устройства 
sizeTab: dw 2         ; размер фат  
countSecTreck: dw 18  ; число секторов на дорожке 
countDisk: dw 2       ; число головок 
countSkr: dd   0      ;
countRes: dd 1440        ; 1440
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indexDisk: db 0;
res: db 0;
sign: db 0x29;
datatime: dd 0;
diskName: db 'is_os boot ',0;
nameFS: db 'FAT16  ',0;
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sstart:
mov ax, cs
mov ds, ax ; выбираем сегмент данных
mov ax, 0x0003
int 0x10

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
mov di,0x600
mov es,di
xor bx,bx
mov ch,0x00
mov cl,0x02
mov dl,0
mov dh,0
mov ah,2
mov al,7
int 0x13

jmp 0x6000             
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
incbin "hello2.bin"
