;;
; Copyright Jacques Deschênes 2019 
; This file is part of STM8_NUCLEO 
;
;     STM8_NUCLEO is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     STM8_NUCLEO is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
;;
;--------------------------------------
        TAB_WIDTH=4 ; default tabulation width 
        EOF=0xff ; end of file marker 
        NLEN_MASK=0xf  ; mask to extract name len 
        KW_TYPE_MASK=0xf0 ; mask to extract keyword type 


	STACK_SIZE=128
	STACK_EMPTY=RAM_SIZE-1  
    INT_SIZE=3 ; int24 size in bytes
    CELL_SIZE=INT_SIZE 
	
    FRUN=0 ; flags run code in variable flags
	FOPT=1 ; run time optimization flag  
    FTIMER=2 ; timer expiration flag  
	FSLEEP=3 ; halt resulting from  SLEEP 
	FBREAK=4 ; break point flag 
	FCOMP=5  ; compiling flags 
    FLN_REJECTED=6 ; a memory full error occured while in *insert_line*. 
    FTRACE=7 ; trace flag 

    LINE_HEADER_SIZE=3 ; line number 2 bytes and line length 1 byte 
    FIRST_DATA_ITEM=LINE_HEADER_SIZE+1 ; skip over DATA_IDX token.

	MAX_LINENO=0x7fff; BASIC maximum line number 


    TIM2_CLK_FREQ=62500

	TIB_SIZE=80
    PAD_SIZE=BLOCK_SIZE 

    NAME_MAX_LEN=15  ; LABLE,CONST and DIM variables maximum length 
    REC_XTRA_BYTES=5 
    REC_LEN_MASK=31

    STDOUT=1 ; output to uart
    BUFOUT=3 ; buffered output  

;--------------------------------------
;   constantes related to Arduino 
;   API mapping 
;-------------------------------------
        INP=0
        OUTP=1 

    EOF=0xff ; end of file marker
    
    TYPE_MASK=0xf0 ; mask to extract data type, i.e. DIM variable symbol  or CONST symbol 
    TYPE_DVAR=(1<<4); DIM variable type 
    TYPE_CONST=(2<<4); CONST data 
    NLEN_MASK=0xf  ; mask to extract name len 
    NONE_IDX = 255 ; not a token 



;--------------------------------------
;   assembler flags 
;-------------------------------------
;    MATH_OVF=0 ; if 1 the stop on math overflow 

    ; assume 16 Mhz Fcpu 
     .macro _usec_dly n 
    ldw x,#(16*n-2)/4 ; 2 cy 
    decw x  ; 1 cy 
    nop     ; 1 cy 
    jrne .-2 ; 2 cy 
    .endm 
    
    ; load X register with 
    ; entry point of dictionary
    ; before calling 'search_dict'
    .macro _ldx_dict dict_name
        ldw x,#dict_name+2
    .endm 

    ; reset BASIC pointer
    ; to beginning of last token
    ; extracted except if it was end of line 
    .macro _unget_token
        decw y
    .endm

    ; extract 16 bits address from BASIC code  
    .macro _get_addr
        ldw x,y     ; 1 cy 
        ldw x,(x)   ; 2 cy 
        addw y,#2   ; 2 cy 
    .endm           ; 5 cy 

    ; alias for _get_addr 
    .macro _get_word 
        _get_addr
        clr a  
    .endm ; 6 cy 

    ; extract character from BASIC code 
    .macro _get_char 
        ld a,(y)    ; 1 cy 
        incw y      ; 1 cy 
    .endm           ; 2 cy 
    
    ; extract next token 
    .macro _next_token 
        _get_char 
    .endm  ; 2 cy 

    ; extract next command token id 
    .macro _next_cmd     
        _get_char       ; 2 cy 
    .endm               ; 2 cy 

    ; get code address in x
    .macro _code_addr 
        clrw x   ; 1 cy 
        ld xl,a  ; 1 cy 
        sllw x   ; 2 cy 
        ldw x,(code_addr,x) ; 2 cy 
    .endm        ; 6 cy 

    ; call subroutine from index in a 
    .macro _call_code
        _code_addr  ; 6 cy  
        call (x)    ; 4 cy 
    .endm  ; 10 cy 

    ; jump to bytecode routine 
    ; routine must jump back to 
    ; interp_loop 
    .macro _jp_code 
        _code_addr 
        jp (x)
    .endm  ; 8 cycles 

    ; jump back to interp_loop 
    .macro _next 
        jp interp_loop 
    .endm ; 2 cycles 
    
;---------------------------------
;  files.asm macros 
;---------------------------------

;----------------------------------
;    file system 
; file header:
;   sign field:  2 bytes .ascii "TB" 
;   program size: 1 word 
;   data: n*BLOCK_SIZE 
;   BLOCK_SIZE is 128 bytes depend 
;   on MCU block erase size. 
;----------------------------------

FILE_SIGN_FIELD = 0 ; signature offset 
FILE_SIZE_FIELD = 2 ; size offset 
FILE_DATA= 4 ; data offset 
FILE_HEADER_SIZE = 4 ; bytes 

;---------------------
; MACRO 
; check if there is 
; an erased program 
; at this address 
; input:
;    X    file header address   
; output:
;    Z    1 erazed
;         0 not erased|not program.  
;--------------------
	.macro _is_erased
	    pushw x 
	    ldw x,(x)
        cpw x,ERASED 
	    popw x 
	.endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MACRO 
;  check for application signature 
; input:
;	x       file header address 
; output:
;   Z      1  signature present 
;          0 no app signature  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .macro _qsign 
	    pushw x 
	    ldw x,(x)
	    cpw x,SIGNATURE ; "PB" 
	    popw x 
	.endm 

;------------------------------------
;  board user LED control macros 
;------------------------------------

    .macro _led_on 
        bset LED_PORT,#LED_BIT 
    .endm 

    .macro _led_off 
        bres LED_PORT,#LED_BIT 
    .endm 

    .macro _led_toggle 
        bcpl LED_PORT,#LED_BIT 
    .endm 

