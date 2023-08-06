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
;------------------------------------
;   1 start bit 
;   8 data bits 
;   1 parity bit odd 
;   1 stop bit 
;
;   least bit sent first 
;   host read bit when clock low  
;------------------------------------

; keyboard port registers 
PS2_PORT=PB_BASE
PS2_ODR=PB_ODR 
PS2_IDR=PB_IDR 
PS2_CR1=PB_CR1 
PS2_CR2=PB_CR2 
PS2_DDR=PB_DDR 
; keyboard pins 
PS2_CLK=0  ; PB:0 
PS2_DATA=1 ; PB:1 

; kbd_state flags 
F_SEND = 0 ; host sending command to keyboard 
F_NUM =	1 ; numlock kbd_leds
F_CAPS = 2 ; capslock kbd_leds
F_SHIFT =	3  ; SHIFT key down 
F_CTRL =	4  ; CTRL key down 
F_ALT =	5  ; ALT key down 
F_ACK	=	6  ;  ACK code received 
F_BATOK =	7  ; BAT_OK code received 	
	
; rxflags  
F_XT =	1    ; extended code 
F_REL =	2    ; key released code 
F_RX_ERR = 4 ; receive error 

; scan code receive phases 
WAIT_START=0
DATA_BIT=1 
PARITY_BIT=2 
STOP_BIT=3 
; transmit byte to keyboard phases 
SEND_BITS=0 
SEND_PARITY=1 
SEND_STOP=2
RCV_ACK=3 

;--------------------------------
    .area CODE 


;--------------------------
; initialize PS/2 keyboard 
; interface 
;--------------------------
ps2_init:
; set external interrupt
; on ps2_clk falling edge 
; set as input 
    bres PS2_DDR,#PS2_CLK 
    bres PS2_DDR,#PS2_DATA
; remove internal pull up
; make it open drain when in output mode      
    bres PS2_CR1,#PS2_CLK 
    bres PS2_CR1,#PS2_DATA 
; enable external interrup on PB falling edge only 
    mov EXTI_CR1,#(2<<2) 
; enable TIMER4 clock 
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4

; enable external interrupt on PS2_CLK        
    bset PS2_CR2,#PS2_CLK   
; reset all variables      
    _clrz sc_qhead 
    _clrz sc_qtail
    _clrz sc_rx_flags 
    _clrz sc_rx_phase 
    _clrz kbd_queue_head 
    _clrz kbd_queue_tail
    _clrz kbd_state 
    ret 

;------------------------------
;  keyboard received 
;  handler 
;  interrupt on PB:0 
;-------------------------------
ps2_intr_handler: 
    _ldaz sc_rx_phase
    cp a,#WAIT_START 
    jreq rx_start_bit
    cp a,#DATA_BIT
    jreq rx_data_bit
    cp a,#PARITY_BIT 
    jreq rx_parity_bit 
    cp a,#STOP_BIT 
    jreq rx_stop_bit
sc_rx_error:
    bset sc_rx_flags,#F_RX_ERR 
    _clrz sc_rx_phase 
    iret         
rx_start_bit:
    btjt PS2_IDR,#PS2_DATA,sc_rx_error
    bres sc_rx_phase,#F_RX_ERR  
    ld a,#128 
    _straz in_byte 
    _clrz parity 
    _incz sc_rx_phase 
    iret  
rx_data_bit:
    btjf PS2_IDR,#PS2_DATA,1$
    _incz parity 
1$: 
    rrc in_byte 
    jrnc 9$ 
    _incz sc_rx_phase 
9$: iret 
rx_parity_bit:
    btjf PS2_IDR,#PS2_DATA,1$
    _incz parity 
1$:      
    _incz sc_rx_phase 
    iret  
rx_stop_bit: 
    btjf PS2_IDR,#PS2_DATA,sc_rx_error 
; check parity, bit 0, should be set  
    btjf parity,#0,sc_rx_error 
    _clrz sc_rx_phase 
    call store_scan_code 
    iret 

;----------------------------------
; host send a byte to keyboard
; input:
;   A      byte to send 
;----------------------------------
    .macro _wait_ack 
    btjf kbd_state,#F_ACK,. 
    .endm 

    .macro _wait_clk_low
    btjt PS2_IDR,#PS2_CLK,. 
    .endm 

    .macro _wait_clk_high 
    btjf PS2_IDR,#PS2_CLK,. 
    .endm 

    .macro _wait_kbd_clk 
        _wait_clk_high 
        _wait_clk_low 
    .endm 

send_to_keyboard:
    _straz out_byte 
    mov tx_bit_cntr,#8
    _clrz tx_parity
; disable video output 
    clr a 
    call video_on_off 
; take control of clock line 
    bset PS2_DDR,#PS2_CLK
    bres PS2_ODR,#PS2_CLK 
