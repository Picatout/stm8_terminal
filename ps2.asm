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


PS2_VAR_ORG=KERNEL_VAR_ORG+KERNEL_VAR_SIZE 
;----------------------------------
    .area DATA 

    .org PS2_VAR_ORG 
;----------------------------------    

KBD_QUEUE_SIZE=8

kbd_rx_byte: .blkb 1 ; keyboard receive byte 
kbd_rx_count: .blkb 1 ; keyboard receive bits counter 
kbd_queue: .blkb KBD_QUEUE_SIZE 
kbd_queue_head: .blkb 1 
kbd_queue_tail: .blkb 1 

PS2_VAR_SIZE=.-kbd_rx_byte  

;--------------------------------
    .area CODE 


