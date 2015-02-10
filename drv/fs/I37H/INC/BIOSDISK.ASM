;biosdisk.asm
 
 
;LBA HDD read in real mode CPU x86, fasm
 
Read:
 
;your disk enter here manual /ваш номер диска впишите руками здесь
       .BIOS_HDD_NUM = 80h ;BIOS disk num/ номер диска
       .MAX_SECTOR = 2000 ;max value for reading
 
 
 
       call     ReadFatBS
 
       push     si di
;input:
;si = ptr to data (512bytes)
;eax = num of sector (LBA)
       push     di
       call     DisplayToUser ;disp512.asm
 keyWx
       pop      si
       call     DisplayToUser ;disp512.asm
 
 
       pop      di si
       call     DisplayBS_FAT
       ret
 
 
;read sectors BIOS
 
;in:
;es:di - buffer
;eax - LBA sector
;cx - sector count
 
.ReadSectors:
       pusha
       mov      [.packet_Buffer_Segment],es
       mov      [.packet_Buffer_Offset],di
       mov      [.packet_LBA],eax
       mov      [.packet_Sector_Count],cx
       mov      dl,[.DriveNumber]
       mov      si,.packet
       mov      ah,42h
int 13h
       cmp      ah,0
       jne      .Hdd_ErrPopa
 
       mov      eax,[.packet_LBA]
 
       popa
       ret
 
.Hdd_ErrPopa: ;
       popa
       pop      ax ;del ret from call
push ds
pop es
       DbgDspl  ' _HDD_ '
       mov      ax,ER_HDD_READ
jmp       FatalError
 
 
 
.LBASector dd 0 ;абсолютный номер начального сектора
.DriveNumber db .BIOS_HDD_NUM ;BIOS номер диска
.EndNumOfSec dd .MAX_SECTOR
 
.packet db 10h,0
.packet_Sector_Count dw 0
.packet_Buffer_Offset dw 0
.packet_Buffer_Segment dw 0
.packet_LBA dd 0,0
 
.Buf512:
       rb       512
 
 
;EOF
