;i37h.asm
 
       include  'inc\macro.asm'
 
 
FILE_NOT_FAUND = 0x01
FILE_OK = 0x02
DISK_IO_ERROR = 0x03
INIT_ERROR = 0x04
 
       org      5120
       use16
 
;file 'i87h.bin'
; push cs
; pop ax
; mov ds,ax
; mov es,ax
 
;init driver All here>>>>>>>>>>>>>>>>
 
       mov      dl,80h
       mov      [Read.DriveNumber],dl
 
 
       mov      ax,37h ;номер прерывания
       mov      word bx,new_handler ;адрес обработчика
       call     hook ;\int\hook.asm
 
       DbgDspl  '> set new int = 37h '
       xor      eax,eax
       int      16h
       jmp      exit
 
 
 
;mov di,boot ; set di=memory for BPB (+3 bytes at start)
;mov cx,SIZE_BPB
GetMBR_GetVBR_GetBPBfromIt:
       pusha
 
       include  'initBPB.asm' ;return ax=memory BPB+3bytesStart
 
       mov      [.saveTmpBPBptr],ax
       popa
       mov      si,[.saveTmpBPBptr]
       mov      cx,0x036
.l1:
       mov      al,[si]
       mov      [di],al
       inc      si
       inc      di
       dec      cx
       jnz      .l1
 
       clc
       ret
.saveTmpBPBptr dw 0
.err:
       stc
       ret
 
 
       include  'inc\int\hook.asm'
       include  'inc\int\intman.asm'
       include  'inc\int\table.asm'
 
       include  'inc\fat16.asm' ;main file for fat16 subprogs
       include  'inc\fatval.asm' ;data file for fat16 subprogs
 
 
       include  'inc\data.asm'
       include  'inc\biosdisk.asm'
       include  'inc\disp512.asm'
       include  'inc\esc.asm'
       include  'inc\dec.asm'
       include  'inc\hex.asm'
       include  'inc\memman.asm'
 
 
ReadFileMain:
mov [ExitCod],byte INIT_ERROR
       include  'drv.asm'
 
 align 512
rb 511
db 'x'
exit:
 
 
;EOF
