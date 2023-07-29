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

;-------------------
;   tv terminal 
;-------------------

; cursor shapes 
BLANK=SPACE  
BLOCK=95+32 
UNDERLINE=101+32 
INSERT=102+32 

;-----------------------
; TIMER4 is use to 
; blink TV cursor 
;-----------------------
timer4_init:
; set for millisecond interrupt 
 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
    mov TIM4_PSCR,#7
    mov TIM4_ARR,#155
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset ntsc_flags,#F_CURSOR 
	bset TIM4_IER,#TIM4_IER_UIE
    ret 

CURSOR_DELAY=300 ; msec 
;----------------------------------
; decrement cursro_delay 
; when zero toggle cursor state 
;--------------------------------
timer4_update_handler:
    btjf ntsc_flags,#F_CURSOR,9$ 
    _ldxz cursor_delay 
    decw x 
    _strxz cursor_delay
    jrne 9$ 
    ldw x,#CURSOR_DELAY 
    _strxz cursor_delay 
    btjf ntsc_flags,#F_CUR_VISI,2$ 
    ld a,char_cursor  
    jra 8$ 
2$: ld a,char_under 
8$: 
    call tv_put_char 
    bcpl ntsc_flags,#F_CUR_VISI 
9$: clr TIM4_SR
    iret 

;------------------
; disable tv cursor 
;------------------
tv_disable_cursor:
    bres TIM4_CR1,#TIM4_CR1_CEN 
    bres ntsc_flags,#F_CURSOR 
    bres ntsc_flags,#F_CUR_VISI
    push a 
    _ldaz char_under 
    call tv_put_char 
    pop a 
    ret 

;------------------------------
; enable tv cursor
;-------------------------------
tv_enable_cursor:
    pushw x 
    call get_char_under 
    _straz char_under 
    ldw x,#CURSOR_DELAY  
    _strxz cursor_delay 
    bset ntsc_flags,#F_CURSOR
    bset TIM4_CR1,#TIM4_CR1_CEN  
    popw x 
    ret 


;--------------------------
;  clear tv screen 
;--------------------------
tv_cls:
    pushw x 
    pushw y 
    push a 
    call tv_disable_cursor 
    ld a,#BLOCK 
    _straz char_cursor
    ld a,#BLANK 
    _straz char_under  
    ldw y,#CHAR_PER_LINE*LINE_PER_SCREEN
    ld a,#BLANK  
    call font_char_address
    pushw x 
    ldw x,#video_buffer 
1$: ld a,(1,sp)
    ld (x),a
    ld a,(2,sp)
    ld (1,x),a 
    addw x,#2  
    decw y 
    jrne 1$ 
    _drop 2 
    _clrz cursor_x 
    _clrz cursor_y    
    call tv_enable_cursor 
    pop a 
    popw y 
    popw x 
    ret 

;-------------------------
; put character to 
; tv screen at current 
; cursor position 
; input:
;    A     character 
; output:
;   none   
;--------------------------
tv_put_char:
    pushw x 
    call font_char_address
    pushw x 
    call tv_cursor_pos 
    pop a 
    ld (x),a
    pop a 
    ld (1,x),a      
9$: 
    popw x 
    ret 

;----------------------------
; return character address 
; in font table 
; input:
;     A     character 
; output:
;    X      address 
;---------------------------
font_char_address:
    sub a,#32
    ldw x,#8 
    mul x,a 
    addw x,font_addr 
    ret 

;-------------------------
; get character under cursor 
; output:
;      A    character 
;---------------------------
get_char_under:
    call tv_cursor_pos
    ldw x,(x)
    subw x,font_addr
    ld a,#8
    div x,a 
    ld a,xl 
    add a,#32 
    ret 

;-------------------------
; set cursor column 
; input:
;    X   column 
;-------------------------
set_cursor_column:
    call tv_disable_cursor 
    ld a,#CHAR_PER_LINE
    div x,a 
    _straz cursor_x 
    call tv_enable_cursor 
    ret 

;-------------------------
; set cursor line 
; input:
;    X    line 
;------------------------
set_cursor_line:
    call tv_disable_cursor
    ld a,#CHAR_PER_LINE
    div x,a 
    _straz cursor_y 
    call tv_enable_cursor
    ret 

;------------------------
; return cursor position 
; in  video_buffer
; output:
;   X     addr in video_buffer  
;------------------------
tv_cursor_pos:
    push a 
    _ldaz cursor_y 
    ldw x,#2*CHAR_PER_LINE 
    mul x,a 
    addw x,#video_buffer 
    _ldaz cursor_x 
    sll a 
    _straz acc8  
    _clrz acc16 
    addw x,acc16 
    pop a
    ret 