; set TIMER4 for 150µsec delay 
; base on 20Mhz sysclock 
    bres TIM4_CR1,#TIM4_CR1_CEN
    mov TIM4_PSCR,#4 ; Fsys/16 
    mov TIM4_ARR,#69 
	clr TIM4_SR 
    mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
    btjf TIM4_SR,#TIM4_SR_UIF,.
	bres TIM4_CR1,#TIM4_CR1_CEN 
;take control of data line
; and reset it, start bit 
    bset PS2_DDR,#PS2_DATA 
    bres PS2_ODR,#PS2_DATA 
; release clock line 
    bres PS2_DDR,#PS2_CLK
1$: ; data bit loop 
    _wait_clk_high  
    _wait_clk_low
    srl out_byte 
    bccm PS2_ODR,#PS2_DATA
    jrnc 2$ 
    _incz tx_parity
2$: 
    _decz tx_bit_cntr 
    jrne 1$ 
; send parity bit
    _wait_kbd_clk 
    srl tx_parity 
    ccf 
    bccm PS2_ODR,#PS2_DATA 
; send stop bit, release data line  
    _wait_kbd_clk 
    bres PS2_DDR,#PS2_DATA
    _wait_clk_high
; wait for both lines low 
3$:
    ld a,PS2_IDR 
    and a,#(1<<PS2_CLK)|(1<<PS2_DATA)
    jrne 3$ 
; wait both lines high 
4$: ld a,PS2_IDR 
    and a,#(1<<PS2_CLK)|(1<<PS2_DATA)
    cp a,#(1<<PS2_CLK)|(1<<PS2_DATA)
    jrne 4$ 
; enable interrupts 
    ld a,#1 
    call video_on_off
    call timer4_init 
    ret 

;------------------------
; expect a ACK from 
; keyboard 
;------------------------
wait_ack:
    clrw x 
1$: btjt kbd_state,#F_ACK,9$
    decw x
    jrne 1$ 
9$:
    ret 

;-------------------------
; set keyboard LED state 
; input:
;    A    LEDs state 
;         CAPSLOCK bit 0 
;         NUMLOCK  bit 1 
;         SCRLOCK bit 2 
;-------------------------
set_kbd_leds:
    push a 
    ld a,#KBD_LED
    bres kbd_state,#F_ACK 
    call send_to_keyboard 
    call wait_ack
    btjf kbd_state,#F_ACK,reset_kbd  
    pop a 
    bres kbd_state,#F_ACK 
    call send_to_keyboard
    call wait_ack 
    btjf kbd_state,#F_ACK,reset_kbd  
    ret 

;--------------------------
; send reset command 
; to keyboard 
;--------------------------
reset_kbd:
    ld a,#KBD_RESET 
    call send_to_keyboard
    ret 


;----------------
; store in_byte 
; in sc_queue 
;---------------
store_scan_code:
    ld a,#KBD_ACK 
    cp a,in_byte 
    jrne 1$
    bset kbd_state,#F_ACK 
    jra 9$
1$:
    ld a,#BAT_OK 
    cp a,in_byte 
    jrne 2$ 
    bset kbd_state,#F_BATOK 
    jra 9$ 
2$:
    ld a,#sc_queue
    add a,sc_qtail 
    clrw x 
    ld xl,a 
    _ldaz in_byte 
    ld (x),a 
    _ldaz sc_qtail
    inc a 
    and a,#SC_QUEUE_SIZE-1 
    _straz sc_qtail  
9$:
    ret 

;----------------------
; get scan code 
; from sc_queue 
; output:
;    A    scan_code 
;----------------------
fetch_scan_code:
    ld a,sc_qhead 
    cp a,sc_qtail 
    jrne 1$
    clr a 
    ret 
1$: pushw x 
    add a,#sc_queue 
    clrw x 
    ld xl,a  
    ld a,(x)
    push a 
    _ldaz sc_qhead 
    inc a 
    and a,#SC_QUEUE_SIZE-1 
    _straz sc_qhead 
    pop a 
    popw x 
    tnz a 
    ret 

;-------------------------------
; wait until scan code available 
;-------------------------------
wait_next_code:
    call fetch_scan_code
    jreq wait_next_code 
    ret 

;------------------------
; check if key is any of 
; SHIFT,CTRL,ALT, CAPSLOCK,NUMLOCK   
; set flag if required 
; input:
;   A     code 
; output:
;   A     code|| 0
;------------------------
state_flag:
    cp a,#VK_CAPS 
    jrne 0$ 
    btjt sc_rx_flags,#F_REL,89$
    bcpl kbd_state,#F_CAPS 
12$:
    ld a,kbd_state
    and a,#(1<<F_CAPS)|(1<<F_NUM)
    call set_kbd_leds 
    jra 89$ 
