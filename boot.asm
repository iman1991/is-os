
section .text
 use16
 org 0x7C00
; наша программа загружается по адресу 0x7C00
start:
jmp sstart
nop
osname: db 'IS_OS  ',0; имя 8 байт   0x03 
sizeSec: dw 512       ; размер сектора 0x0B
countSecKlast: db 4   ; число секторов в кластере 0x0D 
countSecRes:  dw 60   ; размер системной области 0x0E
countTab: db 1        ; число фат таблиц 0x10 :576
countDesFile: dw 0    ; число файлов в корневом каталоге 0x11
countSecDisk: dw 2880 ; общее количество секторов на диске 0x13
typeDisk: db 0x80     ; тип устройства 15
sizeTab: dw 714         ; размер фат  0x16
countSecTreck: dw 18  ; число секторов на дорожке 0x18
countDisk: dw 2       ; число головок 0x1A
countSkr: dd   0      ;         0x1c
countRes: dd 2440        ; 2440 0x20s
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indexDisk: db 0;
res: db 0;
sign: db 0x29;
datatime: dd 0;
diskName: db 'is_os boot ',0;
nameFS: db 'IS_FSYS',0;
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
struc file ;упращанная структура записи 
  name resb 8
  type resb 3
  atr  resb 1
  rsrw resb 14
  clas resb 2
  size resb 4
endstruc

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
mov di,KERNEL_SEGMENT
mov es,di
xor bx,bx
mov ch,0x00
mov cl,0x02
mov dl,0
mov dh,0
mov ah,2
mov al,7
int 0x13

jmp word KERNEL_SEGMENT:0x0000             
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
KERNEL_SEGMENT equ 0x50

finish:
times 0x1FE-finish+start db 0
db 0x55, 0xAA ; сигнатураs загрузочного сектора
incbin "kernel.bin"