;-------------------------------
; move cursor 1 character right 
;-------------------------------
tv_cursor_right: 
    push a 
    _incz cursor_x 
    _ldaz  cursor_x 
    cp a,#CHAR_PER_LINE 
    jrmi 9$ 
    call tv_new_line 
9$: 
    pop a 
    ret 

;-------------------------------
; scroll screen up 1 text line 
;-------------------------------
tv_scroll_up:
    pushw x 
    pushw y
    push a  
    bset ntsc_flags,#F_NO_DTR ; block terminal from receiving characters 
    ldw x,#2*(CHAR_PER_LINE*LINE_PER_SCREEN-CHAR_PER_LINE)
    _strxz acc16 
    ldw x,#video_buffer 
    ldw y,x 
    addw y,#2*CHAR_PER_LINE 
    call move
    ld a,#LINE_PER_SCREEN-1 
    call tv_clear_line  
    bres ntsc_flags,#F_NO_DTR 
    pop a 
    popw y 
    popw x
    ret 

;-------------------------------
;  clear tv screen line 
; input:
;   A     line# {0..24}
;-------------------------------
    BLANK_ADR=1 ; address of blank character in font table 
    LINE_OFFSET=BLANK_ADR+2 ; offset of line# in video_buffer 
    VSIZE=LINE_OFFSET+1 
tv_clear_line:
    pushw x 
    pushw y
    _vars VSIZE 
    ldw y,#CHAR_PER_LINE ; fill counter 
; line offset=2*LINE#*CHAR_PER_LINE     
    sll a 
    ldw x,#CHAR_PER_LINE   
    mul x,a ; line offset 
    addw x,#video_buffer
    ldw (LINE_OFFSET,sp),x
    ld a,#BLANK 
    call font_char_address
    ldw (BLANK_ADR,sp),x
    ldw x,(LINE_OFFSET,sp) 
0$: ld a,(BLANK_ADR,sp)
    ld (x),a 
    ld a,(BLANK_ADR+1,sp)
    ld (1,x),a 
    addw x,#2 
    decw y 
    jrne 0$
    _drop VSIZE 
    popw y 
    popw x  
    ret 

;---------------------------
; send cursor at beginning 
; of next line 
;---------------------------
tv_new_line:
    push a 
    _clrz cursor_x   
    _incz cursor_y
    _ldaz cursor_y 
    cp a,#LINE_PER_SCREEN 
    jrmi 9$ 
    _decz cursor_y
    call tv_scroll_up
9$: 
    pop a 
    ret  

;---------------------------
; if cursor_x>0 delete 
; character left 
;---------------------------
tv_delback:
    push a 
    tnz cursor_x 
    jreq 9$ 
    _decz cursor_x 
    ld a,#BLANK 
    call tv_put_char
9$: pop a    
    ret 

;--------------------------
; print a character to tv 
; screen or execute 
; control sequence 
; input:
;    A     character 
;---------------------------
tv_print_char:
    call tv_disable_cursor
    and a,#127 
    cp a,#SPACE  
    jrpl 8$ 
    cp a,#CTRL_E
    jrne 0$
    bcpl ntsc_flags,#F_LECHO
    jra 9$ 
0$: 
    cp a,#BS 
    jrne 1$ 
    call tv_delback
    jra 9$ 
1$: cp a,#LF 
    jrne 3$ 
2$:
    call tv_new_line 
    jra 9$ 
3$: cp a,#CR 
    jreq 2$
    cp a,#ESC 
    jrne 9$ 
    call uart_getc
    cp a,#'c 
    jrne 4$
    clr a  
    call tv_cls 
    jra 9$
4$: cp a,#'[
    jrne 9$ 
    call process_csi 
    jra 9$         
8$: 
    call tv_put_char
    call tv_cursor_right
9$:
    call tv_enable_cursor
    ret 


;------------------------------------
; sequence control introducer
; received, process control sequence 
;------------------------------------
; csi parameters 
    PN=1 ; first parameter 
    PM=PN+2  ; second parameter
    VSIZE=PM+1 
process_csi:
    _vars VSIZE
; first parameter 
    call get_parameter 
    ldw (PN,sp),x
    cp a,#';
    jrne 2$      
; second parameter     
    call get_parameter 
    ldw (PM,sp),x
