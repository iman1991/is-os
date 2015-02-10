;intman.asm
 
 
       macro    saveall
       {
 
       mov      dword [saveall32regs.eaxreg],eax
       mov      word [saveall16_seg_regs.sp_reg],sp
 
       mov      dword [saveall32regs.ebxreg],ebx
       mov      dword [saveall32regs.edxreg],edx
       mov      dword [saveall32regs.ecxreg],ecx
       mov      dword [saveall32regs.esireg],esi
       mov      dword [saveall32regs.edireg],edi
       pop      ax
       push     ax
       mov      word [saveall16_seg_regs.ds_reg],ax
       push     es
       pop      ax
       mov      word [saveall16_seg_regs.es_reg],ax
       push     fs
       pop      ax
       mov      word [saveall16_seg_regs.fs_reg],ax
       push     gs
       pop      ax
       mov      word [saveall16_seg_regs.gs_reg],ax
       }
 
new_handler:
       pushad
       push     ds ;!saveall ds берёт из стека
       push     cs
       pop      ds
       saveall  ;сохраняем всё
       mov      dword eax,[saveall32regs.eaxreg]
       shl      ax,1 ;x2
       mov      bx,int_table ;в файле table.asm
       add      bx,ax
       jmp      word [bx]
 
int_exit:
       mov      word sp,[saveall16_seg_regs.sp_reg]
 
       pop      ds
       popad
 
push ds
push cs
pop ds
mov al,byte [ExitCod]
mov ecx,dword [szFileBytes]
pop ds
cld
       iret
 
ExitCod db 0
szFileBytes dd 0
 
 
saveall32regs:
.eaxreg dd 0
.ebxreg dd 0
.edxreg dd 0
.ecxreg dd 0
.esireg dd 0
.edireg dd 0
saveall16_seg_regs:
.ds_reg dw 0
.es_reg dw 0
.fs_reg dw 0
.gs_reg dw 0
.sp_reg dw 0
 
;EOF
