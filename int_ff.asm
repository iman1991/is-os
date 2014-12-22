oldseg08 dw 0
oldofs08 dw 0
kernel: 
mov ax,0x2000

ret

new_int:
push    ds
        xor     bx,bx
        mov     ds,bx
        mov     bx,[ds:0020h]
        mov     es,[ds:0022h]
        mov     [cs:oldseg08],es
        mov     [cs:oldofs08],bx
        xor     bx,bx
        mov     ds,bx
        mov     bx,[cs:kernel] ;    
        mov     [ds:0020h],bx    
        mov     [ds:0022h],cs
        pop     ds
ret