2$:; recognize 'A','B','C','D','G','d' and 'H' 
    cp a,#'G 
    jrne 3$ 
; put cursor a column
    ldw x,(PN,sp) ; Pn e|{1..62}
    jreq 22$ 
    decw x 
22$:
    ld a,#CHAR_PER_LINE
    call set_cursor_column
    jp 9$ 
3$:    
    cp a,#'d 
    jrne 4$ 
; put cursor at line 
    ldw x,(PN,sp) ; Pn e|{1..25}
    jreq 32$ 
    decw x 
32$:
    call set_cursor_line
    jp 9$ 
4$:
    cp a,#'H 
    jrne 5$ ; ignore it 
; put cusor at line and column 
    ldw x,(PN,sp)
    jreq 42$ 
    decw x 
42$: 
    call set_cursor_line
    ldw x,(PM,sp)
    jreq 44$ 
    decw  x 
44$:
    call set_cursor_column
    jra 9$ 
5$: ; move cursor n lines up 
    cp a,#'A 
    jrne 6$ 
    ldw x,(PN,sp) 
    jrne 52$ 
    incw x 
52$:
    ld a,#LINE_PER_SCREEN 
    div x,a 
    _straz acc8 
    _ldaz cursor_y  
    sub a,acc8  
    jrnc 66$  
    clr a 
    jra 66$ 
6$: ; move cursor n line down 
    cp a,#'B 
    jrne 7$ 
    ldw x,(PN,sp)
    jrne 62$ 
    incw x
62$: 
    ld a,#LINE_PER_SCREEN 
    div x,a 
    add a,cursor_y 
    cp a,cursor_y 
    jrult 64$ 
    cp a,#LINE_PER_SCREEN
    jrult 66$       
64$: 
    ld a,#LINE_PER_SCREEN-1
66$:
    clrw x 
    ld xl,a 
    call set_cursor_line
    jra 9$ 
7$: ; move cursor n spaces right 
    cp a,#'C 
    jrne 8$ 
    ldw x,(PN,sp)
    jrne 72$ 
    incw x 
72$:
    ld a,#CHAR_PER_LINE
    div x,a 
    add a,cursor_x 
    cp a, cursor_x 
    jrult 74$
    cp a,#CHAR_PER_LINE 
    jrmi 76$
74$: 
    ld a,#CHAR_PER_LINE-1
76$:
    clrw x 
    ld xl,a 
    call set_cursor_column 
    jra 9$ 
8$: ; move cursor n spaces left 
    cp a,#'D 
    jrne 9$ 
    ldw x,(PN,sp) 
    jrne 82$
    incw x 
82$:
    ld a,#CHAR_PER_LINE
    div x,a 
    _straz acc8 
    _ldaz cursor_x  
    sub a,acc8  
    jrnc 76$ 
    clr a  
    jra 76$ 
9$:
    _drop VSIZE 
    ret 


;----------------------
; get control sequence 
; parameter 
; output:
;    A     last character 
;    X     parameter  
;----------------------
    DIGIT=1 
    PM=DIGIT+2 
    VSIZE=PM+1
get_parameter:
    _vars VSIZE 
    clrw x 
    ldw (DIGIT,sp),x 
    ldw (PM,sp),x 
1$: 
    call uart_getc 
    call is_digit 
    jrnc 2$ 
    sub a,#'0
    ld (DIGIT+1,sp),a 
    ld a,#10
    ldw x,(PM,sp)
    mul x,a 
    addw x,(DIGIT,sp)
    ldw (PM,sp),x 
    jra 1$ 
2$:
    ldw x,(PM,sp)
    _drop VSIZE 
    ret 


;------------------------
;  print string to tv 
; input:
;   X      *string
;-------------------------
tv_puts:
    push a
1$:     
    ld a,(x)
    jreq 9$ 
    call tv_print_char  
    incw x 
    jra 1$ 
9$: pop a 
    incw x 
    ret 

;-------------------------
; receive characters from 
; translate scan codes 
; from local keyboard and 
; send them to UART TX 
; 
; character received from 
; UART RX are sent to 
; tv_term for processing. 
; 
; This is the application 
; main program and 
; never exit.
;--------------------------
main:
    call keyboard_read
    jreq 2$
    btjf ntsc_flags,#F_LECHO,1$ 
    push a 
    call tv_print_char
    pop a 
1$:    
    call uart_putc
2$: 
    call uart_qgetc
    jreq main 
    call uart_getc  
    call tv_print_char
    jra main 
