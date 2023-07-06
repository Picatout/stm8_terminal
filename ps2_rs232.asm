;;
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

    .area DATA 
queue:  .blkb 0x20
in_queue: .blkb 16  ; scan codes queue 

qhead: .blkb 1  ; in_queue head index 
qtail: .blkb 1  ; in_queue tail index 
bitcntr: .blkb 1  ; receive code bit counter 
in_byte: .blkb 1  ; receive byte shift in buffer 
parity: .blkb 1   ; receive parity bit 
cmd: .blkb 1      ; cmd code sent to keyboard 
kbd_state: .blkb 1; keyboard alteration keys state 
rxflags: .blkb 1  ; boolean flags for convertion to ASCII 
t0: .blkb 1    ; temporary storage 
t1: .blkb 1    ; temporary storage 
 
    .area CODE 


    .include "ascii.inc"
    .include "ps2_codes.inc"


; kbd_state flags 
F_SCRLL =	0 ; scroll lock kbd_leds
F_NUM =	1 ; numlock kbd_leds
F_CAPS =	2 ; capslock kbd_leds
F_SHIFT =	3  ; shift kbd_leds
F_CTRL =	4  ; left CTRL key down 
F_ALT =	5  ; ALT key down 
F_ACK	=	6  ;  ACK code received 
F_BATOK =	7  ; BAT_OK code received 	
	
; rxflags  
F_XT =	1    
F_REL =	2
F_RX_ERR = 4
 
 
;;;;;;;;;;;;;;;;;;;;
;   macros
;;;;;;;;;;;;;;;;;;;;
 
    .macro case n, label
    cp a,#n
    jrne .+2
    jra label
    .endm
    
    .macro search table
    _ldaz t0 
    _clrz t1 
    call table
    .endm
 
    .area CODE 

;;;;;;;;;;;;;;;;;;;;;;
;  point d'entr�e
;  r�initialisation
;  du MCU
;;;;;;;;;;;;;;;;;;;;;;;    
rst:
    banksel ANSELA
    clrf ANSELA
    clrwdt
    goto init
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;
; service d'intterruption
;;;;;;;;;;;;;;;;;;;;;;;;;    
; cette interruption est d�clench�e
; lorsque le signal clock du clavier
; passe � 0.    
; chaque interruption re�oit
; 1 bit du clavier
; lorsque la r�ception d'un octet est
; compl�t�e s'il n'y a pas d'erreur
; de r�ception l'octet est sauvegard� 
; dans la file 'in_queue'  
; 2018-01-19:
;   ajout de receive_error pour resynchroniser
;   avec le clavier lorsque le start bit n'est pas
;   � z�ro ou le stop bit � 1.    
isr:
    ; remet � z�ro l'indicateur d'interruption
    banksel IOCAF
    movlw 255
    xorwf IOCAF,W
    andwf IOCAF,F
    banksel PORTA
    movfw bitcntr
    skpnz
    bra start_bit
    xorlw 2
    skpnz
    bra parity_bit
    movfw bitcntr
    xorlw 1
    skpnz
    bra stop_bit
    lsrf in_byte,F
    btfss PORTA,KBD_DAT
    bra isr_exit
    bsf in_byte,7
    incf parity,F
    bra isr_exit
parity_bit:
    btfsc PORTA,KBD_DAT
    incf parity,F
    bra isr_exit
stop_bit:
    btfss PORTA,KBD_DAT
    bra receive_error ; erreur de r�ception, code non retenu.
parity_check:  
    btfss parity,0
    bra parity_error ; erreur de parit�, code non retenu.
    movlw BAT_OK
    xorwf in_byte,W
    skpz
    bra $+3
    bsf kbd_state,F_BATOK
    bra isr_exit
    movlw KBD_ACK
    xorwf in_byte,W
    skpz
    bra $+3
    bsf kbd_state,F_ACK
    bra isr_exit
    movlw KBD_RESEND
    xorwf in_byte,W
    skpz
    bra $+3
    bcf kbd_state,F_ACK
    bra isr_exit
    movlw in_queue
    movwf TAIL_PTRL
    movfw qtail
    addwf TAIL_PTRL,F
    movfw in_byte
    movwf QUEUE_TAIL
    incf qtail,F
    movlw 15
    andwf qtail,F
    bra isr_exit
start_bit:
    btfsc PORTA,KBD_DAT
    bra receive_error
    clrf parity
    movlw 11
    movwf bitcntr
isr_exit:
    decf bitcntr,F
    retfie

