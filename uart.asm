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



;-------------------------------
	.area CODE 

;--------------------------
; UART receive character
; in a FIFO buffer 
; CTRL+C (ASCII 3)
; cancel program execution
; and fall back to command line
; CTRL+X reboot system 
; CTLR+Z erase EEPROM autorun 
;        information and reboot
;--------------------------
UartRxHandler: ; console receive char 
	btjf UART_SR,#UART_SR_RXNE,5$ 
	ld a,UART_DR 
	cp a,#CAN ; CTRL_X 
	jrne 1$
	_swreset 	
1$:
	push a 
	ld a,#rx1_queue 
	add a,rx1_tail 
	clrw x 
	ld xl,a 
	pop a 
	ld (x),a 
	ld a,rx1_tail 
	inc a 
	and a,#RX_QUEUE_SIZE-1
	ld rx1_tail,a 
5$:	iret 

;---------------------------------------------
; initialize UART, 115200 8N1
; called from cold_start in hardware_init.asm 
; input:
;	none
; output:
;   none
;---------------------------------------------
BAUD_RATE=115200 
	N1=1
	N2=N1+2 
	VSIZE=N2+2
uart_init:
	_vars VSIZE 
; enable UART clock
	bset CLK_PCKENR1,#UART_PCKEN 	
	bres UART,#UART_CR1_PIEN
; baud rate 115200
	mov UART_BRR2,#0xb
	mov UART_BRR1,#0x8 
    clr UART_DR
	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
	bset UART_CR2,#UART_CR2_SBK
    btjf UART_SR,#UART_SR_TC,.
    clr rx1_head 
	clr rx1_tail
	bset UART,#UART_CR1_PIEN
	_drop VSIZE 
	ret


;---------------------------------
; uart_putc
; send a character via UART
; input:
;    A  	character to send
;---------------------------------
uart_putc:: 
	btjf UART_SR,#UART_SR_TXE,.
	ld UART_DR,a 
	ret 


;---------------------------------
; Query for character in rx1_queue
; input:
;   none 
; output:
;   A     0 no charcter available
;   Z     1 no character available
;---------------------------------
qgetc::
uart_qgetc::
	_ldaz rx1_head 
	sub a,rx1_tail 
	ret 
