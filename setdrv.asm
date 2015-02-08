;setdrv.asm
 
 
;set sriver for IS-OS /SetDrv/
 
;--------------------------------\ в файл kernel.asm 
;example: 
;       mov      dx,word Driver
;       call     SetDrv


;finish:
;times 200h-finish db 0
;Driver:
;yours driver be here
;       incbin   "fsdrv.bin"
;--------------------------------/



 
;dx=drv binary offset (aligned 16 - must be start from paragraf)
;dx=выровненное на 16 байт смещение на драйвер 
SetDrv:
;save ret addr
       pop      ax
       push     cs ;/for far ret/ seg
       push     ax ; offset
       shr      dx,4
 
       push     cs
       pop      ax
       add      ax,dx
 
 
       mov      es,ax
       mov      [jmpaddr_seg],ax
 
       jmp      word far [jmpaddr]
 
 
jmpaddr:
jmpaddr_off dw 0
jmpaddr_seg dw 0
 

;EOF