; en cas d'erreur de parit�e
parity_error:
    clrf rxflags
    retfie
    
; en cas d'erreur de r�ception du clavier
; r�initialise
receive_error:
    reset
    
    
;uart_send
; envoie le contenu de WREG via 
; le p�riph�rique EUSART    
uart_send:
    banksel TXSTA
    btfss TXSTA,TRMT
    bra $-1
    movwf TXREG
    clrw
    return
    
;to_hex
; convertie le digit 
;qui est dans WREG en
;caract�re hexad�cimal
to_hex:
    addlw '0'
    movwf t1
    movlw '9'+1
    subwf t1,W
    skpnc
    addlw 7
    addlw '9'+1
    return

#ifdef DEBUG    
;send_hex
;envoie WREG en hexad�cimal via EUSART    
hex_send:
    movwf t0
    movlw 0xf0
    andwf t0,W
    swapf WREG
    call to_hex
    call uart_send
    movlw 0xf
    andwf   t0,W
    call to_hex
    call uart_send
    movlw 32
    call uart_send
    return
#endif
    
;micro_delay
; boucle de d�lais 
; entr�e: WREG d�lais en multiple de 3 �Sec
;   TCY=1�sec on a 4 �sec d'overhead  call/return         
micro_delay:
    decfsz WREG
    bra $-1
    return

wait_kbd_clock:
    banksel PORTA
    btfss PORTA,KBD_CLK
    bra $-1
    btfsc PORTA,KBD_CLK
    bra $-1
    return
    
;kbd_send
;envoie un octet au clavier
; argument:
;  WREG: octet � envoyer
; sortie:
;   rien    
kbd_send:
    movwf cmd
    movlw 8
    movwf bitcntr
    bcf INTCON,IOCIE ; blocage des interruptions
    clrf parity
; prise de contr�le de l'interface PS/2
; par le MCU    
    banksel TRISA
    bcf TRISA, KBD_CLK
    banksel LATA
    bcf LATA,KBD_CLK
    movlw 150/3 ; d�lais 150�sec
    call micro_delay
    banksel TRISA
    bcf TRISA, KBD_DAT
    banksel LATA
    bcf LATA,KBD_DAT  ; start bit
    banksel TRISA
    bsf TRISA,KBD_CLK ; rel�che la ligne clock
kbd_send_loop:
    call wait_kbd_clock
    bcf PORTA,KBD_DAT
    btfss cmd,0
    bra $+3
    bsf PORTA,KBD_DAT
    incf parity,F
    lsrf cmd,F
    decfsz bitcntr
    bra kbd_send_loop
; envoie parit�e    
    call wait_kbd_clock
    bcf PORTA,KBD_DAT
    btfss parity,0
    bsf PORTA,KBD_DAT
    call wait_kbd_clock
;envoie stop bit    
    banksel TRISA
    bsf TRISA,KBD_DAT ; rel�che ligne data
    banksel PORTA  
    btfss PORTA,KBD_CLK
    bra $-1
    movlw (1<<KBD_DAT)|(1<<KBD_CLK)
    movwf t0
;attend bit ack KBD_DAT et KBD_CLK � z�ro 
    movfw t0
    andwf PORTA,W
    skpz
    bra $-3
;attend rel�chement des lignes    
    movfw t0
    andwf PORTA,W
    xorwf t0,W
    skpz
    bra $-4
; r�active interruption
    banksel IOCAF
    clrf IOCAF
    bsf INTCON,IOCIE
    return

;set_leds
;contr�le les LEDs du clavier
set_leds:
    movlw KBD_LED
    bcf kbd_state,F_ACK
    call kbd_send
    btfss kbd_state,F_ACK
    bra $-1
    bcf kbd_state,F_ACK
    movlw 7
    andwf kbd_state,W
    call kbd_send
    btfss kbd_state,F_ACK
    bra $-1
    return

;signal_reset
; la combinaison de touches
; <CTRL>+<ALT>+<DEL> a �t� enfonc�e.
; la broche NRST est mise � z�ro
; pour 100�Sec pour signaler � l'h�te
; une demande de r�initialisation    
signal_reset:
    banksel LATA
    bcf LATA, NRST
    movlw 100/3
    call micro_delay
    bsf LATA, NRST
    return
    
    
; attend la s�quence des codes PAUSE    
get_pause: 
    movlw 8
    movwf t0