0$:
    cp a,#VK_NUM
    jrne 14$
    btjt sc_rx_flags,#F_REL,89$
    bcpl kbd_state,#F_NUM  
    jra 12$ 
14$: 
    cp a,#VK_LSHIFT 
    jrne 1$
    jra 2$ 
1$:    
    cp a,#VK_RSHIFT 
    jrne 3$ 
2$: 
    ld a,#(1<<F_SHIFT) 
    jra 84$ 
3$: cp a,#VK_LALT 
    jrne 4$ 
    jra 5$ 
4$: cp a,#VK_RALT 
    jrne 6$ 
5$:
    ld a,#(1<<F_ALT)
    jra 84$ 
6$: cp a,#VK_LCTRL 
    jrne 7$ 
    jra 8$ 
7$: cp a,#VK_RCTRL 
    jrne 9$ 
8$: ld a,#(1<<F_CTRL)
84$:
    btjt sc_rx_flags,#F_REL,86$  
    or a, kbd_state
    jra 88$ 
86$: 
    cpl a 
    and a,kbd_state
88$:
     _straz kbd_state 
89$:
    clr a 
9$: 
    btjf sc_rx_flags,#F_REL,10$ 
    clr a 
10$:
    tnz a 
    ret 

;----------------------------------
; modify charcter if 
; SHIFT key is down 
; LEFT and RIGHT keys considered same.
; input:
;   A    character in
; output:
;   A    character out
;   C    set if SHIFT key down   
;----------------------------------- 
; input:
;    A     letter 
; output:
;    A      letter 
;------------------------
if_shifted:
    pushw x 
    call is_alpha 
    jrnc 4$
    xor a,#32 ; default to lower 
    btjf kbd_state,#F_CAPS,1$ 
    xor a,#32 
1$:
    btjf kbd_state,#F_SHIFT,2$ 
    xor a,#32
    scf  
2$: jra 9$ 
4$: ; not letter search shifted_table 
    btjf kbd_state,#F_SHIFT,9$ 
    ldw x,#shifted_codes 
    call table_lookup 
    scf 
9$: popw x 
    ret 

;----------------------------------
; modify charcter if 
; CTRL key is down 
; LEFT and RIGHT keys considered same.
; input:
;   A    character in
; output:
;   A    character out
;   C    set if CTRL key down  
;----------------------------------- 
if_ctrl_down:
    pushw x 
    rcf 
    btjf kbd_state,#F_CTRL,9$ 
    call is_alpha 
    jrnc 2$
    sub a,#'a-1 ; CTRL+letter converted to {1..26}
    jra 3$
2$:
    ldw x,#control_codes
    call table_lookup
3$: 
    scf 
9$: popw x 
    ret 

;----------------------------------
; modify charcter if 
; ALT key is down 
; LEFT and RIGHT keys considered same.
; input:
;   A    character in
; output:
;   A    character out
;   C    set if ALT key down   
;----------------------------------- 
if_alt_down:
    pushw x 
    rcf 
    btjf kbd_state,#F_ALT,9$ 
    ldw x,#altchar_codes
    call table_lookup
    scf 
9$: popw x 
    ret 

;-------------------------
; search scan code 
; in table 
; input: 
;   A    scan code 
;   X    table 
; output:
;   A    0||ASCII||VK_KEY 
;   C    0 not found | 1 found 
;-------------------------
table_lookup: 
    push a 
1$:
    ld a,(x)
    jreq 7$ 
    cp a,(1,sp)
    jreq 8$ 
    addw x,#2 
    jra 1$ 
7$: ld a,(1,sp)
    rcf 
    jra 9$ 
8$: ld a,(1,x)
    scf 
9$: _drop 1 
    ret 


;---------------------
; translate scan code 
; to ASCII 
; input:
;   A    scan code 
; output:
;   A     ASCII code 
;---------------------
translate_code:
    pushw x 
    bres sc_rx_flags,#F_REL 
    ldw x,#std_codes 
    cp a,#XT_KEY 
    jrne 1$ 
    ldw x,#xt_codes
0$: 
    call wait_next_code  
1$:
    cp a,#KEY_REL 
    jrne 2$
    bset sc_rx_flags,#F_REL 
    jra 0$ 
2$: call table_lookup
    jrc 3$ 
    clr a 
    jra 9$ 
3$:
    call state_flag 
    jreq 9$ 
    call if_shifted
    jrc 9$ 
    call if_ctrl_down
    jrc 9$ 
    call if_alt_down  
9$:
    popw x
    tnz a  
    ret 


;---------------------------
;  check sc_queue for code 
;  translate to ASCII 
;  if availaible 
; output:
;   A     ASCII 
;--------------------------
keyboard_read:
    call fetch_scan_code
    jreq 9$ 
    call translate_code 
9$:
    ret 



 



    
