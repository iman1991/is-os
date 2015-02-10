;video.asm
 
 
PRINT_ON = 0x09a
PRINT_OFF = 0x0f7
 
 
int_table:
dw video_0_print ;ax=0
dw video_1_off ;ax=1
dw video_1_on ;ax=2
 
macro end_video
{
       jmp      int_exit ;intman.asm
}
 
 
video_0_print:
cmp byte [on_off_switch], PRINT_ON
jz .work
      end_video
.work:
 
 
       push     es
;restore ds
       mov      word ax,[saveall16_seg_regs.ds_reg]
       mov      es,ax
;restore si
       mov      dword esi,[saveall32regs.esireg]
       mov      di,msg_buf
.l1:
mov byte al,[es:si]
       mov      [di],al
       inc      di
       inc      si
       cmp      al,0
       jnz      .l1
       mov      si,msg_buf
       call     print
       pop      es
       end_video
on_off_switch db PRINT_ON
msg_buf rb 80
 
video_1_off: ;ax=1
 
mov byte [on_off_switch], PRINT_OFF
 
       end_video
 
 
video_1_on: ;ax=2
 
mov byte [on_off_switch], PRINT_ON
 
       end_video
 
 
 
;EOF