wait_code:
    movfw qhead
    xorwf qtail,W
    skpnz
    bra wait_code
    incf qhead,F ;jette le code
    movlw 15
    andwf qhead,F
    decfsz  t0
    bra wait_code
    movlw VK_PAUSE
    call uart_send
    decf qhead,F
    return

    
;_shifted
; retourne le caract�re de la touche lorsque SHIFT est enfonc�e
; entr�e: WREG=caract�re non shift�    
; sortie: WREG=caract�re shift�|0    
_shifted:
    movfw t1
    incf t1,F
    call table_shifted
    movf WREG,F
    skpnz
    return ; pas dans cette table
    xorwf t0,W
    skpnz
    bra shifted_found
    incf t1,F
    bra _shifted
shifted_found:
    movfw t1
    call table_shifted
    return
    
_altchar:
    movfw t1
    incf t1,F
    call table_altchar
    movf WREG,F
    skpnz
    return ; pas dans cette table
    xorwf t0,W
    skpnz
    bra altchar_found
    incf t1,F
    bra _altchar
altchar_found:
    movfw t1
    call table_altchar
    return
    

_control:
    movlw 'A'
    subwf t0,W
    skpc
    bra ctrl_loop
    movlw 'Z'+1
    subwf t0,W
    skpnc
    bra ctrl_loop
    movlw 'A'-1
    subwf t0,W
    return
ctrl_loop:    
    movfw t1
    incf t1,F
    call table_control
    movf WREG,F
    skpnz
    return
    xorwf t0,W
    skpnz
    bra control_found
    incf t1,F
    bra ctrl_loop
control_found:
    movfw t1
    call table_control
    return
    
    
;alpha
;v�rifie si WREG est une lettre {'A'..'Z'}
; sortie:
;   C=1 -> alpha
;   C=0 -> non alpha    
alpha:
    movwf t0
    movlw 'A'
    subwf t0,W
    skpc
    bra not_alpha
    movfw t0
    sublw 'Z'
not_alpha:
    movfw t0
    return

;if_shifted
; v�rifie l'�tat de F_CAPS et F_SHIFT
; et applique la transformation requise
; au contenu de WREG
; entr�: WREG contient le caract�re
; sortie: WREG contient le caract�re modifi� (si requis)
if_shifted:
    call alpha
    skpnc
    bra letter
    btfss kbd_state,F_SHIFT
    return
    search _shifted
    return
letter:
    btfsc kbd_state,F_SHIFT
    bra shift_on
    btfss kbd_state,F_CAPS
    addlw 32
    return
shift_on:
    btfsc kbd_state,F_CAPS
    addlw 32
    return

;translate
; converti le scancode en valeur ASCII ou touche virtuelle
; entr�e: WREG=scancode    
translate:
    movwf t0
    clrf t1
trans_loop:
    movfw t1
    incf t1,F
    btfss rxflags,F_XT
    call std_codes
    btfsc rxflags,F_XT
    call xt_codes
    skpnz
    return ; not found
    xorwf t0,W
    skpnz
    bra found
    incf t1,F
    bra trans_loop
found:
    movfw t1
    btfss rxflags,F_XT
    call std_codes
    btfsc rxflags,F_XT
    call xt_codes
    return
    
;code_convert
; conversion code clavier
; vers code ASCII
; argument:
;  code dans in_queue
; sortie:
;   code ASCII dans out_queue
code_convert:
    movlw in_queue
    movwf HEAD_PTRL
    movfw qhead
    addwf HEAD_PTRL
    movfw QUEUE_HEAD
    case KEY_REL, key_release
    case XT_KEY, xkey
    case XT2_KEY, pkey
    call translate
    skpnz
    bra ignore_code
    case VK_LSHIFT, shiftkey
    case VK_RSHIFT, shiftkey
    case VK_CAPS, capskey
    case VK_LCTRL, ctrlkey
    case VK_RCTRL, ctrlkey
    case VK_LALT, altkey
    case VK_RALT, altkey
    case VK_NUM, numkey
    case A_DEL, delete
send_it:    
    btfsc rxflags,F_REL
    bra ignore_code
    btfsc kbd_state,F_CTRL
    bra ctrl_down
    btfsc kbd_state,F_ALT
    bra alt_down
    call if_shifted
    call uart_send
    bra clear_flags
delete:
    movlw A_DEL
    btfsc kbd_state,F_CTRL
    btfss kbd_state,F_ALT
    bra send_it
HARD_RESET
#ifdef SOFT_RESET    
    movlw 20 ; ASCII DC4
    call uart_send
#else  ; hardware reset  
    call signal_reset
#endif    
    bra clear_flags
