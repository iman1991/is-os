
new_int30:
        push ds
        xor     bx,bx
        mov     ds,bx
        mov     si,int30   
        mov     [ds:00C0h],si    
        mov     [ds:00C2h],cs
        pop  ds
        
ret







int30:

;Освобождение памяти
;ah 11h 
;bx сегментный адрес
;cx размер
cmp ah,11h
jne .memload
sub bx,0x1000
mov ax,bx
mov bx,[size_str]
div bx
mov si,ax
mov ax,cx
mov bx,[size_str]
div bx
cmp dx,0
je .loop11
add ax,1
mov bx,ax
add bx,si 
xor al,al
.loop11:
 mov [mem_tab+si],al
 inc si 
 cmp si,bx 
 jne .loop11
jmp .exit

.memload:
; выделение свободной памяти 10h
;вход
;ah - 0x10 выделение памяти для буфера  
;cx - рамер 
;выход 
;ax-сегмент 
; 
.count10 dw 0
cmp ah,0x10
jne .ret_krn
xor ax,ax
mov si,ax

.loop10:
 mov ah,[mem_tab+si]
 cmp ah,0
 jne .ad10 ; если размер свободной памяти меньше требуемой 
; bx приравниваем 0 иначе   
 push bx 
 mov bx,[.count10]
 inc bx
 mov [.count10],bx
 pop bx
 add bx,0xff
 cmp bx,cx 
 jnl .exit10 ; если свободной памяти больше или равно требуемой,
;то вычесляем адрес, иначе переходим наследующую точку   
 mov bx,si
 sub si,[.count10]
 mov al,0x1f  
.loop10i:
 mov [mem_tab+si],al
 inc si 
 cmp si,bx 
 jl .loop10i
 mov ax,bx
 mov bx,[size_str]
 mul bx
 inc dx
 shl dx,12
 shr ax,4
 add ax,dx 
jmp .exit

 .ad10:  
 xor bx,bx
 mov [.count10],bx
 inc si  
 cmp si,count_mem
 jle .loop10
.exit10:
jmp .exit




;функция возврата в ядро 
;вход ah - 1
;выход 
.ret_krn:

cmp ah,1
 jne .exit 
 pop ax
 pop ax
 xor ax,ax
 jmp dword 0x0:run
.exit:



iret

