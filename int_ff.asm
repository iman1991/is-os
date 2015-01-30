new_int30:
push    ds
        xor     bx,bx
        mov     ds,bx
        mov     si,run  
        mov     [ds:00C0h],si    
        mov     [ds:00C2h],cs
        pop     ds
ret

int30 
 pop ax
 pop ax
 jmp dword 0x0:run