ctrl_down:
    search _control
    skpz
    call uart_send
    bra clear_flags
alt_down:
    search _altchar
    skpz
    call uart_send
    bra clear_flags
ctrlkey:
    bcf kbd_state, F_CTRL
    btfss rxflags, F_REL
    bsf kbd_state,F_CTRL
    bra clear_flags
altkey:
    bcf kbd_state, F_ALT
    btfss rxflags, F_REL
    bsf kbd_state,F_ALT
    bra clear_flags
capskey: ; touche verr. majuscule
    btfsc rxflags, F_REL
    bra clear_flags
    movlw 1<<F_CAPS
    xorwf kbd_state,F
    call set_leds
    bra clear_flags
numkey:
    btfsc rxflags, F_REL
    bra clear_flags
    movlw 1<<F_NUM
    xorwf kbd_state,F
    call set_leds
    bra clear_flags
shiftkey: ; touche shift droite|gauche
    bcf kbd_state,F_SHIFT
    btfss rxflags,F_REL
    bsf kbd_state,F_SHIFT
    bra clear_flags
key_release: ; touche rel�ch�e
    bsf rxflags, F_REL
    bra code_done
pkey: ; PAUSE key   
    call get_pause
    bra code_done
xkey: ; extended key
    bsf rxflags, F_XT
    bra code_done
clear_flags:    
ignore_code:
    bcf rxflags,F_REL
    bcf rxflags,F_XT
code_done:
    incf qhead,F
    movlw 15
    andwf qhead,F
    return
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; initialisation mat�rielle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
init:
; configure Fosc � 4Mhz
    banksel OSCCON
    movlw 0xD<<IRCF0 ; 4Mhz no PLL
    movwf OSCCON
    banksel OPTION_REG
    clrf OPTION_REG 
    banksel LATA
    bsf LATA, NRST
; configure TX sur la broche RA4    
    banksel APFCON
    bsf APFCON, TXCKSEL
    banksel TRISA
    bcf TRISA, TX
    bcf TRISA, NRST
; configuration du EUSART
; mode asynchrone 9600 BAUD
; communication � sens unique    
    banksel SPBRG
    bsf BAUDCON, BRG16
    movlw ((FOSC/16/BAUD)&0xff)-1
    movwf SPBRGL
    movlw (FOSC/16/BAUD-1)>>8
    movwf SPBRGH
    bsf TXSTA,TXEN
    bsf RCSTA, SPEN
; configuration interruption sur broche KBD_CLK
; pour produire une interruption sur
; la transistion descendante.
    banksel IOCAN
    bsf IOCAN,KBD_CLK
; les broches associ�es au clavier et au signal NRST sont
; sont configur�es Open Drain    
    banksel ODCONA
    movlw (1<<KBD_CLK)|(1<<KBD_DAT)|(1<<NRST)
    movwf ODCONA
; on d�sactive les pullup sur KBD_CLK et KBD_DAT.
; pullup externes.    
    banksel WPUA
    movlw ~((1<<KBD_CLK)|(1<<KBD_DAT))
    movwf WPUA
; raz ram
    movlw 0x20
    movwf FSR0L
    clrf FSR0H
    movlw 96
    clrf INDF0
    incf FSR0L,F
    decfsz WREG
    bra $-3
; initialisation des variables
    clrf  HEAD_PTRH
    clrf  TAIL_PTRH
    movlw in_queue
    movwf HEAD_PTRL
    movwf HEAD_PTRL
; activation des interruptions
    bcf INTCON, IOCIF
    bsf INTCON,IOCIE
    bsf INTCON,GIE
;envoie une commande de r�initialisation au clavier
    movlw KBD_RESET
    call kbd_send
; attend r�ception ACK
    btfss kbd_state,F_ACK
    bra $-1
; attend r�ception BAT_OK
    btfss kbd_state,F_BATOK
    bra $-1
    call set_leds
#ifdef DEBUG    
test:    
    movlw 'O'
    call uart_send
    movlw 'K'
    call uart_send
    movlw '\r'
    call uart_send
    movlw '\n'
    call uart_send
#endif
    
;;;;;;;;;;;;;;;;;;;    
; boucle principale
;;;;;;;;;;;;;;;;;;;    
main:
    clrwdt ; d�lais d'expiration 2 secondes
;s'il y a des caract�res dans la 
; file les envoyer via l'EUSART
    movfw qhead
    xorwf qtail,W
    skpnz
    bra main
    call code_convert
    bra main
    

    end

    