;
; Copyright Jacques Deschênes 2023 
; This file is part of stm8_terminal 
;
;     stm8_terminal is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_terminal is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
;;

TV_VAR_ORG=PS2_VAR_ORG+PS2_VAR_SIZE
;------------------------------
    .area DATA 
    .org TV_VAR_ORG 
;-----------------------------

; values based on 14.318Mhz crystal

CHAR_PER_LINE=40 
LINE_PER_SCREEN=25 
VISIBLE_SCAN_LINES=200 

FR_HORZ=15734
HLINE=(FMSTR*1000/FR_HORZ-1); horizontal line duration 
HALF_LINE=HLINE/2 ; half-line during sync. 
EPULSE=32 ; pulse width during pre and post equalization
VPULSE=387 ; pulse width during vertical sync. 
HPULSE=66 ; horizontal line sync pulse width. 

; ntsc synchro phases 
PH_PRE_EQU=0 ; pre vsync equalization pulses 
PH_VSYNC=1    ; vertical sync pulses 
PH_POST_EQU=2 ; post vertical sync equalization pulse 
PH_PRE_VID=3  ; pre video lines 
PH_VIDEO=4    ; video lines 
PH_POST_VID=5 ; post video lines 

FIRST_VIDEO_LINE=50 
VIDEO_LINES=200 

;ntsc flags 
F_EVEN=0 ; odd/even field flag 

ntsc_flags: .blkb 1 
ntsc_phase: .blkb 1 ; 
video_line: .blkw 1 ; video lines {0..262} 

TV_VAR_SIZE=.-ntsc_flags 

;-------------------------------
    .area CODE 
;------------------------------

;------------------------------
; initialize TIMER1 for 
; NTSC synchronisation 
; signal 
;------------------------------
ntsc_init:
    _clrz ntsc_flags 
    _clrz ntsc_phase 
; set PD3 as output 
    bset PC_DDR,#6 
    bres PC_ODR,#6    
.if 1
; initialize SPI for video pixel shift out 
	bset CLK_PCKENR1,#CLK_PCKENR1_SPI ; enable clock signal 
; ~CS line controlled by sofware 	
	mov SPI_CR2,#(1<<SPI_CR2_SSM)|(1<<SPI_CR2_SSI)
    clr SPI_SR 
    clr SPI_DR 
    mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR)
.endif 
; initialize timer1 for pwm 
    mov TIM1_IER,#1 ; UIE set 
    bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
    mov TIM1_CCMR1,#(7<<TIM1_CCMR1_OCMODE) |(1<<TIM1_CCMR1_OC1PE)
    bset TIM1_CCER1,#0
    bset TIM1_BKR,#7
; begin with PH_PRE_EQU odd field 
    _clrz ntsc_phase 
    mov TIM1_ARRH,#HLINE>>8 
    mov TIM1_ARRL,#HLINE&0XFF
    mov TIM1_CCR1H,#HPULSE>>8 
    mov TIM1_CCR1L,#HPULSE&0XFF
    bset TIM1_CR1,#TIM1_CR1_CEN
    bset TIM1_EGR,#TIM1_EGR_UG      
;--------------------
; test code 
; fill video_buffer 
;-------------------
    ldw x,#1000
    pushw X
    ldw x,#video_buffer 
0$: clr a 
1$: ld (x),a 
    inc a 
    cp a,#100 
    jrmi 2$ 
    clr a 
2$: incw x 
    dec (2,sp)
    jrne 1$ 
    dec (1,sp)
    jrne 1$
    popw x 
    ret 


;-------------------------------
; TIMER1 update interrupt handler 
; interrupt happend at end 
; of each phase and and pwm 
; is set for next phase 
;-------------------------------
ntsc_sync_interrupt:
    clr TIM1_SR1 
    _ldxz video_line 
    incw x 
    _strxz video_line 
    _ldaz ntsc_phase 
    cp a,#PH_PRE_EQU 
    jrne test_vsync 
; pre equalization pulses
    cpw x,#1 
    jrne 1$ 
    mov TIM1_ARRH,#HALF_LINE>>8 
    mov TIM1_ARRL,#HALF_LINE&0xff
    mov TIM1_CCR1H,#EPULSE>>8 
    mov TIM1_CCR1L,#EPULSE&0xff 
    jra 2$  
1$: cpw x,#6
    jrne 2$
    inc a 
2$:
    jp sync_exit       
