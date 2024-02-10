;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DEBUG=0 ; set to 1 to include debugging code 

HSI=0 ; set this to 1 if using internal high speed oscillator  
.if HSI
FMSTR=16 ; MHZ
HSE=0
.else
FMSTR=20 ; MHZ 
HSE=1  
.endif 


; boards list
; set selected board to 1  
NUCLEO_8S208RB=0
; use this to ensure 
; only one is selected 
.if NUCLEO_8S208RB 
NUCLEO_8S207K8=0
SB5_SHORT=0
.else 
NUCLEO_8S207K8=1
.endif 

; NUCLEO-8S208RB config.
.if NUCLEO_8S208RB 
    .include "inc/stm8s208.inc" 
    .include "inc/nucleo_8s208.inc"
.endif  

; NUCLEO-8S207K8 config. 
.if NUCLEO_8S207K8 
    SB5_SHORT=0 ; when SB5 short on board STM8 OSCIN is connected to 8Mhz TMCO signal  
    .include "inc/stm8s207.inc" 
    .include "inc/nucleo_8s207.inc"
.endif 

; all boards includes 

	.include "inc/ascii.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 

