sfs:      db 10
sfs_txt   db 'Stupid file system',0
m_sek     dw 0
m_dor     dw 0 
c_obj     dw 0
fs_data   times 512 db 0

obj_name  times 16 db 0 ; имя 
obj_id    db 0  
obj_type  db 0 ; 0 корень,1 папка  2 файл  
obj_atrib db 0
srt_dor   db 0
srt_sek   dw 0
could_sec dw 0
f_date    times 512 db 0
sfind     times 16 db 0
rfind     times 16 db 0


;чтение сектора
read_sec:
pusha
mov ch,[m_dor]
shr cx,2
add cl,[m_sek]
xor bx,bx

mov es,di
mov dl,0
mov dh,0
mov ah,2
mov al,1
int 0x13
shl cx,2
shr cl,2
cmp cl,17
jl ex_rfs 
add ch,1
xor cl,cl
mov [m_dor],ch
mov [m_sek],cl

rfs:
popa
ret

; запись сектора
write_sec:
pusha
mov ch,[m_dor]
shr cx,2
add cl,[m_sek]
xor bx,bx

mov es,di
mov dl,0
mov dh,0
mov ah,3
mov al,1
int 0x13
shl cx,2
shr cl,2
cmp cl,17
jl ex_rfs 
add ch,1
xor cl,cl
mov [m_dor],ch
mov [m_sek],cl

ex_rfs:
popa
ret

; форматирование 
form_fs:
 push si
 mov al,[sfs]
 mov [fs_data],al
 mov si,0x0002
 cop:
 mov al,[sfs_txt+si-2]
 mov [fs_data+si],al
 inc si;
 cmp si,20 
 jle cop 
 mov ax,1
 mov [fs_data+21],ax 
 xor ax,ax
 mov [fs_data+22],ax
 mov [fs_data+23],ax
 mov di,fs_data
 call write_sec
 pop si
ret

new_file:
mov si,3
cop_name:
inc si
mov al,[command+si-1]
mov [obj_name+si-4],al
push si
push ax
mov cx,27
add cx,si
mov bx,[c_obj]
imul ax,bx,24
add bx,cx
mov si,bx
pop ax
mov [fs_data+si],al
;mov ax,si
pop si
;mov [rfind+si-4],al 
cmp si,16
 jl cop_name
 mov si,obj_name
 call writeln
 mov si,bx

 mov ax,[c_obj]  
 mov [obj_id],ax
 inc si
 mov [fs_data+si],ax  

 inc ax
 mov [c_obj],ax  
 mov al,2
 inc si
 inc si
mov [fs_data+si],al
 mov [obj_type],al
 mov ax,[m_dor]
 mov [srt_dor],ax
 inc si
 mov [fs_data+si],ax  

 mov ax,[m_sek]
 mov [srt_sek],ax
 inc si
 inc si
 mov [fs_data+si],ax  

 mov ax,1
 mov [could_sec],ax
 inc si
 inc si
 mov [fs_data+si],ax 
 mov ax,0
 mov [m_dor],ax
 mov ax,[sfs]
 mov [m_sek],ax
 mov di,fs_data
 call write_sec 
ret


find_fil:
mov si,4
cop_f:
inc si
mov al,[command+si-1]
mov [sfind+si-6],al
cmp si,16
jl cop_f

mov cx,[c_obj]
cmp cx,0
je ex_fnd
mov si,31
cop_fr:
mov al,[fs_data+si]
mov [rfind+si-31],al
inc si
cmp si,47
jle cop_fr
mov si,rfind
call writeln 
mov si,sfind
call writeln 

  




ex_fnd:

ret



read_fs:
 mov di,fs_data
 xor ax,ax
 mov [m_dor],al
 mov al,[sfs] 
 mov [m_sek],al
 call read_sec
ret;