test_vsync:
    cp a,#PH_VSYNC 
    jrne test_post_equ
    cpw x,#7 
    jrne 1$ 
    mov TIM1_CCR1H,#VPULSE>>8 
    mov TIM1_CCR1L,#VPULSE&0xff 
    jra 2$ 
1$: cpw x,#12 
    jrne 2$ 
    inc a 
2$: 
    jp sync_exit     
test_post_equ:
    cp a,#PH_POST_EQU 
    jrne test_pre_video 
    cpw x,#13 
    jrne 1$ 
    mov TIM1_CCR1H,#EPULSE>>8 
    mov TIM1_CCR1L,#EPULSE&0xff 
    jra 4$
1$:    
    cpw x,#18 
    jrne 3$ 
    btjt ntsc_flags,#F_EVEN,4$
    mov TIM1_ARRH,#HLINE>>8 
    mov TIM1_ARRL,#HLINE&0xff
    jra 4$ 
3$: 
    cpw x,#19 
    jrne 4$
    mov TIM1_ARRH,#HLINE>>8 
    mov TIM1_ARRL,#HLINE&0xff
    mov TIM1_CCR1H,#HPULSE>>8 
    mov TIM1_CCR1L,#HPULSE&0xff  
    inc a 
    ldw x,#9
4$: 
    jra sync_exit 
test_pre_video:
    cp a,#PH_PRE_VID 
    jrne test_video 
    cpw x,#FIRST_VIDEO_LINE-1 
    jrne sync_exit 
    inc a
    jra sync_exit  
test_video: 
    cp a,#PH_VIDEO
    jrne post_video 
    cpw x,#FIRST_VIDEO_LINE
    jrne 1$ 
    bset TIM1_IER,#TIM1_IER_CC1IE
    bres TIM1_IER,#TIM1_IER_UIE
    inc a 
1$:  
    jra sync_exit     
post_video: 
;    cpw x,#262
;    jreq 1$  
    cpw x,#262
    jrmi 2$
    btjt ntsc_flags,#F_EVEN,1$  
    mov TIM1_ARRH,#HALF_LINE>>8 
    mov TIM1_ARRL,#HALF_LINE & 0xff
;    jra sync_exit  
1$: clr a 
    clrw x
    _strxz video_line 
    bcpl ntsc_flags,#F_EVEN
    jra sync_exit  
2$: 
sync_exit:
    _straz ntsc_phase 
    iret 


;----------------------------------
; TIMER1 compare interrupt handler
;----------------------------------
    FONT_LINE=1 
    CH_PER_LINE=FONT_LINE+2 
    VSIZE=CH_PER_LINE  
ntsc_video_interrupt:
    _vars VSIZE
    clr (FONT_LINE,sp) 
    ld a,#36; CHAR_PER_LINE  
    ld (CH_PER_LINE,sp),a  
    clr TIM1_SR1    
; line delay 
0$: ldw x,TIM1_CNTRH  
    cpw x,#HPULSE+25
    jrmi 0$
; compute postion in buffer 
; X=video_line/8*40+video_buffer  
; FONT_LINE=video_line%8+font_6x8     
    _ldxz video_line 
    subw x,#FIRST_VIDEO_LINE
    ld a,#8 
    div x,a
    ld (FONT_LINE+1,sp),a    
    ld a,#40 
    mul x,a  ; video_buffer line  
    addw x,#video_buffer
    ldw y,#font_6x8
    addw y,(FONT_LINE,sp)
    ldw (FONT_LINE,sp),y 
1$:
    ld a,(x) ; 1 cy 
; character offset in table 8*char    
    clrw y   ; 1 cy 
    ld yl,a  ; 1 cy 
    ld a,#8  ; 1 cy 
    mul y,a ; 4 cy 
; add FONT_LINE  
    addw y,(FONT_LINE,sp) ; 2 cy 
;    ld a,(y)  ; 1 cy 
ld a,#0xAA 
    btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy  
    ld SPI_DR,a  ; 1 cy 
    incw x  ; 1 cy 
    dec (CH_PER_LINE,sp) ; 1 cy 
    jrne 1$  ; 2 cy 
    btjt SPI_SR,#SPI_SR_BSY,. 
    clr SPI_DR  
    _ldxz video_line 
    incw x 
    _strxz video_line 
    cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES 
    jrmi 2$ 
    bres TIM1_IER,#TIM1_IER_CC1IE
    bset TIM1_IER,#TIM1_IER_UIE
2$:
    _drop VSIZE 
    iret 


