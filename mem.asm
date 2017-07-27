size_str        equ 0xff ; размер блоков 
count_mem       equ 0x303 ; количество блоков
mem_tab         equ 0xfb00 ; адрес таблицы блоков 
KERNEL_SEGMENT  equ 0x50 ; сегмент ядра 
KERNEL_SIZE     equ 4096 ; размер ядра без драйверов 






;0000h- bios
;0x500 - IS_OS
;1500h-faffh- driver
;cs-1000h,2000h,3000h,4000
;0000h-ffffh- bufer
