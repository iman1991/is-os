;fsdrv.asm
       org      0
 
       file     'i87h\i87h.bin'
       file     'i37h\i37h.bin'
 
;check API
; mov si,testName
; xor eax,eax
; int 37h
 
       mov      si,testMsg
       xor      eax,eax
       int      87h
 
;off debug msgs
;       mov      ax,1
;       int      87h
 
 
       jmp      Exit
 
;testName db 'EMD COM'
testMsg db 'File System Driver = OK $',0
 
Exit:
 
 
;EOF
