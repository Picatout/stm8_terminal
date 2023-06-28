ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialisation
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23 ;------------------------
                                     24 ; if unified compilation 
                                     25 ; must be first in list 
                                     26 ;-----------------------
                                     27 
                                     28     .module HW_INIT 
                                     29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     30     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                           000000     5 DEBUG=0 ; set to 1 to include debugging code 
                                      6 
                           000001     7 HSI=1 ; set this to 1 if using internal high speed oscillator  
                           000001     8 .if HSI 
                           000000     9 HSE=0
                           000000    10 .else
                                     11 HSE=1  
                                     12 .endif 
                                     13 
                           000010    14 FMSTR=16 ; master clock frequency in Mhz 
                                     15 
                                     16 ; boards list
                                     17 ; set selected board to 1  
                           000000    18 NUCLEO_8S208RB=0
                                     19 ; use this to ensure 
                                     20 ; only one is selected 
                           000000    21 .if NUCLEO_8S208RB 
                                     22 NUCLEO_8S207K8=0
                           000001    23 .else 
                           000001    24 NUCLEO_8S207K8=1
                                     25 .endif 
                                     26 
                                     27 ; NUCLEO-8S208RB config.
                           000000    28 .if NUCLEO_8S208RB 
                                     29     .include "inc/stm8s208.inc" 
                                     30     .include "inc/nucleo_8s208.inc"
                                     31 .endif  
                                     32 
                                     33 ; NUCLEO-8S207K8 config. 
                           000001    34 .if NUCLEO_8S207K8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     35     .include "inc/stm8s207.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; 2022/11/14
                                     20 ; STM8S207K8 µC registers map
                                     21 ; sdas source file
                                     22 ; author: Jacques Deschênes, copyright 2018,2019,2022
                                     23 ; licence: GPLv3
                                     24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     25 
                                     26 ;;;;;;;;;;;
                                     27 ; bits
                                     28 ;;;;;;;;;;;;
                           000000    29  BIT0 = 0
                           000001    30  BIT1 = 1
                           000002    31  BIT2 = 2
                           000003    32  BIT3 = 3
                           000004    33  BIT4 = 4
                           000005    34  BIT5 = 5
                           000006    35  BIT6 = 6
                           000007    36  BIT7 = 7
                                     37  	
                                     38 ;;;;;;;;;;;;
                                     39 ; bits masks
                                     40 ;;;;;;;;;;;;
                           000001    41  B0_MASK = (1<<0)
                           000002    42  B1_MASK = (1<<1)
                           000004    43  B2_MASK = (1<<2)
                           000008    44  B3_MASK = (1<<3)
                           000010    45  B4_MASK = (1<<4)
                           000020    46  B5_MASK = (1<<5)
                           000040    47  B6_MASK = (1<<6)
                           000080    48  B7_MASK = (1<<7)
                                     49 
                                     50 ; HSI oscillator frequency 16Mhz
                           F42400    51  FHSI = 16000000
                                     52 ; LSI oscillator frequency 128Khz
                           01F400    53  FLSI = 128000 
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                                     55 ; controller memory regions
                           001800    56  RAM_SIZE = (0x1800) ; 6KB 
                           000400    57  EEPROM_SIZE = (0x400) ; 1KB
                                     58 ; STM8S207K8 have 64K flash
                           010000    59  FLASH_SIZE = (0x10000)
                                     60 ; erase block size 
                           000080    61 BLOCK_SIZE=128 ; bytes 
                                     62 
                           000000    63  RAM_BASE = (0)
                           0017FF    64  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           004000    65  EEPROM_BASE = (0x4000)
                           0043FF    66  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    67  SFR_BASE = (0x5000)
                           0057FF    68  SFR_END = (0x57FF)
                           006000    69  BOOT_ROM_BASE = (0x6000)
                           007FFF    70  BOOT_ROM_END = (0x7fff)
                           008000    71  FLASH_BASE = (0x8000)
                           017FFF    72  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    73  OPTION_BASE = (0x4800)
                           000080    74  OPTION_SIZE = (0x80)
                           00487F    75  OPTION_END = (OPTION_BASE+OPTION_SIZE-1)
                           0048CD    76  DEVID_BASE = (0x48CD)
                           0048D8    77  DEVID_END = (0x48D8)
                           007F00    78  DEBUG_BASE = (0X7F00)
                           007FFF    79  DEBUG_END = (0X7FFF)
                                     80 
                                     81 ; options bytes
                                     82 ; this one can be programmed only from SWIM  (ICP)
                           004800    83  OPT0  = (0x4800)
                                     84 ; these can be programmed at runtime (IAP)
                           004801    85  OPT1  = (0x4801)
                           004802    86  NOPT1  = (0x4802)
                           004803    87  OPT2  = (0x4803)
                           004804    88  NOPT2  = (0x4804)
                           004805    89  OPT3  = (0x4805)
                           004806    90  NOPT3  = (0x4806)
                           004807    91  OPT4  = (0x4807)
                           004808    92  NOPT4  = (0x4808)
                           004809    93  OPT5  = (0x4809)
                           00480A    94  NOPT5  = (0x480A)
                           00480B    95  OPT6  = (0x480B)
                           00480C    96  NOPT6 = (0x480C)
                           00480D    97  OPT7 = (0x480D)
                           00480E    98  NOPT7 = (0x480E)
                           00487E    99  OPTBL  = (0x487E)
                           00487F   100  NOPTBL  = (0x487F)
                                    101 ; option registers usage
                                    102 ; read out protection, value 0xAA enable ROP
                           004800   103  ROP = OPT0  
                                    104 ; user boot code, {0..0x3e} 512 bytes row
                           004801   105  UBC = OPT1
                           004802   106  NUBC = NOPT1
                                    107 ; alternate function register
                           004803   108  AFR = OPT2
                           004804   109  NAFR = NOPT2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                                    110 ; miscelinous options
                           004805   111  WDGOPT = OPT3
                           004806   112  NWDGOPT = NOPT3
                                    113 ; clock options
                           004807   114  CLKOPT = OPT4
                           004808   115  NCLKOPT = NOPT4
                                    116 ; HSE clock startup delay
                           004809   117  HSECNT = OPT5
                           00480A   118  NHSECNT = NOPT5
                                    119 ; flash wait state
                           00480D   120 FLASH_WS = OPT7
                           00480E   121 NFLASH_WS = NOPT7
                                    122 
                                    123 ; watchdog options bits
                           000003   124   WDGOPT_LSIEN   =  BIT3
                           000002   125   WDGOPT_IWDG_HW =  BIT2
                           000001   126   WDGOPT_WWDG_HW =  BIT1
                           000000   127   WDGOPT_WWDG_HALT = BIT0
                                    128 ; NWDGOPT bits
                           FFFFFFFC   129   NWDGOPT_LSIEN    = ~BIT3
                           FFFFFFFD   130   NWDGOPT_IWDG_HW  = ~BIT2
                           FFFFFFFE   131   NWDGOPT_WWDG_HW  = ~BIT1
                           FFFFFFFF   132   NWDGOPT_WWDG_HALT = ~BIT0
                                    133 
                                    134 ; CLKOPT bits
                           000003   135  CLKOPT_EXT_CLK  = BIT3
                           000002   136  CLKOPT_CKAWUSEL = BIT2
                           000001   137  CLKOPT_PRS_C1   = BIT1
                           000000   138  CLKOPT_PRS_C0   = BIT0
                                    139 
                                    140 ; AFR option, remapable functions
                           000007   141  AFR7_BEEP    = BIT7
                           000006   142  AFR6_I2C     = BIT6
                           000005   143  AFR5_TIM1    = BIT5
                           000004   144  AFR4_TIM1    = BIT4
                           000003   145  AFR3_TIM1    = BIT3
                           000002   146  AFR2_CCO     = BIT2
                           000001   147  AFR1_TIM2    = BIT1
                           000000   148  AFR0_ADC     = BIT0
                                    149 
                                    150 ; device ID = (read only)
                           0048CD   151  DEVID_XL  = (0x48CD)
                           0048CE   152  DEVID_XH  = (0x48CE)
                           0048CF   153  DEVID_YL  = (0x48CF)
                           0048D0   154  DEVID_YH  = (0x48D0)
                           0048D1   155  DEVID_WAF  = (0x48D1)
                           0048D2   156  DEVID_LOT0  = (0x48D2)
                           0048D3   157  DEVID_LOT1  = (0x48D3)
                           0048D4   158  DEVID_LOT2  = (0x48D4)
                           0048D5   159  DEVID_LOT3  = (0x48D5)
                           0048D6   160  DEVID_LOT4  = (0x48D6)
                           0048D7   161  DEVID_LOT5  = (0x48D7)
                           0048D8   162  DEVID_LOT6  = (0x48D8)
                                    163 
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                           005000   165 GPIO_BASE = (0x5000)
                           000005   166 GPIO_SIZE = (5)
                                    167 ; PORTS SFR OFFSET
                           000000   168 PA = 0
                           000005   169 PB = 5
                           00000A   170 PC = 10
                           00000F   171 PD = 15
                           000014   172 PE = 20
                           000019   173 PF = 25
                           00001E   174 PG = 30
                           000023   175 PH = 35 
                           000028   176 PI = 40 
                                    177 
                                    178 ; GPIO
                                    179 ; gpio register offset to base
                           000000   180  GPIO_ODR = 0
                           000001   181  GPIO_IDR = 1
                           000002   182  GPIO_DDR = 2
                           000003   183  GPIO_CR1 = 3
                           000004   184  GPIO_CR2 = 4
                           005000   185  GPIO_BASE=(0X5000)
                                    186  
                                    187 ; port A
                           005000   188  PA_BASE = (0X5000)
                           005000   189  PA_ODR  = (0x5000)
                           005001   190  PA_IDR  = (0x5001)
                           005002   191  PA_DDR  = (0x5002)
                           005003   192  PA_CR1  = (0x5003)
                           005004   193  PA_CR2  = (0x5004)
                                    194 ; port B
                           005005   195  PB_BASE = (0X5005)
                           005005   196  PB_ODR  = (0x5005)
                           005006   197  PB_IDR  = (0x5006)
                           005007   198  PB_DDR  = (0x5007)
                           005008   199  PB_CR1  = (0x5008)
                           005009   200  PB_CR2  = (0x5009)
                                    201 ; port C
                           00500A   202  PC_BASE = (0X500A)
                           00500A   203  PC_ODR  = (0x500A)
                           00500B   204  PC_IDR  = (0x500B)
                           00500C   205  PC_DDR  = (0x500C)
                           00500D   206  PC_CR1  = (0x500D)
                           00500E   207  PC_CR2  = (0x500E)
                                    208 ; port D
                           00500F   209  PD_BASE = (0X500F)
                           00500F   210  PD_ODR  = (0x500F)
                           005010   211  PD_IDR  = (0x5010)
                           005011   212  PD_DDR  = (0x5011)
                           005012   213  PD_CR1  = (0x5012)
                           005013   214  PD_CR2  = (0x5013)
                                    215 ; port E
                           005014   216  PE_BASE = (0X5014)
                           005014   217  PE_ODR  = (0x5014)
                           005015   218  PE_IDR  = (0x5015)
                           005016   219  PE_DDR  = (0x5016)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                           005017   220  PE_CR1  = (0x5017)
                           005018   221  PE_CR2  = (0x5018)
                                    222 ; port F
                           005019   223  PF_BASE = (0X5019)
                           005019   224  PF_ODR  = (0x5019)
                           00501A   225  PF_IDR  = (0x501A)
                           00501B   226  PF_DDR  = (0x501B)
                           00501C   227  PF_CR1  = (0x501C)
                           00501D   228  PF_CR2  = (0x501D)
                                    229 ; port G
                           00501E   230  PG_BASE = (0X501E)
                           00501E   231  PG_ODR  = (0x501E)
                           00501F   232  PG_IDR  = (0x501F)
                           005020   233  PG_DDR  = (0x5020)
                           005021   234  PG_CR1  = (0x5021)
                           005022   235  PG_CR2  = (0x5022)
                                    236 ; port H not present on LQFP48/LQFP64 package
                           005023   237  PH_BASE = (0X5023)
                           005023   238  PH_ODR  = (0x5023)
                           005024   239  PH_IDR  = (0x5024)
                           005025   240  PH_DDR  = (0x5025)
                           005026   241  PH_CR1  = (0x5026)
                           005027   242  PH_CR2  = (0x5027)
                                    243 ; port I ; only bit 0 on LQFP64 package, not present on LQFP48
                           005028   244  PI_BASE = (0X5028)
                           005028   245  PI_ODR  = (0x5028)
                           005029   246  PI_IDR  = (0x5029)
                           00502A   247  PI_DDR  = (0x502a)
                           00502B   248  PI_CR1  = (0x502b)
                           00502C   249  PI_CR2  = (0x502c)
                                    250 
                                    251 ; input modes CR1
                           000000   252  INPUT_FLOAT = (0) ; no pullup resistor
                           000001   253  INPUT_PULLUP = (1)
                                    254 ; output mode CR1
                           000000   255  OUTPUT_OD = (0) ; open drain
                           000001   256  OUTPUT_PP = (1) ; push pull
                                    257 ; input modes CR2
                           000000   258  INPUT_DI = (0)
                           000001   259  INPUT_EI = (1)
                                    260 ; output speed CR2
                           000000   261  OUTPUT_SLOW = (0)
                           000001   262  OUTPUT_FAST = (1)
                                    263 
                                    264 
                                    265 ; Flash memory
                           000080   266  BLOCK_SIZE=128 
                           00505A   267  FLASH_CR1  = (0x505A)
                           00505B   268  FLASH_CR2  = (0x505B)
                           00505C   269  FLASH_NCR2  = (0x505C)
                           00505D   270  FLASH_FPR  = (0x505D)
                           00505E   271  FLASH_NFPR  = (0x505E)
                           00505F   272  FLASH_IAPSR  = (0x505F)
                           005062   273  FLASH_PUKR  = (0x5062)
                           005064   274  FLASH_DUKR  = (0x5064)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                                    275 ; data memory unlock keys
                           0000AE   276  FLASH_DUKR_KEY1 = (0xae)
                           000056   277  FLASH_DUKR_KEY2 = (0x56)
                                    278 ; flash memory unlock keys
                           000056   279  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   280  FLASH_PUKR_KEY2 = (0xae)
                                    281 ; FLASH_CR1 bits
                           000003   282  FLASH_CR1_HALT = BIT3
                           000002   283  FLASH_CR1_AHALT = BIT2
                           000001   284  FLASH_CR1_IE = BIT1
                           000000   285  FLASH_CR1_FIX = BIT0
                                    286 ; FLASH_CR2 bits
                           000007   287  FLASH_CR2_OPT = BIT7
                           000006   288  FLASH_CR2_WPRG = BIT6
                           000005   289  FLASH_CR2_ERASE = BIT5
                           000004   290  FLASH_CR2_FPRG = BIT4
                           000000   291  FLASH_CR2_PRG = BIT0
                                    292 ; FLASH_FPR bits
                           000005   293  FLASH_FPR_WPB5 = BIT5
                           000004   294  FLASH_FPR_WPB4 = BIT4
                           000003   295  FLASH_FPR_WPB3 = BIT3
                           000002   296  FLASH_FPR_WPB2 = BIT2
                           000001   297  FLASH_FPR_WPB1 = BIT1
                           000000   298  FLASH_FPR_WPB0 = BIT0
                                    299 ; FLASH_NFPR bits
                           000005   300  FLASH_NFPR_NWPB5 = BIT5
                           000004   301  FLASH_NFPR_NWPB4 = BIT4
                           000003   302  FLASH_NFPR_NWPB3 = BIT3
                           000002   303  FLASH_NFPR_NWPB2 = BIT2
                           000001   304  FLASH_NFPR_NWPB1 = BIT1
                           000000   305  FLASH_NFPR_NWPB0 = BIT0
                                    306 ; FLASH_IAPSR bits
                           000006   307  FLASH_IAPSR_HVOFF = BIT6
                           000003   308  FLASH_IAPSR_DUL = BIT3
                           000002   309  FLASH_IAPSR_EOP = BIT2
                           000001   310  FLASH_IAPSR_PUL = BIT1
                           000000   311  FLASH_IAPSR_WR_PG_DIS = BIT0
                                    312 
                                    313 ; Interrupt control
                           0050A0   314  EXTI_CR1  = (0x50A0)
                           0050A1   315  EXTI_CR2  = (0x50A1)
                                    316 
                                    317 ; Reset Status
                           0050B3   318  RST_SR  = (0x50B3)
                                    319 
                                    320 ; Clock Registers
                           0050C0   321  CLK_ICKR  = (0x50c0)
                           0050C1   322  CLK_ECKR  = (0x50c1)
                           0050C3   323  CLK_CMSR  = (0x50C3)
                           0050C4   324  CLK_SWR  = (0x50C4)
                           0050C5   325  CLK_SWCR  = (0x50C5)
                           0050C6   326  CLK_CKDIVR  = (0x50C6)
                           0050C7   327  CLK_PCKENR1  = (0x50C7)
                           0050C8   328  CLK_CSSR  = (0x50C8)
                           0050C9   329  CLK_CCOR  = (0x50C9)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           0050CA   330  CLK_PCKENR2  = (0x50CA)
                           0050CC   331  CLK_HSITRIMR  = (0x50CC)
                           0050CD   332  CLK_SWIMCCR  = (0x50CD)
                                    333 
                                    334 ; Peripherals clock gating
                                    335 ; CLK_PCKENR1 
                           000007   336  CLK_PCKENR1_TIM1 = (7)
                           000006   337  CLK_PCKENR1_TIM3 = (6)
                           000005   338  CLK_PCKENR1_TIM2 = (5)
                           000004   339  CLK_PCKENR1_TIM4 = (4)
                           000003   340  CLK_PCKENR1_UART3 = (3)
                           000002   341  CLK_PCKENR1_UART1 = (2)
                           000001   342  CLK_PCKENR1_SPI = (1)
                           000000   343  CLK_PCKENR1_I2C = (0)
                                    344 ; CLK_PCKENR2
                           000007   345  CLK_PCKENR2_CAN = (7)
                           000003   346  CLK_PCKENR2_ADC = (3)
                           000002   347  CLK_PCKENR2_AWU = (2)
                                    348 
                                    349 ; Clock bits
                           000005   350  CLK_ICKR_REGAH = (5)
                           000004   351  CLK_ICKR_LSIRDY = (4)
                           000003   352  CLK_ICKR_LSIEN = (3)
                           000002   353  CLK_ICKR_FHW = (2)
                           000001   354  CLK_ICKR_HSIRDY = (1)
                           000000   355  CLK_ICKR_HSIEN = (0)
                                    356 
                           000001   357  CLK_ECKR_HSERDY = (1)
                           000000   358  CLK_ECKR_HSEEN = (0)
                                    359 ; clock source
                           0000E1   360  CLK_SWR_HSI = 0xE1
                           0000D2   361  CLK_SWR_LSI = 0xD2
                           0000B4   362  CLK_SWR_HSE = 0xB4
                                    363 
                           000003   364  CLK_SWCR_SWIF = (3)
                           000002   365  CLK_SWCR_SWIEN = (2)
                           000001   366  CLK_SWCR_SWEN = (1)
                           000000   367  CLK_SWCR_SWBSY = (0)
                                    368 
                           000004   369  CLK_CKDIVR_HSIDIV1 = (4)
                           000003   370  CLK_CKDIVR_HSIDIV0 = (3)
                           000002   371  CLK_CKDIVR_CPUDIV2 = (2)
                           000001   372  CLK_CKDIVR_CPUDIV1 = (1)
                           000000   373  CLK_CKDIVR_CPUDIV0 = (0)
                                    374 
                                    375 ; Watchdog
                           0050D1   376  WWDG_CR  = (0x50D1)
                           0050D2   377  WWDG_WR  = (0x50D2)
                           0050E0   378  IWDG_KR  = (0x50E0)
                           0050E1   379  IWDG_PR  = (0x50E1)
                           0050E2   380  IWDG_RLR  = (0x50E2)
                           0000CC   381  IWDG_KEY_ENABLE = 0xCC  ; enable IWDG key 
                           0000AA   382  IWDG_KEY_REFRESH = 0xAA ; refresh counter key 
                           000055   383  IWDG_KEY_ACCESS = 0x55 ; write register key 
                                    384  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                           0050F0   385  AWU_CSR  = (0x50F0)
                           0050F1   386  AWU_APR  = (0x50F1)
                           0050F2   387  AWU_TBR  = (0x50F2)
                           000004   388  AWU_CSR_AWUEN = 4
                                    389 
                                    390 
                                    391 
                                    392 ; Beeper
                                    393 ; beeper output is alternate function AFR7 on PD4
                                    394 ; connected to CN9-6
                           0050F3   395  BEEP_CSR  = (0x50F3)
                           00000F   396  BEEP_PORT = PD
                           000004   397  BEEP_BIT = 4
                           000010   398  BEEP_MASK = B4_MASK
                                    399 
                                    400 ; SPI
                           005200   401  SPI_CR1  = (0x5200)
                           005201   402  SPI_CR2  = (0x5201)
                           005202   403  SPI_ICR  = (0x5202)
                           005203   404  SPI_SR  = (0x5203)
                           005204   405  SPI_DR  = (0x5204)
                           005205   406  SPI_CRCPR  = (0x5205)
                           005206   407  SPI_RXCRCR  = (0x5206)
                           005207   408  SPI_TXCRCR  = (0x5207)
                                    409 
                                    410 ; SPI_CR1 bit fields 
                           000000   411   SPI_CR1_CPHA=0
                           000001   412   SPI_CR1_CPOL=1
                           000002   413   SPI_CR1_MSTR=2
                           000003   414   SPI_CR1_BR=3
                           000006   415   SPI_CR1_SPE=6
                           000007   416   SPI_CR1_LSBFIRST=7
                                    417   
                                    418 ; SPI_CR2 bit fields 
                           000000   419   SPI_CR2_SSI=0
                           000001   420   SPI_CR2_SSM=1
                           000002   421   SPI_CR2_RXONLY=2
                           000004   422   SPI_CR2_CRCNEXT=4
                           000005   423   SPI_CR2_CRCEN=5
                           000006   424   SPI_CR2_BDOE=6
                           000007   425   SPI_CR2_BDM=7  
                                    426 
                                    427 ; SPI_SR bit fields 
                           000000   428   SPI_SR_RXNE=0
                           000001   429   SPI_SR_TXE=1
                           000003   430   SPI_SR_WKUP=3
                           000004   431   SPI_SR_CRCERR=4
                           000005   432   SPI_SR_MODF=5
                           000006   433   SPI_SR_OVR=6
                           000007   434   SPI_SR_BSY=7
                                    435 
                                    436 ; I2C
                           005210   437  I2C_BASE_ADDR = 0x5210 
                           005210   438  I2C_CR1  = (0x5210)
                           005211   439  I2C_CR2  = (0x5211)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           005212   440  I2C_FREQR  = (0x5212)
                           005213   441  I2C_OARL  = (0x5213)
                           005214   442  I2C_OARH  = (0x5214)
                           005216   443  I2C_DR  = (0x5216)
                           005217   444  I2C_SR1  = (0x5217)
                           005218   445  I2C_SR2  = (0x5218)
                           005219   446  I2C_SR3  = (0x5219)
                           00521A   447  I2C_ITR  = (0x521A)
                           00521B   448  I2C_CCRL  = (0x521B)
                           00521C   449  I2C_CCRH  = (0x521C)
                           00521D   450  I2C_TRISER  = (0x521D)
                           00521E   451  I2C_PECR  = (0x521E)
                                    452 
                           000007   453  I2C_CR1_NOSTRETCH = (7)
                           000006   454  I2C_CR1_ENGC = (6)
                           000000   455  I2C_CR1_PE = (0)
                                    456 
                           000007   457  I2C_CR2_SWRST = (7)
                           000003   458  I2C_CR2_POS = (3)
                           000002   459  I2C_CR2_ACK = (2)
                           000001   460  I2C_CR2_STOP = (1)
                           000000   461  I2C_CR2_START = (0)
                                    462 
                           000000   463  I2C_OARL_ADD0 = (0)
                                    464 
                           000009   465  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   466  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    467 
                           000007   468  I2C_OARH_ADDMODE = (7)
                           000006   469  I2C_OARH_ADDCONF = (6)
                           000002   470  I2C_OARH_ADD9 = (2)
                           000001   471  I2C_OARH_ADD8 = (1)
                                    472 
                           000007   473  I2C_SR1_TXE = (7)
                           000006   474  I2C_SR1_RXNE = (6)
                           000004   475  I2C_SR1_STOPF = (4)
                           000003   476  I2C_SR1_ADD10 = (3)
                           000002   477  I2C_SR1_BTF = (2)
                           000001   478  I2C_SR1_ADDR = (1)
                           000000   479  I2C_SR1_SB = (0)
                                    480 
                           000005   481  I2C_SR2_WUFH = (5)
                           000003   482  I2C_SR2_OVR = (3)
                           000002   483  I2C_SR2_AF = (2)
                           000001   484  I2C_SR2_ARLO = (1)
                           000000   485  I2C_SR2_BERR = (0)
                                    486 
                           000007   487  I2C_SR3_DUALF = (7)
                           000004   488  I2C_SR3_GENCALL = (4)
                           000002   489  I2C_SR3_TRA = (2)
                           000001   490  I2C_SR3_BUSY = (1)
                           000000   491  I2C_SR3_MSL = (0)
                                    492 
                           000002   493  I2C_ITR_ITBUFEN = (2)
                           000001   494  I2C_ITR_ITEVTEN = (1)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           000000   495  I2C_ITR_ITERREN = (0)
                                    496 
                           000007   497  I2C_CCRH_FAST = 7 
                           000006   498  I2C_CCRH_DUTY = 6 
                                    499  
                                    500 ; Precalculated values, all in KHz
                           000080   501  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   502  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    503 ;
                                    504 ; Fast I2C mode max rise time = 300ns
                                    505 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    506 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    507 
                           000005   508  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    509 
                           0000C0   510  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   511  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   512  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    513 
                           000080   514  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   515  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   516  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    517 
                           000000   518  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   519  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    520 ;
                                    521 ; Standard I2C mode max rise time = 1000ns
                                    522 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    523 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    524 
                           000011   525  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    526 
                           000000   527  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   528  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   529  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    530 
                           000001   531  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   532  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   533  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    534 
                           000001   535  I2C_READ = 1
                           000000   536  I2C_WRITE = 0
                                    537 
                                    538 ; baudrate constant for brr_value table access
                                    539 ; to be used by uart_init 
                           000000   540 B2400=0
                           000001   541 B4800=1
                           000002   542 B9600=2
                           000003   543 B19200=3
                           000004   544 B38400=4
                           000005   545 B57600=5
                           000006   546 B115200=6
                           000007   547 B230400=7
                           000008   548 B460800=8
                           000009   549 B921600=9
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                                    550 
                                    551 ; UART registers offset from
                                    552 ; base address 
                           000000   553 OFS_UART_SR=0
                           000001   554 OFS_UART_DR=1
                           000002   555 OFS_UART_BRR1=2
                           000003   556 OFS_UART_BRR2=3
                           000004   557 OFS_UART_CR1=4
                           000005   558 OFS_UART_CR2=5
                           000006   559 OFS_UART_CR3=6
                           000007   560 OFS_UART_CR4=7
                           000008   561 OFS_UART_CR5=8
                           000009   562 OFS_UART_CR6=9
                           000009   563 OFS_UART_GTR=9
                           00000A   564 OFS_UART_PSCR=10
                                    565 
                                    566 ; uart identifier
                           000000   567  UART1 = 0 
                           000001   568  UART2 = 1
                           000002   569  UART3 = 2
                                    570 
                                    571 ; pins used by uart 
                           000005   572 UART1_TX_PIN=BIT5
                           000004   573 UART1_RX_PIN=BIT4
                           000005   574 UART3_TX_PIN=BIT5
                           000006   575 UART3_RX_PIN=BIT6
                                    576 ; uart port base address 
                           000000   577 UART1_PORT=PA 
                           00000F   578 UART3_PORT=PD
                                    579 
                                    580 ; UART1 
                           005230   581  UART1_BASE  = (0x5230)
                           005230   582  UART1_SR    = (0x5230)
                           005231   583  UART1_DR    = (0x5231)
                           005232   584  UART1_BRR1  = (0x5232)
                           005233   585  UART1_BRR2  = (0x5233)
                           005234   586  UART1_CR1   = (0x5234)
                           005235   587  UART1_CR2   = (0x5235)
                           005236   588  UART1_CR3   = (0x5236)
                           005237   589  UART1_CR4   = (0x5237)
                           005238   590  UART1_CR5   = (0x5238)
                           005239   591  UART1_GTR   = (0x5239)
                           00523A   592  UART1_PSCR  = (0x523A)
                                    593 
                                    594 ; UART3
                           005240   595  UART3_BASE  = (0x5240)
                           005240   596  UART3_SR    = (0x5240)
                           005241   597  UART3_DR    = (0x5241)
                           005242   598  UART3_BRR1  = (0x5242)
                           005243   599  UART3_BRR2  = (0x5243)
                           005244   600  UART3_CR1   = (0x5244)
                           005245   601  UART3_CR2   = (0x5245)
                           005246   602  UART3_CR3   = (0x5246)
                           005247   603  UART3_CR4   = (0x5247)
                           005249   604  UART3_CR6   = (0x5249)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                                    605 
                                    606 ; UART Status Register bits
                           000007   607  UART_SR_TXE = (7)
                           000006   608  UART_SR_TC = (6)
                           000005   609  UART_SR_RXNE = (5)
                           000004   610  UART_SR_IDLE = (4)
                           000003   611  UART_SR_OR = (3)
                           000002   612  UART_SR_NF = (2)
                           000001   613  UART_SR_FE = (1)
                           000000   614  UART_SR_PE = (0)
                                    615 
                                    616 ; Uart Control Register bits
                           000007   617  UART_CR1_R8 = (7)
                           000006   618  UART_CR1_T8 = (6)
                           000005   619  UART_CR1_UARTD = (5)
                           000004   620  UART_CR1_M = (4)
                           000003   621  UART_CR1_WAKE = (3)
                           000002   622  UART_CR1_PCEN = (2)
                           000001   623  UART_CR1_PS = (1)
                           000000   624  UART_CR1_PIEN = (0)
                                    625 
                           000007   626  UART_CR2_TIEN = (7)
                           000006   627  UART_CR2_TCIEN = (6)
                           000005   628  UART_CR2_RIEN = (5)
                           000004   629  UART_CR2_ILIEN = (4)
                           000003   630  UART_CR2_TEN = (3)
                           000002   631  UART_CR2_REN = (2)
                           000001   632  UART_CR2_RWU = (1)
                           000000   633  UART_CR2_SBK = (0)
                                    634 
                           000006   635  UART_CR3_LINEN = (6)
                           000005   636  UART_CR3_STOP1 = (5)
                           000004   637  UART_CR3_STOP0 = (4)
                           000003   638  UART_CR3_CLKEN = (3)
                           000002   639  UART_CR3_CPOL = (2)
                           000001   640  UART_CR3_CPHA = (1)
                           000000   641  UART_CR3_LBCL = (0)
                                    642 
                           000006   643  UART_CR4_LBDIEN = (6)
                           000005   644  UART_CR4_LBDL = (5)
                           000004   645  UART_CR4_LBDF = (4)
                           000003   646  UART_CR4_ADD3 = (3)
                           000002   647  UART_CR4_ADD2 = (2)
                           000001   648  UART_CR4_ADD1 = (1)
                           000000   649  UART_CR4_ADD0 = (0)
                                    650 
                           000005   651  UART_CR5_SCEN = (5)
                           000004   652  UART_CR5_NACK = (4)
                           000003   653  UART_CR5_HDSEL = (3)
                           000002   654  UART_CR5_IRLP = (2)
                           000001   655  UART_CR5_IREN = (1)
                                    656 ; LIN mode config register
                           000007   657  UART_CR6_LDUM = (7)
                           000005   658  UART_CR6_LSLV = (5)
                           000004   659  UART_CR6_LASE = (4)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                           000002   660  UART_CR6_LHDIEN = (2) 
                           000001   661  UART_CR6_LHDF = (1)
                           000000   662  UART_CR6_LSF = (0)
                                    663 
                                    664 ; TIMERS
                                    665 ; Timer 1 - 16-bit timer with complementary PWM outputs
                           005250   666  TIM1_CR1  = (0x5250)
                           005251   667  TIM1_CR2  = (0x5251)
                           005252   668  TIM1_SMCR  = (0x5252)
                           005253   669  TIM1_ETR  = (0x5253)
                           005254   670  TIM1_IER  = (0x5254)
                           005255   671  TIM1_SR1  = (0x5255)
                           005256   672  TIM1_SR2  = (0x5256)
                           005257   673  TIM1_EGR  = (0x5257)
                           005258   674  TIM1_CCMR1  = (0x5258)
                           005259   675  TIM1_CCMR2  = (0x5259)
                           00525A   676  TIM1_CCMR3  = (0x525A)
                           00525B   677  TIM1_CCMR4  = (0x525B)
                           00525C   678  TIM1_CCER1  = (0x525C)
                           00525D   679  TIM1_CCER2  = (0x525D)
                           00525E   680  TIM1_CNTRH  = (0x525E)
                           00525F   681  TIM1_CNTRL  = (0x525F)
                           005260   682  TIM1_PSCRH  = (0x5260)
                           005261   683  TIM1_PSCRL  = (0x5261)
                           005262   684  TIM1_ARRH  = (0x5262)
                           005263   685  TIM1_ARRL  = (0x5263)
                           005264   686  TIM1_RCR  = (0x5264)
                           005265   687  TIM1_CCR1H  = (0x5265)
                           005266   688  TIM1_CCR1L  = (0x5266)
                           005267   689  TIM1_CCR2H  = (0x5267)
                           005268   690  TIM1_CCR2L  = (0x5268)
                           005269   691  TIM1_CCR3H  = (0x5269)
                           00526A   692  TIM1_CCR3L  = (0x526A)
                           00526B   693  TIM1_CCR4H  = (0x526B)
                           00526C   694  TIM1_CCR4L  = (0x526C)
                           00526D   695  TIM1_BKR  = (0x526D)
                           00526E   696  TIM1_DTR  = (0x526E)
                           00526F   697  TIM1_OISR  = (0x526F)
                                    698 
                                    699 ; Timer Control Register bits
                           000007   700  TIM_CR1_ARPE = (7)
                           000006   701  TIM_CR1_CMSH = (6)
                           000005   702  TIM_CR1_CMSL = (5)
                           000004   703  TIM_CR1_DIR = (4)
                           000003   704  TIM_CR1_OPM = (3)
                           000002   705  TIM_CR1_URS = (2)
                           000001   706  TIM_CR1_UDIS = (1)
                           000000   707  TIM_CR1_CEN = (0)
                                    708 
                           000006   709  TIM1_CR2_MMS2 = (6)
                           000005   710  TIM1_CR2_MMS1 = (5)
                           000004   711  TIM1_CR2_MMS0 = (4)
                           000002   712  TIM1_CR2_COMS = (2)
                           000000   713  TIM1_CR2_CCPC = (0)
                                    714 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                                    715 ; Timer Slave Mode Control bits
                           000007   716  TIM1_SMCR_MSM = (7)
                           000006   717  TIM1_SMCR_TS2 = (6)
                           000005   718  TIM1_SMCR_TS1 = (5)
                           000004   719  TIM1_SMCR_TS0 = (4)
                           000002   720  TIM1_SMCR_SMS2 = (2)
                           000001   721  TIM1_SMCR_SMS1 = (1)
                           000000   722  TIM1_SMCR_SMS0 = (0)
                                    723 
                                    724 ; Timer External Trigger Enable bits
                           000007   725  TIM1_ETR_ETP = (7)
                           000006   726  TIM1_ETR_ECE = (6)
                           000005   727  TIM1_ETR_ETPS1 = (5)
                           000004   728  TIM1_ETR_ETPS0 = (4)
                           000003   729  TIM1_ETR_ETF3 = (3)
                           000002   730  TIM1_ETR_ETF2 = (2)
                           000001   731  TIM1_ETR_ETF1 = (1)
                           000000   732  TIM1_ETR_ETF0 = (0)
                                    733 
                                    734 ; Timer Interrupt Enable bits
                           000007   735  TIM1_IER_BIE = (7)
                           000006   736  TIM1_IER_TIE = (6)
                           000005   737  TIM1_IER_COMIE = (5)
                           000004   738  TIM1_IER_CC4IE = (4)
                           000003   739  TIM1_IER_CC3IE = (3)
                           000002   740  TIM1_IER_CC2IE = (2)
                           000001   741  TIM1_IER_CC1IE = (1)
                           000000   742  TIM1_IER_UIE = (0)
                                    743 
                                    744 ; Timer Status Register bits
                           000007   745  TIM1_SR1_BIF = (7)
                           000006   746  TIM1_SR1_TIF = (6)
                           000005   747  TIM1_SR1_COMIF = (5)
                           000004   748  TIM1_SR1_CC4IF = (4)
                           000003   749  TIM1_SR1_CC3IF = (3)
                           000002   750  TIM1_SR1_CC2IF = (2)
                           000001   751  TIM1_SR1_CC1IF = (1)
                           000000   752  TIM1_SR1_UIF = (0)
                                    753 
                           000004   754  TIM1_SR2_CC4OF = (4)
                           000003   755  TIM1_SR2_CC3OF = (3)
                           000002   756  TIM1_SR2_CC2OF = (2)
                           000001   757  TIM1_SR2_CC1OF = (1)
                                    758 
                                    759 ; Timer Event Generation Register bits
                           000007   760  TIM1_EGR_BG = (7)
                           000006   761  TIM1_EGR_TG = (6)
                           000005   762  TIM1_EGR_COMG = (5)
                           000004   763  TIM1_EGR_CC4G = (4)
                           000003   764  TIM1_EGR_CC3G = (3)
                           000002   765  TIM1_EGR_CC2G = (2)
                           000001   766  TIM1_EGR_CC1G = (1)
                           000000   767  TIM1_EGR_UG = (0)
                                    768 
                                    769 ; Capture/Compare Mode Register 1 - channel configured in output
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           000007   770  TIM1_CCMR1_OC1CE = (7)
                           000006   771  TIM1_CCMR1_OC1M2 = (6)
                           000005   772  TIM1_CCMR1_OC1M1 = (5)
                           000004   773  TIM1_CCMR1_OC1M0 = (4)
                           000003   774  TIM1_CCMR1_OC1PE = (3)
                           000002   775  TIM1_CCMR1_OC1FE = (2)
                           000001   776  TIM1_CCMR1_CC1S1 = (1)
                           000000   777  TIM1_CCMR1_CC1S0 = (0)
                                    778 
                                    779 ; Capture/Compare Mode Register 1 - channel configured in input
                           000007   780  TIM1_CCMR1_IC1F3 = (7)
                           000006   781  TIM1_CCMR1_IC1F2 = (6)
                           000005   782  TIM1_CCMR1_IC1F1 = (5)
                           000004   783  TIM1_CCMR1_IC1F0 = (4)
                           000003   784  TIM1_CCMR1_IC1PSC1 = (3)
                           000002   785  TIM1_CCMR1_IC1PSC0 = (2)
                                    786 ;  TIM1_CCMR1_CC1S1 = (1)
                           000000   787  TIM1_CCMR1_CC1S0 = (0)
                                    788 
                                    789 ; Capture/Compare Mode Register 2 - channel configured in output
                           000007   790  TIM1_CCMR2_OC2CE = (7)
                           000006   791  TIM1_CCMR2_OC2M2 = (6)
                           000005   792  TIM1_CCMR2_OC2M1 = (5)
                           000004   793  TIM1_CCMR2_OC2M0 = (4)
                           000003   794  TIM1_CCMR2_OC2PE = (3)
                           000002   795  TIM1_CCMR2_OC2FE = (2)
                           000001   796  TIM1_CCMR2_CC2S1 = (1)
                           000000   797  TIM1_CCMR2_CC2S0 = (0)
                                    798 
                                    799 ; Capture/Compare Mode Register 2 - channel configured in input
                           000007   800  TIM1_CCMR2_IC2F3 = (7)
                           000006   801  TIM1_CCMR2_IC2F2 = (6)
                           000005   802  TIM1_CCMR2_IC2F1 = (5)
                           000004   803  TIM1_CCMR2_IC2F0 = (4)
                           000003   804  TIM1_CCMR2_IC2PSC1 = (3)
                           000002   805  TIM1_CCMR2_IC2PSC0 = (2)
                                    806 ;  TIM1_CCMR2_CC2S1 = (1)
                           000000   807  TIM1_CCMR2_CC2S0 = (0)
                                    808 
                                    809 ; Capture/Compare Mode Register 3 - channel configured in output
                           000007   810  TIM1_CCMR3_OC3CE = (7)
                           000006   811  TIM1_CCMR3_OC3M2 = (6)
                           000005   812  TIM1_CCMR3_OC3M1 = (5)
                           000004   813  TIM1_CCMR3_OC3M0 = (4)
                           000003   814  TIM1_CCMR3_OC3PE = (3)
                           000002   815  TIM1_CCMR3_OC3FE = (2)
                           000001   816  TIM1_CCMR3_CC3S1 = (1)
                           000000   817  TIM1_CCMR3_CC3S0 = (0)
                                    818 
                                    819 ; Capture/Compare Mode Register 3 - channel configured in input
                           000007   820  TIM1_CCMR3_IC3F3 = (7)
                           000006   821  TIM1_CCMR3_IC3F2 = (6)
                           000005   822  TIM1_CCMR3_IC3F1 = (5)
                           000004   823  TIM1_CCMR3_IC3F0 = (4)
                           000003   824  TIM1_CCMR3_IC3PSC1 = (3)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                           000002   825  TIM1_CCMR3_IC3PSC0 = (2)
                                    826 ;  TIM1_CCMR3_CC3S1 = (1)
                           000000   827  TIM1_CCMR3_CC3S0 = (0)
                                    828 
                                    829 ; Capture/Compare Mode Register 4 - channel configured in output
                           000007   830  TIM1_CCMR4_OC4CE = (7)
                           000006   831  TIM1_CCMR4_OC4M2 = (6)
                           000005   832  TIM1_CCMR4_OC4M1 = (5)
                           000004   833  TIM1_CCMR4_OC4M0 = (4)
                           000003   834  TIM1_CCMR4_OC4PE = (3)
                           000002   835  TIM1_CCMR4_OC4FE = (2)
                           000001   836  TIM1_CCMR4_CC4S1 = (1)
                           000000   837  TIM1_CCMR4_CC4S0 = (0)
                                    838 
                                    839 ; Capture/Compare Mode Register 4 - channel configured in input
                           000007   840  TIM1_CCMR4_IC4F3 = (7)
                           000006   841  TIM1_CCMR4_IC4F2 = (6)
                           000005   842  TIM1_CCMR4_IC4F1 = (5)
                           000004   843  TIM1_CCMR4_IC4F0 = (4)
                           000003   844  TIM1_CCMR4_IC4PSC1 = (3)
                           000002   845  TIM1_CCMR4_IC4PSC0 = (2)
                                    846 ;  TIM1_CCMR4_CC4S1 = (1)
                           000000   847  TIM1_CCMR4_CC4S0 = (0)
                                    848 
                                    849 ; Timer 2 - 16-bit timer
                           005300   850  TIM2_CR1  = (0x5300)
                           005301   851  TIM2_IER  = (0x5301)
                           005302   852  TIM2_SR1  = (0x5302)
                           005303   853  TIM2_SR2  = (0x5303)
                           005304   854  TIM2_EGR  = (0x5304)
                           005305   855  TIM2_CCMR1  = (0x5305)
                           005306   856  TIM2_CCMR2  = (0x5306)
                           005307   857  TIM2_CCMR3  = (0x5307)
                           005308   858  TIM2_CCER1  = (0x5308)
                           005309   859  TIM2_CCER2  = (0x5309)
                           00530A   860  TIM2_CNTRH  = (0x530A)
                           00530B   861  TIM2_CNTRL  = (0x530B)
                           00530C   862  TIM2_PSCR  = (0x530C)
                           00530D   863  TIM2_ARRH  = (0x530D)
                           00530E   864  TIM2_ARRL  = (0x530E)
                           00530F   865  TIM2_CCR1H  = (0x530F)
                           005310   866  TIM2_CCR1L  = (0x5310)
                           005311   867  TIM2_CCR2H  = (0x5311)
                           005312   868  TIM2_CCR2L  = (0x5312)
                           005313   869  TIM2_CCR3H  = (0x5313)
                           005314   870  TIM2_CCR3L  = (0x5314)
                                    871 
                                    872 ; TIM2_CR1 bitfields
                           000000   873  TIM2_CR1_CEN=(0) ; Counter enable
                           000001   874  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   875  TIM2_CR1_URS=(2) ; Update request source
                           000003   876  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   877  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
                                    878 
                                    879 ; TIMER2_CCMR bitfields 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                           000000   880  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   881  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   882  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    883 
                                    884 ; TIMER2_CCER1 bitfields
                           000000   885  TIM2_CCER1_CC1E=(0)
                           000001   886  TIM2_CCER1_CC1P=(1)
                           000004   887  TIM2_CCER1_CC2E=(4)
                           000005   888  TIM2_CCER1_CC2P=(5)
                                    889 
                                    890 ; TIMER2_EGR bitfields
                           000000   891  TIM2_EGR_UG=(0) ; update generation
                           000001   892  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   893  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   894  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   895  TIM2_EGR_TG=(6); Trigger generation
                                    896 
                                    897 ; Timer 3
                           005320   898  TIM3_CR1  = (0x5320)
                           005321   899  TIM3_IER  = (0x5321)
                           005322   900  TIM3_SR1  = (0x5322)
                           005323   901  TIM3_SR2  = (0x5323)
                           005324   902  TIM3_EGR  = (0x5324)
                           005325   903  TIM3_CCMR1  = (0x5325)
                           005326   904  TIM3_CCMR2  = (0x5326)
                           005327   905  TIM3_CCER1  = (0x5327)
                           005328   906  TIM3_CNTRH  = (0x5328)
                           005329   907  TIM3_CNTRL  = (0x5329)
                           00532A   908  TIM3_PSCR  = (0x532A)
                           00532B   909  TIM3_ARRH  = (0x532B)
                           00532C   910  TIM3_ARRL  = (0x532C)
                           00532D   911  TIM3_CCR1H  = (0x532D)
                           00532E   912  TIM3_CCR1L  = (0x532E)
                           00532F   913  TIM3_CCR2H  = (0x532F)
                           005330   914  TIM3_CCR2L  = (0x5330)
                                    915 
                                    916 ; TIM3_CR1  fields
                           000000   917  TIM3_CR1_CEN = (0)
                           000001   918  TIM3_CR1_UDIS = (1)
                           000002   919  TIM3_CR1_URS = (2)
                           000003   920  TIM3_CR1_OPM = (3)
                           000007   921  TIM3_CR1_ARPE = (7)
                                    922 ; TIM3_CCR2  fields
                           000000   923  TIM3_CCMR2_CC2S_POS = (0)
                           000003   924  TIM3_CCMR2_OC2PE_POS = (3)
                           000004   925  TIM3_CCMR2_OC2M_POS = (4)  
                                    926 ; TIM3_CCER1 fields
                           000000   927  TIM3_CCER1_CC1E = (0)
                           000001   928  TIM3_CCER1_CC1P = (1)
                           000004   929  TIM3_CCER1_CC2E = (4)
                           000005   930  TIM3_CCER1_CC2P = (5)
                                    931 ; TIM3_CCER2 fields
                           000000   932  TIM3_CCER2_CC3E = (0)
                           000001   933  TIM3_CCER2_CC3P = (1)
                                    934 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                                    935 ; Timer 4
                           005340   936  TIM4_CR1  = (0x5340)
                           005341   937  TIM4_IER  = (0x5341)
                           005342   938  TIM4_SR  = (0x5342)
                           005343   939  TIM4_EGR  = (0x5343)
                           005344   940  TIM4_CNTR  = (0x5344)
                           005345   941  TIM4_PSCR  = (0x5345)
                           005346   942  TIM4_ARR  = (0x5346)
                                    943 
                                    944 ; Timer 4 bitmasks
                                    945 
                           000007   946  TIM4_CR1_ARPE = (7)
                           000003   947  TIM4_CR1_OPM = (3)
                           000002   948  TIM4_CR1_URS = (2)
                           000001   949  TIM4_CR1_UDIS = (1)
                           000000   950  TIM4_CR1_CEN = (0)
                                    951 
                           000000   952  TIM4_IER_UIE = (0)
                                    953 
                           000000   954  TIM4_SR_UIF = (0)
                                    955 
                           000000   956  TIM4_EGR_UG = (0)
                                    957 
                           000002   958  TIM4_PSCR_PSC2 = (2)
                           000001   959  TIM4_PSCR_PSC1 = (1)
                           000000   960  TIM4_PSCR_PSC0 = (0)
                                    961 
                           000000   962  TIM4_PSCR_1 = 0
                           000001   963  TIM4_PSCR_2 = 1
                           000002   964  TIM4_PSCR_4 = 2
                           000003   965  TIM4_PSCR_8 = 3
                           000004   966  TIM4_PSCR_16 = 4
                           000005   967  TIM4_PSCR_32 = 5
                           000006   968  TIM4_PSCR_64 = 6
                           000007   969  TIM4_PSCR_128 = 7
                                    970 
                                    971 ; ADC2
                           005400   972  ADC_CSR  = (0x5400)
                           005401   973  ADC_CR1  = (0x5401)
                           005402   974  ADC_CR2  = (0x5402)
                           005403   975  ADC_CR3  = (0x5403)
                           005404   976  ADC_DRH  = (0x5404)
                           005405   977  ADC_DRL  = (0x5405)
                           005406   978  ADC_TDRH  = (0x5406)
                           005407   979  ADC_TDRL  = (0x5407)
                                    980  
                                    981 ; ADC bitmasks
                                    982 
                           000007   983  ADC_CSR_EOC = (7)
                           000006   984  ADC_CSR_AWD = (6)
                           000005   985  ADC_CSR_EOCIE = (5)
                           000004   986  ADC_CSR_AWDIE = (4)
                           000003   987  ADC_CSR_CH3 = (3)
                           000002   988  ADC_CSR_CH2 = (2)
                           000001   989  ADC_CSR_CH1 = (1)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000000   990  ADC_CSR_CH0 = (0)
                                    991 
                           000006   992  ADC_CR1_SPSEL2 = (6)
                           000005   993  ADC_CR1_SPSEL1 = (5)
                           000004   994  ADC_CR1_SPSEL0 = (4)
                           000001   995  ADC_CR1_CONT = (1)
                           000000   996  ADC_CR1_ADON = (0)
                                    997 
                           000006   998  ADC_CR2_EXTTRIG = (6)
                           000005   999  ADC_CR2_EXTSEL1 = (5)
                           000004  1000  ADC_CR2_EXTSEL0 = (4)
                           000003  1001  ADC_CR2_ALIGN = (3)
                           000001  1002  ADC_CR2_SCAN = (1)
                                   1003 
                           000007  1004  ADC_CR3_DBUF = (7)
                           000006  1005  ADC_CR3_DRH = (6)
                                   1006 
                                   1007 ; beCAN
                           005420  1008  CAN_MCR = (0x5420)
                           005421  1009  CAN_MSR = (0x5421)
                           005422  1010  CAN_TSR = (0x5422)
                           005423  1011  CAN_TPR = (0x5423)
                           005424  1012  CAN_RFR = (0x5424)
                           005425  1013  CAN_IER = (0x5425)
                           005426  1014  CAN_DGR = (0x5426)
                           005427  1015  CAN_FPSR = (0x5427)
                           005428  1016  CAN_P0 = (0x5428)
                           005429  1017  CAN_P1 = (0x5429)
                           00542A  1018  CAN_P2 = (0x542A)
                           00542B  1019  CAN_P3 = (0x542B)
                           00542C  1020  CAN_P4 = (0x542C)
                           00542D  1021  CAN_P5 = (0x542D)
                           00542E  1022  CAN_P6 = (0x542E)
                           00542F  1023  CAN_P7 = (0x542F)
                           005430  1024  CAN_P8 = (0x5430)
                           005431  1025  CAN_P9 = (0x5431)
                           005432  1026  CAN_PA = (0x5432)
                           005433  1027  CAN_PB = (0x5433)
                           005434  1028  CAN_PC = (0x5434)
                           005435  1029  CAN_PD = (0x5435)
                           005436  1030  CAN_PE = (0x5436)
                           005437  1031  CAN_PF = (0x5437)
                                   1032 
                                   1033 
                                   1034 ; CPU
                           007F00  1035  CPU_A  = (0x7F00)
                           007F01  1036  CPU_PCE  = (0x7F01)
                           007F02  1037  CPU_PCH  = (0x7F02)
                           007F03  1038  CPU_PCL  = (0x7F03)
                           007F04  1039  CPU_XH  = (0x7F04)
                           007F05  1040  CPU_XL  = (0x7F05)
                           007F06  1041  CPU_YH  = (0x7F06)
                           007F07  1042  CPU_YL  = (0x7F07)
                           007F08  1043  CPU_SPH  = (0x7F08)
                           007F09  1044  CPU_SPL   = (0x7F09)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           007F0A  1045  CPU_CCR   = (0x7F0A)
                                   1046 
                                   1047 ; global configuration register
                           007F60  1048  CFG_GCR   = (0x7F60)
                           000001  1049  CFG_GCR_AL = 1
                           000000  1050  CFG_GCR_SWIM = 0
                                   1051 
                                   1052 ; interrupt software priority 
                           007F70  1053  ITC_SPR1   = (0x7F70) ; (0..3) 0->resreved,AWU..EXT0 
                           007F71  1054  ITC_SPR2   = (0x7F71) ; (4..7) EXT1..EXT4 RX 
                           007F72  1055  ITC_SPR3   = (0x7F72) ; (8..11) beCAN RX..TIM1 UPDT/OVR  
                           007F73  1056  ITC_SPR4   = (0x7F73) ; (12..15) TIM1 CAP/CMP .. TIM3 UPDT/OVR 
                           007F74  1057  ITC_SPR5   = (0x7F74) ; (16..19) TIM3 CAP/CMP..I2C  
                           007F75  1058  ITC_SPR6   = (0x7F75) ; (20..23) UART3 TX..TIM4 CAP/OVR 
                           007F76  1059  ITC_SPR7   = (0x7F76) ; (24..29) FLASH WR..
                           007F77  1060  ITC_SPR8   = (0x7F77) ; (30..32) ..
                                   1061 
                           000001  1062 ITC_SPR_LEVEL1=1 
                           000000  1063 ITC_SPR_LEVEL2=0
                           000003  1064 ITC_SPR_LEVEL3=3 
                                   1065 
                                   1066 ; SWIM, control and status register
                           007F80  1067  SWIM_CSR   = (0x7F80)
                                   1068 ; debug registers
                           007F90  1069  DM_BK1RE   = (0x7F90)
                           007F91  1070  DM_BK1RH   = (0x7F91)
                           007F92  1071  DM_BK1RL   = (0x7F92)
                           007F93  1072  DM_BK2RE   = (0x7F93)
                           007F94  1073  DM_BK2RH   = (0x7F94)
                           007F95  1074  DM_BK2RL   = (0x7F95)
                           007F96  1075  DM_CR1   = (0x7F96)
                           007F97  1076  DM_CR2   = (0x7F97)
                           007F98  1077  DM_CSR1   = (0x7F98)
                           007F99  1078  DM_CSR2   = (0x7F99)
                           007F9A  1079  DM_ENFCTR   = (0x7F9A)
                                   1080 
                                   1081 ; Interrupt Numbers
                           000000  1082  INT_TLI = 0
                           000001  1083  INT_AWU = 1
                           000002  1084  INT_CLK = 2
                           000003  1085  INT_EXTI0 = 3
                           000004  1086  INT_EXTI1 = 4
                           000005  1087  INT_EXTI2 = 5
                           000006  1088  INT_EXTI3 = 6
                           000007  1089  INT_EXTI4 = 7
                           000008  1090  INT_CAN_RX = 8
                           000009  1091  INT_CAN_TX = 9
                           00000A  1092  INT_SPI = 10
                           00000B  1093  INT_TIM1_OVF = 11
                           00000C  1094  INT_TIM1_CCM = 12
                           00000D  1095  INT_TIM2_OVF = 13
                           00000E  1096  INT_TIM2_CCM = 14
                           00000F  1097  INT_TIM3_OVF = 15
                           000010  1098  INT_TIM3_CCM = 16
                           000011  1099  INT_UART1_TX_COMPLETED = 17
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           000012  1100  INT_AUART1_RX_FULL = 18
                           000013  1101  INT_I2C = 19
                           000014  1102  INT_UART3_TX_COMPLETED = 20
                           000015  1103  INT_UART3_RX_FULL = 21
                           000016  1104  INT_ADC2 = 22
                           000017  1105  INT_TIM4_OVF = 23
                           000018  1106  INT_FLASH = 24
                                   1107 
                                   1108 ; Interrupt Vectors
                           008000  1109  INT_VECTOR_RESET = 0x8000
                           008004  1110  INT_VECTOR_TRAP = 0x8004
                           008008  1111  INT_VECTOR_TLI = 0x8008
                           00800C  1112  INT_VECTOR_AWU = 0x800C
                           008010  1113  INT_VECTOR_CLK = 0x8010
                           008014  1114  INT_VECTOR_EXTI0 = 0x8014
                           008018  1115  INT_VECTOR_EXTI1 = 0x8018
                           00801C  1116  INT_VECTOR_EXTI2 = 0x801C
                           008020  1117  INT_VECTOR_EXTI3 = 0x8020
                           008024  1118  INT_VECTOR_EXTI4 = 0x8024
                           008028  1119  INT_VECTOR_CAN_RX = 0x8028
                           00802C  1120  INT_VECTOR_CAN_TX = 0x802c
                           008030  1121  INT_VECTOR_SPI = 0x8030
                           008034  1122  INT_VECTOR_TIM1_OVF = 0x8034
                           008038  1123  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C  1124  INT_VECTOR_TIM2_OVF = 0x803C
                           008040  1125  INT_VECTOR_TIM2_CCM = 0x8040
                           008044  1126  INT_VECTOR_TIM3_OVF = 0x8044
                           008048  1127  INT_VECTOR_TIM3_CCM = 0x8048
                           00804C  1128  INT_VECTOR_UART1_TX_COMPLETED = 0x804c
                           008050  1129  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1130  INT_VECTOR_I2C = 0x8054
                           008058  1131  INT_VECTOR_UART3_TX_COMPLETED = 0x8058
                           00805C  1132  INT_VECTOR_UART3_RX_FULL = 0x805C
                           008060  1133  INT_VECTOR_ADC2 = 0x8060
                           008064  1134  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1135  INT_VECTOR_FLASH = 0x8068
                                   1136 
                                   1137 ; Condition code register bits
                           000007  1138 CC_V = 7  ; overflow flag 
                           000005  1139 CC_I1= 5  ; interrupt bit 1
                           000004  1140 CC_H = 4  ; half carry 
                           000003  1141 CC_I0 = 3 ; interrupt bit 0
                           000002  1142 CC_N = 2 ;  negative flag 
                           000001  1143 CC_Z = 1 ;  zero flag  
                           000000  1144 CC_C = 0 ; carry bit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                                     36     .include "inc/nucleo_8s207.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; NUCLEO-8S208RB board specific definitions
                                     20 ; Date: 2019/10/29
                                     21 ; author: Jacques Deschênes, copyright 2018,2019
                                     22 ; licence: GPLv3
                                     23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     24 
                                     25 ; mcu on board is stm8s207k8
                                     26 
                                     27 ; crystal on board is 8Mhz
                                     28 ; st-link crystal 
                           7A1200    29 FHSE = 8000000
                                     30 
                                     31 ; LD3 is user LED
                                     32 ; connected to PC5 via Q2
                           00500A    33 LED_PORT = PC_BASE ;port C
                           000005    34 LED_BIT = 5
                           000020    35 LED_MASK = (1<<LED_BIT) ;bit 5 mask
                                     36 
                                     37 ; user interface UART via STLINK (T_VCP)
                                     38 
                           000002    39 UART=UART3 
                                     40 ; port used by  UART3 
                           00500A    41 UART_PORT_ODR=PC_ODR 
                           00500C    42 UART_PORT_DDR=PC_DDR 
                           00500B    43 UART_PORT_IDR=PC_IDR 
                           00500D    44 UART_PORT_CR1=PC_CR1 
                           00500E    45 UART_PORT_CR2=PC_CR2 
                                     46 
                                     47 ; clock enable bit 
                           000003    48 UART_PCKEN=CLK_PCKENR1_UART3 
                                     49 
                                     50 ; uart3 registers 
                           005240    51 UART_SR=UART3_SR
                           005241    52 UART_DR=UART3_DR
                           005242    53 UART_BRR1=UART3_BRR1
                           005243    54 UART_BRR2=UART3_BRR2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                           005244    55 UART_CR1=UART3_CR1
                           005245    56 UART_CR2=UART3_CR2
                                     57 
                                     58 ; TX, RX pin
                           000005    59 UART_TX_PIN=UART3_TX_PIN 
                           000006    60 UART_RX_PIN=UART3_RX_PIN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     37 .endif 
                                     38 
                                     39 ; all boards includes 
                                     40 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                                     41 	.include "inc/ascii.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------------------------
                                     20 ;     ASCII control  values
                                     21 ;     CTRL_x   are VT100 keyboard values  
                                     22 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                     23 ;-------------------------------------------------------
                           000001    24 		CTRL_A = 1
                           000001    25 		SOH=CTRL_A  ; start of heading 
                           000002    26 		CTRL_B = 2
                           000002    27 		STX=CTRL_B  ; start of text 
                           000003    28 		CTRL_C = 3
                           000003    29 		ETX=CTRL_C  ; end of text 
                           000004    30 		CTRL_D = 4
                           000004    31 		EOT=CTRL_D  ; end of transmission 
                           000005    32 		CTRL_E = 5
                           000005    33 		ENQ=CTRL_E  ; enquery 
                           000006    34 		CTRL_F = 6
                           000006    35 		ACK=CTRL_F  ; acknowledge
                           000007    36 		CTRL_G = 7
                           000007    37         BELL = 7    ; vt100 terminal generate a sound.
                           000008    38 		CTRL_H = 8  
                           000008    39 		BS = 8     ; back space 
                           000009    40         CTRL_I = 9
                           000009    41     	TAB = 9     ; horizontal tabulation
                           00000A    42         CTRL_J = 10 
                           00000A    43 		LF = 10     ; line feed
                           00000B    44 		CTRL_K = 11
                           00000B    45         VT = 11     ; vertical tabulation 
                           00000C    46 		CTRL_L = 12
                           00000C    47         FF = 12      ; new page
                           00000D    48 		CTRL_M = 13
                           00000D    49 		CR = 13      ; carriage return 
                           00000E    50 		CTRL_N = 14
                           00000E    51 		SO=CTRL_N    ; shift out 
                           00000F    52 		CTRL_O = 15
                           00000F    53 		SI=CTRL_O    ; shift in 
                           000010    54 		CTRL_P = 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                           000010    55 		DLE=CTRL_P   ; data link escape 
                           000011    56 		CTRL_Q = 17
                           000011    57 		DC1=CTRL_Q   ; device control 1 
                           000011    58 		XON=DC1 
                           000012    59 		CTRL_R = 18
                           000012    60 		DC2=CTRL_R   ; device control 2 
                           000013    61 		CTRL_S = 19
                           000013    62 		DC3=CTRL_S   ; device control 3
                           000013    63 		XOFF=DC3 
                           000014    64 		CTRL_T = 20
                           000014    65 		DC4=CTRL_T   ; device control 4 
                           000015    66 		CTRL_U = 21
                           000015    67 		NAK=CTRL_U   ; negative acknowledge
                           000016    68 		CTRL_V = 22
                           000016    69 		SYN=CTRL_V   ; synchronous idle 
                           000017    70 		CTRL_W = 23
                           000017    71 		ETB=CTRL_W   ; end of transmission block
                           000018    72 		CTRL_X = 24
                           000018    73 		CAN=CTRL_X   ; cancel 
                           000019    74 		CTRL_Y = 25
                           000019    75 		EM=CTRL_Y    ; end of medium
                           00001A    76 		CTRL_Z = 26
                           00001A    77 		SUB=CTRL_Z   ; substitute 
                           00001A    78 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    79 		ESC = 27     ; escape 
                           00001C    80 		FS=28        ; file separator 
                           00001D    81 		GS=29        ; group separator 
                           00001E    82 		RS=30		 ; record separator 
                           00001F    83 		US=31 		 ; unit separator 
                           000020    84 		SPACE = 32
                           00002C    85 		COMMA = 44
                           00003A    86 		COLON = 58 
                           00003B    87 		SEMIC = 59  
                           000023    88 		SHARP = 35
                           000027    89 		TICK = 39
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



                                     42 	.include "inc/gen_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 ;   console Input/Output module
                                     20 ;   DATE: 2019-12-11
                                     21 ;    
                                     22 ;   General usage macros.   
                                     23 ;
                                     24 ;--------------------------------------
                                     25 
                                     26     ; reserve space on stack
                                     27     ; for local variables
                                     28     .macro _vars n 
                                     29     sub sp,#n 
                                     30     .endm 
                                     31     
                                     32     ; free space on stack
                                     33     .macro _drop n 
                                     34     addw sp,#n 
                                     35     .endm
                                     36 
                                     37     ; declare ARG_OFS for arguments 
                                     38     ; displacement on stack. This 
                                     39     ; value depend on local variables 
                                     40     ; size.
                                     41     .macro _argofs n 
                                     42     ARG_OFS=2+n 
                                     43     .endm 
                                     44 
                                     45     ; declare a function argument 
                                     46     ; position relative to stack pointer 
                                     47     ; _argofs must be called before it.
                                     48     .macro _arg name ofs 
                                     49     name=ARG_OFS+ofs 
                                     50     .endm 
                                     51 
                                     52     ; software reset 
                                     53     .macro _swreset
                                     54     mov WWDG_CR,#0X80
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                     55     .endm 
                                     56 
                                     57     ; increment zero page variable 
                                     58     .macro _incz v 
                                     59     .byte 0x3c, v 
                                     60     .endm 
                                     61 
                                     62     ; decrement zero page variable 
                                     63     .macro _decz v 
                                     64     .byte 0x3a,v 
                                     65     .endm 
                                     66 
                                     67     ; clear zero page variable 
                                     68     .macro _clrz v 
                                     69     .byte 0x3f, v 
                                     70     .endm 
                                     71 
                                     72     ; load A zero page variable 
                                     73     .macro _ldaz v 
                                     74     .byte 0xb6,v 
                                     75     .endm 
                                     76 
                                     77     ; store A zero page variable 
                                     78     .macro _straz v 
                                     79     .byte 0xb7,v 
                                     80     .endm 
                                     81 
                                     82     ; tnz zero page variable 
                                     83     .macro _tnz v 
                                     84     .byte 0x3d,v 
                                     85     .endm 
                                     86 
                                     87     ; load x from variable in zero page 
                                     88     .macro _ldxz v 
                                     89     .byte 0xbe,v 
                                     90     .endm 
                                     91 
                                     92     ; load y from variable in zero page 
                                     93     .macro _ldyz v 
                                     94     .byte 0x90,0xbe,v 
                                     95     .endm 
                                     96 
                                     97     ; store x in zero page variable 
                                     98     .macro _strxz v 
                                     99     .byte 0xbf,v 
                                    100     .endm 
                                    101 
                                    102     ; store y in zero page variable 
                                    103     .macro _stryz v 
                                    104     .byte 0x90,0xbf,v 
                                    105     .endm 
                                    106 
                                    107     ;  increment 16 bits variable
                                    108     ;  use 10 bytes  
                                    109     .macro _incwz  v 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                    110         _incz v+1   ; 1 cy, 2 bytes 
                                    111         jrne .+4  ; 1|2 cy, 2 bytes 
                                    112         _incz v     ; 1 cy, 2 bytes  
                                    113     .endm ; 3 cy 
                                    114 
                                    115     ; xor op with zero page variable 
                                    116     .macro _xorz v 
                                    117     .byte 0xb8,v 
                                    118     .endm 
                                    119     
                                    120     ; move memory to memory in 0 page 
                                    121     .macro _movzz a1, a2 
                                    122     .byte 0x45,a2,a1 
                                    123     .endm 
                                    124 
                                    125     ; check point 
                                    126     ; for debugging help 
                                    127     ; display a character 
                                    128     .macro _cp ch 
                                    129     ld a,#ch 
                                    130     call uart_putc 
                                    131     .endm 
                                    132     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                     43 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                           000004    19         TAB_WIDTH=4 ; default tabulation width 
                           0000FF    20         EOF=0xff ; end of file marker 
                           00000F    21         NLEN_MASK=0xf  ; mask to extract name len 
                           0000F0    22         KW_TYPE_MASK=0xf0 ; mask to extract keyword type 
                                     23 
                                     24 
                           000080    25 	STACK_SIZE=128
                           0017FF    26 	STACK_EMPTY=RAM_SIZE-1  
                           000010    27 	PENDING_STACK_SIZE= 16
                                     28 
                                     29     ; boolean bit in 'flags' variable 
                           000000    30     FRUN=0 ; program running 
                           000001    31 	FOPT=1 ; run time optimization flag  
                           000003    32 	FSLEEP=3 ; halt resulting from  SLEEP 
                           000004    33 	FSTOP=4 ; STOP command flag 
                           000005    34 	FCOMP=5  ; compiling flags 
                           000006    35     FAUTO=6 ; auto line numbering . 
                           000007    36     FTRACE=7 ; trace flag 
                                     37 
                           000003    38     LINE_HEADER_SIZE=3 ; line number 2 bytes and line length 1 byte 
                           000004    39     FIRST_DATA_ITEM=LINE_HEADER_SIZE+1 ; skip over DATA_IDX token.
                                     40 
                           007FFF    41 	MAX_LINENO=0x7fff; BASIC maximum line number 
                                     42 
                           000008    43 	RX_QUEUE_SIZE=8 
                                     44 
                           00F424    45     TIM2_CLK_FREQ=62500
                                     46 
                           000080    47 	TIB_SIZE=128
                           000080    48     PAD_SIZE=BLOCK_SIZE 
                                     49 
                           000002    50     ADR_SIZE=2  ; bytes 
                           000002    51     NAME_SIZE=2 ; bytes 
                                     52     
                                     53 
                           000001    54     STDOUT=1 ; output to uart
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                           000003    55     BUFOUT=3 ; buffered output  
                                     56 
                           000001    57     TOS=1 ; offset of top of stack parameter on stack 
                                     58 
                           0000FF    59     EOF=0xff ; end of file marker
                                     60     
                           0000F0    61     TYPE_MASK=0xf0 ; mask to extract data type, i.e. DIM variable symbol  or CONST symbol 
                           000010    62     TYPE_DVAR=(1<<4); DIM variable type 
                           000020    63     TYPE_CONST=(2<<4); CONST data 
                           00000F    64     NLEN_MASK=0xf  ; mask to extract name len 
                           0000FF    65     NONE_IDX = 255 ; not a token 
                                     66 
                           005042    67     SIGNATURE="PB" ; program signature field 
                                     68 
                                     69 ;--------------------------------------
                                     70 ;   assembler flags 
                                     71 ;-------------------------------------
                                     72 ;    MATH_OVF=0 ; if 1 the stop on math overflow 
                                     73 
                                     74     ; assume 16 Mhz Fcpu 
                                     75      .macro _usec_dly n 
                                     76     ldw x,#(16*n-2)/4 ; 2 cy 
                                     77     decw x  ; 1 cy 
                                     78     nop     ; 1 cy 
                                     79     jrne .-2 ; 2 cy 
                                     80     .endm 
                                     81     
                                     82     ; load X register with 
                                     83     ; entry point of dictionary
                                     84     ; before calling 'search_dict'
                                     85     .macro _ldx_dict dict_name
                                     86         ldw x,#dict_name+2
                                     87     .endm 
                                     88 
                                     89     ; reset BASIC pointer
                                     90     ; to beginning of last token
                                     91     ; extracted except if it was end of line 
                                     92     .macro _unget_token
                                     93         decw y
                                     94     .endm
                                     95 
                                     96     ; extract 16 bits address from BASIC code  
                                     97     .macro _get_addr
                                     98         ldw x,y     ; 1 cy 
                                     99         ldw x,(x)   ; 2 cy 
                                    100         addw y,#2   ; 2 cy 
                                    101     .endm           ; 5 cy 
                                    102 
                                    103     ; alias for _get_addr 
                                    104     .macro _get_word 
                                    105         _get_addr
                                    106     .endm ; 5 cy 
                                    107 
                                    108     ; extract character from BASIC code 
                                    109     .macro _get_char 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                    110         ld a,(y)    ; 1 cy 
                                    111         incw y      ; 1 cy 
                                    112     .endm           ; 2 cy 
                                    113     
                                    114     ; extract next token 
                                    115     .macro _next_token 
                                    116         _get_char 
                                    117     .endm  ; 2 cy 
                                    118 
                                    119     ; extract next command token id 
                                    120     .macro _next_cmd     
                                    121         _get_char       ; 2 cy 
                                    122     .endm               ; 2 cy 
                                    123 
                                    124     ; get code address in x
                                    125     .macro _code_addr 
                                    126         clrw x   ; 1 cy 
                                    127         ld xl,a  ; 1 cy 
                                    128         sllw x   ; 2 cy 
                                    129         ldw x,(code_addr,x) ; 2 cy 
                                    130     .endm        ; 6 cy 
                                    131 
                                    132     ; call subroutine from index in a 
                                    133     .macro _call_code
                                    134         _code_addr  ; 6 cy  
                                    135         call (x)    ; 4 cy 
                                    136     .endm  ; 10 cy 
                                    137 
                                    138     ; jump to bytecode routine 
                                    139     ; routine must jump back to 
                                    140     ; interp_loop 
                                    141     .macro _jp_code 
                                    142         _code_addr 
                                    143         jp (x)
                                    144     .endm  ; 8 cycles 
                                    145 
                                    146     ; jump back to interp_loop 
                                    147     .macro _next 
                                    148         jp interp_loop 
                                    149     .endm ; 2 cycles 
                                    150     
                                    151 ;---------------------------------
                                    152 ;  files.asm macros 
                                    153 ;---------------------------------
                                    154 
                                    155 ;----------------------------------
                                    156 ;    file system 
                                    157 ; file header:
                                    158 ;   sign field:  2 bytes .ascii "TB" 
                                    159 ;   program size: 1 word 
                                    160 ;   data: n*BLOCK_SIZE 
                                    161 ;   BLOCK_SIZE is 128 bytes depend 
                                    162 ;   on MCU block erase size. 
                                    163 ;----------------------------------
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                           000000   165 FILE_SIGN_FIELD = 0 ; signature offset 
                           000002   166 FILE_SIZE_FIELD = 2 ; size offset 
                           000004   167 FILE_DATA= 4 ; data offset 
                           000004   168 FILE_HEADER_SIZE = 4 ; bytes 
                                    169 
                                    170 ;---------------------
                                    171 ; MACRO 
                                    172 ; check if there is 
                                    173 ; an erased program 
                                    174 ; at this address 
                                    175 ; input:
                                    176 ;    X    file header address   
                                    177 ; output:
                                    178 ;    Z    1 erazed
                                    179 ;         0 not erased|not program.  
                                    180 ;--------------------
                                    181 	.macro _is_erased
                                    182 	    pushw x 
                                    183 	    ldw x,(x)
                                    184         cpw x,ERASED 
                                    185 	    popw x 
                                    186 	.endm 
                                    187 
                                    188 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    189 ; MACRO 
                                    190 ;  check for application signature 
                                    191 ; input:
                                    192 ;	x       file header address 
                                    193 ; output:
                                    194 ;   Z      1  signature present 
                                    195 ;          0 no app signature  
                                    196 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    197     .macro _qsign 
                                    198 	    pushw x 
                                    199 	    ldw x,(x)
                                    200 	    cpw x,SIGNATURE ; "PB" 
                                    201 	    popw x 
                                    202 	.endm 
                                    203 
                                    204 ;------------------------------------
                                    205 ;  board user LED control macros 
                                    206 ;------------------------------------
                                    207 
                                    208     .macro _led_on 
                                    209         bset LED_PORT,#LED_BIT 
                                    210     .endm 
                                    211 
                                    212     .macro _led_off 
                                    213         bres LED_PORT,#LED_BIT 
                                    214     .endm 
                                    215 
                                    216     .macro _led_toggle 
                                    217         bcpl LED_PORT,#LED_BIT 
                                    218     .endm 
                                    219 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



                                    220 
                                    221 ;------------------------------------
                                    222 ;   BASIC pending_stack macros 
                                    223 ;-------------------------------------
                                    224     ; reset pending stack 
                                    225     .macro _rst_pending 
                                    226     ldw x,#pending_stack+PENDING_STACK_SIZE
                                    227     _strxz psp 
                                    228     .endm 
                                    229 
                                    230     ; fetch TOS 
                                    231     .macro _last_pending 
                                    232     ld a,[psp]
                                    233     .endm 
                                    234 
                                    235     ; push operation token
                                    236     ; input:
                                    237     ;    A   token  
                                    238     .macro _push_op  
                                    239     _decz psp+1
                                    240     ld [psp],a 
                                    241     .endm 
                                    242 
                                    243     ; pop pending operation
                                    244     ; output:
                                    245     ;    A   token  
                                    246     .macro _pop_op 
                                    247     ld a,[psp]
                                    248     _incz psp+1 
                                    249     .endm 
                                    250 
                                    251     ; check for stack full 
                                    252     ; output:
                                    253     ;   A    ==0 -> stack full 
                                    254     .macro _pending_full 
                                    255     ld a,#pending_stack 
                                    256     sub a,psp+1 
                                    257     .endm 
                                    258 
                                    259     ; check for stack_empty
                                    260     ; output:
                                    261     ;   A   == 0 -> stack empty     
                                    262     .macro _pending_empty 
                                    263     _ldaz psp+1 
                                    264     sub a,#pending_stack+PENDING_STACK_SIZE
                                    265     .endm 
                                    266 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                     44     .include "arithm16_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2020,2021,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 
                                     21 
                           000002    22 	INT_SIZE==2 ; 2's complement 16 bits integers {-32767...32767} 
                           000002    23 	CELL_SIZE==INT_SIZE 
                                     24 
                                     25 
                                     26     ; store int16 from X to stack 
                                     27     .macro _i16_store  i 
                                     28     ldw (i,sp),x 
                                     29     .endm 
                                     30 
                                     31     ; fetch int16 from stack to X 
                                     32     .macro _i16_fetch i 
                                     33     ldw x,(i,sp)
                                     34     .endm 
                                     35 
                                     36     ; pop int16 from top of stack 
                                     37     .macro _i16_pop 
                                     38     popw x 
                                     39     .endm 
                                     40 
                                     41     ; push int16 on stack 
                                     42     .macro _i16_push 
                                     43     pushw X
                                     44     .endm 
                                     45 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                     45 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                     31 
                                     32 
                           000004    33 SYS_VARS_ORG=4 
                                     34 
                                     35 ; application vars start at this address 
                           000028    36 APP_VARS_START_ADR==SYS_VARS_ORG+SYS_VARS_SIZE+ARITHM_VARS_SIZE+TERMIOS_VARS_SIZE
                                     37 
                                     38 ;--------------------------------
                                     39 	.area DATA (ABS)
      000004                         40 	.org SYS_VARS_ORG  
                                     41 ;---------------------------------
                                     42 
      000004                         43 ticks: .blkw 1 ; millisecond system ticks 
      000006                         44 timer: .blkw 1 ; msec count down timer 
      000008                         45 tone_ms: .blkw 1 ; tone duration msec 
      00000A                         46 sys_flags: .blkb 1; system boolean flags 
      00000B                         47 seedx: .blkw 1  ; bits 31...15 used by 'prng' function
      00000D                         48 seedy: .blkw 1  ; bits 15...0 used by 'prng' function 
      00000F                         49 base: .blkb 1 ;  numeric base used by 'print_int' 
      000010                         50 fmstr: .blkb 1 ; Fmaster frequency in Mhz
      000011                         51 farptr: .blkb 1 ; 24 bits pointer used by file system, upper-byte
      000012                         52 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000013                         53 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000014                         54 trap_ret: .blkw 1 ; trap return address 
      000016                         55 kvars_end: 
                           000012    56 SYS_VARS_SIZE==kvars_end-ticks   
                                     57 
                                     58 ; system boolean flags 
                           000000    59 FSYS_TIMER==0 
                           000001    60 FSYS_TONE==1 
                           000002    61 FSYS_UPPER==2 ; getc uppercase all letters 
                                     62   
                                     63 ;;--------------------------------------
                                     64     .area HOME
                                     65 ;; interrupt vector table at 0x8000
                                     66 ;;--------------------------------------
                                     67 
      008000 82 00 81 25             68     int cold_start			; RESET vector 
      008004 82 00 81 E7             69 	int TrapHandler         ; trap instruction 
      008008 82 00 80 80             70 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 80             71 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 80             72 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 80             73 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 80 80             74 	int NonHandledInterrupt ;int4 EXTI1 gpio B external interrupts
      00801C 82 00 80 80             75 	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
      008020 82 00 80 80             76 	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
      008024 82 00 80 80             77 	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupt 
      008028 82 00 80 80             78 	int NonHandledInterrupt ;int8 beCAN RX interrupt
      00802C 82 00 80 80             79 	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
      008030 82 00 80 80             80 	int NonHandledInterrupt ;int10 SPI End of transfer
      008034 82 00 80 80             81 	int NonHandledInterrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 80 80             82 	int NonHandledInterrupt ;int12 TIM1 ; TIM1 capture/compare
      00803C 82 00 80 80             83 	int NonHandledInterrupt ;int13 TIM2 update /overflow
      008040 82 00 80 80             84 	int NonHandledInterrupt ;int14 TIM2 capture/compare
      008044 82 00 80 80             85 	int NonHandledInterrupt ;int15 TIM3 Update/overflow
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



      008048 82 00 80 80             86 	int NonHandledInterrupt ;int16 TIM3 Capture/compare
      00804C 82 00 80 80             87 	int NonHandledInterrupt ;int17 UART1 TX completed
                           000000    88 .if NUCLEO_8S208RB  
                                     89 	int UartRxHandler		;int18 UART1 RX full 
                           000001    90 .else 
      008050 82 00 80 80             91 	int NonHandledInterrupt ;int18 UART1 RX full 
                                     92 .endif 
      008054 82 00 80 80             93 	int NonHandledInterrupt ; int19 i2c
      008058 82 00 80 80             94 	int NonHandledInterrupt ;int20 UART3 TX completed
                           000001    95 .if NUCLEO_8S207K8  
      00805C 82 00 84 8F             96 	int UartRxHandler 		;int21 UART3 RX full
                           000000    97 .else 
                                     98 	int NonHandledInterrupt ;int21 UART3 RX full
                                     99 .endif 
      008060 82 00 80 80            100 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 82 85            101 	int Timer4UpdateHandler	;int23 TIM4 update/overflow ; used as msec ticks counter
      008068 82 00 80 80            102 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
      00806C 82 00 80 80            103 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 80            104 	int NonHandledInterrupt ;int26  not used
      008074 82 00 80 80            105 	int NonHandledInterrupt ;int27  not used
      008078 82 00 80 80            106 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 80            107 	int NonHandledInterrupt ;int29  not used
                                    108 
                                    109 
                                    110 	.area CODE 
                                    111 ;	.org 0x8080 
                                    112 
                                    113 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    114 ; non handled interrupt 
                                    115 ; reset MCU
                                    116 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        117 NonHandledInterrupt:
      000000                        118 	_swreset ; see "inc/gen_macros.inc"
      008080 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    119 
                           000000   120 .if 0
                                    121 user_interrupted:
                                    122 ; BASIC program can be 
                                    123 ; interrupted by CTRL+C 
                                    124 ; in case locked in infinite loop. 
                                    125     btjt flags,#FRUN,4$
                                    126 	ret 
                                    127 4$:	; program interrupted by user 
                                    128 	bres flags,#FRUN 
                                    129 ;	ldw x,#USER_ABORT
                                    130 ;	call puts 
                                    131 5$:	jp warm_start
                                    132 
                                    133 
                                    134 ;USER_ABORT: .asciz "\nProgram aborted by user.\n"
                                    135 .endif 
                                    136 
                                    137 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    138 ;    peripherals initialization
                                    139 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    140 
                                    141 ;----------------------------------------
                                    142 ; inialize MCU clock 
                                    143 ; input:
                                    144 ;   A       fmstr Mhz 
                                    145 ;   XL      CLK_CKDIVR , clock divisor
                                    146 ;   XH     HSI|HSE   
                                    147 ; output:
                                    148 ;   none 
                                    149 ;----------------------------------------
      008084                        150 clock_init:	
      000004                        151 	_straz fmstr
      008084 B7 10                    1     .byte 0xb7,fmstr 
      008086 9E               [ 1]  152 	ld a,xh ; clock source HSI|HSE 
      008087 72 17 50 C5      [ 1]  153 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      00808B C1 50 C3         [ 1]  154 	cp a,CLK_CMSR 
      00808E 27 0C            [ 1]  155 	jreq 2$ ; no switching required 
                                    156 ; select clock source 
      008090 C7 50 C4         [ 1]  157 	ld CLK_SWR,a
      008093 72 07 50 C5 FB   [ 2]  158 	btjf CLK_SWCR,#CLK_SWCR_SWIF,. 
      008098 72 12 50 C5      [ 1]  159 	bset CLK_SWCR,#CLK_SWCR_SWEN
      00809C                        160 2$: 	
                                    161 ; cpu clock divisor 
      00809C 9F               [ 1]  162 	ld a,xl 
      00809D C7 50 C6         [ 1]  163 	ld CLK_CKDIVR,a  
      0080A0 72 5F 50 C6      [ 1]  164 	clr CLK_CKDIVR 
      0080A4 81               [ 4]  165 	ret
                                    166 
                                    167 ;----------------------------------
                                    168 ; TIMER2 used as audio tone output 
                                    169 ; on port D:5. CN9-6
                                    170 ; channel 1 configured as PWM mode 1 
                                    171 ;-----------------------------------  
      0080A5                        172 timer2_init:
      0080A5 72 1A 50 C7      [ 1]  173 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM2 ; enable TIMER2 clock 
      0080A9 35 60 53 05      [ 1]  174  	mov TIM2_CCMR1,#(6<<TIM2_CCMR_OCM) ; PWM mode 1 
      0080AD 35 06 53 0C      [ 1]  175 	mov TIM2_PSCR,#6 ; fmstr/64
      0080B1 81               [ 4]  176 	ret 
                                    177 
                                    178 ;---------------------------------
                                    179 ; TIM4 is configured to generate an 
                                    180 ; interrupt every millisecond 
                                    181 ;----------------------------------
      0080B2                        182 timer4_init:
      0080B2 72 18 50 C7      [ 1]  183 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
      0080B6 72 11 53 40      [ 1]  184 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080BA C6 00 10         [ 1]  185 	ld a,fmstr 
      0080BD AE 00 E8         [ 2]  186 	ldw x,#0xe8 
      0080C0 42               [ 4]  187 	mul x,a
      0080C1 89               [ 2]  188 	pushw x 
      0080C2 AE 00 03         [ 2]  189 	ldw x,#3 
      0080C5 42               [ 4]  190 	mul x,a 
      0080C6 5E               [ 1]  191 	swapw x 
      0080C7 72 FB 01         [ 2]  192 	addw x,(1,sp) 
      00004A                        193 	_drop 2  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      0080CA 5B 02            [ 2]    1     addw sp,#2 
      0080CC 4F               [ 1]  194 	clr a 
      0080CD                        195 0$:	 
      0080CD A3 01 00         [ 2]  196 	cpw x,#256 
      0080D0 2B 04            [ 1]  197 	jrmi 1$ 
      0080D2 4C               [ 1]  198 	inc a 
      0080D3 54               [ 2]  199 	srlw x 
      0080D4 20 F7            [ 2]  200 	jra 0$ 
      0080D6                        201 1$:
      0080D6 C7 53 45         [ 1]  202 	ld TIM4_PSCR,a 
      0080D9 9F               [ 1]  203 	ld a,xl 
      0080DA C7 53 46         [ 1]  204 	ld TIM4_ARR,a
      0080DD 35 05 53 40      [ 1]  205 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080E1 72 10 53 41      [ 1]  206 	bset TIM4_IER,#TIM4_IER_UIE
                                    207 ; set int level to 1 
      0080E5 A6 01            [ 1]  208 	ld a,#ITC_SPR_LEVEL1 
      0080E7 AE 00 17         [ 2]  209 	ldw x,#INT_TIM4_OVF 
      0080EA CD 80 EE         [ 4]  210 	call set_int_priority
      0080ED 81               [ 4]  211 	ret
                                    212 
                                    213 
                                    214 ;--------------------------
                                    215 ; set software interrupt 
                                    216 ; priority 
                                    217 ; input:
                                    218 ;   A    priority 1,2,3 
                                    219 ;   X    vector 
                                    220 ;---------------------------
                           000001   221 	SPR_ADDR=1 
                           000003   222 	PRIORITY=3
                           000004   223 	SLOT=4
                           000005   224 	MASKED=5  
                           000005   225 	VSIZE=5
      0080EE                        226 set_int_priority::
      00006E                        227 	_vars VSIZE
      0080EE 52 05            [ 2]    1     sub sp,#VSIZE 
      0080F0 A4 03            [ 1]  228 	and a,#3  
      0080F2 6B 03            [ 1]  229 	ld (PRIORITY,sp),a 
      0080F4 A6 04            [ 1]  230 	ld a,#4 
      0080F6 62               [ 2]  231 	div x,a 
      0080F7 48               [ 1]  232 	sll a  ; slot*2 
      0080F8 6B 04            [ 1]  233 	ld (SLOT,sp),a
      0080FA 1C 7F 70         [ 2]  234 	addw x,#ITC_SPR1 
      0080FD 1F 01            [ 2]  235 	ldw (SPR_ADDR,sp),x 
                                    236 ; build mask
      0080FF AE FF FC         [ 2]  237 	ldw x,#0xfffc 	
      008102 7B 04            [ 1]  238 	ld a,(SLOT,sp)
      008104 27 05            [ 1]  239 	jreq 2$ 
      008106 99               [ 1]  240 	scf 
      008107 59               [ 2]  241 1$:	rlcw x 
      008108 4A               [ 1]  242 	dec a 
      008109 26 FC            [ 1]  243 	jrne 1$
      00810B 9F               [ 1]  244 2$:	ld a,xl 
                                    245 ; apply mask to slot 
      00810C 1E 01            [ 2]  246 	ldw x,(SPR_ADDR,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



      00810E F4               [ 1]  247 	and a,(x)
      00810F 6B 05            [ 1]  248 	ld (MASKED,sp),a 
                                    249 ; shift priority to slot 
      008111 7B 03            [ 1]  250 	ld a,(PRIORITY,sp)
      008113 97               [ 1]  251 	ld xl,a 
      008114 7B 04            [ 1]  252 	ld a,(SLOT,sp)
      008116 27 04            [ 1]  253 	jreq 4$
      008118 58               [ 2]  254 3$:	sllw x 
      008119 4A               [ 1]  255 	dec a 
      00811A 26 FC            [ 1]  256 	jrne 3$
      00811C 9F               [ 1]  257 4$:	ld a,xl 
      00811D 1A 05            [ 1]  258 	or a,(MASKED,sp)
      00811F 1E 01            [ 2]  259 	ldw x,(SPR_ADDR,sp)
      008121 F7               [ 1]  260 	ld (x),a 
      0000A2                        261 	_drop VSIZE 
      008122 5B 05            [ 2]    1     addw sp,#VSIZE 
      008124 81               [ 4]  262 	ret 
                                    263 
                                    264 ;-------------------------------------
                                    265 ;  initialization entry point 
                                    266 ;-------------------------------------
      008125                        267 cold_start:
                                    268 ;at reset stack pointer is at RAM_END  
                                    269 ; clear all ram
      008125 96               [ 1]  270 	ldw x,sp 
                           000000   271 .if 0	
                                    272 0$: clr (x)
                                    273 	decw x 
                                    274 	jrne 0$
                                    275 .endif 	
                                    276 ; activate pull up on all inputs 
      008126 A6 FF            [ 1]  277 	ld a,#255 
      008128 C7 50 03         [ 1]  278 	ld PA_CR1,a 
      00812B C7 50 08         [ 1]  279 	ld PB_CR1,a 
      00812E C7 50 0D         [ 1]  280 	ld PC_CR1,a 
      008131 C7 50 12         [ 1]  281 	ld PD_CR1,a 
      008134 C7 50 17         [ 1]  282 	ld PE_CR1,a 
      008137 C7 50 1C         [ 1]  283 	ld PF_CR1,a 
      00813A C7 50 21         [ 1]  284 	ld PG_CR1,a 
      00813D C7 50 2B         [ 1]  285 	ld PI_CR1,a
                                    286 ; set user LED pin as output 
      008140 72 1A 50 0D      [ 1]  287     bset LED_PORT+GPIO_CR1,#LED_BIT
      008144 72 1A 50 0E      [ 1]  288     bset LED_PORT+GPIO_CR2,#LED_BIT
      008148 72 1A 50 0C      [ 1]  289     bset LED_PORT+ GPIO_DDR,#LED_BIT
      00814C 72 1B 50 0A      [ 1]  290 	bres LED_PORT+GPIO_ODR,#LED_BIT ; turn on user LED  
                                    291 ; disable schmitt triggers on Arduino CN4 analog inputs
      008150 55 00 3F 54 07   [ 1]  292 	mov ADC_TDRL,0x3f
                                    293 ; select internal clock no divisor: 16 Mhz 	
      008155 A6 10            [ 1]  294 	ld a,#16 ; Mhz 
      008157 AE E1 00         [ 2]  295 	ldw x,#CLK_SWR_HSI<<8   ; high speed internal oscillator 
      00815A CD 80 84         [ 4]  296     call clock_init 
                                    297 ; UART at 115200 BAUD
                                    298 ; used for user interface 
      00815D AE 85 41         [ 2]  299 	ldw x,#uart_putc 
      008160 CF 00 1A         [ 2]  300 	ldw out,x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      008163 CD 84 C0         [ 4]  301 	call uart_init
      008166 CD 80 B2         [ 4]  302 	call timer4_init ; msec ticks timer 
      008169 CD 80 A5         [ 4]  303 	call timer2_init ; tone generator 	
      00816C 9A               [ 1]  304 	rim ; enable interrupts 
      00816D 35 0A 00 0F      [ 1]  305 	mov base,#10
      0000F1                        306 	_clrz sys_flags 
      008171 3F 0A                    1     .byte 0x3f, sys_flags 
      008173 CD 82 AA         [ 4]  307 	call beep_1khz  ;
      008176 AE FF FF         [ 2]  308 	ldw x,#-1
      008179 CD 83 50         [ 4]  309 	call set_seed 
                                    310 
                                    311 ; jp kernel_test 	
      00817C CC 89 CD         [ 2]  312 	jp WOZMON
                                    313 
                           000001   314 .if 1
      00817F 72 14 00 0A      [ 1]  315 	bset sys_flags,#FSYS_UPPER 
      008183 CD 85 E9         [ 4]  316 call new_line 	
      008186                        317 test: ; test compiler 
      008186 A6 3E            [ 1]  318 	ld a,#'> 
      008188 CD 85 2C         [ 4]  319 	call putc 
      00818B CD 86 79         [ 4]  320 	call readln 
      00818E CD 8F 15         [ 4]  321 	call compile 
      008191 CD 81 96         [ 4]  322 	call dump_code 
      008194 20 F0            [ 2]  323 	jra test 
                                    324 
      008196                        325 dump_code: 
      008196 90 AE 17 00      [ 2]  326 	ldw y,#pad 
      00819A 4B 10            [ 1]  327 	push #16  
      00819C 90 E6 02         [ 1]  328 	ld a,(2,y)
      00819F 88               [ 1]  329 	push a
      0081A0 90 9E            [ 1]  330 	ld a,yh 
      0081A2 CD 88 1C         [ 4]  331 	call print_hex 
      0081A5 90 9F            [ 1]  332 	ld a,yl  
      0081A7 CD 88 1C         [ 4]  333 	call print_hex
      0081AA AE 00 02         [ 2]  334 	ldw x,#2 
      0081AD CD 86 0C         [ 4]  335 	call spaces 
      0081B0                        336 1$: 
      0081B0 90 F6            [ 1]  337 	ld a,(y)
      0081B2 CD 88 1C         [ 4]  338 	call print_hex 
      0081B5 CD 86 06         [ 4]  339 	call space 
      0081B8 90 5C            [ 1]  340 	incw y
      0081BA 0A 02            [ 1]  341 	dec (2,sp)
      0081BC 26 17            [ 1]  342 	jrne 2$ 
      0081BE CD 85 E9         [ 4]  343 	call new_line 
      0081C1 90 9E            [ 1]  344 	ld a,yh 
      0081C3 CD 88 1C         [ 4]  345 	call print_hex 
      0081C6 90 9F            [ 1]  346 	ld a,yl  
      0081C8 CD 88 1C         [ 4]  347 	call print_hex
      0081CB AE 00 02         [ 2]  348 	ldw x,#2 
      0081CE CD 86 0C         [ 4]  349 	call spaces 
      0081D1 A6 10            [ 1]  350 	ld a,#16
      0081D3 6B 02            [ 1]  351 	ld (2,sp),a 
      0081D5                        352 2$:
      0081D5 0A 01            [ 1]  353 	dec (1,sp) 
      0081D7 26 D7            [ 1]  354 	jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



      000159                        355 9$: _drop 2 
      0081D9 5B 02            [ 2]    1     addw sp,#2 
      0081DB CD 85 E9         [ 4]  356 	call new_line 
      0081DE AE 17 00         [ 2]  357 	ldw x,#pad   
      0081E1 E6 02            [ 1]  358 	ld a,(2,x)
      0081E3 CD 9A 9F         [ 4]  359 	call prt_basic_line 
      0081E6 81               [ 4]  360 	ret 	
                                    361 .endif 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of pomme-1 
                                      4 ;
                                      5 ;     pomme-1 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     pomme-1 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with pomme-1.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19     .module KERNEL 
                                     20 
                                     21 ;-----------------------
                                     22 ; a little kernel 
                                     23 ; to access TERMIOS 
                                     24 ; functions using 
                                     25 ; STM8 TRAP instruction
                                     26 ;------------------------
                                     27 
                                     28 ;;-----------------------------------
                                     29     .area SSEG (ABS)
                                     30 ;; working buffers and stack at end of RAM. 	
                                     31 ;;-----------------------------------
      001680                         32     .org RAM_SIZE-STACK_SIZE-TIB_SIZE-PAD_SIZE 
      001680                         33 tib:: .ds TIB_SIZE             ; terminal input buffer
      001700                         34 block_buffer::                 ; use to write FLASH block (alias for pad )
      001700                         35 pad:: .ds PAD_SIZE             ; working buffer
      001780                         36 stack_full:: .ds STACK_SIZE   ; control stack 
      001800                         37 stack_unf: ; stack underflow ; control_stack underflow 
                                     38 
                                     39 
                                     40 ;---------------------------------------------
                                     41 ;  kernel functions table 
                                     42 ;  functions code is passed in A 
                                     43 ;  parameters are passed in X,Y
                                     44 ;  output returned in A,X,Y,CC  
                                     45 ;
                                     46 ;  code |  function      | input    |  output
                                     47 ;  -----|----------------|----------|---------
                                     48 ;    0  | reset system   | none     | none 
                                     49 ;    1  | ticks          | none     | X=msec ticker 
                                     50 ;    2  | putchar        | X=char   | none 
                                     51 ;    3  | getchar        | none     | A=char
                                     52 ;    4  | querychar      | none     | A=0,-1
                                     53 ;    5  | clr_screen     | none     | none 
                                     54 ;    6  | delback        | none     | none 
                                     55 ;    7  | getline        | xl=buflen | A= line length
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



                                     56 ;       |                | xh=lnlen  |  
                                     57 ;       |                | y=bufadr | 
                                     58 ;    8  | puts           | X=*str   | none 
                                     59 ;    9  | print_int      | X=int16  | none 
                                     60 ;       |                | A=unsigned| A=string length 
                                     61 ;    10 | set timer      | X=value  | none 
                                     62 ;   11  | check time out | none     | A=0|-1 
                                     63 ;   12  | génère une     | X=msec   | 
                                     64 ;       | tonalité audio | Y=Freq   | none
                                     65 ;   13  | stop tone      |  none    | none
                                     66 ;   14  | get random #   | none     | X = random value 
                                     67 ;   15  | seed prgn      | X=param  | none  
                                     68 ;----------------------------------------------
                                     69 ; syscall codes  
                                     70 ; global constants 
                           000000    71     SYS_RST==0
                           000001    72     SYS_TICKS=1 
                           000002    73     PUTC==2
                           000003    74     GETC==3 
                           000004    75     QCHAR==4
                           000005    76     CLS==5
                           000006    77     DELBK==6
                           000007    78     GETLN==7 
                           000008    79     PRT_STR==8
                           000009    80     PRT_INT==9 
                           00000A    81     SET_TIMER==10
                           00000B    82     CHK_TIMOUT==11 
                           00000C    83     START_TONE==12 
                           00000D    84     GET_RND==13
                           00000E    85     SEED_PRNG==14 
                                     86 
                                     87 ;;-------------------------------
                                     88     .area CODE
                                     89 
                                     90 ;;--------------------------------
                                     91 
                                     92 
                                     93 ;-------------------------
                                     94 ;  software interrupt handler 
                                     95 ;-------------------------
      0081E7                         96 TrapHandler::
      0081E7 1E 08            [ 2]   97     ldw x,(8,sp) ; get trap return address 
      000169                         98     _strxz trap_ret 
      0081E9 BF 14                    1     .byte 0xbf,trap_ret 
      0081EB AE 81 F1         [ 2]   99     ldw x,#syscall_handler 
      0081EE 1F 08            [ 2]  100     ldw (8,sp),x 
      0081F0 80               [11]  101     iret 
                                    102 
                                    103 
                                    104 
                                    105     .macro _syscode n, t 
                                    106     cp a,#n 
                                    107     jrne t   
                                    108     .endm 
                                    109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



                                    110 ;---------------------------------
                                    111 ;  must be handled outside 
                                    112 ;  of TrapHandler to enable 
                                    113 ;  interrupts 
                                    114 ;---------------------------------
      0081F1                        115 syscall_handler:      
      000171                        116     _syscode SYS_RST, 0$ 
      0081F1 A1 00            [ 1]    1     cp a,#SYS_RST 
      0081F3 26 04            [ 1]    2     jrne 0$   
      000175                        117     _swreset
      0081F5 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      0081F9                        118 0$:
      000179                        119     _syscode SYS_TICKS,1$
      0081F9 A1 01            [ 1]    1     cp a,#SYS_TICKS 
      0081FB 26 05            [ 1]    2     jrne 1$   
      00017D                        120     _ldxz ticks 
      0081FD BE 04                    1     .byte 0xbe,ticks 
      0081FF CC 82 81         [ 2]  121     jp syscall_exit      
      008202                        122 1$:
      000182                        123     _syscode PUTC, 2$  
      008202 A1 02            [ 1]    1     cp a,#PUTC 
      008204 26 07            [ 1]    2     jrne 2$   
      008206 9F               [ 1]  124     ld a,xl 
      008207 CD 85 41         [ 4]  125     call uart_putc
      00820A CC 82 81         [ 2]  126     jp syscall_exit 
      00820D                        127 2$:
      00018D                        128     _syscode GETC,3$ 
      00820D A1 03            [ 1]    1     cp a,#GETC 
      00820F 26 06            [ 1]    2     jrne 3$   
      008211 CD 85 50         [ 4]  129     call uart_getc 
      008214 CC 82 81         [ 2]  130     jp syscall_exit
      008217                        131 3$:
      000197                        132     _syscode QCHAR,4$ 
      008217 A1 04            [ 1]    1     cp a,#QCHAR 
      008219 26 05            [ 1]    2     jrne 4$   
      00821B CD 85 4A         [ 4]  133     call qgetc  
      00821E 20 61            [ 2]  134     jra syscall_exit
      008220                        135 4$:
      0001A0                        136     _syscode CLS,5$ 
      008220 A1 05            [ 1]    1     cp a,#CLS 
      008222 26 05            [ 1]    2     jrne 5$   
      008224 CD 85 EF         [ 4]  137     call clr_screen
      008227 20 58            [ 2]  138     jra syscall_exit 
      008229                        139 5$: 
      0001A9                        140     _syscode DELBK,6$ 
      008229 A1 06            [ 1]    1     cp a,#DELBK 
      00822B 26 05            [ 1]    2     jrne 6$   
      00822D CD 85 D9         [ 4]  141     call bksp  
      008230 20 4F            [ 2]  142     jra syscall_exit 
      008232                        143 6$: 
      0001B2                        144     _syscode GETLN , 7$
      008232 A1 07            [ 1]    1     cp a,#GETLN 
      008234 26 05            [ 1]    2     jrne 7$   
      008236 CD 86 79         [ 4]  145     call readln  
      008239 20 46            [ 2]  146     jra syscall_exit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



      00823B                        147 7$: 
      0001BB                        148     _syscode PRT_STR , 8$
      00823B A1 08            [ 1]    1     cp a,#PRT_STR 
      00823D 26 05            [ 1]    2     jrne 8$   
      00823F CD 85 A3         [ 4]  149     call puts 
      008242 20 3D            [ 2]  150     jra syscall_exit
      008244                        151 8$: 
      0001C4                        152     _syscode PRT_INT , 9$
      008244 A1 09            [ 1]    1     cp a,#PRT_INT 
      008246 26 05            [ 1]    2     jrne 9$   
      008248 CD 88 2E         [ 4]  153     call print_int
      00824B 20 34            [ 2]  154     jra syscall_exit      
      00824D                        155 9$: 
      0001CD                        156     _syscode SET_TIMER , 10$
      00824D A1 0A            [ 1]    1     cp a,#SET_TIMER 
      00824F 26 08            [ 1]    2     jrne 10$   
      008251 72 11 00 0A      [ 1]  157     bres sys_flags,#FSYS_TIMER 
      0001D5                        158     _strxz timer 
      008255 BF 06                    1     .byte 0xbf,timer 
      008257 20 28            [ 2]  159     jra syscall_exit 
      008259                        160 10$:
      0001D9                        161     _syscode CHK_TIMOUT, 11$
      008259 A1 0B            [ 1]    1     cp a,#CHK_TIMOUT 
      00825B 26 09            [ 1]    2     jrne 11$   
      00825D 4F               [ 1]  162     clr a 
      00825E 72 01 00 0A 1E   [ 2]  163     btjf sys_flags,#FSYS_TIMER,syscall_exit  
      008263 43               [ 1]  164     cpl a 
      008264 20 1B            [ 2]  165     jra syscall_exit
      008266                        166 11$: 
      0001E6                        167     _syscode START_TONE , 12$    
      008266 A1 0C            [ 1]    1     cp a,#START_TONE 
      008268 26 05            [ 1]    2     jrne 12$   
      00826A CD 82 B9         [ 4]  168     call tone 
      00826D 20 12            [ 2]  169     jra syscall_exit 
      00826F                        170 12$: 
      0001EF                        171     _syscode GET_RND , 13$
      00826F A1 0D            [ 1]    1     cp a,#GET_RND 
      008271 26 05            [ 1]    2     jrne 13$   
      008273 CD 83 2E         [ 4]  172     call prng 
      008276 20 09            [ 2]  173     jra syscall_exit 
      008278                        174 13$: 
      0001F8                        175     _syscode SEED_PRNG , 14$
      008278 A1 0E            [ 1]    1     cp a,#SEED_PRNG 
      00827A 26 05            [ 1]    2     jrne 14$   
      00827C CD 83 50         [ 4]  176     call set_seed 
      00827F 20 00            [ 2]  177     jra syscall_exit 
      008281                        178 14$: 
                                    179 
                                    180 ; bad codes ignored 
      008281                        181 syscall_exit:
      008281 72 CC 00 14      [ 5]  182     jp [trap_ret] 
                                    183 
                                    184 
                                    185 ;------------------------------
                                    186 ; TIMER 4 is used to maintain 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                    187 ; a milliseconds 'ticks' counter
                                    188 ; and decrement 'timer' varaiable
                                    189 ; and 'tone_ms' variable .
                                    190 ; these 3 variables are unsigned  
                                    191 ; ticks range {0..65535}
                                    192 ; timer range {0..65535}
                                    193 ; tone_ms range {0..65535}
                                    194 ;--------------------------------
      008285                        195 Timer4UpdateHandler:
      008285 72 5F 53 42      [ 1]  196 	clr TIM4_SR 
      000209                        197 	_incz ticks+1 
      008289 3C 05                    1     .byte 0x3c, ticks+1 
      00828B 26 02            [ 1]  198 	jrne 0$ 
      00020D                        199 	_incz ticks
      00828D 3C 04                    1     .byte 0x3c, ticks 
      00828F                        200 0$:
      00020F                        201 	_ldxz timer
      00828F BE 06                    1     .byte 0xbe,timer 
      008291 27 09            [ 1]  202 	jreq 1$
      008293 5A               [ 2]  203 	decw x 
      000214                        204 	_strxz timer 
      008294 BF 06                    1     .byte 0xbf,timer 
      008296 26 04            [ 1]  205 	jrne 1$ 
      008298 72 10 00 0A      [ 1]  206 	bset sys_flags,#FSYS_TIMER  
      00829C                        207 1$:
      00021C                        208     _ldxz tone_ms 
      00829C BE 08                    1     .byte 0xbe,tone_ms 
      00829E 27 09            [ 1]  209     jreq 2$ 
      0082A0 5A               [ 2]  210     decw x 
      000221                        211     _strxz tone_ms 
      0082A1 BF 08                    1     .byte 0xbf,tone_ms 
      0082A3 26 04            [ 1]  212     jrne 2$ 
      0082A5 72 13 00 0A      [ 1]  213     bres sys_flags,#FSYS_TONE   
      0082A9                        214 2$: 
      0082A9 80               [11]  215 	iret 
                                    216 
                                    217 
                                    218 ;-----------------
                                    219 ; 1 Khz beep 
                                    220 ;-----------------
      0082AA                        221 beep_1khz::
      0082AA 90 89            [ 2]  222 	pushw y 
      0082AC AE 00 64         [ 2]  223 	ldw x,#100
      0082AF 90 AE 03 E8      [ 2]  224 	ldw y,#1000
      0082B3 CD 82 B9         [ 4]  225 	call tone
      0082B6 90 85            [ 2]  226 	popw y
      0082B8 81               [ 4]  227 	ret 
                                    228 
                                    229 ;---------------------
                                    230 ; input:
                                    231 ;   Y   frequency 
                                    232 ;   x   duration 
                                    233 ;---------------------
                           000001   234 	DIVDHI=1   ; dividend 31..16 
                           000003   235 	DIVDLO=DIVDHI+INT_SIZE ; dividend 15..0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                           000005   236 	DIVR=DIVDLO+INT_SIZE  ; divisor 
                           000006   237 	VSIZE=3*INT_SIZE  
      0082B9                        238 tone:: 
      000239                        239 	_vars VSIZE 
      0082B9 52 06            [ 2]    1     sub sp,#VSIZE 
      00023B                        240 	_strxz tone_ms 
      0082BB BF 08                    1     .byte 0xbf,tone_ms 
      0082BD 72 12 00 0A      [ 1]  241 	bset sys_flags,#FSYS_TONE    
      0082C1 17 05            [ 2]  242 	ldw (DIVR,sp),y  ; divisor  
      0082C3 90 AE 00 10      [ 2]  243 	ldw y,#fmstr 
      0082C7 AE 3D 09         [ 2]  244 	ldw x,#15625 ; ftimer=fmstr*1e6/64
      0082CA CD 83 87         [ 4]  245 	call umstar    ; x product 15..0 , y=product 31..16 
      00024D                        246 	_i16_store DIVDLO  
      0082CD 1F 03            [ 2]    1     ldw (DIVDLO,sp),x 
      0082CF 17 01            [ 2]  247 	ldw (DIVDHI,sp),y 
      000251                        248 	_i16_fetch DIVR ; DIVR=freq audio   
      0082D1 1E 05            [ 2]    1     ldw x,(DIVR,sp)
      0082D3 CD 83 F2         [ 4]  249 	call udiv32_16 
      0082D6 9E               [ 1]  250 	ld a,xh 
      0082D7 C7 53 0D         [ 1]  251 	ld TIM2_ARRH,a 
      0082DA 9F               [ 1]  252 	ld a,xl 
      0082DB C7 53 0E         [ 1]  253 	ld TIM2_ARRL,a 
                                    254 ; 50% duty cycle 
      0082DE 54               [ 2]  255 	srlw x  
      0082DF 9E               [ 1]  256 	ld a,xh 
      0082E0 C7 53 0F         [ 1]  257 	ld TIM2_CCR1H,a 
      0082E3 9F               [ 1]  258 	ld a,xl
      0082E4 C7 53 10         [ 1]  259 	ld TIM2_CCR1L,a
      0082E7 72 10 53 08      [ 1]  260 	bset TIM2_CCER1,#TIM2_CCER1_CC1E
      0082EB 72 10 53 00      [ 1]  261 	bset TIM2_CR1,#TIM2_CR1_CEN
      0082EF 72 10 53 04      [ 1]  262 	bset TIM2_EGR,#TIM2_EGR_UG 	
      0082F3                        263 0$: ; wait end of tone 
      0082F3 8F               [10]  264     wfi 
      0082F4 72 02 00 0A FA   [ 2]  265     btjt sys_flags,#FSYS_TONE ,0$    
      0082F9                        266 tone_off: 
      0082F9 72 11 53 08      [ 1]  267 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      0082FD 72 11 53 00      [ 1]  268 	bres TIM2_CR1,#TIM2_CR1_CEN 
      000281                        269      _drop VSIZE 
      008301 5B 06            [ 2]    1     addw sp,#VSIZE 
      008303 81               [ 4]  270 	ret 
                                    271 
                                    272 
                                    273 ;---------------------------------
                                    274 ; Pseudo Random Number Generator 
                                    275 ; XORShift algorithm.
                                    276 ;---------------------------------
                                    277 
                                    278 ;---------------------------------
                                    279 ;  seedx:seedy= x:y ^ seedx:seedy
                                    280 ; output:
                                    281 ;  X:Y   seedx:seedy new value   
                                    282 ;---------------------------------
      008304                        283 xor_seed32:
      008304 9E               [ 1]  284     ld a,xh 
      000285                        285     _xorz seedx 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



      008305 B8 0B                    1     .byte 0xb8,seedx 
      000287                        286     _straz seedx
      008307 B7 0B                    1     .byte 0xb7,seedx 
      008309 9F               [ 1]  287     ld a,xl 
      00028A                        288     _xorz seedx+1 
      00830A B8 0C                    1     .byte 0xb8,seedx+1 
      00028C                        289     _straz seedx+1 
      00830C B7 0C                    1     .byte 0xb7,seedx+1 
      00830E 90 9E            [ 1]  290     ld a,yh 
      000290                        291     _xorz seedy
      008310 B8 0D                    1     .byte 0xb8,seedy 
      000292                        292     _straz seedy 
      008312 B7 0D                    1     .byte 0xb7,seedy 
      008314 90 9F            [ 1]  293     ld a,yl 
      000296                        294     _xorz seedy+1 
      008316 B8 0E                    1     .byte 0xb8,seedy+1 
      000298                        295     _straz seedy+1 
      008318 B7 0E                    1     .byte 0xb7,seedy+1 
      00029A                        296     _ldxz seedx  
      00831A BE 0B                    1     .byte 0xbe,seedx 
      00029C                        297     _ldyz seedy 
      00831C 90 BE 0D                 1     .byte 0x90,0xbe,seedy 
      00831F 81               [ 4]  298     ret 
                                    299 
                                    300 ;-----------------------------------
                                    301 ;   x:y= x:y << a 
                                    302 ;  input:
                                    303 ;    A     shift count 
                                    304 ;    X:Y   uint32 value 
                                    305 ;  output:
                                    306 ;    X:Y   uint32 shifted value   
                                    307 ;-----------------------------------
      008320                        308 sll_xy_32: 
      008320 90 58            [ 2]  309     sllw y 
      008322 59               [ 2]  310     rlcw x
      008323 4A               [ 1]  311     dec a 
      008324 26 FA            [ 1]  312     jrne sll_xy_32 
      008326 81               [ 4]  313     ret 
                                    314 
                                    315 ;-----------------------------------
                                    316 ;   x:y= x:y >> a 
                                    317 ;  input:
                                    318 ;    A     shift count 
                                    319 ;    X:Y   uint32 value 
                                    320 ;  output:
                                    321 ;    X:Y   uint32 shifted value   
                                    322 ;-----------------------------------
      008327                        323 srl_xy_32: 
      008327 54               [ 2]  324     srlw x 
      008328 90 56            [ 2]  325     rrcw y 
      00832A 4A               [ 1]  326     dec a 
      00832B 26 FA            [ 1]  327     jrne srl_xy_32 
      00832D 81               [ 4]  328     ret 
                                    329 
                                    330 ;-------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                    331 ;  PRNG generator proper 
                                    332 ; input:
                                    333 ;   none 
                                    334 ; ouput:
                                    335 ;   X     bits 31...16  PRNG seed  
                                    336 ;  use: 
                                    337 ;   seedx:seedy   system variables   
                                    338 ;--------------------------------------
      00832E                        339 prng::
      00832E 90 89            [ 2]  340 	pushw y   
      0002B0                        341     _ldxz seedx
      008330 BE 0B                    1     .byte 0xbe,seedx 
      0002B2                        342 	_ldyz seedy  
      008332 90 BE 0D                 1     .byte 0x90,0xbe,seedy 
      008335 A6 0D            [ 1]  343 	ld a,#13
      008337 CD 83 20         [ 4]  344     call sll_xy_32 
      00833A CD 83 04         [ 4]  345     call xor_seed32
      00833D A6 11            [ 1]  346     ld a,#17 
      00833F CD 83 27         [ 4]  347     call srl_xy_32
      008342 CD 83 04         [ 4]  348     call xor_seed32 
      008345 A6 05            [ 1]  349     ld a,#5 
      008347 CD 83 20         [ 4]  350     call sll_xy_32
      00834A CD 83 04         [ 4]  351     call xor_seed32
      00834D 90 85            [ 2]  352     popw y 
      00834F 81               [ 4]  353     ret 
                                    354 
                                    355 
                                    356 ;---------------------------------
                                    357 ; initialize seedx:seedy 
                                    358 ; input:
                                    359 ;    X    0 -> seedx=ticks, seedy=tib[0..1] 
                                    360 ;    X    !0 -> seedx=X, seedy=[0x6000]
                                    361 ;-------------------------------------------
      008350                        362 set_seed:
      008350 5D               [ 2]  363     tnzw x 
      008351 26 0B            [ 1]  364     jrne 1$ 
      008353 CE 00 04         [ 2]  365     ldw x,ticks 
      0002D6                        366     _strxz seedx
      008356 BF 0B                    1     .byte 0xbf,seedx 
      008358 CE 16 80         [ 2]  367     ldw x,tib 
      0002DB                        368     _strxz seedy  
      00835B BF 0D                    1     .byte 0xbf,seedy 
      00835D 81               [ 4]  369     ret 
      00835E CE 00 04         [ 2]  370 1$: ldw x,ticks 
      0002E1                        371     _strxz seedx
      008361 BF 0B                    1     .byte 0xbf,seedx 
      008363 CE 60 00         [ 2]  372     ldw x,0x6000
      0002E6                        373     _strxz seedy  
      008366 BF 0D                    1     .byte 0xbf,seedy 
      008368 81               [ 4]  374     ret 
                                    375 
                                    376  
                                    377      
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2020,2021,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 
                                     21 
                                     22 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     23 ;;  Arithmetic operators
                                     24 ;;  16/32 bits integers
                                     25 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     26 
                                     27 ;-------------------------------------
                                     28 	.area DATA
      000016                         29 	.org SYS_VARS_ORG+SYS_VARS_SIZE 
                                     30 ;---------------------------------------
                                     31 
      000016                         32 acc32: .blkb 1 ; 32 bit accumalator upper-byte 
      000017                         33 acc24: .blkb 1 ; 24 bits accumulator upper-byte 
      000018                         34 acc16: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000019                         35 acc8:  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      00001A                         36 arithm_vars_end:
                           000004    37 ARITHM_VARS_SIZE=arithm_vars_end-acc32 
                                     38 
                                     39 ;----------------------------------
                                     40 	.area CODE
                                     41 ;----------------------------------
                                     42 
                                     43 ;-------------------------------
                                     44 ; acc16 2's complement 
                                     45 ;-------------------------------
      008369                         46 neg_acc16:
      008369 72 53 00 18      [ 1]   47 	cpl acc16 
      00836D 72 53 00 19      [ 1]   48 	cpl acc8 
      0002F1                         49 	_incz acc8
      008371 3C 19                    1     .byte 0x3c, acc8 
      008373 26 02            [ 1]   50 	jrne 1$ 
      0002F5                         51 	_incz acc16 
      008375 3C 18                    1     .byte 0x3c, acc16 
      008377 81               [ 4]   52 1$: ret 
                                     53 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



                                     54 ;----------------------------------------
                                     55 ;  unsigned multiply uint16*uint8 
                                     56 ;  input:
                                     57 ;     X     uint16 
                                     58 ;     A     uint8
                                     59 ;  output:
                                     60 ;     X     product 
                                     61 ;-----------------------------------------
      008378                         62 umul16_8:
      008378 89               [ 2]   63 	pushw x 
      008379 42               [ 4]   64 	mul x,a
      00837A 89               [ 2]   65 	pushw x 
      00837B 1E 03            [ 2]   66 	ldw x,(3,SP)
      00837D 5E               [ 1]   67 	swapw x 
      00837E 42               [ 4]   68 	mul x,a
      00837F 4F               [ 1]   69 	clr a 
      008380 02               [ 1]   70 	rlwa x ; if a<>0 then overlflow  
      008381 72 FB 01         [ 2]   71 	addw x,(1,sp)
      000304                         72 	_drop 4 
      008384 5B 04            [ 2]    1     addw sp,#4 
      008386 81               [ 4]   73 	ret 
                                     74 
                                     75 ;--------------------------------------
                                     76 ;  multiply 2 uint16_t return uint32_t
                                     77 ;  input:
                                     78 ;     x       uint16_t 
                                     79 ;     y       uint16_t 
                                     80 ;  output:
                                     81 ;     x       product bits 15..0
                                     82 ;     y       product bits 31..16 
                                     83 ;---------------------------------------
                           000001    84 		U1=1  ; uint16_t 
                           000003    85 		DPROD=U1+INT_SIZE ; uint32_t
                           000006    86 		VSIZE=3*INT_SIZE 
      008387                         87 umstar:
      000307                         88 	_vars VSIZE 
      008387 52 06            [ 2]    1     sub sp,#VSIZE 
      008389 1F 01            [ 2]   89 	ldw (U1,sp),x
      00838B 0F 05            [ 1]   90 	clr (DPROD+2,sp)
      00838D 0F 06            [ 1]   91 	clr (DPROD+3,sp) 
                                     92 ; DPROD=u1hi*u2hi
      00838F 90 9E            [ 1]   93 	ld a,yh 
      008391 5E               [ 1]   94 	swapw x 
      008392 42               [ 4]   95 	mul x,a 
      008393 1F 03            [ 2]   96 	ldw (DPROD,sp),x
                                     97 ; DPROD+1 +=u1hi*u2lo 
      008395 7B 01            [ 1]   98 	ld a,(U1,sp)
      008397 97               [ 1]   99 	ld xl,a 
      008398 90 9F            [ 1]  100 	ld a,yl 
      00839A 42               [ 4]  101 	mul x,a 
      00839B 72 FB 04         [ 2]  102 	addw x,(DPROD+1,sp)
      00839E 24 02            [ 1]  103 	jrnc 1$ 
      0083A0 0C 03            [ 1]  104 	inc (DPROD,sp)
      0083A2 1F 04            [ 2]  105 1$: ldw (DPROD+1,sp),x 
                                    106 ; DPROD+1 += u1lo*u2hi 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



      0083A4 7B 02            [ 1]  107 	ld a,(U1+1,sp)
      0083A6 97               [ 1]  108 	ld xl,a 
      0083A7 90 9E            [ 1]  109 	ld a,yh 
      0083A9 42               [ 4]  110 	mul x,a 
      0083AA 72 FB 04         [ 2]  111 	addw x,(DPROD+1,sp)
      0083AD 24 02            [ 1]  112 	jrnc 2$ 
      0083AF 0C 03            [ 1]  113 	inc (DPROD,sp)
      0083B1 1F 04            [ 2]  114 2$: ldw (DPROD+1,sp),x 
                                    115 ; DPROD+2=u1lo*u2lo 
      0083B3 93               [ 1]  116 	ldw x,y  
      0083B4 7B 02            [ 1]  117 	ld a,(U1+1,sp)
      0083B6 42               [ 4]  118 	mul x,a 
      0083B7 72 FB 05         [ 2]  119 	addw x,(DPROD+2,sp)
      0083BA 24 06            [ 1]  120 	jrnc 3$
      0083BC 0C 04            [ 1]  121 	inc (DPROD+1,sp)
      0083BE 26 02            [ 1]  122 	jrne 3$
      0083C0 0C 03            [ 1]  123 	inc (DPROD,sp)
      0083C2                        124 3$:
      0083C2 16 03            [ 2]  125 	ldw y,(DPROD,sp)
      000344                        126 	_drop VSIZE 
      0083C4 5B 06            [ 2]    1     addw sp,#VSIZE 
      0083C6 81               [ 4]  127 	ret
                                    128 
                                    129 
                                    130 ;-------------------------------------
                                    131 ; multiply 2 integers
                                    132 ; input:
                                    133 ;  	x       n1 
                                    134 ;   y 		n2 
                                    135 ; output:
                                    136 ;	X        product 
                                    137 ;-------------------------------------
                           000001   138 	SIGN=1
                           000001   139 	VSIZE=1
      0083C7                        140 multiply:
      000347                        141 	_vars VSIZE 
      0083C7 52 01            [ 2]    1     sub sp,#VSIZE 
      0083C9 0F 01            [ 1]  142 	clr (SIGN,sp)
      0083CB 5D               [ 2]  143 	tnzw x 
      0083CC 2A 03            [ 1]  144 	jrpl 1$
      0083CE 03 01            [ 1]  145 	cpl (SIGN,sp)
      0083D0 50               [ 2]  146 	negw x 
      0083D1                        147 1$:	
      0083D1 90 5D            [ 2]  148 	tnzw y   
      0083D3 2A 04            [ 1]  149 	jrpl 2$ 
      0083D5 03 01            [ 1]  150 	cpl (SIGN,sp)
      0083D7 90 50            [ 2]  151 	negw y 
      0083D9                        152 2$:	
      0083D9 CD 83 87         [ 4]  153 	call umstar
      0083DC 90 5D            [ 2]  154 	tnzw y 
      0083DE 26 03            [ 1]  155 	jrne 3$
      0083E0 5D               [ 2]  156 	tnzw x 
      0083E1 2A 05            [ 1]  157 	jrpl 4$
      0083E3                        158 3$:
      0083E3 A6 02            [ 1]  159 	ld a,#ERR_GT32767
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      0083E5 CC 92 27         [ 2]  160 	jp tb_error 
      0083E8                        161 4$:
      0083E8 7B 01            [ 1]  162 	ld a,(SIGN,sp)
      0083EA 27 03            [ 1]  163 	jreq 5$
      0083EC CD 84 19         [ 4]  164 	call dneg 
      0083EF                        165 5$:	
      00036F                        166 	_drop VSIZE 
      0083EF 5B 01            [ 2]    1     addw sp,#VSIZE 
      0083F1 81               [ 4]  167 	ret
                                    168 
                                    169 
                                    170 ;--------------------------------------
                                    171 ; divide uint32_t/uint16_t
                                    172 ; return:  quotient and remainder 
                                    173 ; quotient expected to be uint16_t 
                                    174 ; input:
                                    175 ;   DBLDIVDND    on stack 
                                    176 ;   X            divisor 
                                    177 ; output:
                                    178 ;   X            quotient 
                                    179 ;   Y            remainder 
                                    180 ;---------------------------------------
                           000002   181 	VSIZE=2
      0083F2                        182 	_argofs VSIZE 
                           000004     1     ARG_OFS=2+VSIZE 
      000372                        183 	_arg DBLDIVDND 1
                           000005     1     DBLDIVDND=ARG_OFS+1 
                                    184 	; local variables 
                           000001   185 	DIVISOR=1 
      000372                        186 udiv32_16:
      000372                        187 	_vars VSIZE 
      0083F2 52 02            [ 2]    1     sub sp,#VSIZE 
      0083F4 1F 01            [ 2]  188 	ldw (DIVISOR,sp),x	; save divisor 
      0083F6 1E 07            [ 2]  189 	ldw x,(DBLDIVDND+2,sp)  ; bits 15..0
      0083F8 16 05            [ 2]  190 	ldw y,(DBLDIVDND,sp) ; bits 31..16
      0083FA 90 5D            [ 2]  191 	tnzw y
      0083FC 26 06            [ 1]  192 	jrne long_division 
      0083FE 16 01            [ 2]  193 	ldw y,(DIVISOR,sp)
      008400 65               [ 2]  194 	divw x,y
      000381                        195 	_drop VSIZE 
      008401 5B 02            [ 2]    1     addw sp,#VSIZE 
      008403 81               [ 4]  196 	ret
      008404                        197 long_division:
      008404 51               [ 1]  198 	exgw x,y ; hi in x, lo in y 
      008405 A6 11            [ 1]  199 	ld a,#17 
      008407                        200 1$:
      008407 13 01            [ 2]  201 	cpw x,(DIVISOR,sp)
      008409 25 03            [ 1]  202 	jrc 2$
      00840B 72 F0 01         [ 2]  203 	subw x,(DIVISOR,sp)
      00840E 8C               [ 1]  204 2$:	ccf 
      00840F 90 59            [ 2]  205 	rlcw y 
      008411 59               [ 2]  206 	rlcw x 
      008412 4A               [ 1]  207 	dec a
      008413 26 F2            [ 1]  208 	jrne 1$
      008415 51               [ 1]  209 	exgw x,y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      000396                        210 	_drop VSIZE 
      008416 5B 02            [ 2]    1     addw sp,#VSIZE 
      008418 81               [ 4]  211 	ret
                                    212 
                                    213 ;-----------------------------
                                    214 ; negate double int.
                                    215 ; input:
                                    216 ;   x     bits 15..0
                                    217 ;   y     bits 31..16
                                    218 ; output: 
                                    219 ;   x     bits 15..0
                                    220 ;   y     bits 31..16
                                    221 ;-----------------------------
      008419                        222 dneg:
      008419 53               [ 2]  223 	cplw x 
      00841A 90 53            [ 2]  224 	cplw y 
      00841C 5C               [ 1]  225 	incw x 
      00841D 26 02            [ 1]  226 	jrne 1$  
      00841F 90 5C            [ 1]  227 	incw y 
      008421 81               [ 4]  228 1$: ret 
                                    229 
                                    230 
                                    231 ;--------------------------------
                                    232 ; sign extend single to double
                                    233 ; input:
                                    234 ;   x    int16_t
                                    235 ; output:
                                    236 ;   x    int32_t bits 15..0
                                    237 ;   y    int32_t bits 31..16
                                    238 ;--------------------------------
      008422                        239 dbl_sign_extend:
      008422 90 5F            [ 1]  240 	clrw y
      008424 9E               [ 1]  241 	ld a,xh 
      008425 A4 80            [ 1]  242 	and a,#0x80 
      008427 27 02            [ 1]  243 	jreq 1$
      008429 90 53            [ 2]  244 	cplw y
      00842B 81               [ 4]  245 1$: ret 	
                                    246 
                                    247 
                                    248 ;----------------------------------
                                    249 ;  euclidian divide dbl/n1 
                                    250 ;  ref: https://en.wikipedia.org/wiki/Euclidean_division
                                    251 ; input:
                                    252 ;    dbl    int32_t on stack 
                                    253 ;    x 		n1   int16_t  divisor  
                                    254 ; output:
                                    255 ;    X      dbl/x  int16_t 
                                    256 ;    Y      remainder int16_t 
                                    257 ;----------------------------------
                           000008   258 	VSIZE=8
      00842C                        259 	_argofs VSIZE 
                           00000A     1     ARG_OFS=2+VSIZE 
      0003AC                        260 	_arg DIVDNDHI 1 
                           00000B     1     DIVDNDHI=ARG_OFS+1 
      0003AC                        261 	_arg DIVDNDLO 3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



                           00000D     1     DIVDNDLO=ARG_OFS+3 
                                    262 	; local variables
                           000001   263 	DBLHI=1
                           000003   264 	DBLLO=3 
                           000005   265 	SREMDR=5 ; sign remainder 
                           000006   266 	SQUOT=6 ; sign quotient 
                           000007   267 	DIVISR=7 ; divisor 
      0003AC                        268 div32_16:
      0003AC                        269 	_vars VSIZE 
      00842C 52 08            [ 2]    1     sub sp,#VSIZE 
      00842E 0F 05            [ 1]  270 	clr (SREMDR,sp)
      008430 0F 06            [ 1]  271 	clr (SQUOT,sp)
                                    272 ; copy arguments 
      008432 16 0B            [ 2]  273 	ldw y,(DIVDNDHI,sp)
      008434 17 01            [ 2]  274 	ldw (DBLHI,sp),y
      008436 16 0D            [ 2]  275 	ldw y,(DIVDNDLO,sp)
      008438 17 03            [ 2]  276 	ldw (DBLLO,sp),y 
                                    277 ; check for 0 divisor
                           000000   278 .if 0 
                                    279 	tnzw x 
                                    280     jrne 0$
                                    281 	ld a,#ERR_DIV0 
                                    282 	jp tb_error
                                    283 .endif  
                                    284 ; check divisor sign 	
      00843A 5D               [ 2]  285 0$:	tnzw x 
      00843B 2A 03            [ 1]  286 	jrpl 1$
      00843D 03 06            [ 1]  287 	cpl (SQUOT,sp)
      00843F 50               [ 2]  288 	negw x
      008440 1F 07            [ 2]  289 1$:	ldw (DIVISR,sp),x
                                    290 ; check dividend sign 	 
      008442 7B 01            [ 1]  291  	ld a,(DBLHI,sp) 
      008444 A4 80            [ 1]  292 	and a,#0x80 
      008446 27 0F            [ 1]  293 	jreq 2$ 
      008448 03 06            [ 1]  294 	cpl (SQUOT,sp)
      00844A 03 05            [ 1]  295 	cpl (SREMDR,sp)
      00844C 1E 03            [ 2]  296 	ldw x,(DBLLO,sp)
      00844E 16 01            [ 2]  297 	ldw y,(DBLHI,sp)
      008450 CD 84 19         [ 4]  298 	call dneg 
      008453 1F 03            [ 2]  299 	ldw (DBLLO,sp),x 
      008455 17 01            [ 2]  300 	ldw (DBLHI,sp),y 
      008457 1E 07            [ 2]  301 2$:	ldw x,(DIVISR,sp)
      008459 CD 83 F2         [ 4]  302 	call udiv32_16
      00845C 90 5D            [ 2]  303 	tnzw y 
      00845E 27 05            [ 1]  304 	jreq 3$ 
                                    305 ; x=quotient 
                                    306 ; y=remainder 
                                    307 ; sign quotient
      008460 0D 06            [ 1]  308 	tnz (SQUOT,sp)
      008462 2A 01            [ 1]  309 	jrpl 3$ 
      008464 50               [ 2]  310 	negw x 
      008465                        311 3$: ; sign remainder 
      008465 0D 05            [ 1]  312 	tnz (SREMDR,sp) 
      008467 2A 02            [ 1]  313 	jrpl 4$
      008469 90 50            [ 2]  314 	negw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      00846B                        315 4$:	
      0003EB                        316 	_drop VSIZE 
      00846B 5B 08            [ 2]    1     addw sp,#VSIZE 
      00846D 81               [ 4]  317 	ret 
                                    318 
                                    319 
                                    320 
                                    321 ;----------------------------------
                                    322 ; division x/y 
                                    323 ; input:
                                    324 ;    X       dividend
                                    325 ;    Y       divisor 
                                    326 ; output:
                                    327 ;    X       quotient
                                    328 ;    Y       remainder 
                                    329 ;-----------------------------------
                                    330 	; local variables 
                           000001   331 	DBLHI=1
                           000003   332 	DBLLO=3
                           000005   333 	DIVISR=5
                           000006   334 	VSIZE=6 
      00846E                        335 divide: 
      0003EE                        336 	_vars VSIZE
      00846E 52 06            [ 2]    1     sub sp,#VSIZE 
      008470 90 5D            [ 2]  337 	tnzw y 
      008472 26 05            [ 1]  338 	jrne 1$
      008474 A6 12            [ 1]  339 	ld a,#ERR_DIV0 
      008476 CC 92 27         [ 2]  340 	jp tb_error
      008479                        341 1$: 
      008479 17 05            [ 2]  342 	ldw (DIVISR,sp),y
      00847B CD 84 22         [ 4]  343 	call dbl_sign_extend
      00847E 1F 03            [ 2]  344 	ldw (DBLLO,sp),x 
      008480 17 01            [ 2]  345 	ldw (DBLHI,sp),y 
      008482 1E 05            [ 2]  346 	ldw x,(DIVISR,sp)
      008484 CD 84 2C         [ 4]  347 	call div32_16 
      000407                        348 	_drop VSIZE 
      008487 5B 06            [ 2]    1     addw sp,#VSIZE 
      008489 81               [ 4]  349 	ret
                                    350 
                                    351 
                                    352 ;----------------------------------
                                    353 ;  remainder resulting from euclidian 
                                    354 ;  division of x/y 
                                    355 ; input:
                                    356 ;   x   	dividend int16_t 
                                    357 ;   y 		divisor int16_t
                                    358 ; output:
                                    359 ;   X       n1%n2 
                                    360 ;----------------------------------
      00848A                        361 modulo:
      00848A CD 84 6E         [ 4]  362 	call divide
      00848D 93               [ 1]  363 	ldw x,y 
      00848E 81               [ 4]  364 	ret 
                                    365 
                                    366 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022 
                                      3 ; This file is part of PABasic 
                                      4 ;
                                      5 ;     PABasic is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     PABasic is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with PABasic.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;------------------------------
                                     19 ; This file is for functions 
                                     20 ; interfacing with VT100 terminal
                                     21 ; emulator.
                                     22 ; defined functions:
                                     23 ;   getc   wait for a character 
                                     24 ;   qgetc  check if char available 
                                     25 ;   putc   send a char to terminal
                                     26 ;   puts   print a string to terminal
                                     27 ;   readln  read text line from terminal 
                                     28 ;   spaces  print n spaces on terminal 
                                     29 ;   print_hex  print hex value from A 
                                     30 ;------------------------------
                                     31 
                           000000    32 SEPARATE=0 
                                     33 
                           000000    34 .if SEPARATE 
                                     35     .module TERMINAL  
                                     36     .include "config.inc"
                                     37 
                                     38     .area CODE 
                                     39 .endif 
                                     40 
                                     41 
                                     42 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     43 ;;   UART subroutines
                                     44 ;;   used for user interface 
                                     45 ;;   communication channel.
                                     46 ;;   settings: 
                                     47 ;;		115200 8N1 no flow control
                                     48 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     49 
                           000008    50 RX_QUEUE_SIZE==8 ; UART receive queue size 
                                     51 
                                     52 ;--------------------------------------
                                     53 	.area DATA
      00001A                         54 	.org SYS_VARS_ORG+SYS_VARS_SIZE+ARITHM_VARS_SIZE 
                                     55 ;--------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



                                     56 
      00001A                         57 out: .blkw 1 ; output char routine address 
      00001C                         58 ctrl_c_vector: .blkw 1 ; application can set a routine address here to be executed when CTTRL+C is pressed.
      00001E                         59 rx1_head:  .blkb 1 ; rx1_queue head pointer
      00001F                         60 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
      000020                         61 rx1_queue: .ds RX_QUEUE_SIZE ; UART receive circular queue 
      000028                         62 term_vars_end: 
                           00000E    63 TERMIOS_VARS_SIZE==term_vars_end-out 
                                     64 
                                     65 	.area CODE
                                     66 
                                     67 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     68 ;;; Uart1 intterrupt handler 
                                     69 ;;; on receive character 
                                     70 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     71 ;--------------------------
                                     72 ; UART receive character
                                     73 ; in a FIFO buffer 
                                     74 ; CTRL+C (ASCII 3)
                                     75 ; cancel program execution
                                     76 ; and fall back to command line
                                     77 ; CTRL+X reboot system 
                                     78 ; CTLR+Z erase EEPROM autorun 
                                     79 ;        information and reboot
                                     80 ;--------------------------
      00848F                         81 UartRxHandler: ; console receive char 
      00848F 72 0B 52 40 2B   [ 2]   82 	btjf UART_SR,#UART_SR_RXNE,5$ 
      008494 C6 52 41         [ 1]   83 	ld a,UART_DR 
      008497 A1 03            [ 1]   84 	cp a,#CTRL_C 
      008499 26 09            [ 1]   85 	jrne 2$
      00849B CE 00 1C         [ 2]   86 	ldw x,ctrl_c_vector 
      00849E 27 1F            [ 1]   87 	jreq 5$ 
      0084A0 1F 08            [ 2]   88 	ldw (8,sp),x 
      0084A2 20 1B            [ 2]   89 	jra 5$ 
      0084A4                         90 2$:
      0084A4 A1 18            [ 1]   91 	cp a,#CAN ; CTRL_X 
      0084A6 26 04            [ 1]   92 	jrne 3$
      000428                         93 	_swreset 	
      0084A8 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      0084AC                         94 3$:	
      0084AC 88               [ 1]   95 	push a 
      0084AD A6 20            [ 1]   96 	ld a,#rx1_queue 
      0084AF CB 00 1F         [ 1]   97 	add a,rx1_tail 
      0084B2 5F               [ 1]   98 	clrw x 
      0084B3 97               [ 1]   99 	ld xl,a 
      0084B4 84               [ 1]  100 	pop a 
      0084B5 F7               [ 1]  101 	ld (x),a 
      0084B6 C6 00 1F         [ 1]  102 	ld a,rx1_tail 
      0084B9 4C               [ 1]  103 	inc a 
      0084BA A4 07            [ 1]  104 	and a,#RX_QUEUE_SIZE-1
      0084BC C7 00 1F         [ 1]  105 	ld rx1_tail,a 
      0084BF                        106 5$:	
      0084BF 80               [11]  107 	iret 
                                    108 
                                    109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                                    110 ;---------------------------------------------
                                    111 ; initialize UART, 115200 8N1
                                    112 ; called from cold_start in hardware_init.asm 
                                    113 ; input:
                                    114 ;	none
                                    115 ; output:
                                    116 ;   none
                                    117 ;---------------------------------------------
                           01C200   118 BAUD_RATE=115200 
                           000001   119 	N1=1
                           000003   120 	N2=N1+INT_SIZE 
                           000005   121 	VSIZE=N2+2
      0084C0                        122 uart_init:
      000440                        123 	_vars VSIZE 
      0084C0 52 05            [ 2]    1     sub sp,#VSIZE 
                                    124 ; BRR value = Fmaster/115200 
      0084C2 5F               [ 1]  125 	clrw x 
      000443                        126 	_ldaz fmstr 
      0084C3 B6 10                    1     .byte 0xb6,fmstr 
      0084C5 02               [ 1]  127 	rlwa x 
      0084C6 90 AE 27 10      [ 2]  128 	ldw y,#10000
      0084CA CD 83 87         [ 4]  129 	call umstar
      00044D                        130 	_i16_store N2   
      0084CD 1F 03            [ 2]    1     ldw (N2,sp),x 
      0084CF 93               [ 1]  131 	ldw x,y 
      000450                        132 	_i16_store N1 
      0084D0 1F 01            [ 2]    1     ldw (N1,sp),x 
      0084D2 AE 04 80         [ 2]  133 	ldw x,#BAUD_RATE/100
      0084D5 CD 83 F2         [ 4]  134 	call udiv32_16 ; X quotient, Y  remainder 
      0084D8 90 A3 02 40      [ 2]  135 	cpw y,#BAUD_RATE/200
      0084DC 2B 01            [ 1]  136 	jrmi 1$ 
      0084DE 5C               [ 1]  137 	incw x
      0084DF                        138 1$:  
                                    139 ; // brr value in X
      0084DF A6 10            [ 1]  140 	ld a,#16 
      0084E1 62               [ 2]  141 	div x,a 
      0084E2 88               [ 1]  142 	push a  ; least nibble of BRR1 
      0084E3 02               [ 1]  143 	rlwa x 
      0084E4 4E               [ 1]  144 	swap a  ; high nibble of BRR1 
      0084E5 1A 01            [ 1]  145 	or a,(1,sp)
      000467                        146 	_drop 1 
      0084E7 5B 01            [ 2]    1     addw sp,#1 
      0084E9 C7 52 43         [ 1]  147 	ld UART_BRR2,a 
      0084EC 9E               [ 1]  148 	ld a,xh 
      0084ED C7 52 42         [ 1]  149 	ld UART_BRR1,a
      0084F0                        150 3$:
      0084F0 72 5F 52 41      [ 1]  151     clr UART_DR
      0084F4 35 2C 52 45      [ 1]  152 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      0084F8 72 10 52 45      [ 1]  153 	bset UART_CR2,#UART_CR2_SBK
      0084FC 72 0D 52 40 FB   [ 2]  154     btjf UART_SR,#UART_SR_TC,.
      008501 72 5F 00 1E      [ 1]  155     clr rx1_head 
      008505 72 5F 00 1F      [ 1]  156 	clr rx1_tail
      008509 5F               [ 1]  157 	clrw x
      00048A                        158 	_strxz ctrl_c_vector
      00850A BF 1C                    1     .byte 0xbf,ctrl_c_vector 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



      00850C AE 85 41         [ 2]  159 	ldw x,#uart_putc 
      00048F                        160 	_strxz out 
      00850F BF 1A                    1     .byte 0xbf,out 
      008511 72 10 00 02      [ 1]  161 	bset UART,#UART_CR1_PIEN
      000495                        162 	_drop VSIZE 
      008515 5B 05            [ 2]    1     addw sp,#VSIZE 
      008517 81               [ 4]  163 	ret
                                    164 
                                    165 
                                    166 ;---------------------------------
                                    167 ;  set output vector 
                                    168 ;  input:
                                    169 ;     A     STDOUT -> uart 
                                    170 ;           BUFOUT -> [ptr16]
                                    171 ;     X     buffer address 
                                    172 ;---------------------------------
      008518                        173 set_output:
      008518 CF 00 12         [ 2]  174 	ldw ptr16,x 
      00851B AE 85 41         [ 2]  175 	ldw x,#uart_putc 
      00851E A1 01            [ 1]  176 	cp a,#STDOUT 
      008520 27 07            [ 1]  177 	jreq 1$
      008522 A1 03            [ 1]  178 	cp a,#BUFOUT 
      008524 26 05            [ 1]  179 	jrne 9$  
      008526 AE 85 32         [ 2]  180 	ldw x,#buf_putc 
      0004A9                        181 1$: _strxz out  
      008529 BF 1A                    1     .byte 0xbf,out 
      00852B 81               [ 4]  182 9$:	ret 
                                    183 
                                    184 
                                    185 ;---------------------------------
                                    186 ;  vectorized character output 
                                    187 ;  input:
                                    188 ;     A   character to send 
                                    189 ;---------------------------------
      00852C                        190 putc:
      00852C 89               [ 2]  191 	pushw x 
      0004AD                        192 	_ldxz out 
      00852D BE 1A                    1     .byte 0xbe,out 
      00852F FD               [ 4]  193 	call (x)
      008530 85               [ 2]  194 	popw x 
      008531 81               [ 4]  195 	ret 
                                    196 
                                    197 ;---------------------------------
                                    198 ; output character to a buffer 
                                    199 ; pointed by ptr16
                                    200 ; input:
                                    201 ;    A     character to save 
                                    202 ;---------------------------------
      008532                        203 buf_putc:
      008532 72 C7 00 12      [ 4]  204 	ld [ptr16],a
      0004B6                        205 	_incz ptr8 
      008536 3C 13                    1     .byte 0x3c, ptr8 
      008538 26 02            [ 1]  206 	jrne 9$
      0004BA                        207 	_incz ptr16 
      00853A 3C 12                    1     .byte 0x3c, ptr16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



      00853C 72 3F 00 12      [ 4]  208 9$:	clr [ptr16] 
      008540 81               [ 4]  209 	ret 
                                    210 
                                    211 
                                    212 ;---------------------------------
                                    213 ; uart_putc
                                    214 ; send a character via UART
                                    215 ; input:
                                    216 ;    A  	character to send
                                    217 ;---------------------------------
      008541                        218 uart_putc:: 
      008541 72 0F 52 40 FB   [ 2]  219 	btjf UART_SR,#UART_SR_TXE,.
      008546 C7 52 41         [ 1]  220 	ld UART_DR,a 
      008549 81               [ 4]  221 	ret 
                                    222 
                                    223 
                                    224 ;---------------------------------
                                    225 ; Query for character in rx1_queue
                                    226 ; input:
                                    227 ;   none 
                                    228 ; output:
                                    229 ;   A     0 no charcter available
                                    230 ;   Z     1 no character available
                                    231 ;---------------------------------
      00854A                        232 qgetc::
      00854A                        233 uart_qgetc::
      0004CA                        234 	_ldaz rx1_head 
      00854A B6 1E                    1     .byte 0xb6,rx1_head 
      00854C C0 00 1F         [ 1]  235 	sub a,rx1_tail 
      00854F 81               [ 4]  236 	ret 
                                    237 
                                    238 ;---------------------------------
                                    239 ; wait character from UART 
                                    240 ; input:
                                    241 ;   none
                                    242 ; output:
                                    243 ;   A 			char  
                                    244 ;--------------------------------	
      008550                        245 getc:: ;console input
      008550                        246 uart_getc::
      008550 CD 85 4A         [ 4]  247 	call uart_qgetc
      008553 27 FB            [ 1]  248 	jreq uart_getc 
      008555 89               [ 2]  249 	pushw x 
                                    250 ;; rx1_queue must be in page 0 	
      008556 A6 20            [ 1]  251 	ld a,#rx1_queue
      008558 CB 00 1E         [ 1]  252 	add a,rx1_head 
      00855B 5F               [ 1]  253 	clrw x  
      00855C 97               [ 1]  254 	ld xl,a 
      00855D F6               [ 1]  255 	ld a,(x)
      00855E 88               [ 1]  256 	push a
      0004DF                        257 	_ldaz rx1_head 
      00855F B6 1E                    1     .byte 0xb6,rx1_head 
      008561 4C               [ 1]  258 	inc a 
      008562 A4 07            [ 1]  259 	and a,#RX_QUEUE_SIZE-1
      0004E4                        260 	_straz rx1_head 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      008564 B7 1E                    1     .byte 0xb7,rx1_head 
      008566 84               [ 1]  261 	pop a 
      008567 72 05 00 0A 03   [ 2]  262 	btjf sys_flags,#FSYS_UPPER,1$
      00856C CD 88 F4         [ 4]  263 	call to_upper 
      00856F                        264 1$: 
      00856F 85               [ 2]  265 	popw x
      008570 81               [ 4]  266 	ret 
                                    267 
                                    268 ;-----------------------------
                                    269 ;  constants replacing 
                                    270 ;  ANSI sequence received 
                                    271 ;  from terminal.
                                    272 ;  These are the ANSI sequences
                                    273 ;  accepted by readln function
                                    274 ;------------------------------
                           000080   275     ARROW_LEFT=128
                           000081   276     ARROW_RIGHT=129
                           000082   277     HOME=130
                           000083   278     KEY_END=131
                           000084   279     SUP=132 
                                    280 
      008571 43 81 44 80 48 82 46   281 convert_table: .byte 'C',ARROW_RIGHT,'D',ARROW_LEFT,'H',HOME,'F',KEY_END,'3',SUP,0,0
             83 33 84 00 00
                                    282 
                                    283 ;--------------------------------
                                    284 ; receive ANSI ESC 
                                    285 ; sequence and convert it
                                    286 ; to a single character code 
                                    287 ; in range {128..255}
                                    288 ; This is called after receiving 
                                    289 ; ESC character. 
                                    290 ; ignored sequence return 0 
                                    291 ; output:
                                    292 ;   A    converted character 
                                    293 ;-------------------------------
      00857D                        294 get_escape:
      00857D CD 85 50         [ 4]  295     call getc 
      008580 A1 5B            [ 1]  296     cp a,#'[ ; this character is expected after ESC 
      008582 27 02            [ 1]  297     jreq 1$
      008584 4F               [ 1]  298     clr a
      008585 81               [ 4]  299     ret
      008586 CD 85 50         [ 4]  300 1$: call getc 
      008589 AE 85 71         [ 2]  301     ldw x,#convert_table
      00858C                        302 2$:
      00858C F1               [ 1]  303     cp a,(x)
      00858D 27 08            [ 1]  304     jreq 4$
      00858F 1C 00 02         [ 2]  305     addw x,#2
      008592 7D               [ 1]  306     tnz (x)
      008593 26 F7            [ 1]  307     jrne 2$
      008595 4F               [ 1]  308     clr a
      008596 81               [ 4]  309     ret 
      008597 5C               [ 1]  310 4$: incw x 
      008598 F6               [ 1]  311     ld a,(x)
      008599 A1 84            [ 1]  312     cp a,#SUP
      00859B 26 05            [ 1]  313     jrne 5$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



      00859D 88               [ 1]  314     push a 
      00859E CD 85 50         [ 4]  315     call getc
      0085A1 84               [ 1]  316     pop a 
      0085A2                        317 5$:
      0085A2 81               [ 4]  318     ret 
                                    319 
                                    320 
                                    321 ;-----------------------------
                                    322 ; send an ASCIZ string to UART 
                                    323 ; input: 
                                    324 ;   x 		char * 
                                    325 ; output:
                                    326 ;   none 
                                    327 ;-------------------------------
      0085A3                        328 puts::
      0085A3 F6               [ 1]  329     ld a,(x)
      0085A4 27 06            [ 1]  330 	jreq 1$
      0085A6 CD 85 2C         [ 4]  331 	call putc 
      0085A9 5C               [ 1]  332 	incw x 
      0085AA 20 F7            [ 2]  333 	jra puts 
      0085AC 5C               [ 1]  334 1$:	incw x 
      0085AD 81               [ 4]  335 	ret 
                                    336 
                                    337 ;---------------------------------------------------------------
                                    338 ; send ANSI Control Sequence Introducer (CSI) 
                                    339 ; ANSI: CSI 
                                    340 ; note: ESC is ASCII 27
                                    341 ;       [   is ASCII 91
                                    342 ; ref: https://en.wikipedia.org/wiki/ANSI_escape_code#CSIsection  
                                    343 ;----------------------------------------------------------------- 
      0085AE                        344 send_csi:
      0085AE 88               [ 1]  345 	push a 
      0085AF A6 1B            [ 1]  346 	ld a,#ESC 
      0085B1 CD 85 2C         [ 4]  347 	call putc 
      0085B4 A6 5B            [ 1]  348 	ld a,#'[
      0085B6 CD 85 2C         [ 4]  349 	call putc
      0085B9 84               [ 1]  350 	pop a  
      0085BA 81               [ 4]  351 	ret 
                                    352 
                                    353 ;---------------------
                                    354 ;send ANSI parameter value
                                    355 ; ANSI parameter values are 
                                    356 ; sent as ASCII charater 
                                    357 ; not as binary number.
                                    358 ; this routine 
                                    359 ; convert binary number to 
                                    360 ; ASCII string and send it.
                                    361 ; expected range {0..99}
                                    362 ; input: 
                                    363 ; 	A {0..99} 
                                    364 ; output:
                                    365 ;   none 
                                    366 ;---------------------
      0085BB                        367 send_parameter:
      0085BB 89               [ 2]  368 	pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



      0085BC 5F               [ 1]  369 	clrw x 
      0085BD 97               [ 1]  370 	ld xl,a 
      0085BE A6 0A            [ 1]  371 	ld a,#10 
      0085C0 62               [ 2]  372 	div x,a 
      0085C1 95               [ 1]  373 	ld xh,a 
      0085C2 9F               [ 1]  374 	ld a,xl
      0085C3 4D               [ 1]  375     tnz a 
      0085C4 27 0B            [ 1]  376     jreq 2$
      0085C6 A1 09            [ 1]  377 	cp a,#9 
      0085C8 23 02            [ 2]  378 	jrule 1$
      0085CA A6 09            [ 1]  379 	ld a,#9
      0085CC                        380 1$:
      0085CC AB 30            [ 1]  381 	add a,#'0 
      0085CE CD 85 2C         [ 4]  382 	call putc
      0085D1 9E               [ 1]  383 2$:	ld a,xh 
      0085D2 AB 30            [ 1]  384 	add a,#'0
      0085D4 CD 85 2C         [ 4]  385 	call putc 
      0085D7 85               [ 2]  386 	popw x 
      0085D8 81               [ 4]  387 	ret 
                                    388 
                                    389 ;---------------------------
                                    390 ; delete character at left 
                                    391 ; of cursor on terminal 
                                    392 ; input:
                                    393 ;   none 
                                    394 ; output:
                                    395 ;	none 
                                    396 ;---------------------------
      0085D9                        397 bksp:
      0085D9 A6 08            [ 1]  398 	ld a,#BS 
      0085DB CD 85 2C         [ 4]  399 	call putc 
      0085DE A6 20            [ 1]  400 	ld a,#SPACE 
      0085E0 CD 85 2C         [ 4]  401 	call putc 
      0085E3 A6 08            [ 1]  402 	ld a,#BS 
      0085E5 CD 85 2C         [ 4]  403 	call putc 
      0085E8 81               [ 4]  404 	ret 
                                    405 
                                    406 ;---------------------------
                                    407 ; send LF character 
                                    408 ; terminal interpret it 
                                    409 ; as CRLF 
                                    410 ;---------------------------
      0085E9                        411 new_line: 
      0085E9 A6 0A            [ 1]  412 	ld a,#LF 
      0085EB CD 85 2C         [ 4]  413 	call putc 
      0085EE 81               [ 4]  414 	ret 
                                    415 
                                    416 ;--------------------------
                                    417 ; erase terminal screen 
                                    418 ;--------------------------
      0085EF                        419 clr_screen:
      0085EF A6 1B            [ 1]  420 	ld a,#ESC 
      0085F1 CD 85 2C         [ 4]  421 	call putc 
      0085F4 A6 63            [ 1]  422 	ld a,#'c 
      0085F6 CD 85 2C         [ 4]  423 	call putc 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



      0085F9 81               [ 4]  424 	ret 
                                    425 
                                    426 ;---------------------------
                                    427 ; move cursor at column  
                                    428 ; input:
                                    429 ;    n    colon 
                                    430 ;---------------------------
      0085FA                        431 cursor_column:
      0085FA CD 85 AE         [ 4]  432 	call send_csi 
      0085FD CD 85 BB         [ 4]  433 	call send_parameter 
      008600 A6 47            [ 1]  434 	ld a,#'G 
      008602 CD 85 2C         [ 4]  435 	call putc 
      008605 81               [ 4]  436 	ret 
                                    437 
                                    438 
                                    439 ;--------------------------
                                    440 ; output a single space
                                    441 ;--------------------------
      008606                        442 space:
      008606 A6 20            [ 1]  443 	ld a,#SPACE 
      008608 CD 85 2C         [ 4]  444 	call putc 
      00860B 81               [ 4]  445 	ret 
                                    446 
                                    447 ;--------------------------
                                    448 ; print n spaces on terminal
                                    449 ; input:
                                    450 ;  X 		number of spaces 
                                    451 ; output:
                                    452 ;	none 
                                    453 ;---------------------------
      00860C                        454 spaces::
      00860C A6 20            [ 1]  455 	ld a,#SPACE 
      00860E 5D               [ 2]  456 1$:	tnzw x
      00860F 27 06            [ 1]  457 	jreq 9$
      008611 CD 85 2C         [ 4]  458 	call putc 
      008614 5A               [ 2]  459 	decw x
      008615 20 F7            [ 2]  460 	jra 1$
      008617                        461 9$: 
      008617 81               [ 4]  462 	ret 
                                    463 
                                    464 
                                    465 ;-----------------------------
                                    466 ; send ANSI sequence to delete
                                    467 ; whole display line. 
                                    468 ; cursor set left screen.
                                    469 ; ANSI: CSI K
                                    470 ; input:
                                    471 ;   none
                                    472 ; output:
                                    473 ;   none 
                                    474 ;-----------------------------
      008618                        475 erase_line:
                                    476 ; move to screen left 
      008618 CD 86 2D         [ 4]  477 	call restore_cursor_pos  
                                    478 ; delete from cursor to end of line 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



      00861B CD 85 AE         [ 4]  479     call send_csi
      00861E A6 4B            [ 1]  480 	ld a,#'K 
      008620 CD 85 2C         [ 4]  481 	call putc 
      008623 81               [ 4]  482 	ret 
                                    483 
                                    484 ;-------------------------------
                                    485 ; save current cursor postion 
                                    486 ; this value persist to next 
                                    487 ; call to this procedure.
                                    488 ; ANSI: CSI s
                                    489 ;--------------------------------
      008624                        490 save_cursor_pos: 
      008624 CD 85 AE         [ 4]  491 	call send_csi 
      008627 A6 73            [ 1]  492 	ld a,#'s 
      008629 CD 85 2C         [ 4]  493 	call putc 
      00862C 81               [ 4]  494 	ret 
                                    495 
                                    496 ;--------------------------------
                                    497 ; restore cursor position from 
                                    498 ; saved value 
                                    499 ; ANSI: CSI u	
                                    500 ;---------------------------------
      00862D                        501 restore_cursor_pos:
      00862D 88               [ 1]  502 	push a 
      00862E CD 85 AE         [ 4]  503 	call send_csi 
      008631 A6 75            [ 1]  504 	ld a,#'u 
      008633 CD 85 2C         [ 4]  505 	call putc 
      008636 84               [ 1]  506 	pop a 
      008637 81               [ 4]  507 	ret 
                                    508 
                                    509 ;---------------------------------
                                    510 ; move cursor to CPOS 
                                    511 ; input:
                                    512 ;   A     CPOS 
                                    513 ;---------------------------------
      008638                        514 move_to_cpos:
      008638 CD 86 2D         [ 4]  515 	call restore_cursor_pos
      00863B 4D               [ 1]  516 	tnz a 
      00863C 27 0B            [ 1]  517 	jreq 9$ 
      00863E CD 85 AE         [ 4]  518 	call send_csi 
      008641 CD 85 BB         [ 4]  519 	call send_parameter
      008644 A6 43            [ 1]  520 	ld a,#'C 
      008646 CD 85 2C         [ 4]  521 	call putc 
      008649 81               [ 4]  522 9$:	ret 
                                    523 
                                    524 ;----------------------------------
                                    525 ; change cursor shape according 
                                    526 ; to editing mode 
                                    527 ; input:
                                    528 ;   A      -1 block shape (overwrite) 
                                    529 ;           0 vertical line (insert)
                                    530 ; output:
                                    531 ;   none 
                                    532 ;-----------------------------------
      00864A                        533 cursor_style:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      00864A 4D               [ 1]  534 	tnz a 
      00864B 26 04            [ 1]  535 	jrne 1$ 
      00864D A6 35            [ 1]  536 	ld a,#'5 
      00864F 20 02            [ 2]  537 	jra 2$
      008651 A6 31            [ 1]  538 1$: ld a,#'1
      008653                        539 2$:	
      008653 CD 85 AE         [ 4]  540 	call send_csi
      008656 CD 85 2C         [ 4]  541 	call putc 
      008659 CD 86 06         [ 4]  542 	call space
      00865C A6 71            [ 1]  543 	ld a,#'q 
      00865E CD 85 2C         [ 4]  544 	call putc 
      008661 81               [ 4]  545 	ret 
                                    546 
                                    547 ;--------------------------
                                    548 ; insert character in text 
                                    549 ; line 
                                    550 ; input:
                                    551 ;   A       character to insert 
                                    552 ;   XL      insert position  
                                    553 ;   XH     line length    
                                    554 ; output:
                                    555 ;   tib     updated
                                    556 ;-------------------------
                                    557  ; local variables 
                           000001   558 	ICHAR=1 ; character to insert 
                           000002   559 	LLEN=2  ; line length
                           000003   560 	IPOS=3  ; insert position 
                           000003   561 	VSIZE=3  ; local variables size 
      008662                        562 insert_char: 
      0005E2                        563 	_vars VSIZE 
      008662 52 03            [ 2]    1     sub sp,#VSIZE 
      008664 6B 01            [ 1]  564     ld (ICHAR,sp),a 
      008666 1F 02            [ 2]  565 	ldw (LLEN,sp),x 
      008668 4F               [ 1]  566 	clr a 
      008669 01               [ 1]  567 	rrwa x ; A=IPOS , XL=LLEN, XH=0 
      00866A 9F               [ 1]  568 	ld a,xl  
      00866B 10 03            [ 1]  569 	sub a,(IPOS,sp) 
      00866D 1C 16 80         [ 2]  570 	addw x,#tib 
      008670 CD 87 F6         [ 4]  571 	call move_string_right 
      008673 7B 01            [ 1]  572 	ld a,(ICHAR,sp)
      008675 F7               [ 1]  573 	ld (x),a
      0005F6                        574 	_drop VSIZE  
      008676 5B 03            [ 2]    1     addw sp,#VSIZE 
      008678 81               [ 4]  575 	ret 
                                    576 
                                    577 ;------------------------------------
                                    578 ; read a line of text from terminal
                                    579 ;  control keys: 
                                    580 ;    BS   efface caractère à gauche 
                                    581 ;    CTRL_R  edit previous line.
                                    582 ;    CTRL_D  delete line  
                                    583 ;    HOME  go to start of line  
                                    584 ;    KEY_END  go to end of line 
                                    585 ;    ARROW_LEFT  move cursor left 
                                    586 ;    ARROW_RIGHT  move cursor right 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



                                    587 ;    CTRL_L accept lower case letter 
                                    588 ;    CTRL_U accept upper case only 
                                    589 ;    CTRL_O  toggle between insert/overwrite
                                    590 ; input:
                                    591 ;	A    length of string already in buffer 
                                    592 ; local variable on stack:
                                    593 ;	LL  line length
                                    594 ;   RXCHAR last received character
                                    595 ; use:
                                    596 ;   Y point end of line  
                                    597 ; output:
                                    598 ;   A  line length 
                                    599 ;   text in tib  buffer
                                    600 ;------------------------------------
                                    601 	; local variables
                           000001   602 	RXCHAR = 1 ; last char received
                           000001   603 	LL_HB=1  ; line length high byte 
                           000002   604 	LL = 2  ; actual line length
                           000003   605 	CPOS=3  ; cursor position 
                           000004   606 	OVRWR=4 ; overwrite flag 
                           000004   607 	VSIZE=4 
      008679                        608 readln::
      008679 90 89            [ 2]  609 	pushw y 
      0005FB                        610 	_vars VSIZE 
      00867B 52 04            [ 2]    1     sub sp,#VSIZE 
      00867D 5F               [ 1]  611 	clrw x 
      00867E 1F 01            [ 2]  612 	ldw (LL_HB,sp),x 
      008680 1F 03            [ 2]  613 	ldw (CPOS,sp),x 
      008682 6B 02            [ 1]  614 	ld (LL,sp),a
      008684 6B 03            [ 1]  615 	ld (CPOS,sp),a  
      008686 03 04            [ 1]  616 	cpl (OVRWR,sp) ; default to overwrite mode
      008688 CD 86 24         [ 4]  617 	call save_cursor_pos
      00868B 0D 02            [ 1]  618 	tnz (LL,sp)
      00868D 27 10            [ 1]  619 	jreq skip_display
      00868F AE 16 80         [ 2]  620 	ldw x,#tib 
      008692 CD 85 A3         [ 4]  621 	call puts 
      008695 20 08            [ 2]  622 	jra skip_display 
      008697                        623 readln_loop:
      008697 CD 88 07         [ 4]  624 	call display_line
      00869A                        625 update_cursor:
      00869A 7B 03            [ 1]  626 	ld a,(CPOS,sp)
      00869C CD 86 38         [ 4]  627 	call move_to_cpos   
      00869F                        628 skip_display: 
      00869F CD 85 50         [ 4]  629 	call getc
      0086A2 6B 01            [ 1]  630 	ld (RXCHAR,sp),a
      0086A4 A1 1B            [ 1]  631     cp a,#ESC 
      0086A6 26 05            [ 1]  632     jrne 0$
      0086A8 CD 85 7D         [ 4]  633     call get_escape 
      0086AB 6B 01            [ 1]  634     ld (RXCHAR,sp),a 
      0086AD A1 0D            [ 1]  635 0$:	cp a,#CR
      0086AF 26 03            [ 1]  636 	jrne 1$
      0086B1 CC 87 B1         [ 2]  637 	jp readln_quit
      0086B4 A1 0A            [ 1]  638 1$:	cp a,#LF 
      0086B6 26 03            [ 1]  639 	jrne 2$ 
      0086B8 CC 87 B1         [ 2]  640 	jp readln_quit
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



      0086BB                        641 2$:
      0086BB A1 08            [ 1]  642 	cp a,#BS
      0086BD 26 10            [ 1]  643 	jrne 3$
      0086BF 7B 03            [ 1]  644 	ld a,(CPOS,sp)
      0086C1 CD 87 DD         [ 4]  645 	call delete_left
      0086C4 11 03            [ 1]  646 	cp a,(CPOS,sp)
      0086C6 27 04            [ 1]  647 	jreq 21$ 
      0086C8 6B 03            [ 1]  648 	ld (CPOS,SP),a 
      0086CA 0A 02            [ 1]  649 	dec (LL,sp)
      0086CC                        650 21$:
      0086CC CC 86 97         [ 2]  651     jp readln_loop 
      0086CF                        652 3$:
      0086CF A1 04            [ 1]  653 	cp a,#CTRL_D
      0086D1 26 0B            [ 1]  654 	jrne 4$
                                    655 ;delete line 
      0086D3 4F               [ 1]  656 	clr a 
      0086D4 AE 16 80         [ 2]  657 	ldw x,#tib 
      0086D7 7F               [ 1]  658 	clr(x)
      0086D8 0F 03            [ 1]  659 	clr (CPOS,sp)
      0086DA 0F 02            [ 1]  660 	clr (LL,sp)
      0086DC 20 B9            [ 2]  661 	jra readln_loop
      0086DE                        662 4$:
      0086DE A1 12            [ 1]  663 	cp a,#CTRL_R 
      0086E0 26 13            [ 1]  664 	jrne 5$
                                    665 ;repeat line 
      0086E2 0D 02            [ 1]  666 	tnz (LL,sp)
      0086E4 26 B1            [ 1]  667 	jrne readln_loop
      0086E6 AE 16 80         [ 2]  668 	ldw x,#tib 
      0086E9 CD 88 86         [ 4]  669 	call strlen
      0086EC 4D               [ 1]  670 	tnz a  
      0086ED 27 A8            [ 1]  671 	jreq readln_loop
      0086EF 6B 02            [ 1]  672 	ld (LL,sp),a 
      0086F1 6B 03            [ 1]  673     ld (CPOS,sp),a
      0086F3 20 A2            [ 2]  674 	jra readln_loop 
      0086F5                        675 5$:
      0086F5 A1 81            [ 1]  676 	cp a,#ARROW_RIGHT
      0086F7 26 0E            [ 1]  677    	jrne 7$ 
                                    678 ; right arrow
      0086F9 7B 03            [ 1]  679 	ld a,(CPOS,sp)
      0086FB 11 02            [ 1]  680     cp a,(LL,sp)
      0086FD 2B 03            [ 1]  681     jrmi 61$
      0086FF CC 86 9F         [ 2]  682     jp skip_display 
      008702                        683 61$:
      008702 0C 03            [ 1]  684 	inc (CPOS,sp)
      008704 CC 86 9A         [ 2]  685     jp update_cursor  
      008707 A1 80            [ 1]  686 7$: cp a,#ARROW_LEFT  
      008709 26 0C            [ 1]  687 	jrne 8$
                                    688 ; left arrow 
      00870B 0D 03            [ 1]  689 	tnz (CPOS,sp)
      00870D 26 03            [ 1]  690 	jrne 71$
      00870F CC 86 9F         [ 2]  691 	jp skip_display
      008712                        692 71$:
      008712 0A 03            [ 1]  693 	dec (CPOS,sp)
      008714 CC 86 9A         [ 2]  694 	jp update_cursor 
      008717 A1 82            [ 1]  695 8$: cp a,#HOME  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



      008719 26 08            [ 1]  696 	jrne 9$
                                    697 ; HOME 
      00871B 0F 03            [ 1]  698 	clr (CPOS,sp)
      00871D CD 86 2D         [ 4]  699 	call restore_cursor_pos
      008720 CC 86 9F         [ 2]  700 	jp skip_display  
      008723 A1 83            [ 1]  701 9$: cp a,#KEY_END  
      008725 26 07            [ 1]  702 	jrne 10$
                                    703 ; KEY_END 
      008727 7B 02            [ 1]  704 	ld a,(LL,sp)
      008729 6B 03            [ 1]  705 	ld (CPOS,sp),a 
      00872B CC 86 9A         [ 2]  706 	jp update_cursor
      00872E                        707 10$:
      00872E A1 0C            [ 1]  708 	cp a,#CTRL_L 
      008730 26 07            [ 1]  709 	jrne 11$ 
      008732 72 15 00 0A      [ 1]  710 	bres sys_flags,#FSYS_UPPER 
      008736 CC 86 9F         [ 2]  711 	jp skip_display 
      008739                        712 11$: 
      008739 A1 15            [ 1]  713 	cp a,#CTRL_U 
      00873B 26 07            [ 1]  714 	jrne 12$
      00873D 72 14 00 0A      [ 1]  715 	bset sys_flags,#FSYS_UPPER
      008741 CC 86 9F         [ 2]  716 	jp skip_display 
      008744                        717 12$: 
      008744 A1 0F            [ 1]  718 	cp a,#CTRL_O
      008746 26 0D            [ 1]  719 	jrne 13$ 
                                    720 ; toggle between insert/overwrite
      008748 03 04            [ 1]  721 	cpl (OVRWR,sp)
      00874A 7B 04            [ 1]  722  	ld a,(OVRWR,sp)
      00874C CD 86 4A         [ 4]  723 	call cursor_style
      00874F CD 82 AA         [ 4]  724 	call beep_1khz
      008752 CC 86 9F         [ 2]  725 	jp skip_display
      008755 A1 84            [ 1]  726 13$: cp a,#SUP 
      008757 26 11            [ 1]  727     jrne final_test 
                                    728 ; del character under cursor 
      008759 7B 03            [ 1]  729     ld a,(CPOS,sp)
      00875B 11 02            [ 1]  730 	cp a,(LL,sp)
      00875D 26 03            [ 1]  731 	jrne 14$ 
      00875F CC 86 9F         [ 2]  732 	jp skip_display
      008762                        733 14$:
      008762 CD 87 CF         [ 4]  734 	call delete_under
      008765 0A 02            [ 1]  735 	dec (LL,sp)
      008767 CC 86 97         [ 2]  736     jp readln_loop 
      00876A                        737 final_test:
      00876A A1 20            [ 1]  738 	cp a,#SPACE
      00876C 2A 03            [ 1]  739 	jrpl accept_char
      00876E CC 86 9F         [ 2]  740 	jp skip_display
      008771                        741 accept_char:
      008771 A6 7F            [ 1]  742 	ld a,#TIB_SIZE-1
      008773 11 02            [ 1]  743 	cp a, (LL,sp)
      008775 2A 03            [ 1]  744 	jrpl 1$
      008777 CC 86 9F         [ 2]  745 	jp skip_display ; max length reached 
      00877A 0D 04            [ 1]  746 1$:	tnz (OVRWR,sp)
      00877C 26 17            [ 1]  747 	jrne overwrite
                                    748 ; insert mode 
      00877E 7B 03            [ 1]  749     ld a,(CPOS,sp)
      008780 11 02            [ 1]  750 	cp a,(LL,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



      008782 27 11            [ 1]  751 	jreq overwrite
      008784 5F               [ 1]  752 	clrw x 
      008785 97               [ 1]  753     ld xl,a ; xl=cpos 
      008786 7B 02            [ 1]  754 	ld a,(LL,sp)
      008788 95               [ 1]  755 	ld xh,a  ; xh=ll 
      008789 7B 01            [ 1]  756     ld a,(RXCHAR,sp)
      00878B CD 86 62         [ 4]  757     call insert_char 
      00878E 0C 02            [ 1]  758     inc (LL,sp)
      008790 0C 03            [ 1]  759     inc (CPOS,sp)	
      008792 CC 86 97         [ 2]  760     jp readln_loop 
      008795                        761 overwrite:
      008795 5F               [ 1]  762 	clrw x 
      008796 7B 03            [ 1]  763 	ld a,(CPOS,sp)
      008798 97               [ 1]  764 	ld xl,a 
      008799 1C 16 80         [ 2]  765 	addw x,#tib 
      00879C 7B 01            [ 1]  766 	ld a,(RXCHAR,sp)
      00879E F7               [ 1]  767 	ld (x),a
      00879F CD 85 2C         [ 4]  768 	call putc 
      0087A2 7B 03            [ 1]  769 	ld a,(CPOS,sp)
      0087A4 11 02            [ 1]  770 	cp a,(LL,sp)
      0087A6 2B 04            [ 1]  771 	jrmi 1$
      0087A8 0C 02            [ 1]  772 	inc (LL,sp)
      0087AA 6F 01            [ 1]  773 	clr (1,x) 
      0087AC                        774 1$:	
      0087AC 0C 03            [ 1]  775 	inc (CPOS,sp)
      0087AE CC 86 9F         [ 2]  776 	jp skip_display 
      0087B1                        777 readln_quit:
      0087B1 AE 16 80         [ 2]  778 	ldw x,#tib
      0087B4 0F 01            [ 1]  779     clr (LL_HB,sp) 
      0087B6 72 FB 01         [ 2]  780     addw x,(LL_HB,sp)
      0087B9 7F               [ 1]  781     clr (x)
      0087BA A6 0D            [ 1]  782 	ld a,#CR
      0087BC CD 85 2C         [ 4]  783 	call putc
      0087BF A6 FF            [ 1]  784  	ld a,#-1 
      0087C1 CD 86 4A         [ 4]  785 	call cursor_style
      0087C4 7B 02            [ 1]  786 	ld a,(LL,sp)
      000746                        787 	_drop VSIZE 
      0087C6 5B 04            [ 2]    1     addw sp,#VSIZE 
      0087C8 90 85            [ 2]  788 	popw y 
      0087CA 72 14 00 0A      [ 1]  789 	bset sys_flags,#FSYS_UPPER 
      0087CE 81               [ 4]  790 	ret
                                    791 
                                    792 ;--------------------------
                                    793 ; delete character under cursor
                                    794 ; and update display 
                                    795 ; input:
                                    796 ;   A      cursor position
                                    797 ;   Y      end of line pointer 
                                    798 ; output:
                                    799 ;   A      not change 
                                    800 ;   Y      updated 
                                    801 ;-------------------------
                           000001   802 	CPOS=1
                           000001   803 	VSIZE=1
      0087CF                        804 delete_under:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



      0087CF 88               [ 1]  805 	push A ; CPOS 
      0087D0 5F               [ 1]  806 	clrw x 
      0087D1 97               [ 1]  807 	ld xl,a 
      0087D2 1C 16 80         [ 2]  808 	addw x,#tib 
      0087D5 F6               [ 1]  809 	ld a,(x)
      0087D6 27 03            [ 1]  810 	jreq 2$ ; at end of line  
      0087D8 CD 87 ED         [ 4]  811 	call move_string_left
      0087DB 84               [ 1]  812 2$: pop a
      0087DC 81               [ 4]  813 	ret 
                                    814 
                                    815 
                                    816 ;------------------------------
                                    817 ; delete character left of cursor
                                    818 ; and update display  
                                    819 ; input:
                                    820 ;    A    CPOS 
                                    821 ;    Y    end of line pointer 
                                    822 ; output:
                                    823 ;    A    updated CPOS 
                                    824 ;-------------------------------
      0087DD                        825 delete_left:
      0087DD 4D               [ 1]  826 	tnz a 
      0087DE 27 0C            [ 1]  827 	jreq 9$ 
      0087E0 88               [ 1]  828 	push a 
      0087E1 5F               [ 1]  829 	clrw x 
      0087E2 97               [ 1]  830 	ld xl,a  
      0087E3 1C 16 80         [ 2]  831 	addw x,#tib
      0087E6 5A               [ 2]  832 	decw x
      0087E7 CD 87 ED         [ 4]  833 	call move_string_left   
      0087EA 84               [ 1]  834 	pop a 
      0087EB 4A               [ 1]  835 	dec a  
      0087EC 81               [ 4]  836 9$:	ret 
                                    837 
                                    838 ;-----------------------------
                                    839 ; move_string_left 
                                    840 ; move .asciz 1 character left 
                                    841 ; input: 
                                    842 ;    X    destination 
                                    843 ; output:
                                    844 ;    x    end of moved string 
                                    845 ;-----------------------------
      0087ED                        846 move_string_left: 
      0087ED E6 01            [ 1]  847 1$:	ld a,(1,x)
      0087EF F7               [ 1]  848 	ld (x),a
      0087F0 27 03            [ 1]  849 	jreq 2$  
      0087F2 5C               [ 1]  850 	incw x 
      0087F3 20 F8            [ 2]  851 	jra 1$ 
      0087F5 81               [ 4]  852 2$: ret 
                                    853 
                                    854 ;-----------------------------
                                    855 ; move_string_right 
                                    856 ; move .asciz 1 character right 
                                    857 ; to give space for character 
                                    858 ; insertion 
                                    859 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



                                    860 ;   A     string length 
                                    861 ;   X     *str_end 
                                    862 ; output:
                                    863 ;   X     *slot  
                                    864 ;------------------------------
      0087F6                        865 move_string_right: 
      0087F6 4D               [ 1]  866 	tnz a 
      0087F7 27 0D            [ 1]  867 	jreq 9$
      0087F9 4C               [ 1]  868 	inc a  
      0087FA 88               [ 1]  869 	push a
      0087FB F6               [ 1]  870 1$: ld a,(x)
      0087FC E7 01            [ 1]  871 	ld (1,x),a
      0087FE 5A               [ 2]  872 	decw x  
      0087FF 0A 01            [ 1]  873 	dec (1,sp)
      008801 26 F8            [ 1]  874 	jrne 1$
      000783                        875 	_drop 1
      008803 5B 01            [ 2]    1     addw sp,#1 
      008805 5C               [ 1]  876 	incw x  
      008806 81               [ 4]  877 9$: ret 
                                    878 
                                    879 ;------------------------------
                                    880 ; display '>' on terminal 
                                    881 ; followed by edited line
                                    882 ;------------------------------
      008807                        883 display_line:
      008807 CD 86 18         [ 4]  884 	call erase_line  
                                    885 ; write edited line 	
      00880A AE 16 80         [ 2]  886 	ldw x,#tib 
      00880D CD 85 A3         [ 4]  887 	call puts 
      008810 81               [ 4]  888 	ret 
                                    889 
                                    890 ;----------------------------------
                                    891 ; convert to hexadecimal digit 
                                    892 ; input:
                                    893 ;   A       digit to convert 
                                    894 ; output:
                                    895 ;   A       hexdecimal character 
                                    896 ;----------------------------------
      008811                        897 to_hex_char::
      008811 A4 0F            [ 1]  898 	and a,#15 
      008813 A1 0A            [ 1]  899 	cp a,#10 
      008815 2B 02            [ 1]  900 	jrmi 1$ 
      008817 AB 07            [ 1]  901 	add a,#7
      008819 AB 30            [ 1]  902 1$: add a,#'0 
      00881B 81               [ 4]  903 	ret 
                                    904 
                                    905 ;------------------------------
                                    906 ; print byte  in hexadecimal 
                                    907 ; on console
                                    908 ; no space separator 
                                    909 ; input:
                                    910 ;    A		byte to print
                                    911 ;------------------------------
      00881C                        912 print_hex::
      00881C 88               [ 1]  913 	push a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



      00881D 4E               [ 1]  914 	swap a 
      00881E CD 88 11         [ 4]  915 	call to_hex_char 
      008821 CD 85 2C         [ 4]  916 	call putc 
      008824 84               [ 1]  917     pop a  
      008825 CD 88 11         [ 4]  918 	call to_hex_char
      008828 CD 85 2C         [ 4]  919 	call putc   
      00882B 81               [ 4]  920 	ret 
                                    921 
                                    922 ;------------------------
                                    923 ; print int8 
                                    924 ; input:
                                    925 ;    A    int8 
                                    926 ; output:
                                    927 ;    none 
                                    928 ;-----------------------
      00882C                        929 prt_i8:
      00882C 5F               [ 1]  930 	clrw x 
      00882D 97               [ 1]  931 	ld xl,a  
                                    932 
                                    933 
                                    934 ;------------------------------------
                                    935 ; print integer  
                                    936 ; input:
                                    937 ;	X  		    integer to print 
                                    938 ;	'base' 		numerical base for conversion 
                                    939 ;    A 			signed||unsigned conversion
                                    940 ;  output:
                                    941 ;    A          string length
                                    942 ;------------------------------------
      00882E                        943 print_int:
      00882E A6 FF            [ 1]  944 	ld a,#255  ; signed conversion  
      008830 CD 88 39         [ 4]  945     call itoa  ; conversion entier en  .asciz
      008833 88               [ 1]  946 	push a 
      008834 CD 85 A3         [ 4]  947 	call puts
      008837 84               [ 1]  948 	pop a 
      008838 81               [ 4]  949     ret	
                                    950 
                                    951 ;------------------------------------
                                    952 ; convert integer in x to string
                                    953 ; input:
                                    954 ;   'base'	conversion base 
                                    955 ;	X   	integer to convert
                                    956 ;   A       0=unsigned, else signed 
                                    957 ; output:
                                    958 ;   X  		pointer to first char of string
                                    959 ;   A       string length
                                    960 ; use:
                                    961 ;   pad     to build string 
                                    962 ;------------------------------------
                           000001   963 	SIGN=1  ; 1 byte, integer sign 
                           000002   964 	LEN=SIGN+1   ; 1 byte, string length 
                           000002   965 	VSIZE=2 ;locals size
      008839                        966 itoa::
      008839 90 89            [ 2]  967 	pushw y 
      0007BB                        968 	_vars VSIZE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



      00883B 52 02            [ 2]    1     sub sp,#VSIZE 
      00883D 0F 02            [ 1]  969 	clr (LEN,sp) ; string length  
      00883F 0F 01            [ 1]  970 	clr (SIGN,sp)    ; sign
      008841 4D               [ 1]  971 	tnz a
      008842 27 06            [ 1]  972 	jreq 1$ ; unsigned conversion  
      008844 5D               [ 2]  973 	tnzw x 
      008845 2A 03            [ 1]  974 	jrpl 1$ 
      008847 03 01            [ 1]  975 	cpl (SIGN,sp)
      008849 50               [ 2]  976 	negw x 
      00884A                        977 1$:
                                    978 ; initialize string pointer 
                                    979 ; build string at end of pad  
      00884A 90 AE 17 00      [ 2]  980 	ldw y,#pad 
      00884E 72 A9 00 80      [ 2]  981 	addw y,#PAD_SIZE 
      008852 90 5A            [ 2]  982 	decw y 
      008854 90 7F            [ 1]  983 	clr (y)
      008856 A6 20            [ 1]  984 	ld a,#SPACE
      008858 90 5A            [ 2]  985 	decw y
      00885A 90 F7            [ 1]  986 	ld (y),a 
      00885C 0C 02            [ 1]  987 	inc (LEN,sp)
      00885E                        988 itoa_loop:
      00885E A6 0A            [ 1]  989     ld a,#10 
      008860 62               [ 2]  990     div x,a 
      008861 AB 30            [ 1]  991     add a,#'0  ; remainder of division
      008863 A1 3A            [ 1]  992     cp a,#'9+1
      008865 2B 02            [ 1]  993     jrmi 2$
      008867 AB 07            [ 1]  994     add a,#7 
      008869                        995 2$:	
      008869 90 5A            [ 2]  996 	decw y
      00886B 90 F7            [ 1]  997     ld (y),a
      00886D 0C 02            [ 1]  998 	inc (LEN,sp)
                                    999 ; if x==0 conversion done
      00886F 5D               [ 2] 1000 	tnzw x 
      008870 26 EC            [ 1] 1001     jrne itoa_loop
      008872 7B 01            [ 1] 1002 	ld a,(SIGN,sp)
      008874 27 08            [ 1] 1003     jreq 10$
      008876 A6 2D            [ 1] 1004     ld a,#'-
      008878 90 5A            [ 2] 1005     decw y
      00887A 90 F7            [ 1] 1006     ld (y),a
      00887C 0C 02            [ 1] 1007 	inc (LEN,sp)
      00887E                       1008 10$:
      00887E 7B 02            [ 1] 1009 	ld a,(LEN,sp)
      008880 93               [ 1] 1010 	ldw x,y 
      000801                       1011 	_drop VSIZE
      008881 5B 02            [ 2]    1     addw sp,#VSIZE 
      008883 90 85            [ 2] 1012 	popw y 
      008885 81               [ 4] 1013 	ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022,2023  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;--------------------------
                                     20 ; standards functions
                                     21 ;--------------------------
                                     22 
                                     23 
                                     24 ;--------------------------
                                     25 	.area CODE
                                     26 ;--------------------------
                                     27 
                                     28 ;--------------------------------------
                                     29 ; retrun string length
                                     30 ; input:
                                     31 ;   X         .asciz  pointer 
                                     32 ; output:
                                     33 ;   X         not affected 
                                     34 ;   A         length 
                                     35 ;-------------------------------------
      008886                         36 strlen::
      008886 89               [ 2]   37 	pushw x 
      008887 4F               [ 1]   38 	clr a
      008888 7D               [ 1]   39 1$:	tnz (x) 
      008889 27 04            [ 1]   40 	jreq 9$ 
      00888B 4C               [ 1]   41 	inc a 
      00888C 5C               [ 1]   42 	incw x 
      00888D 20 F9            [ 2]   43 	jra 1$ 
      00888F 85               [ 2]   44 9$:	popw x 
      008890 81               [ 4]   45 	ret 
                                     46 
                                     47 ;------------------------------------
                                     48 ; compare 2 strings
                                     49 ; input:
                                     50 ;   X 		char* first string 
                                     51 ;   Y       char* second string 
                                     52 ; output:
                                     53 ;   Z flag 	0 != | 1 ==  
                                     54 ;-------------------------------------
      008891                         55 strcmp::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



      008891 F6               [ 1]   56 	ld a,(x)
      008892 27 09            [ 1]   57 	jreq 5$ 
      008894 90 F1            [ 1]   58 	cp a,(y) 
      008896 26 07            [ 1]   59 	jrne 9$ 
      008898 5C               [ 1]   60 	incw x 
      008899 90 5C            [ 1]   61 	incw y 
      00889B 20 F4            [ 2]   62 	jra strcmp 
      00889D                         63 5$: ; end of first string 
      00889D 90 F1            [ 1]   64 	cp a,(y)
      00889F 81               [ 4]   65 9$:	ret 
                                     66 
                                     67 ;---------------------------------------
                                     68 ;  copy src string to dest 
                                     69 ; input:
                                     70 ;   X 		dest 
                                     71 ;   Y 		src 
                                     72 ; output: 
                                     73 ;   X 		dest 
                                     74 ;----------------------------------
      0088A0                         75 strcpy::
      0088A0 88               [ 1]   76 	push a 
      0088A1 89               [ 2]   77 	pushw x 
      0088A2 90 F6            [ 1]   78 1$: ld a,(y)
      0088A4 27 06            [ 1]   79 	jreq 9$ 
      0088A6 F7               [ 1]   80 	ld (x),a 
      0088A7 5C               [ 1]   81 	incw x 
      0088A8 90 5C            [ 1]   82 	incw y 
      0088AA 20 F6            [ 2]   83 	jra 1$ 
      0088AC 7F               [ 1]   84 9$:	clr (x)
      0088AD 85               [ 2]   85 	popw x 
      0088AE 84               [ 1]   86 	pop a 
      0088AF 81               [ 4]   87 	ret 
                                     88 
                                     89 ;---------------------------------------
                                     90 ; move memory block 
                                     91 ; input:
                                     92 ;   X 		destination 
                                     93 ;   Y 	    source 
                                     94 ;   acc16	bytes count 
                                     95 ; output:
                                     96 ;   X       destination 
                                     97 ;--------------------------------------
                           000001    98 	INCR=1 ; incrament high byte 
                           000002    99 	LB=2 ; increment low byte 
                           000002   100 	VSIZE=2
      0088B0                        101 move::
      0088B0 88               [ 1]  102 	push a 
      0088B1 89               [ 2]  103 	pushw x 
      000832                        104 	_vars VSIZE 
      0088B2 52 02            [ 2]    1     sub sp,#VSIZE 
      0088B4 0F 01            [ 1]  105 	clr (INCR,sp)
      0088B6 0F 02            [ 1]  106 	clr (LB,sp)
      0088B8 90 89            [ 2]  107 	pushw y 
      0088BA 13 01            [ 2]  108 	cpw x,(1,sp) ; compare DEST to SRC 
      0088BC 90 85            [ 2]  109 	popw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]



      0088BE 27 2F            [ 1]  110 	jreq move_exit ; x==y 
      0088C0 2B 0E            [ 1]  111 	jrmi move_down
      0088C2                        112 move_up: ; start from top address with incr=-1
      0088C2 72 BB 00 18      [ 2]  113 	addw x,acc16
      0088C6 72 B9 00 18      [ 2]  114 	addw y,acc16
      0088CA 03 01            [ 1]  115 	cpl (INCR,sp)
      0088CC 03 02            [ 1]  116 	cpl (LB,sp)   ; increment = -1 
      0088CE 20 05            [ 2]  117 	jra move_loop  
      0088D0                        118 move_down: ; start from bottom address with incr=1 
      0088D0 5A               [ 2]  119     decw x 
      0088D1 90 5A            [ 2]  120 	decw y
      0088D3 0C 02            [ 1]  121 	inc (LB,sp) ; incr=1 
      0088D5                        122 move_loop:	
      000855                        123     _ldaz acc16 
      0088D5 B6 18                    1     .byte 0xb6,acc16 
      0088D7 CA 00 19         [ 1]  124 	or a, acc8
      0088DA 27 13            [ 1]  125 	jreq move_exit 
      0088DC 72 FB 01         [ 2]  126 	addw x,(INCR,sp)
      0088DF 72 F9 01         [ 2]  127 	addw y,(INCR,sp) 
      0088E2 90 F6            [ 1]  128 	ld a,(y)
      0088E4 F7               [ 1]  129 	ld (x),a 
      0088E5 89               [ 2]  130 	pushw x 
      000866                        131 	_ldxz acc16 
      0088E6 BE 18                    1     .byte 0xbe,acc16 
      0088E8 5A               [ 2]  132 	decw x 
      0088E9 CF 00 18         [ 2]  133 	ldw acc16,x 
      0088EC 85               [ 2]  134 	popw x 
      0088ED 20 E6            [ 2]  135 	jra move_loop
      0088EF                        136 move_exit:
      00086F                        137 	_drop VSIZE
      0088EF 5B 02            [ 2]    1     addw sp,#VSIZE 
      0088F1 85               [ 2]  138 	popw x 
      0088F2 84               [ 1]  139 	pop a 
      0088F3 81               [ 4]  140 	ret 	
                                    141 
                                    142 ;-------------------------
                                    143 ;  upper case letter 
                                    144 ; input:
                                    145 ;   A    letter 
                                    146 ; output:
                                    147 ;   A    
                                    148 ;--------------------------
      0088F4                        149 to_upper:
      0088F4 A1 61            [ 1]  150     cp a,#'a 
      0088F6 2B 06            [ 1]  151     jrmi 9$ 
      0088F8 A1 7B            [ 1]  152     cp a,#'z+1 
      0088FA 2A 02            [ 1]  153     jrpl 9$ 
      0088FC A4 DF            [ 1]  154     and a,#0xDF 
      0088FE 81               [ 4]  155 9$: ret 
                                    156 
                                    157 ;-------------------------------------
                                    158 ; check if A is a letter 
                                    159 ; input:
                                    160 ;   A 			character to test 
                                    161 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



                                    162 ;   C flag      1 true, 0 false 
                                    163 ;-------------------------------------
      0088FF                        164 is_alpha::
      0088FF A1 41            [ 1]  165 	cp a,#'A 
      008901 8C               [ 1]  166 	ccf 
      008902 24 0B            [ 1]  167 	jrnc 9$ 
      008904 A1 5B            [ 1]  168 	cp a,#'Z+1 
      008906 25 07            [ 1]  169 	jrc 9$ 
      008908 A1 61            [ 1]  170 	cp a,#'a 
      00890A 8C               [ 1]  171 	ccf 
      00890B 24 02            [ 1]  172 	jrnc 9$
      00890D A1 7B            [ 1]  173 	cp a,#'z+1
      00890F 81               [ 4]  174 9$: ret 	
                                    175 
                                    176 ;------------------------------------
                                    177 ; check if character in {'0'..'9'}
                                    178 ; input:
                                    179 ;    A  character to test
                                    180 ; output:
                                    181 ;    Carry  0 not digit | 1 digit
                                    182 ;------------------------------------
      008910                        183 is_digit::
      008910 A1 30            [ 1]  184 	cp a,#'0
      008912 25 03            [ 1]  185 	jrc 1$
      008914 A1 3A            [ 1]  186     cp a,#'9+1
      008916 8C               [ 1]  187 	ccf 
      008917 8C               [ 1]  188 1$:	ccf 
      008918 81               [ 4]  189     ret
                                    190 
                                    191 ;------------------------------------
                                    192 ; check if character in {'0'..'9','A'..'F'}
                                    193 ; input:
                                    194 ;    A  character to test
                                    195 ; output:
                                    196 ;    Carry  0 not hex_digit | 1 hex_digit
                                    197 ;------------------------------------
      008919                        198 is_hex_digit::
      008919 CD 89 10         [ 4]  199 	call is_digit 
      00891C 25 08            [ 1]  200 	jrc 9$
      00891E A1 41            [ 1]  201 	cp a,#'A 
      008920 25 03            [ 1]  202 	jrc 1$
      008922 A1 47            [ 1]  203 	cp a,#'G 
      008924 8C               [ 1]  204 	ccf 
      008925 8C               [ 1]  205 1$: ccf 
      008926 81               [ 4]  206 9$: ret 
                                    207 
                                    208 
                                    209 ;-------------------------------------
                                    210 ; return true if character in  A 
                                    211 ; is letter or digit.
                                    212 ; input:
                                    213 ;   A     ASCII character 
                                    214 ; output:
                                    215 ;   A     no change 
                                    216 ;   Carry    0 false| 1 true 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]



                                    217 ;--------------------------------------
      008927                        218 is_alnum::
      008927 CD 89 10         [ 4]  219 	call is_digit
      00892A 25 03            [ 1]  220 	jrc 1$ 
      00892C CD 88 FF         [ 4]  221 	call is_alpha
      00892F 81               [ 4]  222 1$:	ret 
                                    223 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of pomme-1 
                                      4 ;
                                      5 ;     pomme-1 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     pomme-1 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with pomme-1.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------
                                     20 ;  SPI peripheral support
                                     21 ;  low level driver 
                                     22 ;--------------------------------
                                     23 
                                     24 	.module SPI 
                                     25 
                           000000    26 SEPARATE=0 
                                     27 
                           000000    28 .if SEPARATE 
                                     29     .module I2C   
                                     30     .include "config.inc"
                                     31 
                                     32     .area CODE 
                                     33 .endif 
                                     34 
                                     35 ; SPI channel select pins 
                           000000    36 SPI_CS_RAM==0     ; PB0 
                           000001    37 SPI_CS_FLASH==1   ; PB1 
                                     38 
                                     39 ;---------------------------------
                                     40 ; enable SPI peripheral to maximum 
                                     41 ; frequency = Fspi=Fmstr/2 
                                     42 ; input:
                                     43 ;    none  
                                     44 ; output:
                                     45 ;    none 
                                     46 ;--------------------------------- 
      008930                         47 cmd_spi_enable:
                                     48 ; configure ~CS on PB1 and BP0 (CN4:11 and CN4:12) as output. 
      008930 72 10 50 07      [ 1]   49 	bset PB_DDR,#SPI_CS_RAM 
      008934 72 10 50 05      [ 1]   50 	bset PB_ODR,#SPI_CS_RAM   ; deselet channel 
      008938 72 12 50 07      [ 1]   51 	bset PB_DDR,#SPI_CS_FLASH  
      00893C 72 12 50 05      [ 1]   52 	bset PB_ODR,#SPI_CS_FLASH  ; deselect channel 
                                     53 ; configure SPI as master mode 0.	
      008940 72 14 52 00      [ 1]   54 	bset SPI_CR1,#SPI_CR1_MSTR
                                     55 ; enable SPI
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]



      008944 72 1C 52 00      [ 1]   56 	bset SPI_CR1,#SPI_CR1_SPE 	
      008948 81               [ 4]   57 	ret 
                                     58 
                                     59 ;----------------------------
                                     60 ; disable SPI peripheral 
                                     61 ;----------------------------
      008949                         62 spi_disable:
                                     63 ; wait spi idle 
      008949 72 0E 52 03 FB   [ 2]   64 	btjt SPI_SR,#SPI_SR_BSY,.
      00894E 72 1D 52 00      [ 1]   65 	bres SPI_CR1,#SPI_CR1_SPE
      008952 72 13 50 C7      [ 1]   66 	bres CLK_PCKENR1,#CLK_PCKENR1_SPI 
      008956 72 11 50 07      [ 1]   67 	bres PB_DDR,#SPI_CS_RAM 
      00895A 72 13 50 07      [ 1]   68 	bres PB_DDR,#SPI_CS_FLASH  
      00895E 81               [ 4]   69 	ret 
                                     70 
                                     71 ;------------------------
                                     72 ; clear SPI error 
                                     73 ;-----------------------
      00895F                         74 spi_clear_error:
      00895F A6 78            [ 1]   75 	ld a,#0x78 
      008961 C5 52 03         [ 1]   76 	bcp a,SPI_SR 
      008964 27 04            [ 1]   77 	jreq 1$
      008966 72 5F 52 03      [ 1]   78 	clr SPI_SR 
      00896A 81               [ 4]   79 1$: ret 
                                     80 
                                     81 ;----------------------
                                     82 ; send byte 
                                     83 ; input:
                                     84 ;   A     byte to send 
                                     85 ; output:
                                     86 ;   A     byte received 
                                     87 ;----------------------
      00896B                         88 spi_send_byte:
      00896B 88               [ 1]   89 	push a 
      00896C CD 89 5F         [ 4]   90 	call spi_clear_error
      00896F 84               [ 1]   91 	pop a 
      008970 72 03 52 03 FB   [ 2]   92 	btjf SPI_SR,#SPI_SR_TXE,.
      008975 C7 52 04         [ 1]   93 	ld SPI_DR,a
      008978 72 01 52 03 FB   [ 2]   94 	btjf SPI_SR,#SPI_SR_RXNE,.  
      00897D C6 52 04         [ 1]   95 	ld a,SPI_DR 
      008980 81               [ 4]   96 	ret 
                                     97 
                                     98 ;------------------------------
                                     99 ;  receive SPI byte 
                                    100 ; output:
                                    101 ;    A 
                                    102 ;------------------------------
      008981                        103 spi_rcv_byte:
      008981 A6 FF            [ 1]  104 	ld a,#255
      008983 72 01 52 03 E3   [ 2]  105 	btjf SPI_SR,#SPI_SR_RXNE,spi_send_byte 
      008988 C6 52 04         [ 1]  106 	ld a,SPI_DR 
      00898B 81               [ 4]  107 	ret
                                    108 
                                    109 ;----------------------------
                                    110 ;  create bit mask
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]



                                    111 ;  input:
                                    112 ;     A     bit 
                                    113 ;  output:
                                    114 ;     A     2^bit 
                                    115 ;-----------------------------
      00898C                        116 create_bit_mask:
      00898C 88               [ 1]  117 	push a 
      00898D A6 01            [ 1]  118 	ld a,#1 
      00898F 0D 01            [ 1]  119 	tnz (1,sp)
      008991 27 05            [ 1]  120 	jreq 9$
      008993                        121 1$:
      008993 48               [ 1]  122 	sll a 
      008994 0A 01            [ 1]  123 	dec (1,sp)
      008996 26 FB            [ 1]  124 	jrne 1$
      000918                        125 9$: _drop 1
      008998 5B 01            [ 2]    1     addw sp,#1 
      00899A 81               [ 4]  126 	ret 
                                    127 
                                    128 ;-------------------------------
                                    129 ; SPI select channel 
                                    130 ; input:
                                    131 ;   A    channel SPI_CS_RAM || 
                                    132 ;                SPI_CS_FLASH 
                                    133 ;--------------------------------
      00899B                        134 spi_select_channel:
      00899B CD 89 8C         [ 4]  135 	call create_bit_mask 
      00899E 43               [ 1]  136 	cpl a  
      00899F 88               [ 1]  137 	push a 
      0089A0 C6 50 05         [ 1]  138 	ld a,PB_ODR 
      0089A3 14 01            [ 1]  139 	and a,(1,sp)
      0089A5 C7 50 05         [ 1]  140 	ld PB_ODR,a 
      000928                        141 	_drop 1 
      0089A8 5B 01            [ 2]    1     addw sp,#1 
      0089AA 81               [ 4]  142 	ret 
                                    143 
                                    144 ;------------------------------
                                    145 ; SPI deselect channel 
                                    146 ; input:
                                    147 ;   A    channel SPI_CS_RAM ||
                                    148 ; 				 SPI_CS_FLASH 
                                    149 ;-------------------------------
      0089AB                        150 spi_deselect_channel:
      0089AB CD 89 8C         [ 4]  151 	call create_bit_mask 
      0089AE 88               [ 1]  152 	push a 
      0089AF C6 50 05         [ 1]  153 	ld a,PB_ODR 
      0089B2 1A 01            [ 1]  154 	or a,(1,sp)
      0089B4 C7 50 05         [ 1]  155 	ld PB_ODR,a 
      000937                        156 	_drop 1 
      0089B7 5B 01            [ 2]    1     addw sp,#1 
      0089B9 81               [ 4]  157 	ret 
                                    158 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of pomme-1 
                                      4 ;
                                      5 ;     pomme-1 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     pomme-1 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with pomme-1.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;--------------------------------
                                     20 ;  with this version of wozmon 
                                     21 ;  for stm8 I follow exact model 
                                     22 ;  used by Steve Wozniak only 
                                     23 ;  exception is taking advantage 
                                     24 ;  of extension that STM8 bring 
                                     25 ;  over 6502 cpu. 
                                     26 ;--------------------------------
                                     27 
                                     28 
                                     29     .module MONITOR
                                     30 
                                     31     .area CODE
                                     32 
                                     33 ;--------------------------------------------------
                                     34 ; command line interface
                                     35 ; input formats:
                                     36 ;       hex_number  -> display byte at that address 
                                     37 ;       hex_number.hex_number -> display bytes in that range 
                                     38 ;       hex_number: hex_byte [hex_byte]*  -> modify content of RAM or peripheral registers 
                                     39 ;       hex_numberR  -> run machine code a hex_number  address  
                                     40 ;       CTRL_B -> launch pomme BASIC
                                     41 ;----------------------------------------------------
                                     42 ; monitor variables 
                           000028    43 YSAV = APP_VARS_START_ADR 
                           00002A    44 XAMADR = YSAV+2
                           00002C    45 STORADR= XAMADR+2
                           00002E    46 LAST=STORADR+2
                           000030    47 MODE=LAST+2 
                                     48 
                                     49 
                                     50 ; operating modes
                           000000    51 XAM=0
                           00002E    52 XAM_BLOK='.
                           00003A    53 STOR=': 
                                     54 
                                     55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal [24-Bits]



                                     56 ; Modeled on Apple I monitor Written by Steve Wozniak 
                                     57 
      0089BA 70 6F 6D 6D 65 20 49    58 mon_str: .asciz "pomme I monitor" 
             20 6D 6F 6E 69 74 6F
             72 00
                                     59 
      0089CA                         60 GO_BASIC: 
      0089CA CC 93 1C         [ 2]   61     jp P1BASIC 
      0089CD                         62 WOZMON:: 
      0089CD CD 85 EF         [ 4]   63     call clr_screen
      0089D0 AE 89 BA         [ 2]   64     ldw x,#mon_str
      0089D3 CD 85 A3         [ 4]   65     call puts 
      0089D6                         66 GETLINE: 
      0089D6 A6 0D            [ 1]   67     ld a,#CR 
      0089D8 CD 85 2C         [ 4]   68     call putc 
      0089DB A6 23            [ 1]   69     ld a,#'# 
      0089DD CD 85 2C         [ 4]   70     call putc
      0089E0 90 5F            [ 1]   71     clrw y 
      0089E2 20 09            [ 2]   72     jra NEXTCHAR 
      0089E4                         73 BACKSPACE:
      0089E4 90 5D            [ 2]   74     tnzw y 
      0089E6 27 05            [ 1]   75     jreq NEXTCHAR 
      0089E8 CD 85 D9         [ 4]   76     call bksp 
      0089EB 90 5A            [ 2]   77     decw y 
      0089ED                         78 NEXTCHAR:
      0089ED CD 85 50         [ 4]   79     call getc
      0089F0 A1 08            [ 1]   80     cp a,#BS  
      0089F2 27 F0            [ 1]   81     jreq BACKSPACE 
      0089F4 A1 1B            [ 1]   82     cp a,#ESC 
      0089F6 27 DE            [ 1]   83     jreq GETLINE ; rejected characters cancel input, start over  
      0089F8 A1 02            [ 1]   84     cp a,#CTRL_B 
      0089FA 27 CE            [ 1]   85     jreq GO_BASIC 
      0089FC A1 60            [ 1]   86     cp a,#'`
      0089FE 2B 02            [ 1]   87     jrmi UPPER ; already uppercase 
                                     88 ; uppercase character
                                     89 ; all characters from 0x60..0x7f 
                                     90 ; are folded to 0x40..0x5f     
      008A00 A4 DF            [ 1]   91     and a,#0XDF  
      008A02                         92 UPPER: ; there is no lower case letter in buffer 
      008A02 90 D7 16 80      [ 1]   93     ld (tib,y),a 
      008A06 CD 85 2C         [ 4]   94     call putc
      008A09 A1 0D            [ 1]   95     cp a,#CR 
      008A0B 27 04            [ 1]   96     jreq EOL
      008A0D 90 5C            [ 1]   97     incw y 
      008A0F 20 DC            [ 2]   98     jra NEXTCHAR  
      008A11                         99 EOL: ; end of line, now analyse input 
      008A11 90 AE FF FF      [ 2]  100     ldw y,#-1
      008A15 4F               [ 1]  101     clr a  
      008A16                        102 SETMODE: 
      000996                        103     _straz MODE  
      008A16 B7 30                    1     .byte 0xb7,MODE 
      008A18                        104 BLSKIP: ; skip blank  
      008A18 90 5C            [ 1]  105     incw y 
      008A1A                        106 NEXTITEM:
      008A1A 90 D6 16 80      [ 1]  107     ld a,(tib,y)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal [24-Bits]



      008A1E A1 0D            [ 1]  108     cp a,#CR ; 
      008A20 27 B4            [ 1]  109     jreq GETLINE ; end of input line  
      008A22 A1 2E            [ 1]  110     cp a,#XAM_BLOK
      008A24 2B F2            [ 1]  111     jrmi BLSKIP 
      008A26 27 EE            [ 1]  112     jreq SETMODE 
      008A28 A1 3A            [ 1]  113     cp a,#STOR 
      008A2A 27 EA            [ 1]  114     jreq SETMODE 
      008A2C A1 52            [ 1]  115     cp a,#'R 
      008A2E 27 44            [ 1]  116     jreq RUN
      0009B0                        117     _stryz YSAV ; save for comparison
      008A30 90 BF 28                 1     .byte 0x90,0xbf,YSAV 
      008A33 5F               [ 1]  118     clrw x 
      008A34                        119 NEXTHEX:
      008A34 90 D6 16 80      [ 1]  120     ld a,(tib,y)
      008A38 A8 30            [ 1]  121     xor a,#0x30 
      008A3A A1 0A            [ 1]  122     cp a,#10 
      008A3C 2B 06            [ 1]  123     jrmi DIG 
      008A3E A1 71            [ 1]  124     cp a,#0x71 
      008A40 2B 10            [ 1]  125     jrmi NOTHEX 
      008A42 A0 67            [ 1]  126     sub a,#0x67
      008A44                        127 DIG: 
      008A44 4B 04            [ 1]  128     push #4
      008A46 4E               [ 1]  129     swap a 
      008A47                        130 HEXSHIFT:
      008A47 48               [ 1]  131     sll a 
      008A48 59               [ 2]  132     rlcw x  
      008A49 0A 01            [ 1]  133     dec (1,sp)
      008A4B 26 FA            [ 1]  134     jrne HEXSHIFT
      008A4D 84               [ 1]  135     pop a 
      008A4E 90 5C            [ 1]  136     incw y
      008A50 20 E2            [ 2]  137     jra NEXTHEX
      008A52                        138 NOTHEX:
      008A52 90 B3 28         [ 2]  139     cpw y,YSAV 
      008A55 26 03            [ 1]  140     jrne GOTNUMBER
      008A57 CC 89 D6         [ 2]  141     jp GETLINE ; no hex number  
      008A5A                        142 GOTNUMBER: 
      0009DA                        143     _ldaz MODE 
      008A5A B6 30                    1     .byte 0xb6,MODE 
      008A5C 26 09            [ 1]  144     jrne NOTREAD ; not READ mode  
                                    145 ; set XAM and STOR address 
      0009DE                        146     _strxz XAMADR 
      008A5E BF 2A                    1     .byte 0xbf,XAMADR 
      0009E0                        147     _strxz STORADR 
      008A60 BF 2C                    1     .byte 0xbf,STORADR 
      0009E2                        148     _strxz LAST 
      008A62 BF 2E                    1     .byte 0xbf,LAST 
      008A64 4F               [ 1]  149     clr a 
      008A65 20 16            [ 2]  150     jra NXTPRNT 
      008A67                        151 NOTREAD:  
                                    152 ; which mode then?        
      008A67 A1 3A            [ 1]  153     cp a,#': 
      008A69 26 0C            [ 1]  154     jrne XAM_BLOCK
      008A6B 9F               [ 1]  155     ld a,xl 
      0009EC                        156     _ldxz STORADR 
      008A6C BE 2C                    1     .byte 0xbe,STORADR 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]



      008A6E F7               [ 1]  157     ld (x),a 
      008A6F 5C               [ 1]  158     incw x 
      0009F0                        159     _strxz STORADR 
      008A70 BF 2C                    1     .byte 0xbf,STORADR 
      008A72                        160 TONEXTITEM:
      008A72 20 A6            [ 2]  161     jra NEXTITEM 
      008A74                        162 RUN:
      0009F4                        163     _ldxz XAMADR 
      008A74 BE 2A                    1     .byte 0xbe,XAMADR 
      008A76 FC               [ 2]  164     jp (x)
      008A77                        165 XAM_BLOCK:
      0009F7                        166     _strxz LAST 
      008A77 BF 2E                    1     .byte 0xbf,LAST 
      0009F9                        167     _ldxz XAMADR
      008A79 BE 2A                    1     .byte 0xbe,XAMADR 
      008A7B 5C               [ 1]  168     incw x 
      008A7C 9F               [ 1]  169     ld a,xl
      008A7D                        170 NXTPRNT:
      008A7D 26 12            [ 1]  171     jrne PRDATA 
      008A7F A6 0D            [ 1]  172     ld a,#CR 
      008A81 CD 85 2C         [ 4]  173     call putc 
      008A84 9E               [ 1]  174     ld a,xh 
      008A85 CD 8A A6         [ 4]  175     call PRBYTE 
      008A88 9F               [ 1]  176     ld a,xl 
      008A89 CD 8A A6         [ 4]  177     call PRBYTE 
      008A8C A6 3A            [ 1]  178     ld a,#': 
      008A8E CD 85 2C         [ 4]  179     call putc 
      008A91                        180 PRDATA:
      008A91 A6 20            [ 1]  181     ld a,#SPACE 
      008A93 CD 85 2C         [ 4]  182     call putc
      008A96 F6               [ 1]  183     ld a,(x)
      008A97 CD 8A A6         [ 4]  184     call PRBYTE
      008A9A 5C               [ 1]  185     incw x
      008A9B 27 D5            [ 1]  186     jreq TONEXTITEM ; rollover 
      008A9D                        187 XAMNEXT:
      008A9D B3 2E            [ 2]  188     cpw x,LAST 
      008A9F 22 D1            [ 1]  189     jrugt TONEXTITEM
      008AA1                        190 MOD8CHK:
      008AA1 9F               [ 1]  191     ld a,xl 
      008AA2 A4 07            [ 1]  192     and a,#7 
      008AA4 20 D7            [ 2]  193     jra NXTPRNT
      008AA6                        194 PRBYTE:
      008AA6 CD 88 1C         [ 4]  195     call print_hex
      008AA9 81               [ 4]  196     ret 
      008AAA                        197 ECHO:
      008AAA CD 85 2C         [ 4]  198     call putc 
      008AAD 81               [ 4]  199     RET 
                                    200 
                                    201 ;----------------------------
                                    202 ; code to test 'R' command 
                                    203 ; blink LED on NUCLEO board 
                                    204 ;----------------------------
                           000000   205 .if 0
                                    206 r_test:
                                    207     bset PC_DDR,#5
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 92.
Hexadecimal [24-Bits]



                                    208     bset PC_CR1,#5
                                    209 1$: bcpl PC_ODR,#5 
                                    210 ; delay 
                                    211     ld a,#4
                                    212     clrw x
                                    213 2$:
                                    214     decw x 
                                    215     jrne 2$
                                    216     dec a 
                                    217     jrne 2$ 
                                    218 ; if key exit 
                                    219     btjf UART_SR,#UART_SR_RXNE,1$
                                    220     ld a,UART_DR 
                                    221 ; reset MCU to ensure monitor
                                    222 ; with peripherals in known state
                                    223     _swreset
                                    224 
                                    225 ;------------------------------------
                                    226 ; another program to test 'R' command
                                    227 ; print ASCII characters to terminal
                                    228 ; in loop 
                                    229 ;-------------------------------------
                                    230 ascii:
                                    231     ld a,#SPACE
                                    232 1$:
                                    233     call putc 
                                    234     inc a 
                                    235     cp a,#127 
                                    236     jrmi 1$
                                    237     ld a,#CR 
                                    238     call putc 
                                    239 ; if key exit 
                                    240     btjf UART_SR,#UART_SR_RXNE,ascii
                                    241     ld a,UART_DR 
                                    242 ; reset MCU to ensure monitor
                                    243 ; with peripherals in known state
                                    244     _swreset
                                    245 
                                    246 .endif 
                                    247 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 93.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           000000    19 .if SEPARATE 
                                     20     .module PROC_TABLE 
                                     21     .include "config.inc"
                                     22 
                                     23     .area CODE 
                                     24 .endif 
                                     25 
                                     26 
                                     27 
                                     28 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     29 ;;  table of code routines 
                                     30 ;; used by virtual machine 
                                     31 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     32 
                                     33 	.macro _code_entry proc_address,token_name    
                                     34 	.word proc_address
                                     35 	token_name =TOK_IDX 
                                     36 	TOK_IDX=TOK_IDX+1 
                                     37 	.endm 
                                     38 
                           000000    39 	TOK_IDX=0
      008AAE                         40 code_addr:
                                     41 ; command end marker  
      000A2E                         42 	_code_entry next_line, EOL_IDX  ; $0 
      008AAE 93 BE                    1 	.word next_line
                           000000     2 	EOL_IDX =TOK_IDX 
                           000001     3 	TOK_IDX=TOK_IDX+1 
      000A30                         43 	_code_entry do_nothing, COLON_IDX   ; $1 ':'
      008AB0 93 A6                    1 	.word do_nothing
                           000001     2 	COLON_IDX =TOK_IDX 
                           000002     3 	TOK_IDX=TOK_IDX+1 
                           000001    44     CMD_END = TOK_IDX-1 
                                     45 ; caractères délimiteurs 
      000A32                         46     _code_entry syntax_error, COMMA_IDX ; $2  ',' 
      008AB2 92 25                    1 	.word syntax_error
                           000002     2 	COMMA_IDX =TOK_IDX 
                           000003     3 	TOK_IDX=TOK_IDX+1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 94.
Hexadecimal [24-Bits]



      000A34                         47 	_code_entry syntax_error,SCOL_IDX  ; $3 ';' 
      008AB4 92 25                    1 	.word syntax_error
                           000003     2 	SCOL_IDX =TOK_IDX 
                           000004     3 	TOK_IDX=TOK_IDX+1 
      000A36                         48 	_code_entry syntax_error, LPAREN_IDX ; $4 '(' 
      008AB6 92 25                    1 	.word syntax_error
                           000004     2 	LPAREN_IDX =TOK_IDX 
                           000005     3 	TOK_IDX=TOK_IDX+1 
      000A38                         49 	_code_entry syntax_error, RPAREN_IDX ; $5 ')' 
      008AB8 92 25                    1 	.word syntax_error
                           000005     2 	RPAREN_IDX =TOK_IDX 
                           000006     3 	TOK_IDX=TOK_IDX+1 
      000A3A                         50 	_code_entry syntax_error, QUOTE_IDX  ; $6 '"' 
      008ABA 92 25                    1 	.word syntax_error
                           000006     2 	QUOTE_IDX =TOK_IDX 
                           000007     3 	TOK_IDX=TOK_IDX+1 
                           000006    51     DELIM_LAST=TOK_IDX-1 
                                     52 ; literal values 
      000A3C                         53     _code_entry syntax_error,LITC_IDX ; 8 bit literal 
      008ABC 92 25                    1 	.word syntax_error
                           000007     2 	LITC_IDX =TOK_IDX 
                           000008     3 	TOK_IDX=TOK_IDX+1 
      000A3E                         54     _code_entry syntax_error,LITW_IDX  ; 16 bits literal 
      008ABE 92 25                    1 	.word syntax_error
                           000008     2 	LITW_IDX =TOK_IDX 
                           000009     3 	TOK_IDX=TOK_IDX+1 
                           000008    55     LIT_LAST=TOK_IDX-1 
                                     56 ; variable identifiers  
      000A40                         57 	_code_entry kword_let2,VAR_IDX    ; $9 integer variable  
      008AC0 96 9E                    1 	.word kword_let2
                           000009     2 	VAR_IDX =TOK_IDX 
                           00000A     3 	TOK_IDX=TOK_IDX+1 
      000A42                         58 	_code_entry let_string2,STR_VAR_IDX  ; string variable 
      008AC2 96 C2                    1 	.word let_string2
                           00000A     2 	STR_VAR_IDX =TOK_IDX 
                           00000B     3 	TOK_IDX=TOK_IDX+1 
                           00000A    59     SYMB_LAST=TOK_IDX-1 
                                     60 ; arithmetic operators      
      000A44                         61 	_code_entry syntax_error, ADD_IDX   ; $D 
      008AC4 92 25                    1 	.word syntax_error
                           00000B     2 	ADD_IDX =TOK_IDX 
                           00000C     3 	TOK_IDX=TOK_IDX+1 
      000A46                         62 	_code_entry syntax_error, SUB_IDX   ; $E
      008AC6 92 25                    1 	.word syntax_error
                           00000C     2 	SUB_IDX =TOK_IDX 
                           00000D     3 	TOK_IDX=TOK_IDX+1 
      000A48                         63 	_code_entry syntax_error, DIV_IDX   ; $10 
      008AC8 92 25                    1 	.word syntax_error
                           00000D     2 	DIV_IDX =TOK_IDX 
                           00000E     3 	TOK_IDX=TOK_IDX+1 
      000A4A                         64 	_code_entry syntax_error, MOD_IDX   ; $11
      008ACA 92 25                    1 	.word syntax_error
                           00000E     2 	MOD_IDX =TOK_IDX 
                           00000F     3 	TOK_IDX=TOK_IDX+1 
      000A4C                         65 	_code_entry syntax_error, MULT_IDX  ; $12 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 95.
Hexadecimal [24-Bits]



      008ACC 92 25                    1 	.word syntax_error
                           00000F     2 	MULT_IDX =TOK_IDX 
                           000010     3 	TOK_IDX=TOK_IDX+1 
                           00000F    66     OP_ARITHM_LAST=TOK_IDX-1 
                                     67 ; relational operators
      000A4E                         68 	_code_entry syntax_error,REL_LE_IDX  ; 
      008ACE 92 25                    1 	.word syntax_error
                           000010     2 	REL_LE_IDX =TOK_IDX 
                           000011     3 	TOK_IDX=TOK_IDX+1 
      000A50                         69 	_code_entry syntax_error,REL_EQU_IDX ; 
      008AD0 92 25                    1 	.word syntax_error
                           000011     2 	REL_EQU_IDX =TOK_IDX 
                           000012     3 	TOK_IDX=TOK_IDX+1 
      000A52                         70 	_code_entry syntax_error,REL_GE_IDX  ;  
      008AD2 92 25                    1 	.word syntax_error
                           000012     2 	REL_GE_IDX =TOK_IDX 
                           000013     3 	TOK_IDX=TOK_IDX+1 
      000A54                         71 	_code_entry syntax_error,REL_LT_IDX  ;  
      008AD4 92 25                    1 	.word syntax_error
                           000013     2 	REL_LT_IDX =TOK_IDX 
                           000014     3 	TOK_IDX=TOK_IDX+1 
      000A56                         72 	_code_entry syntax_error,REL_GT_IDX  ;  
      008AD6 92 25                    1 	.word syntax_error
                           000014     2 	REL_GT_IDX =TOK_IDX 
                           000015     3 	TOK_IDX=TOK_IDX+1 
      000A58                         73 	_code_entry syntax_error,REL_NE_IDX  ; 
      008AD8 92 25                    1 	.word syntax_error
                           000015     2 	REL_NE_IDX =TOK_IDX 
                           000016     3 	TOK_IDX=TOK_IDX+1 
                           000015    74     OP_REL_LAST=TOK_IDX-1 
                                     75 ; boolean operators 
      000A5A                         76     _code_entry syntax_error, NOT_IDX    ; $19
      008ADA 92 25                    1 	.word syntax_error
                           000016     2 	NOT_IDX =TOK_IDX 
                           000017     3 	TOK_IDX=TOK_IDX+1 
      000A5C                         77     _code_entry syntax_error, AND_IDX    ; $1A 
      008ADC 92 25                    1 	.word syntax_error
                           000017     2 	AND_IDX =TOK_IDX 
                           000018     3 	TOK_IDX=TOK_IDX+1 
      000A5E                         78     _code_entry syntax_error, OR_IDX     ; $1B 
      008ADE 92 25                    1 	.word syntax_error
                           000018     2 	OR_IDX =TOK_IDX 
                           000019     3 	TOK_IDX=TOK_IDX+1 
                           000018    79     BOOL_OP_LAST=TOK_IDX-1 
                                     80 ; keywords 
      000A60                         81     _code_entry kword_dim, DIM_IDX       ; $1F 
      008AE0 98 BD                    1 	.word kword_dim
                           000019     2 	DIM_IDX =TOK_IDX 
                           00001A     3 	TOK_IDX=TOK_IDX+1 
      000A62                         82     _code_entry kword_end, END_IDX       ; $21 
      008AE2 9F 2F                    1 	.word kword_end
                           00001A     2 	END_IDX =TOK_IDX 
                           00001B     3 	TOK_IDX=TOK_IDX+1 
      000A64                         83     _code_entry kword_for, FOR_IDX       ; $22
      008AE4 9D F8                    1 	.word kword_for
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 96.
Hexadecimal [24-Bits]



                           00001B     2 	FOR_IDX =TOK_IDX 
                           00001C     3 	TOK_IDX=TOK_IDX+1 
      000A66                         84     _code_entry kword_next, NEXT_IDX     ; $27 
      008AE6 9E 4C                    1 	.word kword_next
                           00001C     2 	NEXT_IDX =TOK_IDX 
                           00001D     3 	TOK_IDX=TOK_IDX+1 
      000A68                         85     _code_entry kword_gosub, GOSUB_IDX   ; $23 
      008AE8 9E C3                    1 	.word kword_gosub
                           00001D     2 	GOSUB_IDX =TOK_IDX 
                           00001E     3 	TOK_IDX=TOK_IDX+1 
      000A6A                         86     _code_entry kword_return, RET_IDX    ; $2A
      008AEA 9E E3                    1 	.word kword_return
                           00001E     2 	RET_IDX =TOK_IDX 
                           00001F     3 	TOK_IDX=TOK_IDX+1 
      000A6C                         87     _code_entry kword_goto, GOTO_IDX     ; $24 
      008AEC 9E A4                    1 	.word kword_goto
                           00001F     2 	GOTO_IDX =TOK_IDX 
                           000020     3 	TOK_IDX=TOK_IDX+1 
      000A6E                         88     _code_entry kword_if, IF_IDX         ; $25 
      008AEE 9D 14                    1 	.word kword_if
                           000020     2 	IF_IDX =TOK_IDX 
                           000021     3 	TOK_IDX=TOK_IDX+1 
      000A70                         89     _code_entry syntax_error,THEN_IDX 
      008AF0 92 25                    1 	.word syntax_error
                           000021     2 	THEN_IDX =TOK_IDX 
                           000022     3 	TOK_IDX=TOK_IDX+1 
      000A72                         90     _code_entry kword_let, LET_IDX       ; $26 
      008AF2 96 8D                    1 	.word kword_let
                           000022     2 	LET_IDX =TOK_IDX 
                           000023     3 	TOK_IDX=TOK_IDX+1 
      000A74                         91 	_code_entry kword_remark, REM_IDX    ; $29 
      008AF4 93 B1                    1 	.word kword_remark
                           000023     2 	REM_IDX =TOK_IDX 
                           000024     3 	TOK_IDX=TOK_IDX+1 
      000A76                         92     _code_entry syntax_error, STEP_IDX   ; $2B 
      008AF6 92 25                    1 	.word syntax_error
                           000024     2 	STEP_IDX =TOK_IDX 
                           000025     3 	TOK_IDX=TOK_IDX+1 
      000A78                         93     _code_entry kword_stop, STOP_IDX     ; $2C
      008AF8 9F 88                    1 	.word kword_stop
                           000025     2 	STOP_IDX =TOK_IDX 
                           000026     3 	TOK_IDX=TOK_IDX+1 
      000A7A                         94     _code_entry kword_con, CON_IDX 
      008AFA 9F D3                    1 	.word kword_con
                           000026     2 	CON_IDX =TOK_IDX 
                           000027     3 	TOK_IDX=TOK_IDX+1 
      000A7C                         95     _code_entry syntax_error, TO_IDX     ; $2D
      008AFC 92 25                    1 	.word syntax_error
                           000027     2 	TO_IDX =TOK_IDX 
                           000028     3 	TOK_IDX=TOK_IDX+1 
                           000027    96     KWORD_LAST=TOK_IDX-1 
                                     97 ; functions
      000A7E                         98 	_code_entry func_abs, ABS_IDX         ; $41
      008AFE A0 1C                    1 	.word func_abs
                           000028     2 	ABS_IDX =TOK_IDX 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 97.
Hexadecimal [24-Bits]



                           000029     3 	TOK_IDX=TOK_IDX+1 
      000A80                         99     _code_entry func_peek, PEEK_IDX         ; $4D 
      008B00 9D 05                    1 	.word func_peek
                           000029     2 	PEEK_IDX =TOK_IDX 
                           00002A     3 	TOK_IDX=TOK_IDX+1 
      000A82                        100     _code_entry func_random, RND_IDX        ; $50
      008B02 A0 2C                    1 	.word func_random
                           00002A     2 	RND_IDX =TOK_IDX 
                           00002B     3 	TOK_IDX=TOK_IDX+1 
      000A84                        101     _code_entry func_sign, SGN_IDX 
      008B04 A0 65                    1 	.word func_sign
                           00002B     2 	SGN_IDX =TOK_IDX 
                           00002C     3 	TOK_IDX=TOK_IDX+1 
      000A86                        102     _code_entry func_len, LEN_IDX  
      008B06 A0 7F                    1 	.word func_len
                           00002C     2 	LEN_IDX =TOK_IDX 
                           00002D     3 	TOK_IDX=TOK_IDX+1 
      000A88                        103     _code_entry func_ticks, TICKS_IDX 
      008B08 A0 06                    1 	.word func_ticks
                           00002D     2 	TICKS_IDX =TOK_IDX 
                           00002E     3 	TOK_IDX=TOK_IDX+1 
      000A8A                        104     _code_entry func_char, CHAR_IDX 
      008B0A A0 09                    1 	.word func_char
                           00002E     2 	CHAR_IDX =TOK_IDX 
                           00002F     3 	TOK_IDX=TOK_IDX+1 
                           00002E   105     FUNC_LAST=TOK_IDX-1                     
                                    106 ; commands 
      000A8C                        107     _code_entry cmd_sleep,SLEEP_IDX 
      008B0C 9F F3                    1 	.word cmd_sleep
                           00002F     2 	SLEEP_IDX =TOK_IDX 
                           000030     3 	TOK_IDX=TOK_IDX+1 
      000A8E                        108     _code_entry cmd_tone,TONE_IDX 
      008B0E 9F 6A                    1 	.word cmd_tone
                           000030     2 	TONE_IDX =TOK_IDX 
                           000031     3 	TOK_IDX=TOK_IDX+1 
      000A90                        109     _code_entry cmd_tab, TAB_IDX 
      008B10 A1 90                    1 	.word cmd_tab
                           000031     2 	TAB_IDX =TOK_IDX 
                           000032     3 	TOK_IDX=TOK_IDX+1 
      000A92                        110     _code_entry cmd_auto, AUTO_IDX 
      008B12 A1 BC                    1 	.word cmd_auto
                           000032     2 	AUTO_IDX =TOK_IDX 
                           000033     3 	TOK_IDX=TOK_IDX+1 
      000A94                        111     _code_entry cmd_himem, HIMEM_IDX 
      008B14 A2 75                    1 	.word cmd_himem
                           000033     2 	HIMEM_IDX =TOK_IDX 
                           000034     3 	TOK_IDX=TOK_IDX+1 
      000A96                        112     _code_entry cmd_lomem, LOMEM_IDX 
      008B16 A2 96                    1 	.word cmd_lomem
                           000034     2 	LOMEM_IDX =TOK_IDX 
                           000035     3 	TOK_IDX=TOK_IDX+1 
      000A98                        113     _code_entry cmd_del, DEL_IDX 
      008B18 A2 04                    1 	.word cmd_del
                           000035     2 	DEL_IDX =TOK_IDX 
                           000036     3 	TOK_IDX=TOK_IDX+1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 98.
Hexadecimal [24-Bits]



      000A9A                        114     _code_entry cmd_clear, CLR_IDX 
      008B1A A1 F5                    1 	.word cmd_clear
                           000036     2 	CLR_IDX =TOK_IDX 
                           000037     3 	TOK_IDX=TOK_IDX+1 
      000A9C                        115     _code_entry cmd_input, INPUT_IDX    ; $6F
      008B1C 9B CA                    1 	.word cmd_input
                           000037     2 	INPUT_IDX =TOK_IDX 
                           000038     3 	TOK_IDX=TOK_IDX+1 
      000A9E                        116     _code_entry cmd_list, LIST_IDX          ; $72
      008B1E 99 E5                    1 	.word cmd_list
                           000038     2 	LIST_IDX =TOK_IDX 
                           000039     3 	TOK_IDX=TOK_IDX+1 
      000AA0                        117     _code_entry cmd_new, NEW_IDX            ; $73
      008B20 9F EB                    1 	.word cmd_new
                           000039     2 	NEW_IDX =TOK_IDX 
                           00003A     3 	TOK_IDX=TOK_IDX+1 
      000AA2                        118     _code_entry cmd_call, CALL_IDX          
      008B22 A1 9B                    1 	.word cmd_call
                           00003A     2 	CALL_IDX =TOK_IDX 
                           00003B     3 	TOK_IDX=TOK_IDX+1 
      000AA4                        119     _code_entry cmd_poke, POKE_IDX          ; $76
      008B24 9C F1                    1 	.word cmd_poke
                           00003B     2 	POKE_IDX =TOK_IDX 
                           00003C     3 	TOK_IDX=TOK_IDX+1 
      000AA6                        120    	_code_entry cmd_print, PRINT_IDX        ; $77
      008B26 9A AD                    1 	.word cmd_print
                           00003C     2 	PRINT_IDX =TOK_IDX 
                           00003D     3 	TOK_IDX=TOK_IDX+1 
      000AA8                        121     _code_entry cmd_run, RUN_IDX            ; $7A
      008B28 9E FC                    1 	.word cmd_run
                           00003D     2 	RUN_IDX =TOK_IDX 
                           00003E     3 	TOK_IDX=TOK_IDX+1 
      000AAA                        122     _code_entry cmd_words, WORDS_IDX        ; $85
      008B2A A0 B4                    1 	.word cmd_words
                           00003E     2 	WORDS_IDX =TOK_IDX 
                           00003F     3 	TOK_IDX=TOK_IDX+1 
                           00003E   123     CMD_LAST=TOK_IDX-1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 99.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2020,2021,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;   compile BASIC source code to byte code
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     22 
                                     23 	.area CODE 
                                     24 
                                     25 ;-------------------------------------
                                     26 ; search text area for a line#
                                     27 ; input:
                                     28 ;   A           0 search from lomem  
                                     29 ;			    1 search from line.addr 
                                     30 ;	X 			line# to search 
                                     31 ; output:
                                     32 ;   A           0 not found | other found 
                                     33 ;   X 			addr of line | 
                                     34 ;				inssert address if not found  
                                     35 ; use: 
                                     36 ;   Y  
                                     37 ;-------------------------------------
                           000001    38 	LL=1 ; line length 
                           000002    39 	LB=2 ; line length low byte 
                           000002    40 	VSIZE=2 
      008B2C                         41 search_lineno::
      008B2C 90 89            [ 2]   42 	pushw y 
      000AAE                         43 	_vars VSIZE
      008B2E 52 02            [ 2]    1     sub sp,#VSIZE 
      008B30 0F 01            [ 1]   44 	clr (LL,sp)
      008B32 90 CE 00 2F      [ 2]   45 	ldw y,lomem
      008B36 4D               [ 1]   46 	tnz a 
      008B37 27 04            [ 1]   47 	jreq 2$
      008B39 90 CE 00 2B      [ 2]   48 	ldw y,line.addr  
      008B3D                         49 2$: 
      008B3D 90 C3 00 33      [ 2]   50 	cpw y,progend 
      008B41 2A 10            [ 1]   51 	jrpl 8$ 
      008B43 90 F3            [ 1]   52 	cpw x,(y)
      008B45 27 0F            [ 1]   53 	jreq 9$
      008B47 2B 0A            [ 1]   54 	jrmi 8$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 100.
Hexadecimal [24-Bits]



      008B49 90 E6 02         [ 1]   55 	ld a,(2,y)
      008B4C 6B 02            [ 1]   56 	ld (LB,sp),a 
      008B4E 72 F9 01         [ 2]   57 	addw y,(LL,sp)
      008B51 20 EA            [ 2]   58 	jra 2$ 
      008B53                         59 8$: ; not found 
      008B53 4F               [ 1]   60 	clr a 
      008B54 20 02            [ 2]   61 	jra 10$
      008B56                         62 9$: ; found 
      008B56 A6 FF            [ 1]   63 	ld a,#-1 
      008B58                         64 10$:
      008B58 93               [ 1]   65 	ldw x,y   
      000AD9                         66 	_drop VSIZE
      008B59 5B 02            [ 2]    1     addw sp,#VSIZE 
      008B5B 90 85            [ 2]   67 	popw y 
      008B5D 81               [ 4]   68 	ret 
                                     69 
                                     70 
                                     71 ;-------------------------------------
                                     72 ; delete line at addr
                                     73 ; input:
                                     74 ;   X 		addr of line i.e DEST for move 
                                     75 ;-------------------------------------
                           000001    76 	LLEN=1
                           000003    77 	SRC=3
                           000004    78 	VSIZE=4
      008B5E                         79 del_line: 
      008B5E 90 89            [ 2]   80 	pushw y 
      000AE0                         81 	_vars VSIZE 
      008B60 52 04            [ 2]    1     sub sp,#VSIZE 
      008B62 E6 02            [ 1]   82 	ld a,(2,x) ; line length
      008B64 6B 02            [ 1]   83 	ld (LLEN+1,sp),a 
      008B66 0F 01            [ 1]   84 	clr (LLEN,sp)
      008B68 90 93            [ 1]   85 	ldw y,x  
      008B6A 72 F9 01         [ 2]   86 	addw y,(LLEN,sp) ;SRC  
      008B6D 17 03            [ 2]   87 	ldw (SRC,sp),y  ;save source 
      008B6F 90 CE 00 33      [ 2]   88 	ldw y,progend 
      008B73 72 F2 03         [ 2]   89 	subw y,(SRC,sp) ; y=count 
      008B76 90 CF 00 18      [ 2]   90 	ldw acc16,y 
      008B7A 16 03            [ 2]   91 	ldw y,(SRC,sp)    ; source
      008B7C CD 88 B0         [ 4]   92 	call move
      008B7F 90 CE 00 33      [ 2]   93 	ldw y,progend  
      008B83 72 F2 01         [ 2]   94 	subw y,(LLEN,sp)
      008B86 90 CF 00 33      [ 2]   95 	ldw progend,y
      008B8A 90 CF 00 35      [ 2]   96 	ldw dvar_bgn,y 
      008B8E 90 CF 00 37      [ 2]   97 	ldw dvar_end,y   
      000B12                         98 	_drop VSIZE     
      008B92 5B 04            [ 2]    1     addw sp,#VSIZE 
      008B94 90 85            [ 2]   99 	popw y 
      008B96 81               [ 4]  100 	ret 
                                    101 
                                    102 ;---------------------------------------------
                                    103 ; open a gap in text area to 
                                    104 ; move new line in this gap
                                    105 ; input:
                                    106 ;    X 			addr gap start 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 101.
Hexadecimal [24-Bits]



                                    107 ;    Y 			gap length 
                                    108 ; output:
                                    109 ;    X 			addr gap start 
                                    110 ;--------------------------------------------
                           000001   111 	DEST=1
                           000003   112 	SRC=3
                           000005   113 	LEN=5
                           000006   114 	VSIZE=6 
      008B97                        115 open_gap:
      008B97 C3 00 33         [ 2]  116 	cpw x,progend 
      008B9A 24 2F            [ 1]  117 	jruge 9$
      000B1C                        118 	_vars VSIZE
      008B9C 52 06            [ 2]    1     sub sp,#VSIZE 
      008B9E 1F 03            [ 2]  119 	ldw (SRC,sp),x 
      008BA0 17 05            [ 2]  120 	ldw (LEN,sp),y 
      008BA2 90 CF 00 18      [ 2]  121 	ldw acc16,y 
      008BA6 90 93            [ 1]  122 	ldw y,x ; SRC
      008BA8 72 BB 00 18      [ 2]  123 	addw x,acc16  
      008BAC 1F 01            [ 2]  124 	ldw (DEST,sp),x 
                                    125 ;compute size to move 	
      000B2E                        126 	_ldxz progend  
      008BAE BE 33                    1     .byte 0xbe,progend 
      008BB0 72 F0 03         [ 2]  127 	subw x,(SRC,sp)
      008BB3 CF 00 18         [ 2]  128 	ldw acc16,x ; size to move
      008BB6 1E 01            [ 2]  129 	ldw x,(DEST,sp) 
      008BB8 CD 88 B0         [ 4]  130 	call move
      000B3B                        131 	_ldxz progend 
      008BBB BE 33                    1     .byte 0xbe,progend 
      008BBD 72 FB 05         [ 2]  132 	addw x,(LEN,sp)
      008BC0 CF 00 33         [ 2]  133 	ldw progend,x
      008BC3 CF 00 35         [ 2]  134 	ldw dvar_bgn,x 
      008BC6 CF 00 37         [ 2]  135 	ldw dvar_end,x 
      000B49                        136 	_drop VSIZE
      008BC9 5B 06            [ 2]    1     addw sp,#VSIZE 
      008BCB 81               [ 4]  137 9$:	ret 
                                    138 
                                    139 ;--------------------------------------------
                                    140 ; insert line in pad into program area 
                                    141 ; first search for already existing 
                                    142 ; replace existing 
                                    143 ; if new line empty delete existing one. 
                                    144 ; input:
                                    145 ;   ptr16		pointer to tokenized line  
                                    146 ; output:
                                    147 ;   none
                                    148 ;---------------------------------------------
                           000001   149 	DEST=1  ; text area insertion address 
                           000003   150 	SRC=3   ; str to insert address 
                           000005   151 	LINENO=5 ; line number 
                           000007   152 	LLEN=7 ; line length 
                           000008   153 	VSIZE=8  
      008BCC                        154 insert_line:
      008BCC 90 89            [ 2]  155 	pushw y 
      000B4E                        156 	_vars VSIZE 
      008BCE 52 08            [ 2]    1     sub sp,#VSIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 102.
Hexadecimal [24-Bits]



      008BD0 72 CE 00 12      [ 5]  157 	ldw x,[ptr16]
      008BD4 1F 05            [ 2]  158 	ldw (LINENO,sp),x 
      008BD6 0F 07            [ 1]  159 	clr (LLEN,sp)
      000B58                        160 	_ldxz ptr16 
      008BD8 BE 12                    1     .byte 0xbe,ptr16 
      008BDA E6 02            [ 1]  161 	ld a,(2,x)
      008BDC 6B 08            [ 1]  162 	ld (LLEN+1,sp),a 
      008BDE 4F               [ 1]  163 	clr a 
      008BDF 1E 05            [ 2]  164 	ldw x,(LINENO,sp)
      008BE1 CD 8B 2C         [ 4]  165 	call search_lineno
      008BE4 1F 01            [ 2]  166 	ldw (DEST,sp),x 
      008BE6 4D               [ 1]  167 	tnz a 
      008BE7 27 03            [ 1]  168 	jreq 1$ ; not found 
      008BE9 CD 8B 5E         [ 4]  169 	call del_line 
      008BEC A6 04            [ 1]  170 1$: ld a,#4 
      008BEE 11 08            [ 1]  171 	cp a,(LLEN+1,sp)
      008BF0 27 3D            [ 1]  172 	jreq 9$
                                    173 ; check for space 
      000B72                        174 	_ldxz progend  
      008BF2 BE 33                    1     .byte 0xbe,progend 
      008BF4 72 FB 07         [ 2]  175 	addw x,(LLEN,sp)
      008BF7 A3 16 80         [ 2]  176 	cpw x,#tib   
      008BFA 25 08            [ 1]  177 	jrult 3$
      008BFC AE 91 A6         [ 2]  178 	ldw x,#err_mem_full 
      008BFF CC 92 27         [ 2]  179 	jp tb_error 
      008C02 20 2B            [ 2]  180 	jra 9$  
      008C04                        181 3$: ; create gap to insert line 
      008C04 1E 01            [ 2]  182 	ldw x,(DEST,sp) 
      008C06 16 07            [ 2]  183 	ldw y,(LLEN,sp)
      008C08 CD 8B 97         [ 4]  184 	call open_gap 
                                    185 ; move new line in gap 
      008C0B 1E 07            [ 2]  186 	ldw x,(LLEN,sp)
      008C0D CF 00 18         [ 2]  187 	ldw acc16,x 
      008C10 90 AE 17 00      [ 2]  188 	ldw y,#pad ;SRC 
      008C14 1E 01            [ 2]  189 	ldw x,(DEST,sp) ; dest address 
      008C16 CD 88 B0         [ 4]  190 	call move
      008C19 1E 01            [ 2]  191 	ldw x,(DEST,sp)
      008C1B C3 00 33         [ 2]  192 	cpw x,progend 
      008C1E 25 0F            [ 1]  193 	jrult 9$ 
      008C20 1E 07            [ 2]  194 	ldw x,(LLEN,sp)
      008C22 72 BB 00 33      [ 2]  195 	addw x,progend 
      008C26 CF 00 33         [ 2]  196 	ldw progend,x 
      008C29 CF 00 35         [ 2]  197 	ldw dvar_bgn,x 
      008C2C CF 00 37         [ 2]  198 	ldw dvar_end,x 
      008C2F                        199 9$:	
      000BAF                        200 	_drop VSIZE
      008C2F 5B 08            [ 2]    1     addw sp,#VSIZE 
      008C31 90 85            [ 2]  201 	popw y 
      008C33 81               [ 4]  202 	ret
                                    203 
                                    204 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    205 ;; compiler routines        ;;
                                    206 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    207 ;------------------------------------
                                    208 ; parse quoted string 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 103.
Hexadecimal [24-Bits]



                                    209 ; input:
                                    210 ;   Y 	pointer to tib 
                                    211 ;   X   pointer to output buffer 
                                    212 ; output:
                                    213 ;	buffer   parsed string
                                    214 ;------------------------------------
                           000001   215 	PREV = 1
                           000002   216 	CURR =2
                           000002   217 	VSIZE=2
      008C34                        218 parse_quote: 
      000BB4                        219 	_vars VSIZE 
      008C34 52 02            [ 2]    1     sub sp,#VSIZE 
      008C36 4F               [ 1]  220 	clr a
      008C37 6B 01            [ 1]  221 1$:	ld (PREV,sp),a 
      008C39                        222 2$:	
      008C39 91 D6 28         [ 4]  223 	ld a,([in.w],y)
      008C3C 27 22            [ 1]  224 	jreq 6$
      000BBE                        225 	_incz in 
      008C3E 3C 29                    1     .byte 0x3c, in 
      008C40 6B 02            [ 1]  226 	ld (CURR,sp),a 
      008C42 A6 5C            [ 1]  227 	ld a,#'\
      008C44 11 01            [ 1]  228 	cp a, (PREV,sp)
      008C46 26 0A            [ 1]  229 	jrne 3$
      008C48 0F 01            [ 1]  230 	clr (PREV,sp)
      008C4A 7B 02            [ 1]  231 	ld a,(CURR,sp)
      008C4C AD 1C            [ 4]  232 	callr convert_escape
      008C4E F7               [ 1]  233 	ld (x),a 
      008C4F 5C               [ 1]  234 	incw x 
      008C50 20 E7            [ 2]  235 	jra 2$
      008C52                        236 3$:
      008C52 7B 02            [ 1]  237 	ld a,(CURR,sp)
      008C54 A1 5C            [ 1]  238 	cp a,#'\'
      008C56 27 DF            [ 1]  239 	jreq 1$
      008C58 A1 22            [ 1]  240 	cp a,#'"
      008C5A 27 04            [ 1]  241 	jreq 6$ 
      008C5C F7               [ 1]  242 	ld (x),a 
      008C5D 5C               [ 1]  243 	incw x 
      008C5E 20 D9            [ 2]  244 	jra 2$
      008C60                        245 6$:
      008C60 7F               [ 1]  246 	clr (x)
      008C61 5C               [ 1]  247 	incw x 
      008C62 90 93            [ 1]  248 	ldw y,x 
      008C64 5F               [ 1]  249 	clrw x 
      008C65 A6 06            [ 1]  250 	ld a,#QUOTE_IDX  
      000BE7                        251 	_drop VSIZE
      008C67 5B 02            [ 2]    1     addw sp,#VSIZE 
      008C69 81               [ 4]  252 	ret 
                                    253 
                                    254 ;---------------------------------------
                                    255 ; called by parse_quote
                                    256 ; subtitute escaped character 
                                    257 ; by their ASCII value .
                                    258 ; input:
                                    259 ;   A  character following '\'
                                    260 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 104.
Hexadecimal [24-Bits]



                                    261 ;   A  substitued char or same if not valid.
                                    262 ;---------------------------------------
      008C6A                        263 convert_escape:
      008C6A 89               [ 2]  264 	pushw x 
      008C6B AE 8C 7F         [ 2]  265 	ldw x,#escaped 
      008C6E F1               [ 1]  266 1$:	cp a,(x)
      008C6F 27 06            [ 1]  267 	jreq 2$
      008C71 7D               [ 1]  268 	tnz (x)
      008C72 27 09            [ 1]  269 	jreq 3$
      008C74 5C               [ 1]  270 	incw x 
      008C75 20 F7            [ 2]  271 	jra 1$
      008C77 1D 8C 7F         [ 2]  272 2$: subw x,#escaped 
      008C7A 9F               [ 1]  273 	ld a,xl 
      008C7B AB 07            [ 1]  274 	add a,#7
      008C7D 85               [ 2]  275 3$:	popw x 
      008C7E 81               [ 4]  276 	ret 
                                    277 
      008C7F 61 62 74 6E 76 66 72   278 escaped:: .asciz "abtnvfr"
             00
                                    279 
                                    280 ;-------------------------
                                    281 ; integer parser 
                                    282 ; input:
                                    283 ;   X      *output buffer (&pad[n])
                                    284 ;   Y 		point to tib 
                                    285 ;   in.w    offset in tib 
                                    286 ;   A 	    first digit|'$' 
                                    287 ; output:  
                                    288 ;   X 		int16   
                                    289 ;   acc16   int16 
                                    290 ;   in.w    updated 
                                    291 ;   Y       pad[n] 
                                    292 ;-------------------------
      008C87                        293 parse_integer: ; { -- n }
      008C87 89               [ 2]  294 	pushw x 
      008C88 72 B9 00 28      [ 2]  295 	addw y,in.w
      008C8C 90 5A            [ 2]  296 	decw y   
      008C8E CD 94 23         [ 4]  297 	call atoi16 
      008C91 72 A2 16 80      [ 2]  298 	subw y,#tib 
      008C95 90 CF 00 28      [ 2]  299 	ldw in.w,y
      008C99 90 85            [ 2]  300 	popw y  
      008C9B 81               [ 4]  301 	ret
                                    302 
                                    303 ;-------------------------------------
                                    304 ; input:
                                    305 ;   X  int16  
                                    306 ;   Y    pad[n]
                                    307 ; output:
                                    308 ;    pad   LITW_IDX,word  
                                    309 ;    y     &pad[n+3]
                                    310 ;------------------------------------
      008C9C                        311 compile_integer:
      008C9C A6 08            [ 1]  312 	ld a,#LITW_IDX 
      008C9E 90 F7            [ 1]  313 	ld (y),a
      008CA0 90 5C            [ 1]  314 	incw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 105.
Hexadecimal [24-Bits]



      008CA2 90 FF            [ 2]  315 	LDW (Y),x 
      008CA4 72 A9 00 02      [ 2]  316 	addw y,#2
      008CA8 81               [ 4]  317 	ret
                                    318 
                                    319 ;---------------------------
                                    320 ;  when lexical unit begin 
                                    321 ;  with a letter a symbol 
                                    322 ;  is expected.
                                    323 ; input:
                                    324 ;   A   first character of symbol 
                                    325 ;	X   point to output buffer 
                                    326 ;   [in.w],Y   point to input text 
                                    327 ; output:
                                    328 ;   A   string length 
                                    329 ;   [in.w],Y   point after lexical unit 
                                    330 ;---------------------------
                           000001   331 	FIRST_CHAR=1
                           000002   332 	VSIZE=2 
      008CA9                        333 parse_symbol:
      000C29                        334 	_vars VSIZE 
      008CA9 52 02            [ 2]    1     sub sp,#VSIZE 
      008CAB 1C 00 01         [ 2]  335 	addw x,#1 ; keep space for token identifier
      008CAE 1F 01            [ 2]  336 	ldw (FIRST_CHAR,sp),x  
      008CB0                        337 symb_loop: 
      008CB0 F7               [ 1]  338 	ld (x), a 
      008CB1 5C               [ 1]  339 	incw x
      008CB2 91 D6 28         [ 4]  340 	ld a,([in.w],y)
      000C35                        341 	_incz in 
      008CB5 3C 29                    1     .byte 0x3c, in 
      008CB7 A1 24            [ 1]  342 	cp a,#'$ 
      008CB9 27 05            [ 1]  343 	jreq 2$ ; string variable: LETTER+'$'  
      008CBB CD 89 10         [ 4]  344 	call is_digit ;
      008CBE 24 04            [ 1]  345 	jrnc 3$ ; integer variable LETTER+DIGIT 
      008CC0                        346 2$:
      008CC0 F7               [ 1]  347 	ld (x),a 
      008CC1 5C               [ 1]  348 	incw x 
      008CC2 20 07            [ 2]  349 	jra 4$
      008CC4                        350 3$:
      008CC4 CD 88 FF         [ 4]  351 	call is_alpha  
      008CC7 25 E7            [ 1]  352 	jrc symb_loop 
      000C49                        353 	_decz in
      008CC9 3A 29                    1     .byte 0x3a,in 
      008CCB                        354 4$:
      008CCB 7F               [ 1]  355 	clr (x)
      008CCC 72 F0 01         [ 2]  356 	subw x,(FIRST_CHAR,sp)
      008CCF 9F               [ 1]  357 	ld a,xl
      000C50                        358 	_drop VSIZE 
      008CD0 5B 02            [ 2]    1     addw sp,#VSIZE 
      008CD2 81               [ 4]  359 	ret 
                                    360 
                                    361 ;--------------------------
                                    362 ; some syntax checking 
                                    363 ; can be done at runtime 
                                    364 ;as FOR TO STEP must be on same line 
                                    365 ;same for IF THEN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 106.
Hexadecimal [24-Bits]



      008CD3                        366 check_syntax:
      008CD3 A1 20            [ 1]  367 	cp a,#IF_IDX 
      008CD5 27 42            [ 1]  368 	jreq push_it 
      008CD7 A1 1B            [ 1]  369 	cp a,#FOR_IDX 
      008CD9 27 3E            [ 1]  370 	jreq push_it 
      008CDB A1 21            [ 1]  371 	cp a,#THEN_IDX 
      008CDD 26 0D            [ 1]  372 	jrne 1$
      000C5F                        373 	_pop_op 
      008CDF 72 C6 00 42      [ 4]    1     ld a,[psp]
      000C63                          2     _incz psp+1 
      008CE3 3C 43                    1     .byte 0x3c, psp+1 
      008CE5 A1 20            [ 1]  374 	cp a,#IF_IDX 
      008CE7 27 2F            [ 1]  375 	jreq 9$ 
      008CE9 CC 92 25         [ 2]  376 	jp syntax_error 
      008CEC                        377 1$: 
      008CEC A1 27            [ 1]  378 	cp a,#TO_IDX 
      008CEE 26 17            [ 1]  379 	jrne 3$ 
      000C70                        380 	_pop_op 
      008CF0 72 C6 00 42      [ 4]    1     ld a,[psp]
      000C74                          2     _incz psp+1 
      008CF4 3C 43                    1     .byte 0x3c, psp+1 
      008CF6 A1 1B            [ 1]  381 	cp a,#FOR_IDX 
      008CF8 27 03            [ 1]  382 	jreq 2$ 
      008CFA CC 92 25         [ 2]  383 	jp syntax_error 
      008CFD A6 27            [ 1]  384 2$: ld a,#TO_IDX 
      000C7F                        385 	_push_op 
      000C7F                          1     _decz psp+1
      008CFF 3A 43                    1     .byte 0x3a,psp+1 
      008D01 72 C7 00 42      [ 4]    2     ld [psp],a 
      008D05 20 11            [ 2]  386 	jra 9$ 
      008D07 A1 24            [ 1]  387 3$: cp a,#STEP_IDX 
      008D09 26 0D            [ 1]  388 	jrne 9$ 
      000C8B                        389 	_pop_op 
      008D0B 72 C6 00 42      [ 4]    1     ld a,[psp]
      000C8F                          2     _incz psp+1 
      008D0F 3C 43                    1     .byte 0x3c, psp+1 
      008D11 A1 27            [ 1]  390 	cp a,#TO_IDX 
      008D13 27 03            [ 1]  391 	jreq 9$ 
      008D15 CC 92 25         [ 2]  392 	jp syntax_error 
      008D18                        393 9$:	
      008D18 81               [ 4]  394 	ret 
      008D19                        395 push_it:
      000C99                        396 	_push_op 
      000C99                          1     _decz psp+1
      008D19 3A 43                    1     .byte 0x3a,psp+1 
      008D1B 72 C7 00 42      [ 4]    2     ld [psp],a 
      008D1F 81               [ 4]  397 	ret 
                                    398 
                                    399 ;---------------------------
                                    400 ;  token begin with a letter,
                                    401 ;  is keyword or variable. 	
                                    402 ; input:
                                    403 ;   X 		point to pad 
                                    404 ;   Y 		point to text
                                    405 ;   A 	    first letter  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 107.
Hexadecimal [24-Bits]



                                    406 ; output:
                                    407 ;   Y		point in pad after token  
                                    408 ;   A 		token identifier
                                    409 ;   pad 	keyword|var_name  
                                    410 ;--------------------------  
                           000001   411 	TOK_POS=1
                           000003   412 	NLEN=TOK_POS+2
                           000003   413 	VSIZE=NLEN 
      008D20                        414 parse_keyword:
      000CA0                        415 	_vars VSIZE 
      008D20 52 03            [ 2]    1     sub sp,#VSIZE 
      008D22 0F 03            [ 1]  416 	clr (NLEN,sp)
      008D24 1F 01            [ 2]  417 	ldw (TOK_POS,sp),x  ; where TOK_IDX should be put 
      008D26 CD 8C A9         [ 4]  418 	call parse_symbol
      008D29 6B 03            [ 1]  419 	ld (NLEN,sp),a 
      008D2B A1 01            [ 1]  420 	cp a,#1
      008D2D 27 30            [ 1]  421 	jreq 3$  
                                    422  ; check in dictionary, if not found must be variable name.
      000CAF                        423 	_ldx_dict kword_dict ; dictionary entry point
      008D2F AE A4 4E         [ 2]    1         ldw x,#kword_dict+2
      008D32 16 01            [ 2]  424 	ldw y,(TOK_POS,sp) ; name to search for
      008D34 72 A9 00 01      [ 2]  425 	addw y,#1 ; name first character 
      008D38 CD 94 6B         [ 4]  426 	call search_dict
      008D3B A1 FF            [ 1]  427 	cp a,#NONE_IDX 
      008D3D 26 2C            [ 1]  428 	jrne 6$
                                    429 ; not in dictionary
                                    430 ; either LETTER+'$' || LETTER+DIGIT 
      008D3F A6 02            [ 1]  431 	ld a,#2 
      008D41 11 03            [ 1]  432 	cp a,(NLEN,sp)
      008D43 27 03            [ 1]  433 	jreq 1$ 
      008D45 CC 92 25         [ 2]  434     jp syntax_error 	
      008D48                        435 1$: ; 2 letters variables 
      008D48 16 01            [ 2]  436 	ldw y,(TOK_POS,sp)
      008D4A 93               [ 1]  437 	ldw x,y 
      008D4B 1C 00 02         [ 2]  438 	addw x,#2 
      008D4E F6               [ 1]  439 	ld a,(x)
      008D4F A1 24            [ 1]  440 	cp a,#'$ 
      008D51 26 04            [ 1]  441 	jrne 2$ 
      008D53 A6 0A            [ 1]  442 	ld a,#STR_VAR_IDX
      008D55 20 0C            [ 2]  443 	jra 5$
      008D57 CD 89 10         [ 4]  444 2$:	call is_digit 
      008D5A 25 05            [ 1]  445 	jrc 4$ ; LETTER+DIGIT 
      008D5C CC 92 25         [ 2]  446 	jp syntax_error 
      008D5F                        447 3$:
                                    448 ; one letter symbol is integer variable name 
                                    449 ; tokenize as: VAR_IDX,LETTER,NUL  
      008D5F 16 01            [ 2]  450 	ldw y,(TOK_POS,sp)
      008D61                        451 4$:	
      008D61 A6 09            [ 1]  452 	ld a,#VAR_IDX 
      008D63                        453 5$:
      008D63 90 F7            [ 1]  454 	ld (y),a
      008D65 72 A9 00 03      [ 2]  455 	addw y,#3
      008D69 20 09            [ 2]  456 	jra 9$
      008D6B                        457 6$:	; word in dictionary 
      008D6B 16 01            [ 2]  458 	ldw y,(TOK_POS,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 108.
Hexadecimal [24-Bits]



      008D6D 90 F7            [ 1]  459 	ld (y),a ; compile token 
      008D6F 90 5C            [ 1]  460 	incw y
      008D71 CD 8C D3         [ 4]  461 	call check_syntax  
      000CF4                        462 9$:	_drop VSIZE 
      008D74 5B 03            [ 2]    1     addw sp,#VSIZE 
      008D76 81               [ 4]  463 	ret  	
                                    464 
                                    465 ;------------------------------------
                                    466 ; skip character c in text starting from 'in'
                                    467 ; input:
                                    468 ;	 y 		point to text buffer
                                    469 ;    a 		character to skip
                                    470 ; output:  
                                    471 ;	'in' ajusted to new position
                                    472 ;------------------------------------
                           000001   473 	C = 1 ; local var
      008D77                        474 skip:
      008D77 88               [ 1]  475 	push a
      008D78 91 D6 28         [ 4]  476 1$:	ld a,([in.w],y)
      008D7B 27 08            [ 1]  477 	jreq 2$
      008D7D 11 01            [ 1]  478 	cp a,(C,sp)
      008D7F 26 04            [ 1]  479 	jrne 2$
      000D01                        480 	_incz in
      008D81 3C 29                    1     .byte 0x3c, in 
      008D83 20 F3            [ 2]  481 	jra 1$
      000D05                        482 2$: _drop 1 
      008D85 5B 01            [ 2]    1     addw sp,#1 
      008D87 81               [ 4]  483 	ret
                                    484 	
                                    485 
                                    486 ;------------------------------------
                                    487 ; scan text for next lexeme
                                    488 ; compile its TOKEN_IDX and value
                                    489 ; in output buffer.  
                                    490 ; update input and output pointers 
                                    491 ; input: 
                                    492 ;	X 		pointer to buffer where 
                                    493 ;	        token idx and value are compiled 
                                    494 ; use:
                                    495 ;	Y       pointer to text in tib 
                                    496 ;   in.w    offset in tib, i.e. tib[in.w]
                                    497 ; output:
                                    498 ;   A       token index  
                                    499 ;   Y       updated position in output buffer   
                                    500 ;------------------------------------
                                    501 	; use to check special character 
                                    502 	.macro _case c t  
                                    503 	ld a,#c 
                                    504 	cp a,(TCHAR,sp) 
                                    505 	jrne t
                                    506 	.endm 
                                    507 	
                                    508 ; local variables 
                           000001   509 	TCHAR=1 ; parsed character 
                           000002   510 	ATTRIB=2 ; token value  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 109.
Hexadecimal [24-Bits]



                           000002   511 	VSIZE=2
      008D88                        512 parse_lexeme:
      000D08                        513 	_vars VSIZE
      008D88 52 02            [ 2]    1     sub sp,#VSIZE 
      008D8A 90 AE 16 80      [ 2]  514 	ldw y,#tib    	
      008D8E A6 20            [ 1]  515 	ld a,#SPACE
      008D90 CD 8D 77         [ 4]  516 	call skip
      008D93 91 D6 28         [ 4]  517 	ld a,([in.w],y)
      008D96 26 05            [ 1]  518 	jrne 1$
      008D98 90 93            [ 1]  519 	ldw y,x 
      008D9A CC 8F 12         [ 2]  520 	jp token_exit ; end of line 
      000D1D                        521 1$:	_incz in 
      008D9D 3C 29                    1     .byte 0x3c, in 
      008D9F 6B 01            [ 1]  522 	ld (TCHAR,sp),a ; first char of lexeme 
                                    523 ; check for quoted string
      008DA1                        524 str_tst:  	
      000D21                        525 	_case '"' nbr_tst
      008DA1 A6 22            [ 1]    1 	ld a,#'"' 
      008DA3 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DA5 26 0C            [ 1]    3 	jrne nbr_tst
      008DA7 A6 06            [ 1]  526 	ld a,#QUOTE_IDX
      008DA9 88               [ 1]  527 	push a 
      008DAA F7               [ 1]  528 	ld (x),a ; compile TOKEN INDEX 
      008DAB 5C               [ 1]  529 	incw x 
      008DAC CD 8C 34         [ 4]  530 	call parse_quote ; compile quoted string 
      008DAF 84               [ 1]  531 	pop a 
      008DB0 CC 8F 12         [ 2]  532 	jp token_exit
      008DB3                        533 nbr_tst:
                                    534 ; check for hexadecimal number 
      000D33                        535 	_case '$' digit_test 
      008DB3 A6 24            [ 1]    1 	ld a,#'$' 
      008DB5 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DB7 26 02            [ 1]    3 	jrne digit_test
      008DB9 20 07            [ 2]  536 	jra integer 
                                    537 ; check for decimal number 	
      008DBB                        538 digit_test: 
      008DBB 7B 01            [ 1]  539 	ld a,(TCHAR,sp)
      008DBD CD 89 10         [ 4]  540 	call is_digit
      008DC0 24 09            [ 1]  541 	jrnc other_tests
      008DC2                        542 integer: 
      008DC2 CD 8C 87         [ 4]  543 	call parse_integer 
      008DC5 CD 8C 9C         [ 4]  544 	call compile_integer
      008DC8 CC 8F 12         [ 2]  545 	jp token_exit 
      008DCB                        546 other_tests: 
      000D4B                        547 	_case '(' bkslsh_tst 
      008DCB A6 28            [ 1]    1 	ld a,#'(' 
      008DCD 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DCF 26 05            [ 1]    3 	jrne bkslsh_tst
      008DD1 A6 04            [ 1]  548 	ld a,#LPAREN_IDX 
      008DD3 CC 8F 0E         [ 2]  549 	jp token_char   	
      008DD6                        550 bkslsh_tst: ; character token 
      000D56                        551 	_case '\',rparnt_tst
      008DD6 A6 5C            [ 1]    1 	ld a,#'\' 
      008DD8 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DDA 26 12            [ 1]    3 	jrne rparnt_tst
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 110.
Hexadecimal [24-Bits]



      008DDC A6 07            [ 1]  552 	ld a,#LITC_IDX 
      008DDE F7               [ 1]  553 	ld (x),a 
      008DDF 88               [ 1]  554 	push a 
      008DE0 5C               [ 1]  555 	incw x 
      008DE1 91 D6 28         [ 4]  556 	ld a,([in.w],y)
      000D64                        557 	_incz in  
      008DE4 3C 29                    1     .byte 0x3c, in 
      008DE6 F7               [ 1]  558 	ld (x),a 
      008DE7 5C               [ 1]  559 	incw x
      008DE8 90 93            [ 1]  560 	ldw y,x 
      008DEA 84               [ 1]  561 	pop a 	 
      008DEB CC 8F 12         [ 2]  562 	jp token_exit
      008DEE                        563 rparnt_tst:		
      000D6E                        564 	_case ')' colon_tst 
      008DEE A6 29            [ 1]    1 	ld a,#')' 
      008DF0 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DF2 26 05            [ 1]    3 	jrne colon_tst
      008DF4 A6 05            [ 1]  565 	ld a,#RPAREN_IDX  
      008DF6 CC 8F 0E         [ 2]  566 	jp token_char
      008DF9                        567 colon_tst:
      000D79                        568 	_case ':' comma_tst 
      008DF9 A6 3A            [ 1]    1 	ld a,#':' 
      008DFB 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008DFD 26 05            [ 1]    3 	jrne comma_tst
      008DFF A6 01            [ 1]  569 	ld a,#COLON_IDX  
      008E01 CC 8F 0E         [ 2]  570 	jp token_char  
      008E04                        571 comma_tst:
      000D84                        572 	_case COMMA semic_tst 
      008E04 A6 2C            [ 1]    1 	ld a,#COMMA 
      008E06 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E08 26 05            [ 1]    3 	jrne semic_tst
      008E0A A6 02            [ 1]  573 	ld a,#COMMA_IDX 
      008E0C CC 8F 0E         [ 2]  574 	jp token_char
      008E0F                        575 semic_tst:
      000D8F                        576 	_case SEMIC dash_tst
      008E0F A6 3B            [ 1]    1 	ld a,#SEMIC 
      008E11 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E13 26 05            [ 1]    3 	jrne dash_tst
      008E15 A6 03            [ 1]  577 	ld a,#SCOL_IDX  
      008E17 CC 8F 0E         [ 2]  578 	jp token_char 	
      008E1A                        579 dash_tst: 	
      000D9A                        580 	_case '-' sharp_tst 
      008E1A A6 2D            [ 1]    1 	ld a,#'-' 
      008E1C 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E1E 26 05            [ 1]    3 	jrne sharp_tst
      008E20 A6 0C            [ 1]  581 	ld a,#SUB_IDX  
      008E22 CC 8F 0E         [ 2]  582 	jp token_char 
      008E25                        583 sharp_tst:
      000DA5                        584 	_case '#' qmark_tst 
      008E25 A6 23            [ 1]    1 	ld a,#'#' 
      008E27 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E29 26 05            [ 1]    3 	jrne qmark_tst
      008E2B A6 15            [ 1]  585 	ld a,#REL_NE_IDX  
      008E2D CC 8F 0E         [ 2]  586 	jp token_char
      008E30                        587 qmark_tst:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 111.
Hexadecimal [24-Bits]



      000DB0                        588 	_case '?' tick_tst 
      008E30 A6 3F            [ 1]    1 	ld a,#'?' 
      008E32 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E34 26 09            [ 1]    3 	jrne tick_tst
      008E36 A6 3C            [ 1]  589 	ld a,#PRINT_IDX   
      008E38 F7               [ 1]  590 	ld (x),a 
      008E39 5C               [ 1]  591 	incw x 
      008E3A 90 93            [ 1]  592 	ldw y,x 
      008E3C CC 8F 12         [ 2]  593 	jp token_exit
      008E3F                        594 tick_tst: ; comment 
      000DBF                        595 	_case TICK plus_tst 
      008E3F A6 27            [ 1]    1 	ld a,#TICK 
      008E41 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E43 26 2F            [ 1]    3 	jrne plus_tst
      008E45 A6 23            [ 1]  596 	ld a,#REM_IDX 
      008E47 F7               [ 1]  597 	ld (x),a 
      008E48 5C               [ 1]  598 	incw x
      008E49                        599 copy_comment:
      008E49 90 AE 16 80      [ 2]  600 	ldw y,#tib 
      008E4D 72 B9 00 28      [ 2]  601 	addw y,in.w
      008E51 90 89            [ 2]  602 	pushw y 
      008E53 CD 88 A0         [ 4]  603 	call strcpy
      008E56 72 F2 01         [ 2]  604 	subw y,(1,sp)
      008E59 90 5C            [ 1]  605 	incw y ; strlen+1
      008E5B 90 89            [ 2]  606 	pushw y  
      008E5D 72 FB 01         [ 2]  607 	addw x,(1,sp) 
      008E60 90 93            [ 1]  608 	ldw y,x 
      008E62 85               [ 2]  609 	popw x 
      008E63 72 FB 01         [ 2]  610 	addw x,(1,sp)
      008E66 5A               [ 2]  611 	decw x 
      008E67 1D 16 80         [ 2]  612 	subw x,#tib 
      008E6A CF 00 28         [ 2]  613 	ldw in.w,x 
      000DED                        614 	_drop 2 
      008E6D 5B 02            [ 2]    1     addw sp,#2 
      008E6F A6 23            [ 1]  615 	ld a,#REM_IDX
      008E71 CC 8F 12         [ 2]  616 	jp token_exit 
      008E74                        617 plus_tst:
      000DF4                        618 	_case '+' star_tst 
      008E74 A6 2B            [ 1]    1 	ld a,#'+' 
      008E76 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E78 26 05            [ 1]    3 	jrne star_tst
      008E7A A6 0B            [ 1]  619 	ld a,#ADD_IDX  
      008E7C CC 8F 0E         [ 2]  620 	jp token_char 
      008E7F                        621 star_tst:
      000DFF                        622 	_case '*' slash_tst 
      008E7F A6 2A            [ 1]    1 	ld a,#'*' 
      008E81 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E83 26 05            [ 1]    3 	jrne slash_tst
      008E85 A6 0F            [ 1]  623 	ld a,#MULT_IDX  
      008E87 CC 8F 0E         [ 2]  624 	jp token_char 
      008E8A                        625 slash_tst: 
      000E0A                        626 	_case '/' prcnt_tst 
      008E8A A6 2F            [ 1]    1 	ld a,#'/' 
      008E8C 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E8E 26 05            [ 1]    3 	jrne prcnt_tst
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 112.
Hexadecimal [24-Bits]



      008E90 A6 0D            [ 1]  627 	ld a,#DIV_IDX  
      008E92 CC 8F 0E         [ 2]  628 	jp token_char 
      008E95                        629 prcnt_tst:
      000E15                        630 	_case '%' eql_tst 
      008E95 A6 25            [ 1]    1 	ld a,#'%' 
      008E97 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008E99 26 05            [ 1]    3 	jrne eql_tst
      008E9B A6 0E            [ 1]  631 	ld a,#MOD_IDX 
      008E9D CC 8F 0E         [ 2]  632 	jp token_char  
                                    633 ; 1 or 2 character tokens 	
      008EA0                        634 eql_tst:
      000E20                        635 	_case '=' gt_tst 		
      008EA0 A6 3D            [ 1]    1 	ld a,#'=' 
      008EA2 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008EA4 26 05            [ 1]    3 	jrne gt_tst
      008EA6 A6 11            [ 1]  636 	ld a,#REL_EQU_IDX 
      008EA8 CC 8F 0E         [ 2]  637 	jp token_char 
      008EAB                        638 gt_tst:
      000E2B                        639 	_case '>' lt_tst 
      008EAB A6 3E            [ 1]    1 	ld a,#'>' 
      008EAD 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008EAF 26 21            [ 1]    3 	jrne lt_tst
      008EB1 A6 14            [ 1]  640 	ld a,#REL_GT_IDX 
      008EB3 6B 02            [ 1]  641 	ld (ATTRIB,sp),a 
      008EB5 91 D6 28         [ 4]  642 	ld a,([in.w],y)
      000E38                        643 	_incz in 
      008EB8 3C 29                    1     .byte 0x3c, in 
      008EBA A1 3D            [ 1]  644 	cp a,#'=
      008EBC 26 04            [ 1]  645 	jrne 1$
      008EBE A6 12            [ 1]  646 	ld a,#REL_GE_IDX  
      008EC0 20 4C            [ 2]  647 	jra token_char  
      008EC2 A1 3C            [ 1]  648 1$: cp a,#'<
      008EC4 26 04            [ 1]  649 	jrne 2$
      008EC6 A6 15            [ 1]  650 	ld a,#REL_NE_IDX  
      008EC8 20 44            [ 2]  651 	jra token_char 
      008ECA 72 5A 00 29      [ 1]  652 2$: dec in
      008ECE 7B 02            [ 1]  653 	ld a,(ATTRIB,sp)
      008ED0 20 3C            [ 2]  654 	jra token_char 	 
      008ED2                        655 lt_tst:
      000E52                        656 	_case '<' other
      008ED2 A6 3C            [ 1]    1 	ld a,#'<' 
      008ED4 11 01            [ 1]    2 	cp a,(TCHAR,sp) 
      008ED6 26 21            [ 1]    3 	jrne other
      008ED8 A6 13            [ 1]  657 	ld a,#REL_LT_IDX  
      008EDA 6B 02            [ 1]  658 	ld (ATTRIB,sp),a 
      008EDC 91 D6 28         [ 4]  659 	ld a,([in.w],y)
      000E5F                        660 	_incz in 
      008EDF 3C 29                    1     .byte 0x3c, in 
      008EE1 A1 3D            [ 1]  661 	cp a,#'=
      008EE3 26 04            [ 1]  662 	jrne 1$
      008EE5 A6 10            [ 1]  663 	ld a,#REL_LE_IDX 
      008EE7 20 25            [ 2]  664 	jra token_char 
      008EE9 A1 3E            [ 1]  665 1$: cp a,#'>
      008EEB 26 04            [ 1]  666 	jrne 2$
      008EED A6 15            [ 1]  667 	ld a,#REL_NE_IDX  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 113.
Hexadecimal [24-Bits]



      008EEF 20 1D            [ 2]  668 	jra token_char 
      008EF1 72 5A 00 29      [ 1]  669 2$: dec in 
      008EF5 7B 02            [ 1]  670 	ld a,(ATTRIB,sp)
      008EF7 20 15            [ 2]  671 	jra token_char 	
      008EF9                        672 other: ; not a special character 	 
      008EF9 7B 01            [ 1]  673 	ld a,(TCHAR,sp)
      008EFB CD 88 FF         [ 4]  674 	call is_alpha 
      008EFE 25 03            [ 1]  675 	jrc 30$ 
      008F00 CC 92 25         [ 2]  676 	jp syntax_error 
      008F03                        677 30$: 
      008F03 CD 8D 20         [ 4]  678 	call parse_keyword
      008F06 A1 23            [ 1]  679 	cp a,#REM_IDX  
      008F08 26 08            [ 1]  680 	jrne token_exit   
      008F0A 93               [ 1]  681 	ldw x,y 
      008F0B CC 8E 49         [ 2]  682 	jp copy_comment
      008F0E                        683 token_char:
      008F0E F7               [ 1]  684 	ld (x),a 
      008F0F 5C               [ 1]  685 	incw x
      008F10 90 93            [ 1]  686 	ldw y,x 
      008F12                        687 token_exit:
      000E92                        688 	_drop VSIZE 
      008F12 5B 02            [ 2]    1     addw sp,#VSIZE 
      008F14 81               [ 4]  689 	ret
                                    690 
                                    691 
                                    692 ;-----------------------------------
                                    693 ; create token list fromm text line 
                                    694 ; save this list in pad buffer 
                                    695 ;  compiled line format: 
                                    696 ;    line_no  2 bytes {0...32767}
                                    697 ;    line length    1 byte  
                                    698 ;    tokens list  variable length 
                                    699 ;   
                                    700 ; input:
                                    701 ;   none
                                    702 ; used variables:
                                    703 ;   in.w  		 3|count, i.e. index in buffer
                                    704 ;   count        length of line | 0  
                                    705 ;   basicptr    
                                    706 ;   pad buffer   compiled BASIC line  
                                    707 ;
                                    708 ; If there is a line number copy pad 
                                    709 ; in program space. 
                                    710 ;-----------------------------------
                           000001   711 	XSAVE=1
                           000002   712 	VSIZE=2
      008F15                        713 compile::
      000E95                        714 	_vars VSIZE 
      008F15 52 02            [ 2]    1     sub sp,#VSIZE 
      008F17 55 00 2F 00 2D   [ 1]  715 	mov basicptr,lomem
      008F1C 72 1A 00 3B      [ 1]  716 	bset flags,#FCOMP 
      000EA0                        717 	_rst_pending
      008F20 AE 00 54         [ 2]    1     ldw x,#pending_stack+PENDING_STACK_SIZE
      000EA3                          2     _strxz psp 
      008F23 BF 42                    1     .byte 0xbf,psp 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 114.
Hexadecimal [24-Bits]



      008F25 4F               [ 1]  718 	clr a 
      008F26 5F               [ 1]  719 	clrw x
      008F27 CF 17 00         [ 2]  720 	ldw pad,x ; line# in destination buffer 
      008F2A C7 17 02         [ 1]  721 	ld pad+2,a ; line length  
      000EAD                        722 	_clrz in.w 
      008F2D 3F 28                    1     .byte 0x3f, in.w 
      000EAF                        723 	_clrz in  ; offset in input text buffer 
      008F2F 3F 29                    1     .byte 0x3f, in 
      008F31 C6 16 80         [ 1]  724 	ld a,tib 
      008F34 CD 89 10         [ 4]  725 	call is_digit
      008F37 24 1B            [ 1]  726 	jrnc 1$ 
      000EB9                        727 	_incz in 
      008F39 3C 29                    1     .byte 0x3c, in 
      008F3B AE 17 03         [ 2]  728 	ldw x,#pad+3
      008F3E 90 AE 16 80      [ 2]  729 	ldw y,#tib   
      008F42 CD 8C 87         [ 4]  730 	call parse_integer 
      008F45 A3 00 01         [ 2]  731 	cpw x,#1
      008F48 2F 05            [ 1]  732 	jrslt 0$
      008F4A CF 17 00         [ 2]  733 	ldw pad,x 
      008F4D 20 05            [ 2]  734 	jra 1$ 
      008F4F A6 01            [ 1]  735 0$:	ld a,#ERR_SYNTAX 
      008F51 CC 92 27         [ 2]  736 	jp tb_error
      008F54                        737 1$:	 
      008F54 90 AE 17 03      [ 2]  738 	ldw y,#pad+3 
      008F58 90 A3 17 80      [ 2]  739 2$:	cpw y,#stack_full 
      008F5C 25 05            [ 1]  740 	jrult 3$
      008F5E A6 0A            [ 1]  741 	ld a,#ERR_MEM_FULL 
      008F60 CC 92 27         [ 2]  742 	jp tb_error 
      008F63                        743 3$:	
      008F63 93               [ 1]  744 	ldw x,y 
      008F64 CD 8D 88         [ 4]  745 	call parse_lexeme 
      008F67 4D               [ 1]  746 	tnz a 
      008F68 26 EE            [ 1]  747 	jrne 2$ 
                                    748 ; compilation completed  
      000EEA                        749 	_pending_empty 
      000EEA                          1     _ldaz psp+1 
      008F6A B6 43                    1     .byte 0xb6,psp+1 
      008F6C A0 54            [ 1]    2     sub a,#pending_stack+PENDING_STACK_SIZE
      008F6E 27 0D            [ 1]  750 	jreq 4$
      000EF0                        751 	_pop_op 
      008F70 72 C6 00 42      [ 4]    1     ld a,[psp]
      000EF4                          2     _incz psp+1 
      008F74 3C 43                    1     .byte 0x3c, psp+1 
      008F76 A1 27            [ 1]  752 	cp a,#TO_IDX 
      008F78 27 03            [ 1]  753 	jreq 4$ 
      008F7A CC 92 25         [ 2]  754 	jp syntax_error 
      008F7D                        755 4$:
      008F7D 90 7F            [ 1]  756 	clr (y)
      008F7F 90 5C            [ 1]  757 	incw y 
      008F81 72 A2 17 00      [ 2]  758 	subw y,#pad ; compiled line length 
      008F85 90 9F            [ 1]  759     ld a,yl
      008F87 AE 17 00         [ 2]  760 	ldw x,#pad 
      000F0A                        761 	_strxz ptr16 
      008F8A BF 12                    1     .byte 0xbf,ptr16 
      008F8C E7 02            [ 1]  762 	ld (2,x),a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 115.
Hexadecimal [24-Bits]



      008F8E FE               [ 2]  763 	ldw x,(x)  ; line# 
      008F8F 27 08            [ 1]  764 	jreq 10$
      008F91 CD 8B CC         [ 4]  765 	call insert_line ; in program space 
      000F14                        766 	_clrz  count
      008F94 3F 2A                    1     .byte 0x3f, count 
      008F96 4F               [ 1]  767 	clr  a ; not immediate command  
      008F97 20 0F            [ 2]  768 	jra  11$ 
      008F99                        769 10$: ; line# is zero 
                                    770 ; for immediate execution from pad buffer.
      000F19                        771 	_ldxz ptr16  
      008F99 BE 12                    1     .byte 0xbe,ptr16 
      008F9B E6 02            [ 1]  772 	ld a,(2,x)
      000F1D                        773 	_straz count
      008F9D B7 2A                    1     .byte 0xb7,count 
      000F1F                        774 	_strxz line.addr
      008F9F BF 2B                    1     .byte 0xbf,line.addr 
      008FA1 1C 00 03         [ 2]  775 	addw x,#LINE_HEADER_SIZE
      000F24                        776 	_strxz basicptr
      008FA4 BF 2D                    1     .byte 0xbf,basicptr 
      008FA6 90 93            [ 1]  777 	ldw y,x
      008FA8                        778 11$:
      000F28                        779 	_drop VSIZE 
      008FA8 5B 02            [ 2]    1     addw sp,#VSIZE 
      008FAA 72 1B 00 3B      [ 1]  780 	bres flags,#FCOMP 
      008FAE 81               [ 4]  781 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 116.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2020,2021,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;---------------------------------------
                                     20 ;  decompiler
                                     21 ;  decompile bytecode to text source
                                     22 ;  used by command LIST
                                     23 ;---------------------------------------
                                     24 
                           000000    25 .if SEPARATE 
                                     26     .module DECOMPILER 
                                     27     .include "config.inc"
                                     28 
                                     29     .area CODE 
                                     30 .endif 
                                     31 
                                     32 ;--------------------------
                                     33 ;  align text in buffer 
                                     34 ;  by  padding left  
                                     35 ;  with  SPACE 
                                     36 ; input:
                                     37 ;   X      str*
                                     38 ;   A      width  
                                     39 ; output:
                                     40 ;   A      strlen
                                     41 ;   X      ajusted
                                     42 ;--------------------------
                           000001    43 	WIDTH=1 ; column width 
                           000002    44 	SLEN=2  ; string length 
                           000002    45 	VSIZE=2 
      008FAF                         46 right_align::
      000F2F                         47 	_vars VSIZE 
      008FAF 52 02            [ 2]    1     sub sp,#VSIZE 
      008FB1 6B 01            [ 1]   48 	ld (WIDTH,sp),a 
      008FB3 CD 88 86         [ 4]   49 	call strlen 
      008FB6 6B 02            [ 1]   50 0$:	ld (SLEN,sp),a  
      008FB8 11 01            [ 1]   51 	cp a,(WIDTH,sp) 
      008FBA 2A 09            [ 1]   52 	jrpl 1$
      008FBC 5A               [ 2]   53 	decw x
      008FBD A6 20            [ 1]   54 	ld a,#SPACE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 117.
Hexadecimal [24-Bits]



      008FBF F7               [ 1]   55 	ld (x),a  
      008FC0 7B 02            [ 1]   56 	ld a,(SLEN,sp)
      008FC2 4C               [ 1]   57 	inc a 
      008FC3 20 F1            [ 2]   58 	jra 0$ 
      008FC5 7B 02            [ 1]   59 1$: ld a,(SLEN,sp)	
      000F47                         60 	_drop VSIZE 
      008FC7 5B 02            [ 2]    1     addw sp,#VSIZE 
      008FC9 81               [ 4]   61 	ret 
                                     62 
                                     63 ;--------------------------
                                     64 ; print quoted string 
                                     65 ; converting control character
                                     66 ; to backslash sequence
                                     67 ; input:
                                     68 ;   X        char *
                                     69 ;-----------------------------
      008FCA                         70 prt_quote:
      008FCA A6 22            [ 1]   71 	ld a,#'"
      008FCC CD 85 2C         [ 4]   72 	call putc 
      008FCF 90 89            [ 2]   73 	pushw y 
      008FD1 CD 93 ED         [ 4]   74 	call skip_string 
      008FD4 85               [ 2]   75 	popw x  
      008FD5 F6               [ 1]   76 1$:	ld a,(x)
      008FD6 5C               [ 1]   77 	incw x 
      008FD7 72 5A 00 2A      [ 1]   78 	dec count 
      008FDB 4D               [ 1]   79 	tnz a 
      008FDC 27 2E            [ 1]   80 	jreq 9$ 
      008FDE A1 20            [ 1]   81 	cp a,#SPACE 
      008FE0 25 0C            [ 1]   82 	jrult 3$
      008FE2 CD 85 2C         [ 4]   83 	call putc 
      008FE5 A1 5C            [ 1]   84 	cp a,#'\ 
      008FE7 26 EC            [ 1]   85 	jrne 1$ 
      008FE9                         86 2$:
      008FE9 CD 85 2C         [ 4]   87 	call putc 
      008FEC 20 E7            [ 2]   88 	jra 1$
      008FEE 88               [ 1]   89 3$: push a 
      008FEF A6 5C            [ 1]   90 	ld a,#'\
      008FF1 CD 85 2C         [ 4]   91 	call putc  
      008FF4 84               [ 1]   92 	pop a 
      008FF5 A0 07            [ 1]   93 	sub a,#7
      000F77                         94 	_straz acc8 
      008FF7 B7 19                    1     .byte 0xb7,acc8 
      008FF9 72 5F 00 18      [ 1]   95 	clr acc16
      008FFD 89               [ 2]   96 	pushw x
      008FFE AE 8C 7F         [ 2]   97 	ldw x,#escaped 
      009001 72 BB 00 18      [ 2]   98 	addw x,acc16 
      009005 F6               [ 1]   99 	ld a,(x)
      009006 CD 85 2C         [ 4]  100 	call putc 
      009009 85               [ 2]  101 	popw x
      00900A 20 C9            [ 2]  102 	jra 1$
      00900C                        103 9$:
      00900C A6 22            [ 1]  104 	ld a,#'"
      00900E CD 85 2C         [ 4]  105 	call putc  
      009011 81               [ 4]  106 	ret
                                    107 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 118.
Hexadecimal [24-Bits]



                                    108 ;--------------------------
                                    109 ; print variable name  
                                    110 ; input:
                                    111 ;   X    variable name
                                    112 ; output:
                                    113 ;   none 
                                    114 ;--------------------------
      009012                        115 prt_var_name:
      009012 9E               [ 1]  116 	ld a,xh 
      009013 A4 7F            [ 1]  117 	and a,#0x7f 
      009015 CD 85 2C         [ 4]  118 	call putc 
      009018 9F               [ 1]  119 	ld a,xl 
      009019 CD 85 2C         [ 4]  120 	call putc 
      00901C 81               [ 4]  121 	ret 
                                    122 
                                    123 ;----------------------------------
                                    124 ; search name in dictionary
                                    125 ; from its token index  
                                    126 ; input:
                                    127 ;   a       	token index   
                                    128 ; output:
                                    129 ;   A           token index | 0 
                                    130 ;   X 			*name  | 0 
                                    131 ;--------------------------------
                           000001   132 	TOKEN=1  ; TOK_IDX 
                           000002   133 	NFIELD=TOKEN+1 ; NAME FIELD 
                           000004   134 	SKIP=NFIELD+2 
                           000005   135 	VSIZE=SKIP+1 
      00901D                        136 tok_to_name:
      000F9D                        137 	_vars VSIZE 
      00901D 52 05            [ 2]    1     sub sp,#VSIZE 
      00901F 0F 04            [ 1]  138 	clr (SKIP,sp) 
      009021 6B 01            [ 1]  139 	ld (TOKEN,sp),a 
      009023 AE A4 CB         [ 2]  140 	ldw x, #all_words+2 ; name field 	
      009026 1F 02            [ 2]  141 1$:	ldw (NFIELD,sp),x
      009028 F6               [ 1]  142 	ld a,(x)
      009029 AB 02            [ 1]  143 	add a,#2 
      00902B 6B 05            [ 1]  144 	ld (SKIP+1,sp),a 
      00902D 72 FB 04         [ 2]  145 	addw x,(SKIP,sp)
      009030 F6               [ 1]  146 	ld a,(x) ; TOK_IDX     
      009031 11 01            [ 1]  147 	cp a,(TOKEN,sp)
      009033 27 0B            [ 1]  148 	jreq 2$
      009035 1E 02            [ 2]  149 	ldw x,(NFIELD,sp) ; name field 
      009037 1D 00 02         [ 2]  150 	subw x,#2 ; link field 
      00903A FE               [ 2]  151 	ldw x,(x) 
      00903B 26 E9            [ 1]  152 	jrne 1$
      00903D 4F               [ 1]  153 	clr a 
      00903E 20 03            [ 2]  154 	jra 9$
      009040 1E 02            [ 2]  155 2$: ldw x,(NFIELD,sp)
      009042 5C               [ 1]  156 	incw x 
      000FC3                        157 9$:	_drop VSIZE
      009043 5B 05            [ 2]    1     addw sp,#VSIZE 
      009045 81               [ 4]  158 	ret
                                    159 
                                    160 ;-------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 119.
Hexadecimal [24-Bits]



                                    161 ; decompile tokens list 
                                    162 ; to original text line 
                                    163 ; input:
                                    164 ;   A      0 don't align line number 
                                    165 ;          !0 align it. 
                                    166 ;   line.addr start of line 
                                    167 ;   Y,basicptr  at first token 
                                    168 ;   count     stop position.
                                    169 ;------------------------------------
                           000001   170 	PSTR=1     ;  1 word 
                           000003   171 	ALIGN=3
                           000004   172 	LAST_BC=4
                           000004   173 	VSIZE=4
      009046                        174 decompile::
      009046 3B 00 0F         [ 1]  175 	push base 
      009049 35 0A 00 0F      [ 1]  176 	mov base,#10
      000FCD                        177 	_vars VSIZE
      00904D 52 04            [ 2]    1     sub sp,#VSIZE 
      00904F 6B 03            [ 1]  178 	ld (ALIGN,sp),a 
      000FD1                        179 	_ldxz line.addr
      009051 BE 2B                    1     .byte 0xbe,line.addr 
      009053 FE               [ 2]  180 	ldw x,(x)
      009054 4F               [ 1]  181 	clr a ; unsigned conversion  
      009055 CD 88 39         [ 4]  182 	call itoa
      009058 0D 03            [ 1]  183 	tnz (ALIGN,sp)
      00905A 27 05            [ 1]  184 	jreq 1$  
      00905C A6 05            [ 1]  185 	ld a,#5 
      00905E CD 8F AF         [ 4]  186 	call right_align 
      009061 CD 85 A3         [ 4]  187 1$:	call puts 
      009064 CD 86 06         [ 4]  188 	call space
      000FE7                        189 	_ldyz basicptr
      009067 90 BE 2D                 1     .byte 0x90,0xbe,basicptr 
      00906A                        190 decomp_loop:
      000FEA                        191 	_ldaz count 
      00906A B6 2A                    1     .byte 0xb6,count 
      00906C 26 03            [ 1]  192 	jrne 0$
      00906E CC 91 2F         [ 2]  193 	jp decomp_exit 
      009071                        194 0$:	
      009071 72 5A 00 2A      [ 1]  195 	dec count 
      000FF5                        196 	_next_token
      000FF5                          1         _get_char 
      009075 90 F6            [ 1]    1         ld a,(y)    ; 1 cy 
      009077 90 5C            [ 1]    2         incw y      ; 1 cy 
      009079 4D               [ 1]  197 	tnz a 
      00907A 26 03            [ 1]  198 	jrne 1$
      00907C CC 91 2F         [ 2]  199 	jp decomp_exit   
      00907F A1 06            [ 1]  200 1$:	cp a,#QUOTE_IDX 
      009081 26 03            [ 1]  201 	jrne 2$
      009083 CC 91 29         [ 2]  202 	jp quoted_string 
      009086 A1 09            [ 1]  203 2$:	cp a,#VAR_IDX 
      009088 26 03            [ 1]  204 	jrne 3$
      00908A CC 90 D5         [ 2]  205 	jp variable 
      00908D A1 23            [ 1]  206 3$:	cp a,#REM_IDX 
      00908F 26 03            [ 1]  207 	jrne 4$
      009091 CC 91 1D         [ 2]  208 	jp comment 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 120.
Hexadecimal [24-Bits]



      009094                        209 4$:	
      009094 A1 0A            [ 1]  210 	cp a,#STR_VAR_IDX 
      009096 26 03            [ 1]  211 	jrne 5$
      009098 CC 90 D5         [ 2]  212 	jp variable 
      00909B A1 07            [ 1]  213 5$:	cp a,#LITC_IDX 
      00909D 26 10            [ 1]  214 	jrne 6$ 
      00909F A6 5C            [ 1]  215 	ld a,#'\ 
      0090A1 CD 85 2C         [ 4]  216 	call putc 
      001024                        217 	_get_char 
      0090A4 90 F6            [ 1]    1         ld a,(y)    ; 1 cy 
      0090A6 90 5C            [ 1]    2         incw y      ; 1 cy 
      001028                        218 	_decz count 
      0090A8 3A 2A                    1     .byte 0x3a,count 
      0090AA CD 85 2C         [ 4]  219 	call putc 
      0090AD 20 21            [ 2]  220 	jra prt_space 
      0090AF A1 08            [ 1]  221 6$:	cp a,#LITW_IDX 
      0090B1 26 02            [ 1]  222 	jrne 7$
      0090B3 20 3B            [ 2]  223 	jra lit_word
      0090B5                        224 7$:	
                                    225 ; print command,funcion or operator 	 
      0090B5 6B 04            [ 1]  226 	ld (LAST_BC,sp),a
      0090B7 CD 90 1D         [ 4]  227 	call tok_to_name 
      0090BA 4D               [ 1]  228 	tnz a 
      0090BB 26 03            [ 1]  229 	jrne 9$
      0090BD CC 91 2F         [ 2]  230 	jp decomp_exit
      0090C0                        231 9$:	
      0090C0 CD 88 86         [ 4]  232 	call strlen 
      0090C3 A1 02            [ 1]  233 	cp a,#2 
      0090C5 2A 06            [ 1]  234 	jrpl 10$
      0090C7 F6               [ 1]  235 	ld a,(x)
      0090C8 CD 85 2C         [ 4]  236 	call putc 
      0090CB 20 9D            [ 2]  237 	jra decomp_loop 
      0090CD                        238 10$:
      0090CD CD 85 A3         [ 4]  239 	call puts
      0090D0                        240 prt_space:
      0090D0 CD 86 06         [ 4]  241 	call space 
      0090D3 20 95            [ 2]  242 	jra decomp_loop
                                    243 ; print variable name 	
      0090D5                        244 variable: ; VAR_IDX 
      0090D5 90 F6            [ 1]  245 	ld a,(y)
      0090D7 A4 7F            [ 1]  246 	and a,#127 
      0090D9 CD 85 2C         [ 4]  247 	call putc 
      0090DC 90 E6 01         [ 1]  248 	ld a,(1,y) 
      0090DF CD 85 2C         [ 4]  249 	call putc 
      0090E2 72 5A 00 2A      [ 1]  250 	dec count 
      0090E6 72 5A 00 2A      [ 1]  251 	dec count   
      0090EA 72 A9 00 02      [ 2]  252 	addw y,#2
      0090EE 20 E0            [ 2]  253 	jra prt_space
                                    254 ; print literal integer  
      0090F0                        255 lit_word: ; LITW_IDX 
      001070                        256 	_get_word
      001070                          1         _get_addr
      0090F0 93               [ 1]    1         ldw x,y     ; 1 cy 
      0090F1 FE               [ 2]    2         ldw x,(x)   ; 2 cy 
      0090F2 72 A9 00 02      [ 2]    3         addw y,#2   ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 121.
Hexadecimal [24-Bits]



      0090F6 5D               [ 2]  257 	tnzw x 
      0090F7 2A 1F            [ 1]  258 	jrpl 1$
      0090F9 7B 04            [ 1]  259 	ld a,(LAST_BC,sp)
      0090FB A1 1D            [ 1]  260 	cp a,#GOSUB_IDX 
      0090FD 2B 19            [ 1]  261 	jrmi 1$ 
      0090FF A1 1F            [ 1]  262 	cp a,#GOTO_IDX 
      009101 22 15            [ 1]  263 	jrugt 1$ 
      009103 1D 80 00         [ 2]  264 	subw x,#0x8000
      009106 72 BB 00 2F      [ 2]  265 	addw x,lomem
      00910A 90 89            [ 2]  266 	pushw y 
      00910C FE               [ 2]  267 	ldw x,(x)
      00910D 90 93            [ 1]  268 	ldw y,x ; line #
      00910F 1E 01            [ 2]  269 	ldw x,(1,sp) ; basicptr
      009111 1D 00 02         [ 2]  270 	subw x,#2 ; 
      009114 FF               [ 2]  271 	ldw (x),y
      009115 93               [ 1]  272 	ldw x,y   
      009116 90 85            [ 2]  273 	popw y 
      009118                        274 1$:	 
      009118 CD 88 2E         [ 4]  275 	call print_int 
      00911B 20 B3            [ 2]  276 	jra prt_space 	
                                    277 ; print comment	
      00911D                        278 comment: ; REM_IDX 
      00911D A6 27            [ 1]  279 	ld a,#''
      00911F CD 85 2C         [ 4]  280 	call putc
      009122 93               [ 1]  281 	ldw x,y
      009123 CD 85 A3         [ 4]  282 	call puts 
      009126 CC 91 2F         [ 2]  283 	jp decomp_exit 
                                    284 ; print quoted string 	
      009129                        285 quoted_string:	
      009129 CD 8F CA         [ 4]  286 	call prt_quote  
      00912C CC 90 D0         [ 2]  287 	jp prt_space
                                    288 ; print \letter 	
                           000000   289 .if 0
                                    290 letter: 
                                    291 	ld a,#'\ 
                                    292 	call putc 
                                    293 	_get_char 
                                    294 	dec count   
                                    295 	call putc  
                                    296 	jp prt_space 
                                    297 .endif 
      00912F                        298 decomp_exit: 
      00912F CD 85 E9         [ 4]  299 	call new_line 
      0010B2                        300 	_drop VSIZE 
      009132 5B 04            [ 2]    1     addw sp,#VSIZE 
      009134 32 00 0F         [ 1]  301 	pop base 
      009137 81               [ 4]  302 	ret 
                                    303 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 122.
Hexadecimal [24-Bits]



                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;   pomme BASIC error messages 
                                      3 ;;   addresses indexed table 
                                      4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      5 
                                      6 	; macro to create err_msg table 
                                      7 	.macro _err_entry msg_addr, error_code 
                                      8 	.word msg_addr  
                                      9 	error_code==ERR_IDX 
                                     10 	ERR_IDX=ERR_IDX+1
                                     11 	.endm 
                                     12 
                           000000    13 	ERR_IDX=0
                                     14 
                                     15 ; array of pointers to 
                                     16 ; error_messages strings table.	
      009138                         17 err_msg_idx:  
                                     18 
      0010B8                         19 	_err_entry 0,ERR_NONE 
      009138 00 00                    1 	.word 0  
                           000000     2 	ERR_NONE==ERR_IDX 
                           000001     3 	ERR_IDX=ERR_IDX+1
      0010BA                         20 	_err_entry err_syntax,ERR_SYNTAX 
      00913A 91 5E                    1 	.word err_syntax  
                           000001     2 	ERR_SYNTAX==ERR_IDX 
                           000002     3 	ERR_IDX=ERR_IDX+1
      0010BC                         21 	_err_entry err_gt32767,ERR_GT32767 
      00913C 91 65                    1 	.word err_gt32767  
                           000002     2 	ERR_GT32767==ERR_IDX 
                           000003     3 	ERR_IDX=ERR_IDX+1
      0010BE                         22 	_err_entry err_gt255,ERR_GT255 
      00913E 91 6C                    1 	.word err_gt255  
                           000003     2 	ERR_GT255==ERR_IDX 
                           000004     3 	ERR_IDX=ERR_IDX+1
      0010C0                         23 	_err_entry err_bad_branch,ERR_BAD_BRANCH 
      009140 91 71                    1 	.word err_bad_branch  
                           000004     2 	ERR_BAD_BRANCH==ERR_IDX 
                           000005     3 	ERR_IDX=ERR_IDX+1
      0010C2                         24 	_err_entry err_bad_return,ERR_BAD_RETURN 
      009142 91 7C                    1 	.word err_bad_return  
                           000005     2 	ERR_BAD_RETURN==ERR_IDX 
                           000006     3 	ERR_IDX=ERR_IDX+1
      0010C4                         25 	_err_entry err_bad_next,ERR_BAD_NEXT 
      009144 91 87                    1 	.word err_bad_next  
                           000006     2 	ERR_BAD_NEXT==ERR_IDX 
                           000007     3 	ERR_IDX=ERR_IDX+1
      0010C6                         26 	_err_entry err_gt8_gosub,ERR_GOSUBS 
      009146 91 90                    1 	.word err_gt8_gosub  
                           000007     2 	ERR_GOSUBS==ERR_IDX 
                           000008     3 	ERR_IDX=ERR_IDX+1
      0010C8                         27 	_err_entry err_gt8_fors, ERR_FORS 
      009148 91 9A                    1 	.word err_gt8_fors  
                           000008     2 	ERR_FORS==ERR_IDX 
                           000009     3 	ERR_IDX=ERR_IDX+1
      0010CA                         28 	_err_entry err_end, ERR_END 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 123.
Hexadecimal [24-Bits]



      00914A 91 A2                    1 	.word err_end  
                           000009     2 	ERR_END==ERR_IDX 
                           00000A     3 	ERR_IDX=ERR_IDX+1
      0010CC                         29 	_err_entry err_mem_full, ERR_MEM_FULL
      00914C 91 A6                    1 	.word err_mem_full  
                           00000A     2 	ERR_MEM_FULL==ERR_IDX 
                           00000B     3 	ERR_IDX=ERR_IDX+1
      0010CE                         30 	_err_entry err_too_long, ERR_TOO_LONG 
      00914E 91 AF                    1 	.word err_too_long  
                           00000B     2 	ERR_TOO_LONG==ERR_IDX 
                           00000C     3 	ERR_IDX=ERR_IDX+1
      0010D0                         31 	_err_entry err_dim, ERR_DIM 
      009150 91 B8                    1 	.word err_dim  
                           00000C     2 	ERR_DIM==ERR_IDX 
                           00000D     3 	ERR_IDX=ERR_IDX+1
      0010D2                         32 	_err_entry err_range, ERR_RANGE 
      009152 91 BC                    1 	.word err_range  
                           00000D     2 	ERR_RANGE==ERR_IDX 
                           00000E     3 	ERR_IDX=ERR_IDX+1
      0010D4                         33 	_err_entry err_str_ovfl, ERR_STR_OVFL 
      009154 91 C2                    1 	.word err_str_ovfl  
                           00000E     2 	ERR_STR_OVFL==ERR_IDX 
                           00000F     3 	ERR_IDX=ERR_IDX+1
      0010D6                         34 	_err_entry err_string, ERR_STRING 
      009156 91 CB                    1 	.word err_string  
                           00000F     2 	ERR_STRING==ERR_IDX 
                           000010     3 	ERR_IDX=ERR_IDX+1
      0010D8                         35 	_err_entry err_retype, ERR_RETYPE 
      009158 91 D2                    1 	.word err_retype  
                           000010     2 	ERR_RETYPE==ERR_IDX 
                           000011     3 	ERR_IDX=ERR_IDX+1
      0010DA                         36 	_err_entry err_prog_only, ERR_PROG_ONLY  
      00915A 91 DE                    1 	.word err_prog_only  
                           000011     2 	ERR_PROG_ONLY==ERR_IDX 
                           000012     3 	ERR_IDX=ERR_IDX+1
      0010DC                         37 	_err_entry err_div0, ERR_DIV0 
      00915C 91 EB                    1 	.word err_div0  
                           000012     2 	ERR_DIV0==ERR_IDX 
                           000013     3 	ERR_IDX=ERR_IDX+1
                                     38 
                                     39 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     40 ; error messages strings table 
                                     41 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      00915E                         42 error_messages: 
                                     43 
      00915E 53 59 4E 54 41 58 00    44 err_syntax: .asciz "SYNTAX"
      009165 3E 33 32 37 36 37 00    45 err_gt32767: .asciz ">32767" 
      00916C 3E 32 35 35 00          46 err_gt255: .asciz ">255" 
      009171 42 41 44 20 42 52 41    47 err_bad_branch: .asciz "BAD BRANCH" 
             4E 43 48 00
      00917C 42 41 44 20 52 45 54    48 err_bad_return: .asciz "BAD RETURN" 
             55 52 4E 00
      009187 42 41 44 20 4E 45 58    49 err_bad_next: .asciz "BAD NEXT" 
             54 00
      009190 3E 38 20 47 4F 53 55    50 err_gt8_gosub: .asciz ">8 GOSUBS"  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 124.
Hexadecimal  42-Bits]



             42 53 00
      009198 53 00 3E 38 20 46 4F    51 err_gt8_fors: .asciz ">8 FORS" 
             52
      0091A0 53 00 45 4E             52 err_end: .asciz "END" 
      0091A4 44 00 4D 45 4D 20 46    53 err_mem_full: .asciz "MEM FULL" 
             55 4C
      0091AD 4C 00 54 4F 4F 20 4C    54 err_too_long: .asciz "TOO LONG" 
             4F 4E
      0091B6 47 00 44 49             55 err_dim: .asciz "DIM" 
      0091BA 4D 00 52 41 4E 47       56 err_range: .asciz "RANGE"
      0091C0 45 00 53 54 52 20 4F    57 err_str_ovfl: .asciz "STR OVFL" 
             56 46
      0091C9 4C 00 53 54 52 49 4E    58 err_string: .asciz "STRING" 
      0091D0 47 00 52 45 54 59 50    59 err_retype: .asciz "RETYPE LINE" 
             45 20 4C 49 4E
      0091DC 45 00 50 52 4F 47 52    60 err_prog_only: .asciz "PROGRAM ONLY" 
             41 4D 20 4F 4E 4C
      0091E9 59 00 44 49 56 20 42    61 err_div0: .asciz "DIV BY 0" 
             59 20
                                     62 
                                     63 ;-------------------------------------
      0091F2 30 00 0A 72 75 6E 20    64 rt_msg: .asciz "\nrun time error, "
             74 69 6D 65 20 65 72
             72 6F 72 2C
      009204 20 00 0A 63 6F 6D 70    65 comp_msg: .asciz "\ncompile error, "
             69 6C 65 20 65 72 72
             6F 72 2C
      009215 20 00 2A 2A 2A          66 err_stars: .asciz "*** " 
      00921A 20 00 20 45 52 52 4F    67 err_err: .asciz " ERROR \n" 
             52 20
                                     68 
      0011A5                         69 syntax_error::
      009223 0A 00            [ 1]   70 	ld a,#ERR_SYNTAX 
      009225                         71 tb_error::
      009225 A6 01 00 3B 19   [ 2]   72 	btjt flags,#FCOMP,1$
      009227 88               [ 1]   73 	push a 
      009227 72 0A 00         [ 2]   74 	ldw x, #rt_msg 
      00922A 3B 19 88         [ 4]   75 	call puts
      00922D AE               [ 1]   76 0$:	pop a 
      00922E 91 F4            [ 4]   77 	callr print_err_msg
      009230 CD 85 A3 84      [ 2]   78 	subw y, line.addr 
      009234 AD 35            [ 1]   79 	ld a,yl 
      009236 72 B2            [ 1]   80 	sub a,#LINE_HEADER_SIZE 
      0011BE                         81 	_ldxz line.addr 
      009238 00 2B                    1     .byte 0xbe,line.addr 
      00923A 90 9F A0         [ 4]   82 	call prt_basic_line
      00923D 03 BE            [ 2]   83 	jra 6$
      0011C5                         84 1$:	
      00923F 2B               [ 1]   85 	push a 
      009240 CD 9A 9F         [ 2]   86 	ldw x,#comp_msg
      009243 20 1F 23         [ 4]   87 	call puts 
      009245 84               [ 1]   88 	pop a 
      009245 88 AE            [ 4]   89 	callr print_err_msg
      009247 92 06 CD         [ 2]   90 	ldw x,#tib
      00924A 85 A3 84         [ 4]   91 	call puts 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 125.
Hexadecimal [24-Bits]



      00924D AD 1C            [ 1]   92 	ld a,#CR 
      00924F AE 16 80         [ 4]   93 	call putc
      0011DA                         94 	_ldxz in.w
      009252 CD 85                    1     .byte 0xbe,in.w 
      009254 A3 A6 0D         [ 4]   95 	call spaces
      009257 CD 85            [ 1]   96 	ld a,#'^
      009259 2C BE 28         [ 4]   97 	call putc 
      0011E4                         98 6$:
      00925C CD 86 0C         [ 2]   99 	ldw x,#STACK_EMPTY 
      00925F A6               [ 1]  100     ldw sp,x
      009260 5E CD 85         [ 2]  101 	jp warm_start 
                                    102 	
                                    103 ;------------------------
                                    104 ; print error message 
                                    105 ; input:
                                    106 ;    A   error code 
                                    107 ; output:
                                    108 ;	 none 
                                    109 ;------------------------
      0011EB                        110 print_err_msg:
      009263 2C               [ 1]  111 	push a 
      009264 AE 11 97         [ 2]  112 	ldw x,#err_stars 
      009264 AE 17 FF         [ 4]  113 	call puts
      009267 94               [ 1]  114 	pop a 
      009268 CC               [ 1]  115 	clrw x 
      009269 93               [ 1]  116 	ld xl,a 
      00926A 6E               [ 2]  117 	sllw x 
      00926B 1C 10 B8         [ 2]  118 	addw x,#err_msg_idx 
      00926B 88               [ 2]  119 	ldw x,(x)
      00926C AE 92 17         [ 4]  120 	call puts 
      00926F CD 85 A3         [ 2]  121 	ldw x,#err_err 
      009272 84 5F 97         [ 4]  122 	call puts 
      009275 58               [ 4]  123 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 126.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022,2023  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;--------------------------------------
                                     20 ;   Implementation of Tiny BASIC
                                     21 ;   REF: https://en.wikipedia.org/wiki/Li-Chen_Wang#Palo_Alto_Tiny_BASIC
                                     22 ;   Palo Alto BASIC is 4th version of TinyBasic
                                     23 ;   DATE: 2019-12-17
                                     24 ;
                                     25 ;--------------------------------------------------
                                     26 ;     implementation information
                                     27 ;
                                     28 ; *  integer are 16 bits two's complement  
                                     29 ;
                                     30 ; *  register Y is used as basicptr    
                                     31 ; 
                                     32 ;    IMPORTANT: when a routine use Y it must preserve 
                                     33 ;               its content and restore it at exit.
                                     34 ;               This hold only when BASIC is running  
                                     35 ;               
                                     36 ; *  BASIC function return their value registers 
                                     37 ;    A character 
                                     38 ;	 X integer || address 
                                     39 ; 
                                     40 ;  * variables return their value in X 
                                     41 ;
                                     42 ;--------------------------------------------------- 
                                     43 
                           000000    44 SEPARATE=0 
                                     45 
                           000000    46 .if SEPARATE 
                                     47     .module TINY_BASIC 
                                     48     .include "config.inc"
                                     49 
                                     50 	.area CODE 
                                     51 .endif 
                                     52 
                                     53 
                                     54 ;--------------------------------------
                                     55     .area DATA
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 127.
Hexadecimal [24-Bits]



      000028                         56 	.org APP_VARS_START_ADR 
                                     57 ;--------------------------------------	
                                     58 
                                     59 ; keep the following 3 variables in this order 
      000028                         60 in.w::  .blkb 1 ; used by compiler 
      000029                         61 in::    .blkb 1 ; low byte of in.w 
      00002A                         62 count:: .blkb 1 ; current BASIC line length and tib text length  
      00002B                         63 line.addr:: .blkw 1 ; BASIC line start at this address. 
      00002D                         64 basicptr::  .blkw 1  ; BASIC interperter program pointer.
                                     65 ;data_line:: .blkw 1  ; data line address 
                                     66 ;data_ptr:  .blkw 1  ; point to DATA in line 
      00002F                         67 lomem:: .blkw 1 ; tokenized BASIC area beginning address 
      000031                         68 himem:: .blkw 1 ; tokenized BASIC area end before this address 
      000033                         69 progend:: .blkw 1 ; address end of BASIC program 
      000035                         70 dvar_bgn:: .blkw 1 ; DIM variables start address 
      000037                         71 dvar_end:: .blkw 1 ; DIM variables end address 
      000039                         72 heap_free:: .blkw 1 ; free RAM growing down from tib 
      00003B                         73 flags:: .blkb 1 ; various boolean flags
      00003C                         74 auto_line: .blkw 1 ; automatic line number  
      00003E                         75 auto_step: .blkw 1 ; automatic lein number increment 
                                     76 ; chain_level: .blkb 1 ; increment for each CHAIN command 
      000040                         77 gosub_nest: .blkb 1 ; nesting level of GOSUB, maximum 8 
      000041                         78 for_nest: .blkb 1 ; nesting level of FOR...NEXT , maximum 8 
      000042                         79 psp: .blkw 1 ; pending_stack pointer 
      000044                         80 pending_stack: .blkb 16 ; pending operations stack 
                                     81 
                                     82 ;------------------------------
                                     83 	.area DATA
      000100                         84 	.org 0x100 
                                     85 ;-------------------------------
                                     86 ; BASIC programs compiled here
      000100                         87 free_ram: 
                                     88 
                                     89 
                                     90 	.area CODE 
                                     91 
                                     92 ;-------------------------------------
                                     93 ;-----------------------
                                     94 ;  display system 
                                     95 ;  information 
                                     96 ;-----------------------
                           000001    97 	MAJOR=1
                           000000    98 	MINOR=0
                           000000    99 	REV=0
                                    100 		
      009276 1C 91 38 FE CD 85 A3   101 copyright_info: .asciz "\npomme BASIC\nCopyright, Jacques Deschenes 2023\nversion "
             AE 92 1C CD 85 A3 81
             6F 70 79 72 69 67 68
             74 2C 20 4A 61 63 71
             75 65 73 20 44 65 73
             63 68 65 6E 65 73 20
             32 30 32 33 0A 76 65
             72 73 69 6F 6E 20 00
                                    102 
      000028                        103 print_copyright:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 128.
Hexadecimal [24-Bits]



      000028 3B 00 0F         [ 1]  104 	push base 
      000029 35 0A 00 0F      [ 1]  105 	mov base, #10 
      00002A AE 12 04         [ 2]  106 	ldw x,#copyright_info 
      00002B CD 05 23         [ 4]  107 	call puts 
      00002D A6 01            [ 1]  108 	ld a,#MAJOR 
      00002F CD 07 AC         [ 4]  109 	call prt_i8
      000031 CD 05 59         [ 4]  110 	call bksp  
      000033 A6 2E            [ 1]  111 	ld a,#'.
      000035 CD 04 AC         [ 4]  112 	call putc 
      000037 A6 00            [ 1]  113 	ld a,#MINOR
      000039 CD 07 AC         [ 4]  114 	call prt_i8   
      00003B CD 05 59         [ 4]  115 	call bksp 
      00003C A6 52            [ 1]  116 	ld a,#'R 
      00003E CD 04 AC         [ 4]  117 	call putc 
      000040 A6 00            [ 1]  118 	ld a,#REV 
      000041 CD 07 AC         [ 4]  119 	call prt_i8
      000042 A6 0D            [ 1]  120 	ld a,#CR 
      000044 CD 04 AC         [ 4]  121 	call putc
      000100 32 00 0F         [ 1]  122 	pop base 
      000100 81               [ 4]  123 	ret
                                    124 
                                    125 ;------------------------------
                                    126 ;  les variables ne sont pas 
                                    127 ;  réinitialisées.
                                    128 ;-----------------------------
      001271                        129 warm_init:
      009284 0A 70 6F         [ 2]  130 	ldw x,#uart_putc 
      009287 6D 6D 65         [ 2]  131 	ldw out,x ; standard output   
      001277                        132 	_clrz flags 
      00928A 20 42                    1     .byte 0x3f, flags 
      00928C 41 53 49 43      [ 1]  133 	mov base,#10 
      00127D                        134 	_rst_pending 
      009290 0A 43 6F         [ 2]    1     ldw x,#pending_stack+PENDING_STACK_SIZE
      001280                          2     _strxz psp 
      009293 70 79                    1     .byte 0xbf,psp 
      009295 72               [ 4]  135 	ret 
                                    136 
                                    137 ;---------------------------
                                    138 ; reset BASIC system variables 
                                    139 ; and clear BASIC program 
                                    140 ; variables  
                                    141 ;---------------------------
      001283                        142 reset_basic:
      009296 69               [ 2]  143 	pushw x 
      009297 67 68 74         [ 2]  144 	ldw x,#free_ram 
      001287                        145 	_strxz lomem
      00929A 2C 20                    1     .byte 0xbf,lomem 
      001289                        146 	_strxz progend  
      00929C 4A 61                    1     .byte 0xbf,progend 
      00128B                        147 	_strxz dvar_bgn 
      00929E 63 71                    1     .byte 0xbf,dvar_bgn 
      00128D                        148 	_strxz dvar_end
      0092A0 75 65                    1     .byte 0xbf,dvar_end 
      0092A2 73 20 44         [ 2]  149 	ldw x,#tib 
      001292                        150 	_strxz himem 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 129.
Hexadecimal [24-Bits]



      0092A5 65 73                    1     .byte 0xbf,himem 
      001294                        151 	_strxz heap_free 
      0092A7 63 68                    1     .byte 0xbf,heap_free 
      0092A9 65 6E 65 73      [ 1]  152 	clr flags
      0092AD 20               [ 2]  153 	popw x
      0092AE 32               [ 4]  154 	ret 
                                    155 
      00129C                        156 P1BASIC:: 
                                    157 ; reset hardware stack 
      0092AF 30 32 33         [ 2]  158     ldw x,#STACK_EMPTY 
      0092B2 0A               [ 1]  159     ldw sp,x 
                                    160 ; upper case letters
      0092B3 76 65 72 73      [ 1]  161 	bset sys_flags,#FSYS_UPPER	
      0092B7 69 6F 6E         [ 4]  162 	call reset_basic
                                    163 ; initialize operation pending stack 	
      0012A7                        164 	_rst_pending 
      0092BA 20 00 54         [ 2]    1     ldw x,#pending_stack+PENDING_STACK_SIZE
      0092BC                          2     _strxz psp 
      0092BC 3B 00                    1     .byte 0xbf,psp 
      0092BE 0F 35 0A         [ 4]  165 	call print_copyright ; display system information
      0092C1 00 0F AE         [ 4]  166 	call free 
                                    167 ; set ctrl_c_vector
      0092C4 92 84 CD         [ 2]  168 	ldw x,#ctrl_c_stop 
      0012B5                        169 	_strxz ctrl_c_vector 
      0092C7 85 A3                    1     .byte 0xbf,ctrl_c_vector 
                                    170 ; RND function seed 
                                    171 ; must be initialized 
                                    172 ; to value other than 0.
                                    173 ; take values from ROM space 
      0092C9 A6 01 CD         [ 2]  174 	ldw x,0x6000
      0092CC 88               [ 2]  175 	ldw x,(x)
      0092CD 2C CD 85         [ 2]  176 	ldw seedy,x  
      0092D0 D9 A6 2E         [ 2]  177 	ldw x,0x6006 
      0092D3 CD               [ 2]  178 	ldw x,(x)
      0092D4 85 2C A6         [ 2]  179 	ldw seedx,x  
      0092D7 00 CD            [ 2]  180 	jra warm_start 
                                    181 
      0092D9 88 2C CD 85 D9 A6 52   182 ctrl_c_msg: .asciz "\nSTOPPED AT " 	
             CD 85 2C A6 00 CD
                                    183 ;-------------------------------
                                    184 ; while a program is running 
                                    185 ; CTRL+C end program
                                    186 ;--------------------------- 
      0012D4                        187 ctrl_c_stop: 
      0092E6 88 2C A6         [ 2]  188 	ldw x,#ctrl_c_msg 
      0092E9 0D CD 85         [ 4]  189 	call puts 
      0092EC 2C 32 00         [ 2]  190 	ldw x,line.addr 
      0092EF 0F               [ 2]  191 	ldw x,(x)
      0092F0 81 07 AE         [ 4]  192 	call print_int
      0092F1 CD 05 69         [ 4]  193 	call new_line 
      0092F1 AE 85 41         [ 2]  194 	ldw x,#STACK_EMPTY 
      0092F4 CF               [ 1]  195 	ldw sp,x
      0092F5 00 1A 3F 3B      [ 1]  196 	bres flags,#FRUN
      0092F9 35 0A            [ 2]  197 	jra cmd_line 
      0012EE                        198 warm_start:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 130.
Hexadecimal [24-Bits]



      0092FB 00 0F AE         [ 4]  199 	call warm_init
                                    200 ;----------------------------
                                    201 ;   BASIC interpreter
                                    202 ;----------------------------
      0012F1                        203 cmd_line: ; user interface 
      0092FE 00 54            [ 1]  204 	ld a,#CR 
      009300 BF 42 81         [ 4]  205 	call putc 
      009303 A6 3E            [ 1]  206 	ld a,#'> 
      009303 89 AE 01         [ 4]  207 	call putc
      009306 00 BF            [ 1]  208 	push #0 
                                    209 ;	clr tib
      009308 2F BF 33 BF 35   [ 2]  210 	btjf flags,#FAUTO,1$ 
      001302                        211 	_ldxz auto_line 
      00930D BF 37                    1     .byte 0xbe,auto_line 
      00930F AE 16 80         [ 4]  212 	call itoa
      009312 BF 31            [ 1]  213 	ld (1,sp),a  
      009314 BF 39            [ 1]  214 	ldw y,x 
      009316 72 5F 00         [ 2]  215 	ldw x,#tib 
      009319 3B 85 81         [ 4]  216 	call strcpy 
      00931C                        217 	_ldxz auto_line 
      00931C AE 17                    1     .byte 0xbe,auto_line 
      00931E FF 94 72 14      [ 2]  218 	addw x,auto_step 
      001317                        219 	_strxz auto_line
      009322 00 0A                    1     .byte 0xbf,auto_line 
      009324 CD               [ 1]  220 1$: pop a 
      009325 93 03 AE         [ 4]  221 	call readln
      009328 00               [ 1]  222 	tnz a 
      009329 54 BF            [ 1]  223 	jreq cmd_line
      00932B 42 CD 92         [ 4]  224 	call compile
      00932E BC               [ 1]  225 	tnz a 
      00932F CD A2            [ 1]  226 	jreq cmd_line ; not direct command
                                    227 
                                    228 ;; direct command 
                                    229 ;; interpret 
                                    230 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    231 ;; This is the interpreter loop
                                    232 ;; for each BASIC code line.
                                    233 ;; 10 cycles  
                                    234 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
      001326                        235 do_nothing: 
      001326                        236 interp_loop:   
      001326                        237     _next_cmd ; command bytecode, 2 cy  
      001326                          1         _get_char       ; 2 cy 
      009331 C4 AE            [ 1]    1         ld a,(y)    ; 1 cy 
      009333 93 54            [ 1]    2         incw y      ; 1 cy 
      00132A                        238 	_jp_code ; 8 cy + 2 cy for jump back to interp_loop  
      00132A                          1         _code_addr 
      009335 BF               [ 1]    1         clrw x   ; 1 cy 
      009336 1C               [ 1]    2         ld xl,a  ; 1 cy 
      009337 CE               [ 2]    3         sllw x   ; 2 cy 
      009338 60 00 FE         [ 2]    4         ldw x,(code_addr,x) ; 2 cy 
      00933B CF               [ 2]    2         jp (x)
                                    239 
                                    240 ;---------------------
                                    241 ; BASIC: REM | ' 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 131.
Hexadecimal [24-Bits]



                                    242 ; skip comment to end of line 
                                    243 ;---------------------- 
      001331                        244 kword_remark::
      00933C 00 0D CE 60      [ 2]  245 	ldw y,line.addr 
      009340 06 FE CF         [ 1]  246 	ld a,(2,y) ; line length 
      001338                        247 	_straz in  
      009343 00 0B                    1     .byte 0xb7,in 
      009345 20 27 0A 53      [ 2]  248 	addw y,in.w   
                                    249 
                                    250 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    251 ; move basicptr to first token 
                                    252 ; of next line 
                                    253 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      00133E                        254 next_line:
      009349 54 4F 50 50 45   [ 2]  255 	btjf flags,#FRUN,cmd_line
      00934E 44 20 41 54      [ 2]  256 	cpw y,progend
      009352 20 00            [ 1]  257 	jrmi 1$
      009354                        258 0$:
      009354 AE 93            [ 1]  259 	ld a,#ERR_END 
      009356 47 CD 85         [ 2]  260 	jp tb_error 
                                    261 ;	jp kword_end 
      00134E                        262 1$:	
      00134E                        263 	_stryz line.addr 
      009359 A3 CE 00                 1     .byte 0x90,0xbf,line.addr 
      00935C 2B FE CD 88      [ 2]  264 	addw y,#LINE_HEADER_SIZE
      009360 2E CD 85 E9 AE   [ 2]  265 	btjf flags,#FTRACE,2$
      009365 17 FF 94         [ 4]  266 	call prt_line_no 
      00135D                        267 2$:	
      00135D                        268   _next 
      009368 72 11 00         [ 2]    1         jp interp_loop 
                                    269 
                                    270 
                                    271 
                                    272 ;------------------------
                                    273 ; when TRACE is active 
                                    274 ; print line number to 
                                    275 ; be executed by VM
                                    276 ;------------------------
      001360                        277 prt_line_no:
      00936B 3B 20 03 2B      [ 5]  278 	ldw x,[line.addr] 
      00936E CD 07 AE         [ 4]  279 	call print_int 
      00936E CD 92            [ 1]  280 	ld a,#CR 
      009370 F1 04 AC         [ 4]  281 	call putc 
      009371 81               [ 4]  282 	ret 
                                    283 
                                    284 
                                    285 ;-------------------------
                                    286 ;  skip .asciz in BASIC line 
                                    287 ;  name 
                                    288 ;  input:
                                    289 ;     x		* string 
                                    290 ;  output:
                                    291 ;     none 
                                    292 ;-------------------------
      00136D                        293 skip_string:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 132.
Hexadecimal [24-Bits]



      009371 A6 0D            [ 1]  294 	ld a,(y)
      009373 CD 85            [ 1]  295 	jreq 8$
      009375 2C A6            [ 1]  296 1$:	incw y
      009377 3E CD            [ 1]  297 	ld a,(y)
      009379 85 2C            [ 1]  298 	jrne 1$  
      00937B 4B 00            [ 1]  299 8$: incw y
      00937D 72               [ 4]  300 	ret 
                                    301 
                                    302 ;-------------------------------
                                    303 ; called when an intger token 
                                    304 ; is expected. can be LIT_IDX 
                                    305 ; or LITW_IDX 
                                    306 ; program fail if not integer 
                                    307 ;------------------------------
      00137A                        308 expect_integer:
      00137A                        309 	_next_token 
      00137A                          1         _get_char 
      00937E 0D 00            [ 1]    1         ld a,(y)    ; 1 cy 
      009380 3B 17            [ 1]    2         incw y      ; 1 cy 
      009382 BE 3C            [ 1]  310 	cp a,#LITW_IDX 
      009384 CD 88            [ 1]  311 	jreq 0$
      009386 39 6B 01         [ 2]  312 	jp syntax_error
      001385                        313 0$:	_get_word 
      001385                          1         _get_addr
      009389 90               [ 1]    1         ldw x,y     ; 1 cy 
      00938A 93               [ 2]    2         ldw x,(x)   ; 2 cy 
      00938B AE 16 80 CD      [ 2]    3         addw y,#2   ; 2 cy 
      00938F 88               [ 4]  314 	ret 
                                    315 
                                    316 
                                    317 ;--------------------------
                                    318 ; input:
                                    319 ;   A      character 
                                    320 ; output:
                                    321 ;   A      digit 
                                    322 ;   Cflag   1 ok, 0 failed 
                                    323 ; use:
                                    324 ;   base
                                    325 ;------------------------------   
      00138C                        326 char_to_digit:
      009390 A0 BE            [ 1]  327 	sub a,#'0
      009392 3C 72            [ 1]  328 	jrmi 9$ 
      009394 BB 00            [ 1]  329 	cp a,#10
      009396 3E BF            [ 1]  330 	jrmi 5$
      009398 3C 84            [ 1]  331 	cp a,#17 
      00939A CD 86            [ 1]  332 	jrmi 9$   
      00939C 79 4D            [ 1]  333 	sub a,#7 
      00939E 27 D1 CD         [ 1]  334 	cp a,base 
      0093A1 8F 15            [ 1]  335 	jrpl 9$	 
      0093A3 4D               [ 1]  336 5$: scf ; ok 
      0093A4 27               [ 4]  337 	ret 
      0093A5 CB               [ 1]  338 9$: rcf ; failed 
      0093A6 81               [ 4]  339 	ret 
                                    340 
                                    341 ;------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 133.
Hexadecimal [24-Bits]



                                    342 ; convert pad content in integer
                                    343 ; input:
                                    344 ;    Y		* .asciz to convert
                                    345 ; output:
                                    346 ;    X        int16_t
                                    347 ;    Y        * .asciz after integer  
                                    348 ;    acc16    int16_t 
                                    349 ; use:
                                    350 ;   base 
                                    351 ;------------------------------------
                                    352 	; local variables
                           000001   353 	N=1 ; INT_SIZE  
                           000003   354 	DIGIT=N+INT_SIZE 
                           000005   355 	SIGN=DIGIT+INT_SIZE ; 1 byte, 
                           000005   356 	VSIZE=SIGN   
      0093A6                        357 atoi16::
      0013A3                        358 	_vars VSIZE
      0093A6 90 F6            [ 2]    1     sub sp,#VSIZE 
                                    359 ; conversion made on stack 
      0093A8 90 5C 5F 97      [ 1]  360 	mov base, #10 ; defaul conversion base 
      0093AC 58 DE            [ 1]  361 	clr (DIGIT,sp)
      0093AE 8A               [ 1]  362 	clrw x 
      0013AC                        363 	_i16_store N   
      0093AF AE FC            [ 2]    1     ldw (N,sp),x 
      0093B1 0F 05            [ 1]  364 	clr (SIGN,sp)
      0093B1 90 CE            [ 1]  365 	ld a,(y)
      0093B3 00 2B            [ 1]  366 	jreq 9$  ; completed if 0
      0093B5 90 E6            [ 1]  367 	cp a,#'-
      0093B7 02 B7            [ 1]  368 	jrne 1$ 
      0093B9 29 72            [ 1]  369 	cpl (SIGN,sp)
      0093BB B9 00            [ 2]  370 	jra 2$
      0013BC                        371 1$:  
      0093BD 28 24            [ 1]  372 	cp a,#'$ 
      0093BE 26 0A            [ 1]  373 	jrne 3$ 
      0093BE 72 01 00 3B      [ 1]  374 	mov base,#16 ; hexadecimal base 
      0093C2 AE 90            [ 1]  375 2$:	incw y
      0093C4 C3 00            [ 1]  376 	ld a,(y)
      0093C6 33 2B            [ 1]  377 	jreq 9$ 
      0013CA                        378 3$:	; char to digit 
      0093C8 05 13 8C         [ 4]  379 	call char_to_digit
      0093C9 24 10            [ 1]  380 	jrnc 9$
      0093C9 A6 09            [ 1]  381 	ld (DIGIT+1,sp),a 
      0013D1                        382 	_i16_fetch N  ; X=N 
      0093CB CC 92            [ 2]    1     ldw x,(N,sp)
      0013D3                        383 	_ldaz base   
      0093CD 27 0F                    1     .byte 0xb6,base 
      0093CE CD 02 F8         [ 4]  384 	call umul16_8      
      0093CE 90 BF 2B         [ 2]  385 	addw x,(DIGIT,sp)
      0013DB                        386 	_i16_store N  
      0093D1 72 A9            [ 2]    1     ldw (N,sp),x 
      0093D3 00 03            [ 2]  387 	jra 2$
      0013DF                        388 9$:	_i16_fetch N
      0093D5 72 0F            [ 2]    1     ldw x,(N,sp)
      0093D7 00 3B            [ 1]  389 	tnz (SIGN,sp)
      0093D9 03 CD            [ 1]  390     jreq 10$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 134.
Hexadecimal [24-Bits]



      0093DB 93               [ 2]  391     negw x
      0013E6                        392 10$:
      0013E6                        393 	_strxz acc16  
      0093DC E0 18                    1     .byte 0xbf,acc16 
      0093DD                        394 	_drop VSIZE
      0093DD CC 93            [ 2]    1     addw sp,#VSIZE 
      0093DF A6               [ 4]  395 	ret
                                    396 
                                    397 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    398 ;;   pomme BASIC  operators,
                                    399 ;;   commands and functions 
                                    400 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    401 
                                    402 ;---------------------------------
                                    403 ; dictionary search 
                                    404 ; input:
                                    405 ;	X 		dictionary entry point, name field  
                                    406 ;   y		.asciz name to search 
                                    407 ; output:
                                    408 ;  A		TOKEN_IDX  
                                    409 ;---------------------------------
                           000001   410 	NLEN=1 ; cmd length 
                           000003   411 	XSAVE=NLEN+2
                           000005   412 	YSAVE=XSAVE+2
                           000006   413 	VSIZE=YSAVE+1
      0093E0                        414 search_dict::
      0013EB                        415 	_vars VSIZE 
      0093E0 72 CE            [ 2]    1     sub sp,#VSIZE 
      0093E2 00 2B            [ 1]  416 	clr (NLEN,sp)
      0093E4 CD 88            [ 2]  417 	ldw (YSAVE,sp),y 
      0013F1                        418 search_next:
      0093E6 2E A6            [ 2]  419 	ldw (XSAVE,sp),x 
                                    420 ; get name length in dictionary	
      0093E8 0D               [ 1]  421 	ld a,(x)
      0093E9 CD 85            [ 1]  422 	ld (NLEN+1,sp),a  
      0093EB 2C 81            [ 2]  423 	ldw y,(YSAVE,sp) ; name pointer 
      0093ED 5C               [ 1]  424 	incw x 
      0093ED 90 F6 27         [ 4]  425 	call strcmp 
      0093F0 06 90            [ 1]  426 	jreq str_match 
      0013FE                        427 no_match:
      0093F2 5C 90            [ 2]  428 	ldw x,(XSAVE,sp) 
      0093F4 F6 26 FA         [ 2]  429 	subw x,#2 ; move X to link field
      0093F7 90 5C            [ 1]  430 	ld a,#NONE_IDX   
      0093F9 81               [ 2]  431 	ldw x,(x) ; next word link 
      0093FA 27 0B            [ 1]  432 	jreq search_exit  ; not found  
                                    433 ;try next 
      0093FA 90 F6            [ 2]  434 	jra search_next
      00140A                        435 str_match:
      0093FC 90 5C            [ 2]  436 	ldw x,(XSAVE,sp)
      0093FE A1 08 27         [ 2]  437 	addw x,(NLEN,sp)
                                    438 ; move x to token field 	
      009401 03 CC 92         [ 2]  439 	addw x,#2 ; to skip length byte and 0 at end  
      009404 25               [ 1]  440 	ld a,(x) ; token index
      001413                        441 search_exit: 
      001413                        442 	_drop VSIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 135.
Hexadecimal [24-Bits]



      009405 93 FE            [ 2]    1     addw sp,#VSIZE 
      009407 72               [ 4]  443 	ret 
                                    444 
                                    445 
                                    446 ;---------------------
                                    447 ; check if next token
                                    448 ;  is of expected type 
                                    449 ; input:
                                    450 ;   A 		 expected token attribute
                                    451 ;  ouput:
                                    452 ;   none     if fail call syntax_error 
                                    453 ;--------------------
      001416                        454 expect:
      009408 A9               [ 1]  455 	push a 
      001417                        456 	_next_token 
      001417                          1         _get_char 
      009409 00 02            [ 1]    1         ld a,(y)    ; 1 cy 
      00940B 81 5C            [ 1]    2         incw y      ; 1 cy 
      00940C 11 01            [ 1]  457 	cp a,(1,sp)
      00940C A0 30            [ 1]  458 	jreq 1$
      00940E 2B 11 A1         [ 2]  459 	jp syntax_error
      009411 0A               [ 1]  460 1$: pop a 
      009412 2B               [ 4]  461 	ret 
                                    462 
                                    463 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    464 ; parse arguments list 
                                    465 ; between ()
                                    466 ;;;;;;;;;;;;;;;;;;;;;;;;;;
      001424                        467 func_args:
      001424                        468 	_next_token 
      001424                          1         _get_char 
      009413 0B A1            [ 1]    1         ld a,(y)    ; 1 cy 
      009415 11 2B            [ 1]    2         incw y      ; 1 cy 
      009417 09 A0            [ 1]  469 	cp a,#LPAREN_IDX 
      009419 07 C1            [ 1]  470 	jreq arg_list 
      00941B 00 0F 2A         [ 2]  471 	jp syntax_error 
                                    472 
                                    473 ; expected to continue in arg_list 
                                    474 ; caller must check for RPAREN_IDX 
                                    475 
                                    476 ;-------------------------------
                                    477 ; parse embedded BASIC routines 
                                    478 ; arguments list.
                                    479 ; arg_list::=  expr[','expr]*
                                    480 ; all arguments are of int24_t type
                                    481 ; and pushed on stack 
                                    482 ; input:
                                    483 ;   none
                                    484 ; output:
                                    485 ;   stack{n}   arguments pushed on stack
                                    486 ;   A  	number of arguments pushed on stack  
                                    487 ;--------------------------------
                           000004   488 	ARGN=4 
                           000002   489 	ARG_SIZE=INT_SIZE 
      00142F                        490 arg_list:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 136.
Hexadecimal [24-Bits]



      00941E 02 99            [ 1]  491 	push #0 ; arguments counter
      009420 81 98            [ 1]  492 	tnz (y)
      009422 81 1A            [ 1]  493 	jreq 7$ 
      009423                        494 1$:	 
      009423 52               [ 1]  495 	pop a 
      009424 05               [ 2]  496 	popw x 
      009425 35 0A            [ 2]  497 	sub sp, #ARG_SIZE
      009427 00               [ 2]  498 	pushw x 
      009428 0F               [ 1]  499 	inc a 
      009429 0F               [ 1]  500 	push a
      00942A 03 5F 1F         [ 4]  501 	call expression 
      00143F                        502 	_i16_store ARGN   
      00942D 01 0F            [ 2]    1     ldw (ARGN,sp),x 
      001441                        503 	_next_token 
      001441                          1         _get_char 
      00942F 05 90            [ 1]    1         ld a,(y)    ; 1 cy 
      009431 F6 27            [ 1]    2         incw y      ; 1 cy 
      009433 2B A1            [ 1]  504 	cp a,#COMMA_IDX 
      009435 2D 26            [ 1]  505 	jreq 1$ 
      009437 04 03            [ 1]  506 	cp a,#RPAREN_IDX 
      009439 05 20            [ 1]  507 	jreq 7$ 
      00144D                        508 	_unget_token 
      00943B 08 5A            [ 2]    1         decw y
      00943C                        509 7$:	
      00943C A1               [ 1]  510 	pop a
      00943D 24               [ 4]  511 	ret  
                                    512 
                                    513 ;--------------------------------
                                    514 ;   BASIC commnands 
                                    515 ;--------------------------------
                                    516 
                           000000   517 .if 0
                                    518 ;----------------------------------
                                    519 ; BASIC: MULDIV(expr1,expr2,expr3)
                                    520 ; return expr1*expr2/expr3 
                                    521 ; product result is int32_t and 
                                    522 ; divisiont is int32_t/int16_t
                                    523 ;----------------------------------
                                    524 	DBL_SIZE=4 
                                    525 muldiv:
                                    526 	call func_args 
                                    527 	cp a,#3 
                                    528 	jreq 1$
                                    529 	jp syntax_error
                                    530 1$: 
                                    531 	ldw x,(5,sp) ; expr1
                                    532 	ldw y,(3,sp) ; expr2
                                    533 	call multiply 
                                    534 	ldw (5,sp),x  ;int32_t 15..0
                                    535 	ldw (3,sp),y  ;int32_t 31..16
                                    536 	popw x        ; expr3 
                                    537 	call div32_16 ; int32_t/expr3 
                                    538 	_drop DBL_SIZE
                                    539 	ret 
                                    540 .endif 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 137.
Hexadecimal [24-Bits]



                                    541 
                                    542 ;--------------------------------
                                    543 ;  arithmetic and relational 
                                    544 ;  routines
                                    545 ;  operators precedence
                                    546 ;  highest to lowest
                                    547 ;  operators on same row have 
                                    548 ;  same precedence and are executed
                                    549 ;  from left to right.
                                    550 ;	'*','/','%'
                                    551 ;   '-','+'
                                    552 ;   '=','>','<','>=','<=','<>','><'
                                    553 ;   '<>' and '><' are equivalent for not equal.
                                    554 ;--------------------------------
                                    555 
                                    556 
                                    557 ;---------------------
                                    558 ; return array element
                                    559 ; address from var(expr)
                                    560 ; input:
                                    561 ;   X       
                                    562 ;   A 		ARRAY_IDX
                                    563 ; output:
                                    564 ;	X 		element address 
                                    565 ;----------------------
      001451                        566 get_array_element:
                           000000   567 .if 0
                                    568 	call func_args 
                                    569 	cp a,#1
                                    570 	jreq 1$
                                    571 	jp syntax_error
                                    572 1$: _i16_pop 
                                    573     ; ignore A, index < 65536 in any case 
                                    574 	; check for bounds 
                                    575 ;	cpw x,array_size 
                                    576 	jrule 3$
                                    577 ; bounds {1..array_size}	
                                    578 2$: ld a,#ERR_RANGE  
                                    579 	jp tb_error 
                                    580 3$: 
                                    581 	tnzw  x
                                    582 	jreq 2$ 
                                    583 	ld a,#INT_SIZE   
                                    584 	mul x,a 
                                    585 	ldw acc16,x   
                                    586 	ldw x,end_free_ram ; array start at this point  
                                    587 	subw x,acc16
                                    588 .endif 
      00943E 26               [ 4]  589 	ret 
                                    590 
                                    591 
                                    592 ;***********************************
                                    593 ;   expression parse,execute 
                                    594 ;***********************************
                                    595 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 138.
Hexadecimal [24-Bits]



                                    596 ;-----------------------------------
                                    597 ; factor ::= ['+'|'-'|e]  var | @ |
                                    598 ;			 integer | function |
                                    599 ;			 '('expression')' 
                                    600 ; output:
                                    601 ;     X     factor value 
                                    602 ; ---------------------------------
                           000001   603 	NEG=1
                           000001   604 	VSIZE=1
      001452                        605 factor:
      001452                        606 	_vars VSIZE 
      00943F 0A 35            [ 2]    1     sub sp,#VSIZE 
      009441 10 00            [ 1]  607 	clr (NEG,sp)
      001456                        608 	_next_token
      001456                          1         _get_char 
      009443 0F 90            [ 1]    1         ld a,(y)    ; 1 cy 
      009445 5C 90            [ 1]    2         incw y      ; 1 cy 
      009447 F6 27            [ 1]  609 	cp a,#CMD_END
      009449 15 03            [ 1]  610 	jrugt 1$ 
      00944A CC 11 A5         [ 2]  611 	jp syntax_error
      001461                        612 1$:
      00944A CD 94            [ 1]  613 	cp a,#ADD_IDX 
      00944C 0C 24            [ 1]  614 	jreq 2$
      00944E 10 6B            [ 1]  615 	cp a,#SUB_IDX 
      009450 04 1E            [ 1]  616 	jrne 4$ 
      009452 01 B6            [ 1]  617 	cpl (NEG,sp)
      00146B                        618 2$:	
      00146B                        619 	_next_token
      00146B                          1         _get_char 
      009454 0F CD            [ 1]    1         ld a,(y)    ; 1 cy 
      009456 83 78            [ 1]    2         incw y      ; 1 cy 
      00146F                        620 4$:
      009458 72 FB            [ 1]  621 	cp a,#LITW_IDX 
      00945A 03 1F            [ 1]  622 	jrne 5$
      001473                        623 	_get_word 
      001473                          1         _get_addr
      00945C 01               [ 1]    1         ldw x,y     ; 1 cy 
      00945D 20               [ 2]    2         ldw x,(x)   ; 2 cy 
      00945E E5 1E 01 0D      [ 2]    3         addw y,#2   ; 2 cy 
      009462 05 27            [ 2]  624 	jra 18$
      00147B                        625 5$: 
      009464 01 50            [ 1]  626 	cp a,#LITC_IDX 
      009466 26 08            [ 1]  627 	jrne 6$
      00147F                        628 	_get_char 
      009466 BF 18            [ 1]    1         ld a,(y)    ; 1 cy 
      009468 5B 05            [ 1]    2         incw y      ; 1 cy 
      00946A 81               [ 1]  629 	clrw x 
      00946B 97               [ 1]  630 	ld xl,a
      00946B 52 06            [ 2]  631 	jra 18$  	
      001487                        632 6$:
      00946D 0F 01            [ 1]  633 	cp a,#VAR_IDX 
      00946F 17 05            [ 1]  634 	jrne 8$
      009471 CD 17 6D         [ 4]  635 	call get_var_adr 
      009471 1F 03 F6         [ 4]  636 	call get_array_adr 
      009474 6B               [ 2]  637 	ldw x,(x)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 139.
Hexadecimal [24-Bits]



      009475 02 16            [ 2]  638 	jra 18$ 	
      001494                        639 8$:
      009477 05 5C            [ 1]  640 	cp a,#LPAREN_IDX
      009479 CD 88            [ 1]  641 	jrne 10$
      00947B 91 27 0C         [ 4]  642 	call expression
      00947E                        643 	_i16_push
      00947E 1E               [ 2]    1     pushw X
      00947F 03 1D            [ 1]  644 	ld a,#RPAREN_IDX 
      009481 00 02 A6         [ 4]  645 	call expect
      0014A1                        646 	_i16_pop 
      009484 FF               [ 2]    1     popw x 
      009485 FE 27            [ 2]  647 	jra 18$ 
      0014A4                        648 10$: ; must be a function 
      0014A4                        649 	_call_code
      0014A4                          1         _code_addr  ; 6 cy  
      009487 0B               [ 1]    1         clrw x   ; 1 cy 
      009488 20               [ 1]    2         ld xl,a  ; 1 cy 
      009489 E7               [ 2]    3         sllw x   ; 2 cy 
      00948A DE 0A 2E         [ 2]    4         ldw x,(code_addr,x) ; 2 cy 
      00948A 1E               [ 4]    2         call (x)    ; 4 cy 
      0014AB                        650 18$: 
      00948B 03 72            [ 1]  651 	tnz (NEG,sp)
      00948D FB 01            [ 1]  652 	jreq 20$
      00948F 1C               [ 2]  653 	negw x   
      0014B0                        654 20$:
      0014B0                        655 	_drop VSIZE
      009490 00 02            [ 2]    1     addw sp,#VSIZE 
      009492 F6               [ 4]  656 	ret
                                    657 
                                    658 
                                    659 ;-----------------------------------
                                    660 ; term ::= factor ['*'|'/'|'%' factor]* 
                                    661 ; output:
                                    662 ;   X    	term  value 
                                    663 ;-----------------------------------
                           000001   664 	N1=1 ; left operand   
                           000003   665 	YSAVE=N1+INT_SIZE   
                           000005   666 	MULOP=YSAVE+ADR_SIZE
                           000005   667 	VSIZE=INT_SIZE+ADR_SIZE+1    
      009493                        668 term:
      0014B3                        669 	_vars VSIZE
      009493 5B 06            [ 2]    1     sub sp,#VSIZE 
                                    670 ; first factor 	
      009495 81 14 52         [ 4]  671 	call factor
      009496                        672 	_i16_store N1 ; left operand 
      009496 88 90            [ 2]    1     ldw (N1,sp),x 
      0014BA                        673 term01:	 ; check for  operator '*'|'/'|'%' 
      0014BA                        674 	_next_token
      0014BA                          1         _get_char 
      009498 F6 90            [ 1]    1         ld a,(y)    ; 1 cy 
      00949A 5C 11            [ 1]    2         incw y      ; 1 cy 
      00949C 01 27            [ 1]  675 	ld (MULOP,sp),a
      00949E 03 CC            [ 1]  676 	cp a,#DIV_IDX 
      0094A0 92 25            [ 1]  677 	jrmi 0$ 
      0094A2 84 81            [ 1]  678 	cp a,#MULT_IDX
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 140.
Hexadecimal [24-Bits]



      0094A4 23 04            [ 2]  679 	jrule 1$ 
      0014C8                        680 0$:	_unget_token
      0094A4 90 F6            [ 2]    1         decw y
      0094A6 90 5C            [ 2]  681 	jra term_exit 
      0014CC                        682 1$:	; got *|/|%
                                    683 ;second factor
      0094A8 A1 04 27         [ 4]  684 	call factor
      0094AB 03 CC            [ 2]  685 	ldw (YSAVE,sp),y ; save y 
      0094AD 92 25            [ 2]  686 	ldw y,(N1,sp)
                                    687 ; select operation 	
      0094AF 7B 05            [ 1]  688 	ld a,(MULOP,sp) 
      0094AF 4B 00            [ 1]  689 	cp a,#MULT_IDX 
      0094B1 90 7D            [ 1]  690 	jrne 3$
                                    691 ; '*' operator
      0094B3 27 1A 47         [ 4]  692 	call multiply 
      0094B5 20 0F            [ 2]  693 	jra 5$
      0094B5 84 85            [ 1]  694 3$: cp a,#DIV_IDX 
      0094B7 52 02            [ 1]  695 	jrne 4$ 
                                    696 ; '/' operator	
      0094B9 89               [ 1]  697 	exgw x,y 
      0094BA 4C 88 CD         [ 4]  698 	call divide 
      0094BD 95 78            [ 2]  699 	jra 5$ 
      0014E8                        700 4$: ; '%' operator
      0094BF 1F               [ 1]  701 	exgw x,y 
      0094C0 04 90 F6         [ 4]  702 	call divide  
      0094C3 90               [ 1]  703 	exgw x,y 
      0014ED                        704 5$: 
      0014ED                        705 	_i16_store N1
      0094C4 5C A1            [ 2]    1     ldw (N1,sp),x 
      0094C6 02 27            [ 2]  706 	ldw y,(YSAVE,sp) 
      0094C8 EC A1            [ 2]  707 	jra term01 
      0014F3                        708 term_exit:
      0014F3                        709 	_i16_fetch N1
      0094CA 05 27            [ 2]    1     ldw x,(N1,sp)
      0014F5                        710 	_drop VSIZE 
      0094CC 02 90            [ 2]    1     addw sp,#VSIZE 
      0094CE 5A               [ 4]  711 	ret 
                                    712 
                                    713 ;-------------------------------
                                    714 ;  expr ::= term [['+'|'-'] term]*
                                    715 ;  result range {-16777215..16777215}
                                    716 ;  output:
                                    717 ;     X   expression value     
                                    718 ;-------------------------------
                           000001   719 	N1=1 ;left operand 
                           000003   720 	YSAVE=N1+INT_SIZE ;   
                           000005   721 	OP=YSAVE+ADR_SIZE ; 1
                           000005   722 	VSIZE=INT_SIZE+ADR_SIZE+1
      0094CF                        723 expression:
      0014F8                        724 	_vars VSIZE 
      0094CF 84 81            [ 2]    1     sub sp,#VSIZE 
                                    725 ; first term 	
      0094D1 CD 14 B3         [ 4]  726 	call term
      0014FD                        727 	_i16_store N1 
      0094D1 81 01            [ 2]    1     ldw (N1,sp),x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 141.
Hexadecimal [24-Bits]



      0094D2                        728 1$:	; operator '+'|'-'
      0014FF                        729 	_next_token
      0014FF                          1         _get_char 
      0094D2 52 01            [ 1]    1         ld a,(y)    ; 1 cy 
      0094D4 0F 01            [ 1]    2         incw y      ; 1 cy 
      0094D6 90 F6            [ 1]  730 	ld (OP,sp),a 
      0094D8 90 5C            [ 1]  731 	cp a,#ADD_IDX 
      0094DA A1 01            [ 1]  732 	jreq 2$
      0094DC 22 03            [ 1]  733 	cp a,#SUB_IDX 
      0094DE CC 92            [ 1]  734 	jreq 2$ 
      00150D                        735 	_unget_token 
      0094E0 25 5A            [ 2]    1         decw y
      0094E1 20 1E            [ 2]  736 	jra 9$ 
      001511                        737 2$: ; second term 
      0094E1 A1 0B 27         [ 4]  738 	call term
      0094E4 06 A1            [ 2]  739 	ldw (YSAVE,sp),y 
      0094E6 0C               [ 1]  740 	exgw x,y 
      001517                        741 	_i16_fetch N1
      0094E7 26 06            [ 2]    1     ldw x,(N1,sp)
      0094E9 03 01            [ 2]  742 	ldw (N1,sp),y ; right operand   
      0094EB 7B 05            [ 1]  743 	ld a,(OP,sp)
      0094EB 90 F6            [ 1]  744 	cp a,#ADD_IDX 
      0094ED 90 5C            [ 1]  745 	jrne 4$
                                    746 ; '+' operator
      0094EF 72 FB 01         [ 2]  747 	ADDW X,(N1,SP)
      0094EF A1 08            [ 2]  748 	jra 5$ 
      001526                        749 4$:	; '-' operator 
      0094F1 26 08 93         [ 2]  750 	SUBW X,(N1,SP)
      001529                        751 5$:
      001529                        752 	_i16_store N1
      0094F4 FE 72            [ 2]    1     ldw (N1,sp),x 
      0094F6 A9 00            [ 2]  753 	ldw y,(YSAVE,sp)
      0094F8 02 20            [ 2]  754 	jra 1$
      00152F                        755 9$:
      00152F                        756 	_i16_fetch N1 
      0094FA 30 01            [ 2]    1     ldw x,(N1,sp)
      0094FB                        757 	_drop VSIZE 
      0094FB A1 07            [ 2]    1     addw sp,#VSIZE 
      0094FD 26               [ 4]  758 	ret 
                                    759 
                                    760 ;---------------------------------------------
                                    761 ; rel ::= expr [rel_op expr]
                                    762 ; rel_op ::=  '=','<','>','>=','<=','<>','><'
                                    763 ;  relation return  integer , zero is false 
                                    764 ;  output:
                                    765 ;	 X		relation result   
                                    766 ;---------------------------------------------
                                    767   ; local variables
                           000001   768 	N1=1 ; left expression 
                           000003   769 	YSAVE=N1+INT_SIZE   
                           000005   770 	REL_OP=YSAVE+ADR_SIZE  ;  
                           000005   771 	VSIZE=INT_SIZE+ADR_SIZE+1 ; bytes  
      001534                        772 relation: 
      001534                        773 	_vars VSIZE
      0094FE 08 90            [ 2]    1     sub sp,#VSIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 142.
Hexadecimal [24-Bits]



      009500 F6 90 5C         [ 4]  774 	call expression
      001539                        775 	_i16_store N1 
      009503 5F 97            [ 2]    1     ldw (N1,sp),x 
                                    776 ; expect rel_op or leave 
      00153B                        777 	_next_token 
      00153B                          1         _get_char 
      009505 20 24            [ 1]    1         ld a,(y)    ; 1 cy 
      009507 90 5C            [ 1]    2         incw y      ; 1 cy 
      009507 A1 09            [ 1]  778 	ld (REL_OP,sp),a 
      009509 26 09            [ 1]  779 	cp a,#REL_LE_IDX
      00950B CD 97            [ 1]  780 	jrmi 1$
      00950D ED CD            [ 1]  781 	cp a,#OP_REL_LAST 
      00950F 98 4C            [ 2]  782 	jrule 2$ 
      001549                        783 1$:	_unget_token 
      009511 FE 20            [ 2]    1         decw y
      009513 17 3C            [ 2]  784 	jra 9$ 
      009514                        785 2$:	; expect another expression
      009514 A1 04 26         [ 4]  786 	call expression
      009517 0C CD            [ 2]  787 	ldw (YSAVE,sp),y 
      009519 95               [ 1]  788 	exgw x,y 
      001553                        789 	_i16_fetch N1
      00951A 78 89            [ 2]    1     ldw x,(N1,sp)
      00951C A6 05            [ 2]  790 	ldw (N1,sp),y ; right expression  
      00951E CD 94            [ 2]  791 	cpw x,(N1,sp)
      009520 96 85            [ 1]  792 	jrslt 4$
      009522 20 07            [ 1]  793 	jrne 5$
                                    794 ; i1==i2 
      009524 7B 05            [ 1]  795 	ld a,(REL_OP,sp)
      009524 5F 97            [ 1]  796 	cp a,#REL_LT_IDX 
      009526 58 DE            [ 1]  797 	jrpl 7$ ; relation false 
      009528 8A AE            [ 2]  798 	jra 6$  ; relation true 
      001565                        799 4$: ; i1<i2
      00952A FD 05            [ 1]  800 	ld a,(REL_OP,sp)
      00952B A1 13            [ 1]  801 	cp a,#REL_LT_IDX 
      00952B 0D 01            [ 1]  802 	jreq 6$ ; relation true 
      00952D 27 01            [ 1]  803 	cp a,#REL_LE_IDX 
      00952F 50 10            [ 1]  804 	jreq 6$  ; relation true
      009530 20 0A            [ 2]  805 	jra 54$
      001571                        806 5$: ; i1>i2
      009530 5B 01            [ 1]  807 	ld a,(REL_OP,sp)
      009532 81 14            [ 1]  808 	cp a,#REL_GT_IDX 
      009533 27 08            [ 1]  809 	jreq 6$ ; relation true 
      009533 52 05            [ 1]  810 	cp a,#REL_GE_IDX 
      009535 CD 94            [ 1]  811 	jreq 6$ ; relation true 
      00157B                        812 54$:
      009537 D2 1F            [ 1]  813 	cp a,#REL_NE_IDX 
      009539 01 05            [ 1]  814 	jrne 7$ ; relation false 
      00953A                        815 6$: ; TRUE  ; relation true 
      00953A 90 F6 90         [ 2]  816 	LDW X,#-1
      00953D 5C 6B            [ 2]  817 	jra 8$ 
      001584                        818 7$:	; FALSE 
      00953F 05               [ 1]  819 	clrw x
      001585                        820 8$: 
      009540 A1 0D            [ 2]  821 	ldw y,(YSAVE,sp) 
      009542 2B 04            [ 2]  822 	jra 10$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 143.
Hexadecimal [24-Bits]



      001589                        823 9$:	
      001589                        824 	_i16_fetch N1
      009544 A1 0F            [ 2]    1     ldw x,(N1,sp)
      00158B                        825 10$:
      00158B                        826 	_drop VSIZE
      009546 23 04            [ 2]    1     addw sp,#VSIZE 
      009548 90               [ 4]  827 	ret 
                                    828 
                                    829 
                                    830 ;-------------------------------------------
                                    831 ;  AND factor:  [NOT] relation 
                                    832 ;  output:
                                    833 ;     X      boolean value 
                                    834 ;-------------------------------------------
                           000001   835 	NOT_OP=1
      00158E                        836 and_factor:
      009549 5A 20            [ 1]  837 	push #0 
      001590                        838 0$:	_next_token  
      001590                          1         _get_char 
      00954B 27 F6            [ 1]    1         ld a,(y)    ; 1 cy 
      00954C 90 5C            [ 1]    2         incw y      ; 1 cy 
      00954C CD 94            [ 1]  839 	cp a,#CMD_END 
      00954E D2 17            [ 1]  840 	jrugt 1$
      009550 03 16 01         [ 2]  841 	jp syntax_error
      009553 7B 05            [ 1]  842 1$:	cp a,#NOT_IDX  
      009555 A1 0F            [ 1]  843 	jrne 2$ 
      009557 26 05            [ 1]  844 	cpl (NOT_OP,sp)
      0015A1                        845 	_next_token
      0015A1                          1         _get_char 
      009559 CD 83            [ 1]    1         ld a,(y)    ; 1 cy 
      00955B C7 20            [ 1]    2         incw y      ; 1 cy 
      00955D 0F A1            [ 2]  846 	jra 4$
      0015A7                        847 2$:
      0015A7                        848 	_unget_token 
      00955F 0D 26            [ 2]    1         decw y
      0015A9                        849 4$:
      009561 06 51 CD         [ 4]  850 	call relation 	
      0015AC                        851 5$:	
      009564 84 6E            [ 1]  852 	tnz (NOT_OP,sp)
      009566 20 05            [ 1]  853 	jreq 8$ 
      009568 53               [ 2]  854 	CPLW X 
      0015B1                        855 8$:
      0015B1                        856 	_drop 1  
      009568 51 CD            [ 2]    1     addw sp,#1 
      00956A 84               [ 4]  857     ret 
                                    858 
                                    859 
                                    860 ;--------------------------------------------
                                    861 ;  AND operator as priority over OR||XOR 
                                    862 ;  format: and_factor [AND and_factor]*
                                    863 ;          
                                    864 ;  output:
                                    865 ;    X      boolean value  
                                    866 ;--------------------------------------------
                           000001   867 	B1=1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 144.
Hexadecimal [24-Bits]



                           000002   868 	VSIZE=INT_SIZE 
      0015B4                        869 and_cond:
      0015B4                        870 	_vars VSIZE 
      00956B 6E 51            [ 2]    1     sub sp,#VSIZE 
      00956D CD 15 8E         [ 4]  871 	call and_factor
      0015B9                        872 	_i16_store B1 
      00956D 1F 01            [ 2]    1     ldw (B1,sp),x 
      0015BB                        873 1$: _next_token 
      0015BB                          1         _get_char 
      00956F 16 03            [ 1]    1         ld a,(y)    ; 1 cy 
      009571 20 C7            [ 1]    2         incw y      ; 1 cy 
      009573 A1 17            [ 1]  874 	cp a,#AND_IDX  
      009573 1E 01            [ 1]  875 	jreq 3$  
      0015C3                        876 	_unget_token 
      009575 5B 05            [ 2]    1         decw y
      009577 81 0E            [ 2]  877 	jra 9$ 
      009578 CD 15 8E         [ 4]  878 3$:	call and_factor  
      009578 52               [ 1]  879 	rlwa x 
      009579 05 CD            [ 1]  880 	and a,(B1,sp)
      00957B 95               [ 1]  881 	rlwa x 
      00957C 33 1F            [ 1]  882 	and a, (B1+1,sp)
      00957E 01               [ 1]  883 	rlwa x 
      00957F                        884 	_i16_store B1 
      00957F 90 F6            [ 2]    1     ldw (B1,sp),x 
      009581 90 5C            [ 2]  885 	jra 1$  
      0015D5                        886 9$:	
      0015D5                        887 	_i16_fetch B1 
      009583 6B 05            [ 2]    1     ldw x,(B1,sp)
      0015D7                        888 	_drop VSIZE 
      009585 A1 0B            [ 2]    1     addw sp,#VSIZE 
      009587 27               [ 4]  889 	ret 	 
                                    890 
                                    891 ;--------------------------------------------
                                    892 ; condition for IF and UNTIL 
                                    893 ; operators: OR,XOR 
                                    894 ; format:  and_cond [ OP and_cond ]* 
                                    895 ; output:
                                    896 ;    stack   value 
                                    897 ;--------------------------------------------
                           000001   898 	B1=1 ; left bool 
                           000003   899 	OP=B1+INT_SIZE ; 1 bytes 
                           000003   900 	VSIZE=INT_SIZE+1
      0015DA                        901 condition:
      0015DA                        902 	_vars VSIZE 
      009588 08 A1            [ 2]    1     sub sp,#VSIZE 
      00958A 0C 27 04         [ 4]  903 	call and_cond
      0015DF                        904 	_i16_store B1
      00958D 90 5A            [ 2]    1     ldw (B1,sp),x 
      0015E1                        905 1$:	_next_token 
      0015E1                          1         _get_char 
      00958F 20 1E            [ 1]    1         ld a,(y)    ; 1 cy 
      009591 90 5C            [ 1]    2         incw y      ; 1 cy 
      009591 CD 95            [ 1]  906 	cp a,#OR_IDX  
      009593 33 17            [ 1]  907 	jreq 2$
                           000000   908 .if 0	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 145.
Hexadecimal [24-Bits]



                                    909 	cp a,#XOR_IDX 
                                    910 	jreq 2$
                                    911 .endif
      0015E9                        912 	_unget_token 
      009595 03 51            [ 2]    1         decw y
      009597 1E 01            [ 2]  913 	jra 9$ 
      009599 17 01            [ 1]  914 2$:	ld (OP,sp),a ; boolean operator  
      00959B 7B 05 A1         [ 4]  915 	call and_cond
      00959E 0B 26            [ 1]  916 	ld a,(OP,sp)
                           000000   917 .if 0
                                    918 	cp a,#XOR_IDX  
                                    919 	jreq 5$
                                    920 .endif  
      0015F4                        921 4$: ; B1 = B1 OR X   
      0095A0 05               [ 1]  922 	rlwa x 
      0095A1 72 FB            [ 1]  923 	or a,(B1,SP)
      0095A3 01               [ 1]  924 	rlwa x 
      0095A4 20 03            [ 1]  925 	or a,(B1+1,SP) 
      0095A6 02               [ 1]  926 	rlwa x 
      0095A6 72 F0            [ 2]  927 	jra 6$  
      0015FD                        928 5$: ; B1 = B1 XOR X 
      0095A8 01               [ 1]  929 	RLWA X 
      0095A9 18 01            [ 1]  930 	XOR A,(B1,SP)
      0095A9 1F               [ 1]  931 	RLWA X 
      0095AA 01 16            [ 1]  932 	XOR A,(B1+1,SP)
      0095AC 03               [ 1]  933 	RLWA X 
      001604                        934 6$: 
      001604                        935 	_i16_store B1 
      0095AD 20 D0            [ 2]    1     ldw (B1,sp),x 
      0095AF 20 D9            [ 2]  936 	jra 1$ 
      001608                        937 9$:	 
      001608                        938 	_i16_fetch B1 ; result in X 
      0095AF 1E 01            [ 2]    1     ldw x,(B1,sp)
      00160A                        939 	_drop VSIZE
      0095B1 5B 05            [ 2]    1     addw sp,#VSIZE 
      0095B3 81               [ 4]  940 	ret 
                                    941 
                           000000   942 .if 0
                                    943 ;--------------------------------------------
                                    944 ; BASIC: HEX 
                                    945 ; select hexadecimal base for integer print
                                    946 ;---------------------------------------------
                                    947 cmd_hex_base:
                                    948 	mov base,#16 
                                    949 	_next  
                                    950 
                                    951 ;--------------------------------------------
                                    952 ; BASIC: DEC 
                                    953 ; select decimal base for integer print
                                    954 ;---------------------------------------------
                                    955 cmd_dec_base:
                                    956 	mov base,#10
                                    957 	_next 
                                    958 
                                    959 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 146.
Hexadecimal [24-Bits]



                                    960 ;------------------------------
                                    961 ; BASIC: SIZE 
                                    962 ; command that print 
                                    963 ; program start addres and size 
                                    964 ;------------------------------
                                    965 cmd_size:
                                    966 	push base 
                                    967 	ldw x,#PROG_ADDR 
                                    968 	call puts 
                                    969 	_ldxz lomem     
                                    970 	mov base,#16 
                                    971 	call print_int
                                    972 	ldw x,#PROG_SIZE 
                                    973 	call puts 
                                    974 	_ldxz himem 
                                    975 	subw x,lomem 
                                    976 	mov base,#10 
                                    977 	call print_int
                                    978 	ldw x,#STR_BYTES 
                                    979 	call puts  
                                    980 	pop base 
                                    981 	_next 
                                    982 
                                    983 .endif 
                                    984 
                                    985 
                                    986 ;-----------------------------
                                    987 ; BASIC: LET var=expr 
                                    988 ; variable assignement 
                                    989 ; output:
                                    990 ;-----------------------------
                           000001   991 	VAR_ADR=1  ; 2 bytes 
                           000003   992 	VALUE=VAR_ADR+2 ;INT_SIZE 
                           000004   993 	VSIZE=2*INT_SIZE 
      0095B4                        994 kword_let::
      00160D                        995 	_vars VSIZE 
      0095B4 52 05            [ 2]    1     sub sp,#VSIZE 
      00160F                        996 	_next_token ; VAR_IDX || STR_VAR_IDX 
      00160F                          1         _get_char 
      0095B6 CD 95            [ 1]    1         ld a,(y)    ; 1 cy 
      0095B8 78 1F            [ 1]    2         incw y      ; 1 cy 
      0095BA 01 90            [ 1]  997 	cp a,#VAR_IDX
      0095BC F6 90            [ 1]  998 	jreq let_int_var
      0095BE 5C 6B            [ 1]  999 	cp a,#STR_VAR_IDX 
      0095C0 05 A1            [ 1] 1000 	jreq let_string
      0095C2 10 2B 04         [ 2] 1001 	jp syntax_error
      00161E                       1002 kword_let2: 	
      00161E                       1003 	_vars VSIZE 
      0095C5 A1 15            [ 2]    1     sub sp,#VSIZE 
      001620                       1004 let_int_var:
      0095C7 23 04 90         [ 4] 1005 	call get_var_adr  
      0095CA 5A 20 3C         [ 4] 1006 	call get_array_adr
      0095CD 1F 01            [ 2] 1007 	ldw (VAR_ADR,sp),x 
      0095CD CD 95            [ 1] 1008 	ld a,#REL_EQU_IDX 
      0095CF 78 17 03         [ 4] 1009 	call expect 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 147.
Hexadecimal [24-Bits]



                                   1010 ; var assignment 
      0095D2 51 1E 01         [ 4] 1011 	call condition
      001630                       1012 	_i16_store VALUE
      0095D5 17 01            [ 2]    1     ldw (VALUE,sp),x 
      0095D7 13 01            [ 2] 1013 	ldw x,(VAR_ADR,sp) 
      0095D9 2F 0A            [ 1] 1014 	ld a,(VALUE,sp)
      0095DB 26               [ 1] 1015 	ld (x),a 
      0095DC 14 7B            [ 1] 1016 	ld a,(VALUE+1,sp)
      0095DE 05 A1            [ 1] 1017 	ld (1,x),a 
      00163B                       1018 9$: _drop VSIZE 	
      0095E0 13 2A            [ 2]    1     addw sp,#VSIZE 
      00163D                       1019 	_next  
      0095E2 21 20 1A         [ 2]    1         jp interp_loop 
                                   1020 
                                   1021 
                                   1022 ;-----------------------
                                   1023 ; BASIC: LET l$="string" 
                                   1024 ;        ||  l$="string"
                                   1025 ;------------------------
                           000001  1026 	TEMP=1 ; temporary storage 
                           000003  1027 	DEST_SIZE=TEMP+2 
                           000005  1028 	DEST_ADR=DEST_SIZE+2  
                           000007  1029 	SRC_ADR=DEST_ADR+2 
                           000009  1030 	SIZE=SRC_ADR+2 
                           00000A  1031 	VSIZE2=SIZE+1
      0095E5                       1032 let_string:
      001640                       1033 	_drop VSIZE
      0095E5 7B 05            [ 2]    1     addw sp,#VSIZE 
      001642                       1034 let_string2:	 
      001642                       1035 	_vars VSIZE2 
      0095E7 A1 13            [ 2]    1     sub sp,#VSIZE2 
      0095E9 27 14            [ 1] 1036 	clr (SIZE,sp)
      0095EB A1 10            [ 1] 1037 	clr (DEST_SIZE,sp)
      0095ED 27 10 20         [ 4] 1038 	call get_var_adr 
      0095F0 0A 01            [ 2] 1039 	ldw (TEMP,sp),x 
      0095F1 EE 02            [ 2] 1040 	ldw x,(2,x)
      0095F1 7B               [ 1] 1041 	ld a,(x)
      0095F2 05               [ 1] 1042 	incw x 
      0095F3 A1 14            [ 2] 1043 	ldw (DEST_ADR,sp),x 
      0095F5 27 08            [ 1] 1044 	ld (DEST_SIZE+1,sp),a 
      0095F7 A1 12            [ 2] 1045 	ldw x,(TEMP,sp) ; var address 
      0095F9 27 04 BF         [ 4] 1046 	call get_string_slice 
      0095FB 1F 01            [ 2] 1047 	ldw (TEMP,sp),x ; slice address 
      0095FB A1 15 26         [ 2] 1048 	subw x,(DEST_ADR,sp) ; count character skipped 
      0095FE 05 F0 03         [ 2] 1049 	subw x,(DEST_SIZE,sp)
      0095FF 50               [ 2] 1050 	negw x  
      0095FF AE FF            [ 2] 1051 	ldw (DEST_SIZE,sp),x ; space left in array 
      009601 FF 20            [ 2] 1052 	ldw x,(TEMP,sp)
      009603 01 05            [ 2] 1053 	ldw (DEST_ADR,sp),x 
      009604 A6 11            [ 1] 1054 	ld a,#REL_EQU_IDX 
      009604 5F 14 16         [ 4] 1055 	call expect 
      009605 90 F6            [ 1] 1056 	ld a,(y)
      009605 16 03            [ 1] 1057 	cp a,#QUOTE_IDX
      009607 20 02            [ 1] 1058 	jrne 4$
      009609 90 5C            [ 1] 1059 	incw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 148.
Hexadecimal [24-Bits]



      009609 1E               [ 1] 1060 	ldw x,y
      00960A 01 07            [ 2] 1061 	ldw (SRC_ADR,sp),x  
      00960B CD 08 06         [ 4] 1062 	call strlen  ; copy count 
      00960B 5B 05            [ 1] 1063 	ld (SIZE+1,sp),a
      00960D 81 F9 09         [ 2] 1064 	addw y,(SIZE,sp)
      00960E 90 5C            [ 1] 1065 	incw y 
      00960E 4B 00            [ 2] 1066 	ldw x,(DEST_SIZE,sp)
      009610 90 F6            [ 2] 1067 	cpw x,(SIZE,sp) 
      009612 90 5C            [ 1] 1068 	jruge 1$ 
      009614 A1 01            [ 1] 1069 0$:	ld a,#ERR_STR_OVFL 
      009616 22 03 CC         [ 2] 1070 	jp tb_error 
      00168E                       1071 1$: 
      009619 92 25            [ 2] 1072 	ldw x,(SIZE,sp) 
      001690                       1073 	_strxz acc16 
      00961B A1 16                    1     .byte 0xbf,acc16 
      00961D 26 08            [ 2] 1074 	jra 5$ 
      001694                       1075 4$: ; VAR$ expression 
      00961F 03 01            [ 1] 1076 	ld a,#STR_VAR_IDX
      009621 90 F6 90         [ 4] 1077 	call expect 
      009624 5C 20 02         [ 4] 1078 	call get_var_adr 
      009627 CD 16 BF         [ 4] 1079 	call get_string_slice
      009627 90 5A            [ 2] 1080 	ldw (SRC_ADR,sp),x   
      009629                       1081 	_clrz acc16 
      009629 CD 95                    1     .byte 0x3f, acc16 
      0016A3                       1082 	_straz acc8 
      00962B B4 19                    1     .byte 0xb7,acc8 
      00962C 6B 0A            [ 1] 1083 	ld (SIZE+1,sp),a 
      00962C 0D 01            [ 1] 1084 	cp a,(DEST_SIZE+1,sp)
      00962E 27 01            [ 1] 1085 	jrugt 0$
      0016AB                       1086 5$:
      009630 53 05            [ 2] 1087 	ldw x,(DEST_ADR,sp) 
      009631 17 01            [ 2] 1088 	ldw (TEMP,sp),y ; save basic pc   
      009631 5B 01            [ 2] 1089 	ldw y,(SRC_ADR,sp)
      009633 81 08 30         [ 4] 1090 	call move 
      009634 72 FB 09         [ 2] 1091 	addw x,(SIZE,sp)
      009634 52               [ 1] 1092 	clr (x)
      0016B8                       1093 6$: 
      009635 02 CD            [ 2] 1094 	ldw y,(TEMP,sp) ; restore basic pc 
      0016BA                       1095 9$:	_drop VSIZE2 
      009637 96 0E            [ 2]    1     addw sp,#VSIZE2 
      0016BC                       1096 	_next 
      009639 1F 01 90         [ 2]    1         jp interp_loop 
                                   1097 
                                   1098 ;----------------------
                                   1099 ; extract a slice 
                                   1100 ; from string variable
                                   1101 ; str(val1[,val2]) 
                                   1102 ; or complete string 
                                   1103 ; if no indices 
                                   1104 ; input:
                                   1105 ;   X     var_adr
                                   1106 ;   Y     point to (expr,expr)
                                   1107 ;   ptr16 destination
                                   1108 ; ouput:
                                   1109 ;   A    slice length 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 149.
Hexadecimal [24-Bits]



                                   1110 ;   X    slice address   
                                   1111 ;----------------------
                           000001  1112 	VAL2=1 
                           000003  1113 	VAL1=VAL2+INT_SIZE 
                           000005  1114 	CHAR_ARRAY=VAL1+INT_SIZE 
                           000007  1115 	RES_LEN=CHAR_ARRAY+INT_SIZE  
                           000009  1116 	YTEMP=RES_LEN+INT_SIZE 
                           000008  1117 	VSIZE=4*INT_SIZE 
      0016BF                       1118 get_string_slice:
      0016BF                       1119 	_vars VSIZE
      00963C F6 90            [ 2]    1     sub sp,#VSIZE 
      00963E 5C A1            [ 1] 1120 	clr (RES_LEN,sp)
      009640 17 27            [ 2] 1121 	ldw x,(2,x) ; char array 
      009642 04 90            [ 2] 1122 	ldw (CHAR_ARRAY,sp),x 
      009644 5A               [ 1] 1123 	ld a,(x)
      009645 20 0E            [ 1] 1124 	ld (RES_LEN+1,sp),a ; reserved space  
                                   1125 ; default slice to entire string 
      009647 CD 96            [ 1] 1126 	clr (VAL1,sp)
      009649 0E 02            [ 1] 1127 	ld a,#1 
      00964B 14 01            [ 1] 1128 	ld (VAL1+1,sp),a
      00964D 02 14            [ 1] 1129 	clr (VAL2,sp)
      00964F 02               [ 1] 1130 	incw x 
      009650 02 1F 01         [ 4] 1131 	call strlen
      009653 20 E6            [ 1] 1132 	ld (VAL2+1,sp),a 
      009655 90 F6            [ 1] 1133 	ld a,(y)
      009655 1E 01            [ 1] 1134 	cp a,#LPAREN_IDX 
      009657 5B 02            [ 1] 1135 	jreq 1$
      009659 81 32            [ 2] 1136 	jra 4$  
      00965A                       1137 1$:  
      00965A 52 03            [ 1] 1138 	incw y 
      00965C CD 96 34         [ 4] 1139 	call expression
      00965F 1F 01 90         [ 2] 1140 	cpw x,#1 
      009662 F6 90            [ 1] 1141 	jrpl 2$ 
      009664 5C A1            [ 1] 1142 0$:	ld a,#ERR_STR_OVFL 
      009666 18 27 04         [ 2] 1143 	jp tb_error 
      009669 90 5A            [ 2] 1144 2$:	cpw x,(VAL2,sp)
      00966B 20 1B            [ 1] 1145 	jrugt 0$ 
      00966D 6B 03            [ 2] 1146 	ldw (VAL1,sp),x 
      00966F CD 96            [ 1] 1147 	ld a,(y)
      009671 34 7B            [ 1] 1148 	cp a,#RPAREN_IDX 
      009673 03 04            [ 1] 1149 	jrne 3$
      009674 90 5C            [ 1] 1150 	incw y 
      009674 02 1A            [ 2] 1151 	jra 4$
      0016FF                       1152 3$: 
      009676 01 02            [ 1] 1153 	ld a,#COMMA_IDX 
      009678 1A 02 02         [ 4] 1154 	call expect 
      00967B 20 07 F8         [ 4] 1155 	call expression 
      00967D 13 01            [ 2] 1156 	cpw x,(VAL2,sp)
      00967D 02 18            [ 1] 1157 	jrugt 0$ 
      00967F 01 02            [ 2] 1158 	ldw (VAL2,sp),x
      009681 18 02            [ 1] 1159 	ld a,#RPAREN_IDX 
      009683 02 14 16         [ 4] 1160 	call expect 
      009684                       1161 4$: ; length and slice address 
      009684 1F 01            [ 2] 1162 	ldw x,(VAL2,sp)
      009686 20 D9 03         [ 2] 1163 	subw x,(VAL1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 150.
Hexadecimal [24-Bits]



      009688 5C               [ 1] 1164 	incw x 
      009688 1E               [ 1] 1165 	ld a,xl ; slice length 
      009689 01 5B            [ 2] 1166 	ldw x,(CHAR_ARRAY,sp)
      00968B 03 81 03         [ 2] 1167 	addw x,(VAL1,sp)
      00968D                       1168 	_drop VSIZE 
      00968D 52 04            [ 2]    1     addw sp,#VSIZE 
      00968F 90               [ 4] 1169 	ret 
                                   1170 
                                   1171 
                                   1172 ;-----------------------
                                   1173 ; allocate data space 
                                   1174 ; on heap 
                                   1175 ; reserve to more bytes 
                                   1176 ; than required 
                                   1177 ; input: 
                                   1178 ;    X     size 
                                   1179 ; output:
                                   1180 ;    X     addr 
                                   1181 ;------------------------
      001721                       1182 heap_alloc:
      009690 F6 90 5C         [ 2] 1183 	addw x,#2 
      009693 A1               [ 2] 1184 	pushw x 
      009694 09 27 09         [ 2] 1185 	ldw x,heap_free 
      009697 A1 0A 27 25      [ 2] 1186 	subw x,dvar_end 
      00969B CC 92            [ 2] 1187 	cpw x,(1,sp)
      00969D 25 05            [ 1] 1188 	jruge 1$
      00969E A6 0A            [ 1] 1189 	ld a,#ERR_MEM_FULL 
      00969E 52 04 A7         [ 2] 1190 	jp tb_error 
      0096A0 CE 00 39         [ 2] 1191 1$: ldw x,heap_free 
      0096A0 CD 97 ED         [ 2] 1192 	subw x,(1,sp)
      00173B                       1193 	_strxz heap_free 
      0096A3 CD 98                    1     .byte 0xbf,heap_free 
      00173D                       1194 	_drop 2 
      0096A5 4C 1F            [ 2]    1     addw sp,#2 
      0096A7 01               [ 4] 1195 	ret 
                                   1196 
                                   1197 ;---------------------------
                                   1198 ; create scalar variable 
                                   1199 ; and initialize to 0.
                                   1200 ; abort program if mem full 
                                   1201 ; input:
                                   1202 ;   x    var_name 
                                   1203 ; output:
                                   1204 ;   x    var_addr 
                                   1205 ;-----------------------------
                           000001  1206 	VNAME=1 
                           000002  1207 	VSIZE=2 
      001740                       1208 create_var:
      001740                       1209 	_vars VSIZE 
      0096A8 A6 11            [ 2]    1     sub sp,#VSIZE 
      0096AA CD 94            [ 2] 1210 	ldw (VNAME,sp),x 
      0096AC 96 CD 96         [ 2] 1211 	ldw x,heap_free 
      0096AF 5A 1F 03 1E      [ 2] 1212 	subw x,dvar_end 
      0096B3 01 7B 03         [ 2] 1213 	cpw x,#4 
      0096B6 F7 7B            [ 1] 1214 	jruge 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 151.
Hexadecimal [24-Bits]



      0096B8 04 E7            [ 1] 1215 	ld a,#ERR_MEM_FULL
      0096BA 01 5B 04         [ 2] 1216 	jp tb_error 
      001755                       1217 1$: 
      0096BD CC 93 A6         [ 2] 1218 	ldw x,dvar_end 
      0096C0 7B 01            [ 1] 1219 	ld a,(VNAME,sp)
      0096C0 5B               [ 1] 1220 	ld (x),a 
      0096C1 04 02            [ 1] 1221 	ld a,(VNAME+1,sp)
      0096C2 E7 01            [ 1] 1222 	ld (1,x),a 
      0096C2 52 0A            [ 1] 1223 	clr (2,x)
      0096C4 0F 09            [ 1] 1224 	clr (3,x)
      0096C6 0F               [ 2] 1225 	pushw x 
      0096C7 03 CD 97         [ 2] 1226 	addw x,#4 
      001767                       1227 	_strxz dvar_end 
      0096CA ED 1F                    1     .byte 0xbf,dvar_end 
      0096CC 01               [ 2] 1228 	popw x ; var address 
      00176A                       1229 	_drop VSIZE  
      0096CD EE 02            [ 2]    1     addw sp,#VSIZE 
      0096CF F6               [ 4] 1230 	ret 
                                   1231 
                                   1232 ;------------------------
                                   1233 ; last token was VAR_IDX 
                                   1234 ; next is VAR_NAME 
                                   1235 ; extract name
                                   1236 ; search var 
                                   1237 ; return data field address 
                                   1238 ; input:
                                   1239 ;   Y      *var_name 
                                   1240 ; output:
                                   1241 ;   y       Y+2 
                                   1242 ;   X       var address
                                   1243 ; ------------------------
                           000001  1244 	F_ARRAY=1
                           000002  1245 	VNAME=2 
                           000003  1246 	VSIZE=3 
      00176D                       1247 get_var_adr:
      00176D                       1248 	_vars VSIZE
      0096D0 5C 1F            [ 2]    1     sub sp,#VSIZE 
      0096D2 05 6B            [ 1] 1249 	clr (F_ARRAY,sp)
      001771                       1250 	_get_word 
      001771                          1         _get_addr
      0096D4 04               [ 1]    1         ldw x,y     ; 1 cy 
      0096D5 1E               [ 2]    2         ldw x,(x)   ; 2 cy 
      0096D6 01 CD 97 3F      [ 2]    3         addw y,#2   ; 2 cy 
      0096DA 1F 01            [ 2] 1251 	ldw (VNAME,sp),x 
      0096DC 72 F0            [ 1] 1252 	ld a,(y) 
      0096DE 05 72            [ 1] 1253 	cp a,#LPAREN_IDX 
      0096E0 F0 03            [ 1] 1254 	jrne 1$ 
      0096E2 50 1F            [ 1] 1255 	cpl (F_ARRAY,sp)
      0096E4 03               [ 1] 1256 	ld  a,xh 
      0096E5 1E 01            [ 1] 1257 	or a,#128 
      0096E7 1F               [ 1] 1258 	ld xh,a 
      0096E8 05 A6            [ 1] 1259 	ld (VNAME,sp),a 
      001787                       1260 1$: 
      0096EA 11 CD 94         [ 4] 1261 	call search_var
      0096ED 96               [ 2] 1262 	tnzw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 152.
Hexadecimal [24-Bits]



      0096EE 90 F6            [ 1] 1263 	jrne 9$ ; found 
                                   1264 ; not found, if scalar create it 
      0096F0 A1 06            [ 1] 1265 	tnz (F_ARRAY,sp)
      0096F2 26 20            [ 1] 1266 	jreq 2$ 
                                   1267 ; this array doesn't exist
                                   1268 ; check for var(1) form 
      0096F4 90 5C 93         [ 4] 1269 	call check_for_idx_1
      001794                       1270 2$:	 	
      0096F7 1F 07            [ 1] 1271 	ld a,(VNAME+1,sp)
      0096F9 CD 88            [ 1] 1272 	cp a,#'$ 
      0096FB 86 6B            [ 1] 1273 	jrne 8$
      0096FD 0A 72            [ 1] 1274 	ld a,#ERR_DIM 
      0096FF F9 09 90         [ 2] 1275 	jp tb_error
      00179F                       1276 8$:	
      009702 5C 1E            [ 2] 1277 	ldw x,(VNAME,sp)
                                   1278 ; it's not an array 
      009704 03               [ 1] 1279 	ld a,xh 
      009705 13 09            [ 1] 1280 	and a,#127 
      009707 24               [ 1] 1281 	ld xh,a 
      009708 05 A6 0E         [ 4] 1282 	call create_var	
      0017A8                       1283 9$:
      0017A8                       1284 	_drop VSIZE 
      00970B CC 92            [ 2]    1     addw sp,#VSIZE 
      00970D 27               [ 4] 1285 	ret 
                                   1286 
                                   1287 ;-------------------------
                                   1288 ; a scalar variable can be 
                                   1289 ; addressed as var(1)
                                   1290 ; check for it 
                                   1291 ; fail if not that form 
                                   1292 ; input: 
                                   1293 ;   X     var address 
                                   1294 ;   Y     *next token after varname
                                   1295 ;-------------------------
      00970E                       1296 check_for_idx_1: 
      00970E 1E 09 BF         [ 2] 1297 	addw x,#2 ; 
      009711 18               [ 2] 1298 	pushw x ; save value  
      009712 20 17            [ 1] 1299 	ld a,(y)
      009714 A1 04            [ 1] 1300 	cp a,#LPAREN_IDX 
      009714 A6 0A            [ 1] 1301 	jrne 3$ 
      009716 CD 94 96         [ 4] 1302 	call func_args 
      009719 CD 97            [ 1] 1303 	cp a,#1 
      00971B ED CD            [ 1] 1304 	jreq 2$
      00971D 97 3F 1F         [ 2] 1305 1$:	jp syntax_error  
      0017BF                       1306 2$:
      0017BF                       1307 	_i16_pop 
      009720 07               [ 2]    1     popw x 
      009721 3F 18 B7         [ 2] 1308 	cpw x,#1 
      009724 19 6B            [ 1] 1309 	jreq 3$
      009726 0A 11            [ 1] 1310 	ld a,#ERR_RANGE  
      009728 04 22 DE         [ 4] 1311 	call tb_error  
      00972B                       1312 3$:
      00972B 1E               [ 2] 1313 	popw x 
      00972C 05               [ 4] 1314     ret 
                                   1315 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 153.
Hexadecimal [24-Bits]



                                   1316 
                                   1317 ;--------------------------
                                   1318 ; get array element address
                                   1319 ; input:
                                   1320 ;   X     var addr  
                                   1321 ; output:
                                   1322 ;    X     element address 
                                   1323 ;---------------------------
                           000001  1324 	IDX=1 
                           000003  1325 	SIZE_FIELD=IDX+INT_SIZE 
                           000004  1326 	VSIZE=2*INT_SIZE 
      0017CC                       1327 get_array_adr:
      0017CC                       1328 	_vars VSIZE
      00972D 17 01            [ 2]    1     sub sp,#VSIZE 
      00972F 16               [ 1] 1329 	tnz (x)
      009730 07 CD            [ 1] 1330 	jrmi 10$ 
                                   1331 ; scalar data field follow name
                                   1332 ; check for 'var(1)' format 	
      009732 88 B0 72         [ 4] 1333 	call check_for_idx_1
      009735 FB 09            [ 2] 1334 	jra 9$ 
      0017D6                       1335 10$:	 
      009737 7F 02            [ 2] 1336 	ldw x,(2,x) ; array data address 
      009738 1F 03            [ 2] 1337 	ldw (SIZE_FIELD,sp),x ; array size field 
      009738 16 01            [ 1] 1338 	ld a,(y)
      00973A 5B 0A            [ 1] 1339 	cp a,#LPAREN_IDX  
      00973C CC 93            [ 1] 1340 	jreq 0$ 
      00973E A6 00 02         [ 2] 1341 	addw x,#2 
      00973F 20 22            [ 2] 1342 	jra 9$ 
      0017E5                       1343 0$:
      00973F 52 08 0F         [ 4] 1344 	call func_args 
      009742 07 EE            [ 1] 1345 	cp a,#1 
      009744 02 1F            [ 1] 1346 	jreq 1$ 
      009746 05 F6 6B         [ 2] 1347 	jp syntax_error 
      0017EF                       1348 1$: _i16_pop 
      009749 08               [ 2]    1     popw x 
      00974A 0F               [ 2] 1349 	tnzw x 
      00974B 03 A6            [ 1] 1350 	jreq 2$ 
      00974D 01 6B            [ 2] 1351 	ldw (IDX,sp),x 
      00974F 04 0F            [ 2] 1352 	ldw x,(SIZE_FIELD,sp)
      009751 01               [ 2] 1353 	ldw x,(x) ; array size 
      009752 5C CD            [ 2] 1354 	cpw x,(IDX,sp)
      009754 88 86            [ 1] 1355 	jrpl 3$ 
      0017FC                       1356 2$: 
      009756 6B 02            [ 1] 1357 	ld a,#ERR_RANGE 
      009758 90 F6 A1         [ 2] 1358 	jp tb_error 
      001801                       1359 3$: 
      00975B 04 27            [ 2] 1360 	ldw x,(IDX,sp) 
      00975D 02               [ 2] 1361 	sllw x ; 2*IDX  
      00975E 20 32 03         [ 2] 1362 	addw x,(SIZE_FIELD,sp)
      009760                       1363 9$:
      001807                       1364 	_drop VSIZE 
      009760 90 5C            [ 2]    1     addw sp,#VSIZE 
      009762 CD               [ 4] 1365 	ret 
                                   1366 
                                   1367 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 154.
Hexadecimal [24-Bits]



                                   1368 
                           000000  1369 .if 0
                                   1370 ;--------------------------
                                   1371 ; return constant/dvar value 
                                   1372 ; from it's record address
                                   1373 ; input:
                                   1374 ;	X	*record 
                                   1375 ; output:
                                   1376 ;   X   value
                                   1377 ;--------------------------
                                   1378 get_value: ; -- i 
                                   1379 	ld a,(x) ; record size 
                                   1380 	and a,#NAME_MAX_LEN
                                   1381 	add a,#2 
                                   1382 	push a 
                                   1383 	push #0 
                                   1384 	addw x,(1,sp)
                                   1385 	ldw x,(x)
                                   1386 	_drop 2
                                   1387 	ret 
                                   1388 .endif 
                                   1389 
                                   1390 
                           000000  1391 .if 0
                                   1392 ;--------------------------
                                   1393 ; BASIC: EEFREE 
                                   1394 ; eeprom_free 
                                   1395 ; search end of data  
                                   1396 ; in EEPROM 
                                   1397 ; input:
                                   1398 ;    none 
                                   1399 ; output:
                                   1400 ;    A:X     address free
                                   1401 ;-------------------------
                                   1402 func_eefree:
                                   1403 eefree:
                                   1404 	ldw x,#EEPROM_BASE 
                                   1405 1$:	mov acc8,#8 ; count 8 consecutive zeros
                                   1406     cpw x,#EEPROM_BASE+EEPROM_SIZE-8
                                   1407 	jruge 8$ ; no free space 
                                   1408 2$: ld a,(x)
                                   1409 	jrne 3$
                                   1410 	incw x 
                                   1411 	dec acc8 
                                   1412 	jrne 2$
                                   1413 	subw x,#8 
                                   1414 	jra 9$  
                                   1415 3$: ld a,(x)
                                   1416 	incw x
                                   1417 	tnz a  
                                   1418 	jrne 3$
                                   1419 	decw x   
                                   1420 	jra 1$ 
                                   1421 8$: clrw x ; no free space 
                                   1422 9$: clr a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 155.
Hexadecimal [24-Bits]



                                   1423 	ldw free_eeprom,x ; save in system variable 
                                   1424 	ret 
                                   1425 .endif 
                                   1426 
                                   1427 
                                   1428 ;-----------------------
                                   1429 ; get string reserved 
                                   1430 ; space 
                                   1431 ; input:
                                   1432 ;   X     string data pointer 
                                   1433 ; output:
                                   1434 ;   X      space 
                                   1435 ;-----------------------------
      00180A                       1436 get_string_space:
      009763 95               [ 2] 1437 	ldw x,(x) ; data address 
      009764 78               [ 1] 1438 	ld a,(x) ; space size 
      009765 A3               [ 1] 1439 	clrw x
      009766 00               [ 1] 1440 	ld xl,a 
      009767 01               [ 4] 1441 	ret 
                                   1442 
                                   1443 ;--------------------------
                                   1444 ; search dim var_name 
                                   1445 ; format of record 
                                   1446 ;  field | size 
                                   1447 ;------------------- 
                                   1448 ;  name | {2} byte, for array bit 15 of name is set
                                   1449 ;  data:  
                                   1450 ;  	integer | INT_SIZE 
                                   1451 ;  	str   | len(str)+1, counted string 
                                   1452 ;  	array | size=2 byte, data=size*INT_SIZE   
                                   1453 ;  
                                   1454 ; input:
                                   1455 ;    X     name
                                   1456 ; output:
                                   1457 ;    X     address|0
                                   1458 ; use:
                                   1459 ;   A,Y, acc16 
                                   1460 ;-------------------------
                           000001  1461 	VAR_NAME=1 ; target name pointer 
                                   1462 ;	WLKPTR=VAR_NAME+2   ; walking pointer in RAM 
                           000003  1463 	SKIP=VAR_NAME+2
                           000004  1464 	VSIZE=SKIP+1  
      00180F                       1465 search_var:
      009768 2A 05            [ 2] 1466 	pushw y 
      001811                       1467 	_vars VSIZE
      00976A A6 0E            [ 2]    1     sub sp,#VSIZE 
                                   1468 ; reset bit 7 
      00976C CC               [ 1] 1469 	ld a,xh 
      00976D 92 27            [ 1] 1470 	and a,#127
      00976F 13               [ 1] 1471     ld xh,a 
      009770 01 22            [ 2] 1472 	ldw (VAR_NAME,sp),x
      009772 F7 1F 03 90      [ 2] 1473 	ldw y,dvar_bgn
      00181D                       1474 1$:	
      009776 F6 A1 05 26      [ 2] 1475 	cpw y, dvar_end
      00977A 04 90            [ 1] 1476 	jrpl 7$ ; no match found 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 156.
Hexadecimal [24-Bits]



      00977C 5C               [ 1] 1477 	ldw x,y 
      00977D 20               [ 2] 1478 	ldw x,(x)
                                   1479 ; reset bit 7 
      00977E 13               [ 1] 1480 	ld a,xh 
      00977F A4 7F            [ 1] 1481 	and a,#127
      00977F A6               [ 1] 1482     ld xh,a 
      009780 02 CD            [ 2] 1483 	cpw x,(VAR_NAME,sp)
      009782 94 96            [ 1] 1484 	jreq 8$ ; match  
                                   1485 ; skip this one 	
      009784 CD 95 78 13      [ 2] 1486 	addw y,#4 
      009788 01 22            [ 2] 1487 	jra 1$ 
      00978A DF 1F            [ 1] 1488 	ld a,(y)
      001835                       1489 7$: ; no match found 
      00978C 01 A6            [ 1] 1490 	clrw y 
      001837                       1491 8$: ; match found 
      00978E 05               [ 1] 1492 	ldw x,y  ; variable address 
      001838                       1493 9$:	_DROP VSIZE
      00978F CD 94            [ 2]    1     addw sp,#VSIZE 
      009791 96 85            [ 2] 1494 	popw y 
      009792 81               [ 4] 1495 	ret 
                                   1496 
                                   1497 ;---------------------------------
                                   1498 ; BASIC: DIM var_name(expr) [,var_name(expr)]* 
                                   1499 ; create named variables at end 
                                   1500 ; of BASIC program. 
                                   1501 ; value are not initialized 
                                   1502 ; bit 7 of first character of name 
                                   1503 ; is set for string and array variables 
                                   1504 ;---------------------------------
                           000001  1505 	HEAP_ADR=1 
                           000003  1506 	DIM_SIZE=HEAP_ADR+ADR_SIZE 
                           000005  1507 	VAR_NAME=DIM_SIZE+INT_SIZE
                           000007  1508 	VAR_ADR=VAR_NAME+NAME_SIZE  
                           000009  1509 	VAR_TYPE=VAR_ADR+ADR_SIZE 
                           000009  1510 	VSIZE=4*INT_SIZE+1 
      00183D                       1511 kword_dim:
      00183D                       1512 	_vars VSIZE
      009792 1E 01            [ 2]    1     sub sp,#VSIZE 
      00183F                       1513 dim_next: 
      00183F                       1514 	_next_token
      00183F                          1         _get_char 
      009794 72 F0            [ 1]    1         ld a,(y)    ; 1 cy 
      009796 03 5C            [ 1]    2         incw y      ; 1 cy 
      009798 9F 1E            [ 1] 1515 	ld (VAR_TYPE,sp),a 
      00979A 05               [ 1] 1516 	ldw x,y 
      00979B 72 FB 03 5B      [ 2] 1517 	addw y,#2 
      00979F 08               [ 2] 1518 	ldw x,(x) ; var name 
                                   1519 ; set bit 7 for string or array 
      0097A0 81               [ 1] 1520 	ld a,xh 
      0097A1 AA 80            [ 1] 1521 	or a,#128 
      0097A1 1C               [ 1] 1522 	ld xh,a 
      0097A2 00 02            [ 2] 1523 	ldw (VAR_NAME,sp),x 
      0097A4 89 CE 00         [ 4] 1524 	call search_var  
      0097A7 39               [ 2] 1525 	tnzw x 
      0097A8 72 B0            [ 1] 1526 	jreq 1$ ; doesn't exist 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 157.
Hexadecimal [24-Bits]



                                   1527 ; if string or integer array 
                                   1528 ; abort with error 
      0097AA 00 37            [ 2] 1529 	ldw (VAR_ADR,sp),x
      0097AC 13               [ 1] 1530 	tnz (x)
      0097AD 01 24            [ 1] 1531 	jrpl 0$  ; it is a scalar will be transformed in array 
      0097AF 05 A6            [ 1] 1532 	ld a,#ERR_DIM ; string or array already exist 
      0097B1 0A CC 92         [ 2] 1533 	jp tb_error
      0097B4 27 CE            [ 1] 1534 0$: or a,#128 ; make it array  
      0097B6 00               [ 1] 1535 	ld (x),a 
      0097B7 39 72            [ 2] 1536 	jra 2$ 	
      001866                       1537 1$:
      0097B9 F0 01            [ 2] 1538 	ldw x,(VAR_NAME,sp)
      0097BB BF 39 5B         [ 4] 1539 	call create_var
      0097BE 02 81            [ 2] 1540 	ldw (VAR_ADR,sp),x  
      0097C0                       1541 2$: 
      0097C0 52 02 1F         [ 4] 1542 	call func_args 
      0097C3 01 CE            [ 1] 1543 	cp a,#1
      0097C5 00 39            [ 1] 1544 	jreq 21$
      0097C7 72 B0 00         [ 2] 1545 	jp syntax_error 
      001877                       1546 21$: _i16_pop 
      0097CA 37               [ 2]    1     popw x 
      0097CB A3 00            [ 2] 1547 	ldw (DIM_SIZE,sp),x 
      0097CD 04 24 05         [ 2] 1548 	cpw x,#1 
      0097D0 A6 0A            [ 1] 1549 	jrpl 4$ 
      00187F                       1550 3$:
      0097D2 CC 92            [ 1] 1551 	ld a,#ERR_RANGE ; array or string must be 1 or more  
      0097D4 27 11 A7         [ 2] 1552 	jp tb_error 
      0097D5 7B 09            [ 1] 1553 4$: ld a,(VAR_TYPE,sp)
      0097D5 CE 00            [ 1] 1554 	cp a,#VAR_IDX 
      0097D7 37 7B            [ 1] 1555 	jreq 5$ 
      0097D9 01 F7 7B         [ 2] 1556 	cpw x,#256 
      0097DC 02 E7            [ 1] 1557 	jrmi 42$ ; string too big
                                   1558 ; remove created var 
      00188F                       1559 	_ldxz dvar_end 
      0097DE 01 6F                    1     .byte 0xbe,dvar_end 
      0097E0 02 6F 03         [ 2] 1560 	subw x,#4 
      001894                       1561 	_strxz dvar_end 
      0097E3 89 1C                    1     .byte 0xbf,dvar_end 
      0097E5 00 04            [ 1] 1562 	ld a,#ERR_GT255
      0097E7 BF 37 85         [ 2] 1563 	jp tb_error
      00189B                       1564 42$:
      0097EA 5B 02 81         [ 4] 1565 	call heap_alloc 
      0097ED 1F 01            [ 2] 1566 	ldw (HEAP_ADR,sp),x 
                                   1567 ; put size in high byte 
                                   1568 ; 0 in low byte  
      0097ED 52 03            [ 1] 1569 	ld a,(DIM_SIZE+1,sp)
      0097EF 0F 01            [ 1] 1570 	ld (DIM_SIZE,sp),a  
      0097F1 93 FE            [ 1] 1571 	clr (DIM_SIZE+1,sp)
      0097F3 72 A9            [ 2] 1572 	jra 7$ 
      0018A8                       1573 5$: ; integer array 
      0097F5 00               [ 2] 1574 	sllw x  
      0097F6 02 1F 02         [ 4] 1575 	call heap_alloc 
      0097F9 90 F6            [ 2] 1576 	ldw (HEAP_ADR,sp),x 
      0018AE                       1577 7$: 	
                                   1578 ; initialize size field 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 158.
Hexadecimal [24-Bits]



      0097FB A1 04            [ 1] 1579 	ld a,(DIM_SIZE,sp)
      0097FD 26               [ 1] 1580 	ld (x),a
      0097FE 08 03            [ 1] 1581 	ld a,(DIM_SIZE+1,sp) 
      009800 01 9E            [ 1] 1582 	ld (1,x),a 
      0018B5                       1583 8$: ; initialize pointer in variable 
      009802 AA 80            [ 2] 1584 	ldw x,(VAR_ADR,sp)
      009804 95 6B            [ 1] 1585 	ld a,(HEAP_ADR,sp)
      009806 02 02            [ 1] 1586 	ld (2,x),a 
      009807 7B 02            [ 1] 1587 	ld a,(HEAP_ADR+1,sp)
      009807 CD 98            [ 1] 1588 	ld (3,x),a 
      0018BF                       1589 	_next_token 
      0018BF                          1         _get_char 
      009809 8F 5D            [ 1]    1         ld a,(y)    ; 1 cy 
      00980B 26 1B            [ 1]    2         incw y      ; 1 cy 
      00980D 0D 01            [ 1] 1590 	cp a,#COMMA_IDX 
      00980F 27 03            [ 1] 1591 	jrne 9$
      009811 CD 98 2B         [ 2] 1592 	jp dim_next 
      009814                       1593 9$: 
      0018CA                       1594 	_unget_token 	
      009814 7B 03            [ 2]    1         decw y
      0018CC                       1595 	_drop VSIZE 
      009816 A1 24            [ 2]    1     addw sp,#VSIZE 
      0018CE                       1596 	_next 
      009818 26 05 A6         [ 2]    1         jp interp_loop 
                                   1597 
                                   1598 
                                   1599 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                                   1600 ; return program size 
                                   1601 ;;;;;;;;;;;;;;;;;;;;;;;;;;
      0018D1                       1602 prog_size:
      0018D1                       1603 	_ldxz progend
      00981B 0C CC                    1     .byte 0xbe,progend 
      00981D 92 27 00 2F      [ 2] 1604 	subw x,lomem 
      00981F 81               [ 4] 1605 	ret 
                                   1606 
                                   1607 ;----------------------------
                                   1608 ; print program information 
                                   1609 ;---------------------------
      0018D8                       1610 program_info: 
      00981F 1E 02 9E         [ 1] 1611 	push base 
      009822 A4 7F 95         [ 2] 1612 	ldw x,#PROG_ADDR 
      009825 CD 97 C0         [ 4] 1613 	call puts 
      009828                       1614 	_ldxz lomem 
      009828 5B 03                    1     .byte 0xbe,lomem 
      00982A 81 10 00 0F      [ 1] 1615 	mov base,#16 
      00982B CD 07 AE         [ 4] 1616 	call print_int
      00982B 1C 00 02 89      [ 1] 1617 	mov base,#10  
      00982F 90 F6 A1         [ 2] 1618 	ldw x,#PROG_SIZE
      009832 04 26 15         [ 4] 1619 	call puts 
      009835 CD 94 A4         [ 4] 1620 	call prog_size 
      009838 A1 01 27         [ 4] 1621 	call print_int 
      00983B 03 CC 92         [ 2] 1622 	ldw x,#STR_BYTES 
      00983E 25 05 23         [ 4] 1623 	call puts
      00983F                       1624 	_ldxz lomem
      00983F 85 A3                    1     .byte 0xbe,lomem 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 159.
Hexadecimal [24-Bits]



      009841 00 01 27         [ 2] 1625 	cpw x,#app 
      009844 05 A6            [ 1] 1626 	jrult 2$
      009846 0D CD 92         [ 2] 1627 	ldw x,#FLASH_MEM 
      009849 27 03            [ 2] 1628 	jra 3$
      00984A AE 19 56         [ 2] 1629 2$: ldw x,#RAM_MEM 	 
      00984A 85 81 23         [ 4] 1630 3$:	call puts 
      00984C A6 0D            [ 1] 1631 	ld a,#CR 
      00984C 52 04 7D         [ 4] 1632 	call putc
      00984F 2B 05 CD         [ 1] 1633 	pop base 
      009852 98               [ 4] 1634 	ret 
                                   1635 
      009853 2B 20 31 67 72 61 6D  1636 PROG_ADDR: .asciz "program address: "
             20 61 64 64 72 65 73
             73 3A 20 00
      009856 2C 20 70 72 6F 67 72  1637 PROG_SIZE: .asciz ", program size: "
             61 6D 20 73 69 7A 65
             3A 20 00
      009856 EE 02 1F 03 90 F6 A1  1638 STR_BYTES: .asciz " bytes" 
      00985D 04 27 05 1C 00 02 20  1639 FLASH_MEM: .asciz " in FLASH memory" 
             22 48 20 6D 65 6D 6F
             72 79 00
      009865 20 69 6E 20 52 41 4D  1640 RAM_MEM:   .asciz " in RAM memory" 
             20 6D 65 6D 6F 72 79
             00
                                   1641 
                                   1642 
                                   1643 ;----------------------------
                                   1644 ; BASIC: LIST [[start][-end]]
                                   1645 ; list program lines 
                                   1646 ; form start to end 
                                   1647 ; if empty argument list then 
                                   1648 ; list all.
                                   1649 ;----------------------------
                           000001  1650 	FIRST=1
                           000003  1651 	LAST=3 
                           000005  1652 	LN_PTR=5
                           000006  1653 	VSIZE=6
      001965                       1654 cmd_list:
      009865 CD 94 A4         [ 4] 1655 	call prog_size 
      009868 A1 01            [ 1] 1656 	jrugt 1$
      00986A 27 03 CC         [ 2] 1657 	jp cmd_line 
      00196D                       1658 1$:
      00196D                       1659 	 _vars VSIZE
      00986D 92 25            [ 2]    1     sub sp,#VSIZE 
      00196F                       1660 	_ldxz lomem 
      00986F 85 5D                    1     .byte 0xbe,lomem 
      009871 27 09            [ 2] 1661 	ldw (LN_PTR,sp),x 
      009873 1F               [ 2] 1662 	ldw x,(x) 
      009874 01 1E            [ 2] 1663 	ldw (FIRST,sp),x ; list from first line 
      009876 03 FE 13         [ 2] 1664 	ldw x,#MAX_LINENO ; biggest line number 
      009879 01 2A            [ 2] 1665 	ldw (LAST,sp),x 
      00197B                       1666 	_next_token
      00197B                          1         _get_char 
      00987B 05 F6            [ 1]    1         ld a,(y)    ; 1 cy 
      00987C 90 5C            [ 1]    2         incw y      ; 1 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 160.
Hexadecimal [24-Bits]



      00987C A6               [ 1] 1667 	tnz a 
      00987D 0D CC            [ 1] 1668 	jreq print_listing 
      00987F 92 27            [ 1] 1669 	cp a,#SUB_IDX 
      009881 27 22            [ 1] 1670 	jreq list_to
      009881 1E 01            [ 2] 1671 	decw y    
      009883 58 72 FB         [ 4] 1672 	call expect_integer 
      009886 03 01            [ 2] 1673 	ldw (FIRST,sp),x	
      009887                       1674 	_next_token
      00198D                          1         _get_char 
      009887 5B 04            [ 1]    1         ld a,(y)    ; 1 cy 
      009889 81 5C            [ 1]    2         incw y      ; 1 cy 
      00988A 4D               [ 1] 1675 	tnz a 
      00988A FE F6            [ 1] 1676 	jrne 2$ 
      00988C 5F 97            [ 2] 1677 	ldw (LAST,sp),x  
      00988E 81 15            [ 2] 1678 	jra  print_listing 
      00988F                       1679 2$: 
      00988F 90 89            [ 1] 1680 	cp a,#SUB_IDX  
      009891 52 04            [ 1] 1681 	jreq 3$ 
      009893 9E A4 7F         [ 2] 1682 	jp syntax_error
      00199F                       1683 3$: _next_token 
      00199F                          1         _get_char 
      009896 95 1F            [ 1]    1         ld a,(y)    ; 1 cy 
      009898 01 90            [ 1]    2         incw y      ; 1 cy 
      00989A CE               [ 1] 1684 	tnz a 
      00989B 00 35            [ 1] 1685 	jreq print_listing
      00989D 90 5A            [ 2] 1686 	decw y	 
      0019A8                       1687 list_to: ; listing will stop at this line
      00989D 90 C3 00         [ 4] 1688     call expect_integer 
      0098A0 37 2A            [ 2] 1689 	ldw (LAST,sp),x
      0019AD                       1690 print_listing:
                                   1691 ; skip lines smaller than FIRST 
      0098A2 12 93            [ 2] 1692 	ldw y,(LN_PTR,sp)
      0019AF                       1693 	 _clrz acc16 
      0098A4 FE 9E                    1     .byte 0x3f, acc16 
      0098A6 A4               [ 1] 1694 1$:	ldw x,y 
      0098A7 7F               [ 2] 1695 	ldw x,(x)
      0098A8 95 13            [ 2] 1696 	cpw x,(FIRST,sp)
      0098AA 01 27            [ 1] 1697 	jrpl 2$
      0098AC 0A 72 A9         [ 1] 1698 	ld a,(2,y)
      0019BA                       1699 	_straz acc8
      0098AF 00 04                    1     .byte 0xb7,acc8 
      0098B1 20 EA 90 F6      [ 2] 1700 	addw y,acc16
      0098B5 90 C3 00 33      [ 2] 1701 	cpw y,progend 
      0098B5 90 5F            [ 1] 1702 	jrpl list_exit 
      0098B7 20 E9            [ 2] 1703 	jra 1$
      0098B7 93 5B            [ 2] 1704 2$: ldw (LN_PTR,sp),y 	
      0019CA                       1705 list_loop:
      0098B9 04 90            [ 2] 1706 	ldw x,(LN_PTR,sp)
      0098BB 85 81 2B         [ 2] 1707 	ldw line.addr,x 
      0098BD E6 02            [ 1] 1708 	ld a,(2,x) 
      0098BD 52 09            [ 1] 1709 	sub a,#LINE_HEADER_SIZE
      0098BF CD 1A 1F         [ 4] 1710 	call prt_basic_line
      0098BF 90 F6            [ 2] 1711 	ldw x,(LN_PTR,sp)
      0098C1 90 5C            [ 1] 1712 	ld a,(2,x)
      0019DA                       1713 	_straz acc8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 161.
Hexadecimal [24-Bits]



      0098C3 6B 09                    1     .byte 0xb7,acc8 
      0019DC                       1714 	_clrz acc16 
      0098C5 93 72                    1     .byte 0x3f, acc16 
      0098C7 A9 00 02 FE      [ 2] 1715 	addw x,acc16
      0098CB 9E AA 80         [ 2] 1716 	cpw x,progend 
      0098CE 95 1F            [ 1] 1717 	jrpl list_exit
      0098D0 05 CD            [ 2] 1718 	ldw (LN_PTR,sp),x
      0098D2 98               [ 2] 1719 	ldw x,(x)
      0098D3 8F 5D            [ 2] 1720 	cpw x,(LAST,sp)  
      0098D5 27 0F            [ 1] 1721 	jrsle list_loop
      0019EE                       1722 list_exit:
      0019EE                       1723 	_drop VSIZE 
      0098D7 1F 07            [ 2]    1     addw sp,#VSIZE 
      0098D9 7D 2A 05         [ 4] 1724 	call program_info
      0098DC A6 0C CC         [ 2] 1725 	jp cmd_line 
                                   1726 
                                   1727 
      0098DF 92 27 AA 80 F7 20 07  1728 LINES_REJECTED: .asciz "WARNING: lines missing in this program.\n"
             3A 20 6C 69 6E 65 73
             20 6D 69 73 73 69 6E
             67 20 69 6E 20 74 68
             69 73 20 70 72 6F 67
             72 61 6D 2E 0A 00
                                   1729 
                           000000  1730 .if 0
                                   1731 ;--------------------------
                                   1732 ; BASIC: EDIT label 
                                   1733 ;  copy program in FLASH 
                                   1734 ;  to RAM for edition 
                                   1735 ;-------------------------
                                   1736 cmd_edit:
                                   1737 	ld a,#LABEL_IDX 
                                   1738 	call expect  
                                   1739 	pushw y
                                   1740 	call skip_label 
                                   1741 	popw x 
                                   1742 	pushw y 
                                   1743 	incw x 
                                   1744 	call search_program 
                                   1745     jrne 1$ 
                                   1746 	ldw x,#ERR_NOT_FILE 
                                   1747 	jp tb_error 
                                   1748 1$: 
                                   1749 	ldw y,x ; file address 
                                   1750 	ldw x,(2,x) ; program size 
                                   1751 	addw x,#FILE_HEADER_SIZE  
                                   1752 	ldw acc16,x  ; bytes to copy 
                                   1753 	ldw x,#rsign ; destination address 
                                   1754 	call move  
                                   1755 	ldw x,#free_ram 
                                   1756 	ldw lomem,x 
                                   1757 	addw x,rsize  
                                   1758 	ldw himem,x
                                   1759 	popw y  
                                   1760 	_next 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 162.
Hexadecimal [24-Bits]



                                   1761 .endif 
                                   1762 
                                   1763 ;---------------------------------
                                   1764 ; decompile line from token list
                                   1765 ; and print it. 
                                   1766 ; input:
                                   1767 ;   A       stop at this position 
                                   1768 ;   X 		pointer at line
                                   1769 ; output:
                                   1770 ;   none 
                                   1771 ;----------------------------------	
      0098E6                       1772 prt_basic_line:
      001A1F                       1773 	_straz count 
      0098E6 1E 05                    1     .byte 0xb7,count 
      0098E8 CD 97 C0         [ 2] 1774 	addw x,#LINE_HEADER_SIZE  
      0098EB 1F 07 2D         [ 2] 1775 	ldw basicptr,x
      0098ED 90 93            [ 1] 1776     ldw y,x 
      0098ED CD 94 A4         [ 4] 1777 	call decompile
                                   1778 ;call new_line 
      0098F0 A1               [ 4] 1779 	ret 
                                   1780 
                                   1781 ;---------------------------------
                                   1782 ; BASIC: PRINT|? arg_list 
                                   1783 ; print values from argument list
                                   1784 ;----------------------------------
                           000001  1785 	SEMICOL=1
                           000001  1786 	VSIZE=1
      001A2D                       1787 cmd_print:
      001A2D                       1788 	_vars VSIZE 
      0098F1 01 27            [ 2]    1     sub sp,#VSIZE 
      001A2F                       1789 reset_semicol:
      0098F3 03 CC            [ 1] 1790 	clr (SEMICOL,sp)
      001A31                       1791 prt_loop:
      001A31                       1792 	_next_token	
      001A31                          1         _get_char 
      0098F5 92 25            [ 1]    1         ld a,(y)    ; 1 cy 
      0098F7 85 1F            [ 1]    2         incw y      ; 1 cy 
      0098F9 03 A3            [ 1] 1793 	cp a,#CMD_END 
      0098FB 00 01            [ 1] 1794 	jrugt 0$
      001A39                       1795 	_unget_token
      0098FD 2A 05            [ 2]    1         decw y
      0098FF 20 5A            [ 2] 1796 	jra 8$
      001A3D                       1797 0$:	
      0098FF A6 0D            [ 1] 1798 	cp a,#QUOTE_IDX
      009901 CC 92            [ 1] 1799 	jreq 1$
      009903 27 7B            [ 1] 1800 	cp a,#STR_VAR_IDX 
      009905 09 A1            [ 1] 1801 	jreq 2$ 
      009907 09 27            [ 1] 1802 	cp a,#SCOL_IDX  
      009909 1E A3            [ 1] 1803 	jreq 4$
      00990B 01 00            [ 1] 1804 	cp a,#COMMA_IDX
      00990D 2B 0C            [ 1] 1805 	jreq 5$	
      00990F BE 37            [ 1] 1806 	cp a,#CHAR_IDX 
      009911 1D 00            [ 1] 1807 	jreq 6$
      009913 04 BF            [ 2] 1808 	jra 7$ 
      001A53                       1809 1$:	; print string 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 163.
Hexadecimal [24-Bits]



      009915 37               [ 1] 1810 	ldw x,y 
      009916 A6 03 CC         [ 4] 1811 	call puts
      009919 92 27            [ 1] 1812 	ldw y,x  
      00991B 20 D4            [ 2] 1813 	jra reset_semicol
      001A5B                       1814 2$:	; print string variable  
      00991B CD 97 A1         [ 4] 1815 	call get_var_adr 
      00991E 1F 01 7B         [ 4] 1816 	call get_string_slice 
      009921 04               [ 1] 1817 	tnz a 
      009922 6B 03            [ 1] 1818 	jreq 22$   
      009924 0F               [ 1] 1819 	push a
      001A65                       1820 21$: 
      009925 04               [ 1] 1821 	ld a,(x)
      009926 20               [ 1] 1822 	incw x 
      009927 06 04 AC         [ 4] 1823 	call putc
      009928 0A 01            [ 1] 1824 	dec (1,sp)
      009928 58 CD            [ 1] 1825 	jrne 21$ 
      00992A 97               [ 1] 1826 	pop a  
      001A6F                       1827 22$:
      00992B A1 1F            [ 2] 1828 	jra reset_semicol 
      001A71                       1829 4$: ; set semi-colon  state 
      00992D 01 01            [ 1] 1830 	cpl (SEMICOL,sp)
      00992E 20 BC            [ 2] 1831 	jra prt_loop 
      001A75                       1832 5$: ; skip to next terminal tabulation
                                   1833      ; terminal TAB are 8 colons 
      00992E 7B 03            [ 1] 1834      ld a,#9 
      009930 F7 7B 04         [ 4] 1835 	 call putc 
      009933 E7 01            [ 2] 1836 	 jra reset_semicol
      009935                       1837 6$: ; appelle la foncton CHAR()
      001A7C                       1838 	_call_code 
      001A7C                          1         _code_addr  ; 6 cy  
      009935 1E               [ 1]    1         clrw x   ; 1 cy 
      009936 07               [ 1]    2         ld xl,a  ; 1 cy 
      009937 7B               [ 2]    3         sllw x   ; 2 cy 
      009938 01 E7 02         [ 2]    4         ldw x,(code_addr,x) ; 2 cy 
      00993B 7B               [ 4]    2         call (x)    ; 4 cy 
      00993C 02               [ 1] 1839 	rrwa x 
      00993D E7 03 90         [ 4] 1840 	call putc 
      009940 F6 90            [ 2] 1841 	jra reset_semicol	 	    
      001A89                       1842 7$:	
      001A89                       1843 	_unget_token 
      009942 5C A1            [ 2]    1         decw y
      009944 02 26 03         [ 4] 1844 	call condition
      009947 CC 98 BF         [ 4] 1845 	call print_int
      00994A CD 05 86         [ 4] 1846 	call space
      00994A 90 5A 5B         [ 2] 1847 	jp reset_semicol 
      001A97                       1848 8$:
      00994D 09 CC            [ 1] 1849 	tnz (SEMICOL,sp)
      00994F 93 A6            [ 1] 1850 	jrne 9$
      009951 A6 0D            [ 1] 1851 	ld a,#CR 
      009951 BE 33 72         [ 4] 1852     call putc 
      001AA0                       1853 9$:	
      001AA0                       1854 	_drop VSIZE 
      009954 B0 00            [ 2]    1     addw sp,#VSIZE 
      001AA2                       1855 	_next
      009956 2F 81 26         [ 2]    1         jp interp_loop 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 164.
Hexadecimal [24-Bits]



                                   1856 
                                   1857 ;----------------------
                                   1858 ; 'save_context' and
                                   1859 ; 'rest_context' must be 
                                   1860 ; called at the same 
                                   1861 ; call stack depth 
                                   1862 ; i.e. SP must have the 
                                   1863 ; same value at  
                                   1864 ; entry point of both 
                                   1865 ; routine. 
                                   1866 ;---------------------
                           000004  1867 	CTXT_SIZE=4 ; size of saved data 
                                   1868 ;--------------------
                                   1869 ; save current BASIC
                                   1870 ; interpreter context 
                                   1871 ; on stack 
                                   1872 ;--------------------
      009958                       1873 	_argofs 0 
                           000002     1     ARG_OFS=2+0 
      001AA5                       1874 	_arg LNADR 1 
                           000003     1     LNADR=ARG_OFS+1 
      001AA5                       1875 	_arg BPTR 3
                           000005     1     BPTR=ARG_OFS+3 
      001AA5                       1876 save_context:
      009958 3B 00            [ 2] 1877 	ldw (BPTR,sp),y 
      001AA7                       1878 	_ldxz line.addr
      00995A 0F AE                    1     .byte 0xbe,line.addr 
      00995C 99 9B            [ 2] 1879 	ldw (LNADR,sp),x 
      00995E CD               [ 4] 1880 	ret
                                   1881 
                                   1882 ;-----------------------
                                   1883 ; restore previously saved 
                                   1884 ; BASIC interpreter context 
                                   1885 ; from stack 
                                   1886 ;-------------------------
      001AAC                       1887 rest_context:
      00995F 85 A3            [ 2] 1888 	ldw x,(LNADR,sp)
      009961 BE 2F 35         [ 2] 1889 	ldw line.addr,x 
      009964 10 00            [ 2] 1890 	ldw y,(BPTR,sp)
      009966 0F               [ 4] 1891 	ret
                                   1892 
                                   1893 
                                   1894 ;-----------------------
                                   1895 ; ask user to retype 
                                   1896 ; input value 
                                   1897 ;----------------------
      001AB4                       1898 retype:
      009967 CD 88 2E         [ 4] 1899 	call new_line
      00996A 35 0A 00         [ 2] 1900 	ldw x,#err_retype 
      00996D 0F AE 99         [ 4] 1901 	call puts 
      009970 AD CD 85         [ 4] 1902 	call new_line 
      009973 A3               [ 4] 1903 	ret 
                                   1904 
                                   1905 ;--------------------------
                                   1906 ; readline from terminal 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 165.
Hexadecimal [24-Bits]



                                   1907 ; and parse it in pad 
                                   1908 ;-------------------------
      001AC1                       1909 input_prompt:
      009974 CD 99            [ 1] 1910 	ld a,#'? 
      009976 51 CD 88         [ 4] 1911 	call putc 
      009979 2E               [ 4] 1912 	ret 
                                   1913 
                                   1914 ;-----------------------
                                   1915 ; print variable name 
                                   1916 ; input:
                                   1917 ;    X    var name 
                                   1918 ; use:
                                   1919 ;   A 
                                   1920 ;-----------------------
      001AC7                       1921 print_var_name:
      00997A AE               [ 1] 1922 	ld a,xh 
      00997B 99 BE            [ 1] 1923 	and a,#127 
      00997D CD 85 A3         [ 4] 1924 	call uart_putc 
      009980 BE               [ 1] 1925 	ld a,xl 
      009981 2F A3            [ 1] 1926 	and a,#127 
      009983 A5 00 25         [ 4] 1927 	call uart_putc 
      009986 05               [ 4] 1928 	ret  
                                   1929 
                                   1930 ;--------------------------
                                   1931 ; input integer to variable 
                                   1932 ; input:
                                   1933 ;   X     var name 
                                   1934 ; output:
                                   1935 ;   X      value 
                                   1936 ;----------------------------
                           000001  1937 	N=1
                           000003  1938 	DIGIT=N+INT_SIZE 
                           000005  1939 	SIGN=DIGIT+INT_SIZE
                           000006  1940 	COUNT=SIGN+1 
                           000006  1941  	VSIZE=COUNT  
      001AD4                       1942 input_integer:
      001AD4                       1943 	_vars VSIZE 
      009987 AE 99            [ 2]    1     sub sp,#VSIZE 
      009989 C5 20            [ 1] 1944 	clr (DIGIT,sp)
      00998B 03 AE 99         [ 4] 1945 	call print_var_name 
      00998E D6 CD 85         [ 4] 1946 	call input_prompt  
      009991 A3               [ 1] 1947 	clrw x 
      009992 A6 0D            [ 2] 1948 	ldw (N,sp),x 
      009994 CD 85            [ 2] 1949 	ldw (SIGN,sp),x
      009996 2C 32 00 0F      [ 1] 1950 	mov base,#10
      00999A 81 70 72         [ 4] 1951 	call getc 
      00999D 6F 67            [ 1] 1952 	cp a,#'- 
      00999F 72 61            [ 1] 1953 	jrne 1$ 
      0099A1 6D 20            [ 1] 1954 	cpl (SIGN,sp)
      0099A3 61 64            [ 2] 1955 	jra 2$ 
      0099A5 64 72            [ 1] 1956 1$: cp a,#'$ 
      0099A7 65 73            [ 1] 1957 	jrne 3$ 
      0099A9 73 3A 20 00      [ 1] 1958 	mov base,#16  
      0099AD 2C 20 70         [ 4] 1959 2$: call getc
      0099B0 72 6F            [ 1] 1960 3$: cp a,#BS 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 166.
Hexadecimal [24-Bits]



      0099B2 67 72            [ 1] 1961 	jrne 4$ 
      0099B4 61 6D            [ 1] 1962 	tnz (COUNT,sp)
      0099B6 20 73            [ 1] 1963 	jreq 2$ 
      0099B8 69 7A 65         [ 4] 1964 	call bksp 
      0099BB 3A 20            [ 2] 1965 	ldw x,(N,sp)
      001B0A                       1966 	_ldaz base 
      0099BD 00 20                    1     .byte 0xb6,base 
      0099BF 62               [ 2] 1967 	div x,a 
      0099C0 79 74            [ 2] 1968 	ldw (N,sp),x
      0099C2 65 73            [ 1] 1969 	dec (COUNT,sp)
      0099C4 00 20            [ 2] 1970 	jra 2$  
      001B13                       1971 4$:	
      0099C6 69 6E 20         [ 4] 1972 	call uart_putc 
      0099C9 46 4C            [ 1] 1973 	cp a,#CR 
      0099CB 41 53            [ 1] 1974 	jreq 7$ 
      0099CD 48 20 6D         [ 4] 1975 	call char_to_digit 
      0099D0 65 6D            [ 1] 1976 	jrnc 9$
      0099D2 6F 72            [ 1] 1977 	inc (COUNT,sp)
      0099D4 79 00            [ 1] 1978 	ld (DIGIT+1,sp),a 
      0099D6 20 69            [ 2] 1979 	ldw x,(N,sp)
      001B25                       1980 	_ldaz base 
      0099D8 6E 20                    1     .byte 0xb6,base 
      0099DA 52 41 4D         [ 4] 1981 	call umul16_8
      0099DD 20 6D 65         [ 2] 1982 	addw x,(DIGIT,sp)
      0099E0 6D 6F            [ 2] 1983 	ldw (N,sp),x
      0099E2 72 79            [ 2] 1984 	jra 2$  	
      0099E4 00 01            [ 2] 1985 7$: ldw x,(N,sp)
      0099E5 0D 05            [ 1] 1986 	tnz (SIGN,sp)
      0099E5 CD 99            [ 1] 1987 	jreq 8$ 
      0099E7 51               [ 2] 1988 	negw x 
      001B38                       1989 8$: 
      0099E8 22               [ 1] 1990 	scf ; success 	
      001B39                       1991 9$:	
      001B39                       1992 	_drop VSIZE 
      0099E9 03 CC            [ 2]    1     addw sp,#VSIZE 
      0099EB 93               [ 4] 1993 	ret 
                                   1994 
                                   1995 ;---------------------------------------
                                   1996 ; input value for string variable 
                                   1997 ; accumulate all character up to CR 
                                   1998 ; input:
                                   1999 ;   X     var name  
                                   2000 ; output:
                                   2001 ;   X     *tib 
                                   2002 ;-------------------------------------- 
      001B3C                       2003 input_string:
      0099EC 71 1A C7         [ 4] 2004 	call print_var_name 
      0099ED CD 1A C1         [ 4] 2005 	call input_prompt 
      0099ED 52               [ 1] 2006 	clr a 
      0099EE 06 BE 2F         [ 4] 2007 	call readln 
      0099F1 1F 05 FE         [ 2] 2008 	ldw x,#tib 
      0099F4 1F               [ 4] 2009 	ret 
                                   2010 
                                   2011 ;------------------------------------------
                                   2012 ; BASIC: INPUT [string],var[,var]
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 167.
Hexadecimal [24-Bits]



                                   2013 ; input value in variables 
                                   2014 ; [string] optionally can be used as prompt 
                                   2015 ;-----------------------------------------
                           000001  2016 	BPTR=1
                           000003  2017 	VAR_VALUE=BPTR+2
                           000005  2018 	VAR_ADR =VAR_VALUE+2
                           000006  2019 	VSIZE=3*INT_SIZE  
      001B4A                       2020 cmd_input:
      0099F5 01 AE 7F FF 1F   [ 2] 2021 	btjt flags,#FRUN,1$ 
      0099FA 03 90            [ 1] 2022 	ld a,#ERR_PROG_ONLY
      0099FC F6 90 5C         [ 2] 2023 	jp tb_error 
      001B54                       2024 1$: 
      001B54                       2025 	_vars VSIZE 
      0099FF 4D 27            [ 2]    1     sub sp,#VSIZE 
      009A01 2B A1            [ 1] 2026 	ld a,(y) 
      009A03 0C 27            [ 1] 2027 	cp a,#QUOTE_IDX 
      009A05 22 90            [ 1] 2028 	jrne 2$ 
      009A07 5A CD            [ 1] 2029 	incw y 
      009A09 93               [ 1] 2030 	ldw x,y  
      009A0A FA 1F 01         [ 4] 2031 	call puts 
      009A0D 90 F6            [ 1] 2032 	ldw y,x 
      009A0F 90 5C 4D         [ 4] 2033 	call new_line
      001B67                       2034 	_next_token 
      001B67                          1         _get_char 
      009A12 26 04            [ 1]    1         ld a,(y)    ; 1 cy 
      009A14 1F 03            [ 1]    2         incw y      ; 1 cy 
      009A16 20 15            [ 1] 2035 	cp a,#COMMA_IDX 
      009A18 27 03            [ 1] 2036 	jreq 2$  
      009A18 A1 0C 27         [ 2] 2037 	jp syntax_error 
      001B72                       2038 2$:
      001B72                       2039 	_next_token
      001B72                          1         _get_char 
      009A1B 03 CC            [ 1]    1         ld a,(y)    ; 1 cy 
      009A1D 92 25            [ 1]    2         incw y      ; 1 cy 
      009A1F 90 F6            [ 1] 2040 	cp a,#CMD_END+1  
      009A21 90 5C            [ 1] 2041 	jrmi input_exit  
      009A23 4D 27            [ 1] 2042     cp a,#VAR_IDX
      009A25 07 90            [ 1] 2043 	jreq 4$
      009A27 5A 0A            [ 1] 2044 	cp a,#STR_VAR_IDX 
      009A28 27 2E            [ 1] 2045 	jreq 8$ 
      009A28 CD 93 FA         [ 2] 2046 	jp syntax_error 
      001B85                       2047 4$: 
      009A2B 1F               [ 1] 2048 	ldw x,y 
      009A2C 03               [ 2] 2049 	ldw x,(x)
      009A2D 1F 05            [ 2] 2050 	ldw (VAR_ADR,sp),x ; var name 
      009A2D 16 05            [ 2] 2051 5$:	ldw x,(VAR_ADR,sp) 
      009A2F 3F 18 93         [ 4] 2052 	call input_integer 
      009A32 FE 13            [ 1] 2053 	jrc 6$ 
      009A34 01 2A 11         [ 4] 2054 	call retype 
      009A37 90 E6            [ 2] 2055 	jra 5$ 	  
      001B95                       2056 6$: 
      009A39 02 B7            [ 2] 2057 	ldw (VAR_VALUE,sp),x 
      009A3B 19 72 B9         [ 4] 2058 	call get_var_adr 
      009A3E 00 18 90         [ 4] 2059 	call get_array_adr 
      009A41 C3 00            [ 1] 2060 	ld a,(VAR_VALUE,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 168.
Hexadecimal [24-Bits]



      009A43 33               [ 1] 2061 	ld (x),a 
      009A44 2A 28            [ 1] 2062 	ld a,(VAR_VALUE+1,sp)
      009A46 20 E9            [ 1] 2063 	ld (1,x),a 
      001BA4                       2064 7$: 
      001BA4                       2065 	_next_token 
      001BA4                          1         _get_char 
      009A48 17 05            [ 1]    1         ld a,(y)    ; 1 cy 
      009A4A 90 5C            [ 1]    2         incw y      ; 1 cy 
      009A4A 1E 05            [ 1] 2066 	cp a,#COMMA_IDX 
      009A4C CF 00            [ 1] 2067 	jreq 2$
      001BAC                       2068 	_unget_token   
      009A4E 2B E6            [ 2]    1         decw y
      009A50 02 A0            [ 2] 2069 	jra input_exit ; all variables done
      001BB0                       2070 8$: ;input string 
      009A52 03               [ 1] 2071 	ldw x,y
      009A53 CD               [ 2] 2072 	ldw x,(x)
      009A54 9A 9F            [ 2] 2073 	ldw (VAR_ADR,sp),x ; save var name 
      009A56 1E 05 E6         [ 4] 2074 	call input_string  
      009A59 02 B7 19         [ 4] 2075 	call get_var_adr 
      009A5C 3F 18            [ 2] 2076 	ldw (VAR_ADR,sp),x ; needed later 
      009A5E 72 BB 00         [ 4] 2077 	call get_string_slice 
      009A61 18 C3            [ 2] 2078 	ldw (BPTR,sp),y  
      009A63 00 33 2A 07      [ 2] 2079 	ldw y,#tib
      009A67 1F 05 FE         [ 4] 2080 	call strcpy 
      009A6A 13 03 2D         [ 2] 2081 	ldw x,#tib 
      009A6D DC 08 06         [ 4] 2082 	call strlen 
      009A6E 1E 05            [ 2] 2083 	ldw x,(VAR_ADR,sp)
      009A6E 5B               [ 2] 2084 	ldw x,(x)
      009A6F 06               [ 1] 2085 	ld (x),a 
      009A70 CD 99            [ 2] 2086 	ldw y,(BPTR,sp)
      009A72 58 CC            [ 2] 2087 	jra 7$   	 
      001BD6                       2088 input_exit:
      001BD6                       2089 	_drop VSIZE 
      009A74 93 71            [ 2]    1     addw sp,#VSIZE 
      001BD8                       2090 	_next  
      009A76 57 41 52         [ 2]    1         jp interp_loop 
                                   2091 
                                   2092 
                                   2093 ;---------------------
                                   2094 ; BASIC: WAIT addr,mask[,xor_mask]
                                   2095 ; read in loop 'addr'  
                                   2096 ; apply & 'mask' to value 
                                   2097 ; loop while result==0.  
                                   2098 ; 'xor_mask' is used to 
                                   2099 ; invert the wait logic.
                                   2100 ; i.e. loop while not 0.
                                   2101 ;---------------------
                           000001  2102 	XMASK=1 ; INT_SIZE  
                           000003  2103 	MASK=XMASK+INT_SIZE  
                           000005  2104 	ADDR=MASK+INT_SIZE 
                           000006  2105 	VSIZE= 3*INT_SIZE 
      001BDB                       2106 cmd_wait: 
      009A79 4E 49 4E         [ 4] 2107 	call arg_list 
      009A7C 47 3A            [ 1] 2108 	cp a,#2
      009A7E 20 6C            [ 1] 2109 	jruge 0$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 169.
Hexadecimal [24-Bits]



      009A80 69 6E 65         [ 2] 2110 	jp syntax_error 
      009A83 73 20            [ 1] 2111 0$:	cp a,#3
      009A85 6D 69            [ 1] 2112 	jreq 1$
      009A87 73 73            [ 1] 2113 	push #0 ; XMASK=0 
      009A89 69 6E            [ 1] 2114 	push #0 
      009A8B 67 20            [ 1] 2115 	push #0 
      001BEF                       2116 1$: 
      009A8D 69 6E            [ 2] 2117 	ldw x,(ADDR+1,sp) ; 16 bits address
      009A8F 20               [ 1] 2118 2$:	ld a,(x)
      009A90 74 68            [ 1] 2119 	and a,(MASK+2,sp)
      009A92 69 73            [ 1] 2120 	xor a,(XMASK+2,sp)
      009A94 20 70            [ 1] 2121 	jreq 2$ 
      001BF8                       2122 	_drop VSIZE 
      009A96 72 6F            [ 2]    1     addw sp,#VSIZE 
      001BFA                       2123 	_next 
      009A98 67 72 61         [ 2]    1         jp interp_loop 
                                   2124 
                                   2125 ; table of power of 2 for {0..7}
      009A9B 6D 2E 0A 00 10 20 40  2126 power2: .byte 1,2,4,8,16,32,64,128
             80
                                   2127 
                                   2128 ;---------------------
                                   2129 ; BASIC: BSET addr,#bit
                                   2130 ; set bit at 'addr' corresponding 
                                   2131 ; correspond to macchine with same name 
                                   2132 ; 2^^bit or [addr]
                                   2133 ; arguments:
                                   2134 ; 	addr 	memory address RAM|PERIPHERAL 
                                   2135 ;   bit		{0..7}
                                   2136 ; output:
                                   2137 ;	none 
                                   2138 ;--------------------------
                           000001  2139 	BIT=1 
                           000003  2140 	ADDR=BIT+INT_SIZE 
      009A9F                       2141 cmd_bit_set:
      009A9F B7 2A 1C         [ 4] 2142 	call arg_list 
      009AA2 00 03            [ 1] 2143 	cp a,#2	 
      009AA4 CF 00            [ 1] 2144 	jreq 1$ 
      009AA6 2D 90 93         [ 2] 2145 	jp syntax_error
      001C0F                       2146 1$: 
      009AA9 CD 90 46         [ 2] 2147 	ldw x,#power2
      009AAC 81 FB 02         [ 2] 2148 	addw x,(BIT+1,sp) 
      009AAD F6               [ 1] 2149 	ld a,(x)
      009AAD 52 01            [ 2] 2150 	ldw x,(ADDR+1,sp)
      009AAF FA               [ 1] 2151     or a,(x)
      009AAF 0F               [ 1] 2152 	ld (x),a 
      001C1A                       2153 	_drop 2*INT_SIZE 
      009AB0 01 04            [ 2]    1     addw sp,#2*INT_SIZE 
      009AB1                       2154 	_next 
      009AB1 90 F6 90         [ 2]    1         jp interp_loop 
                                   2155 
                                   2156 ;---------------------
                                   2157 ; BASIC: BRES addr,#bit 
                                   2158 ; reset a bit at 'addr'  
                                   2159 ; correspond to macchine with same name 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 170.
Hexadecimal [24-Bits]



                                   2160 ; ~2^^bit and [addr]
                                   2161 ; arguments:
                                   2162 ; 	addr 	memory address RAM|PERIPHERAL 
                                   2163 ;   bit 	{0..7}  
                                   2164 ; output:
                                   2165 ;	none 
                                   2166 ;--------------------------
                           000001  2167 	BIT=1 
                           000003  2168 	ADDR=BIT+INT_SIZE 
      001C1F                       2169 cmd_bit_reset:
      009AB4 5C A1 01         [ 4] 2170 	call arg_list 
      009AB7 22 04            [ 1] 2171 	cp a,#2  
      009AB9 90 5A            [ 1] 2172 	jreq 1$ 
      009ABB 20 5A A5         [ 2] 2173 	jp syntax_error
      009ABD                       2174 1$:  
      009ABD A1 06 27         [ 2] 2175 	ldw x,#power2
      009AC0 12 A1 0A         [ 2] 2176 	addw x,(BIT+1,sp) 
      009AC3 27               [ 1] 2177 	ld a,(x)
      009AC4 16               [ 1] 2178 	cpl a 
      009AC5 A1 03            [ 2] 2179 	ldw x,(ADDR+1,sp)
      009AC7 27               [ 1] 2180 	and a,(x)
      009AC8 28               [ 1] 2181 	ld (x),a 
      001C35                       2182 	_drop 2*INT_SIZE 
      009AC9 A1 02            [ 2]    1     addw sp,#2*INT_SIZE 
      001C37                       2183 	_next 
      009ACB 27 28 A1         [ 2]    1         jp interp_loop 
                                   2184 
                                   2185 ;---------------------
                                   2186 ; BASIC: BTOGL addr,bit 
                                   2187 ; toggle bit at 'addr' corresponding 
                                   2188 ; 2^^bit xor [addr]
                                   2189 ; arguments:
                                   2190 ; 	addr 	memory address RAM|PERIPHERAL 
                                   2191 ;   bit	    bit to invert      
                                   2192 ; output:
                                   2193 ;	none 
                                   2194 ;--------------------------
                           000001  2195 	BIT=1 
                           000003  2196 	ADDR=BIT+INT_SIZE 
      001C3A                       2197 cmd_bit_toggle:
      009ACE 2E 27 2B         [ 4] 2198 	call arg_list 
      009AD1 20 36            [ 1] 2199 	cp a,#2 
      009AD3 27 03            [ 1] 2200 	jreq 1$ 
      009AD3 93 CD 85         [ 2] 2201 	jp syntax_error
      001C44                       2202 1$: 
      009AD6 A3 90 93         [ 2] 2203 	ldw x,#power2
      009AD9 20 D4 02         [ 2] 2204 	addw x,(BIT+1,sp) 
      009ADB F6               [ 1] 2205 	ld a,(x)
      009ADB CD 97            [ 2] 2206 	ldw x,(ADDR+1,sp) 
      009ADD ED               [ 1] 2207 	xor a,(x)
      009ADE CD               [ 1] 2208 	ld (x),a 
      001C4F                       2209 	_drop 2*INT_SIZE 
      009ADF 97 3F            [ 2]    1     addw sp,#2*INT_SIZE 
      001C51                       2210 	_next 
      009AE1 4D 27 0B         [ 2]    1         jp interp_loop 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 171.
Hexadecimal [24-Bits]



                                   2211 
                                   2212 ;---------------------
                                   2213 ; BASIC: BTEST(addr,bit)
                                   2214 ; return bit value at 'addr' 
                                   2215 ; bit is in range {0..7}.
                                   2216 ; arguments:
                                   2217 ; 	addr 		memory address RAM|PERIPHERAL 
                                   2218 ;   bit 	    bit position {0..7}  
                                   2219 ; output:
                                   2220 ;	A:X       0|1 bit value  
                                   2221 ;--------------------------
                           000001  2222 	BIT=1 
                           000003  2223 	ADDR=BIT+INT_SIZE 
      001C54                       2224 func_bit_test:
      009AE4 88 14 24         [ 4] 2225 	call func_args 
      009AE5 A1 02            [ 1] 2226 	cp a,#2
      009AE5 F6 5C            [ 1] 2227 	jreq 0$
      009AE7 CD 85 2C         [ 2] 2228 	jp syntax_error
      001C5E                       2229 0$:	
      009AEA 0A 01 26         [ 2] 2230 	ldw x,#power2 
      009AED F7 84 02         [ 2] 2231 	addw x,(BIT+1,sp)
      009AEF F6               [ 1] 2232 	ld a,(x)
      009AEF 20 BE            [ 2] 2233 	ldw x,(ADDR+1,sp)   
      009AF1 F4               [ 1] 2234     and a,(x) 
      009AF1 03 01            [ 1] 2235 	jreq 1$
      009AF3 20 BC            [ 1] 2236 	ld a,#1
      009AF5                       2237 1$:	 
      009AF5 A6               [ 1] 2238 	clrw x 
      009AF6 09               [ 1] 2239 	rlwa x 
      001C6E                       2240 	_drop 2*INT_SIZE 
      009AF7 CD 85            [ 2]    1     addw sp,#2*INT_SIZE 
      009AF9 2C               [ 4] 2241 	ret 
                                   2242 
                                   2243 ;--------------------
                                   2244 ; BASIC: POKE addr,byte
                                   2245 ; put a byte at addr 
                                   2246 ;--------------------
                           000001  2247 	VALUE=1
                           000003  2248 	POK_ADR=VALUE+INT_SIZE 
      001C71                       2249 cmd_poke:
      009AFA 20 B3 2F         [ 4] 2250 	call arg_list 
      009AFC A1 02            [ 1] 2251 	cp a,#2
      009AFC 5F 97            [ 1] 2252 	jreq 1$
      009AFE 58 DE 8A         [ 2] 2253 	jp syntax_error
      001C7B                       2254 1$:	
      001C7B                       2255 	_i16_fetch POK_ADR ; address   
      009B01 AE FD            [ 2]    1     ldw x,(POK_ADR,sp)
      009B03 01 CD            [ 1] 2256 	ld a,(VALUE+1,sp) 
      009B05 85               [ 1] 2257 	ld (x),a 
      001C80                       2258 	_drop 2*INT_SIZE 
      009B06 2C 20            [ 2]    1     addw sp,#2*INT_SIZE 
      001C82                       2259 	_next 
      009B08 A6 13 26         [ 2]    1         jp interp_loop 
                                   2260 
                                   2261 ;-----------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 172.
Hexadecimal [24-Bits]



                                   2262 ; BASIC: PEEK(addr)
                                   2263 ; get the byte at addr 
                                   2264 ; input:
                                   2265 ;	none 
                                   2266 ; output:
                                   2267 ;	X 		value 
                                   2268 ;-----------------------
      009B09                       2269 func_peek:
      009B09 90 5A CD         [ 4] 2270 	call func_args
      009B0C 96 5A            [ 1] 2271 	cp a,#1 
      009B0E CD 88            [ 1] 2272 	jreq 1$
      009B10 2E CD 86         [ 2] 2273 	jp syntax_error
      001C8F                       2274 1$: _i16_pop ; address  
      009B13 06               [ 2]    1     popw x 
      009B14 CC               [ 1] 2275 	ld a,(x)
      009B15 9A               [ 1] 2276 	clrw x 
      009B16 AF               [ 1] 2277 	ld xl,a 
      009B17 81               [ 4] 2278 	ret 
                                   2279 
                                   2280 ;---------------------------
                                   2281 ; BASIC IF expr : instructions
                                   2282 ; evaluate expr and if true 
                                   2283 ; execute instructions on same line. 
                                   2284 ;----------------------------
      001C94                       2285 kword_if: 
      009B17 0D 01            [ 1] 2286 	ld a,(y)
      009B19 26 05            [ 1] 2287 	cp a,#STR_VAR_IDX 
      009B1B A6 0D            [ 1] 2288 	jreq if_string 
      009B1D CD 85            [ 1] 2289 	cp a,#QUOTE_IDX
      009B1F 2C 1A            [ 1] 2290 	jreq if_string 
      009B20 CD 15 DA         [ 4] 2291 	call condition
      009B20 5B               [ 2] 2292 	tnzw x 
      009B21 01 CC            [ 1] 2293 	jrne 1$ 
      009B23 93 A6 31         [ 2] 2294 	jp kword_remark 
      009B25 A6 21            [ 1] 2295 1$: ld a,#THEN_IDX 
      009B25 17 05 BE         [ 4] 2296 	call expect 
      001CAC                       2297 cond_accepted: 
      009B28 2B 1F            [ 1] 2298 	ld a,(y)
      009B2A 03 81            [ 1] 2299 	cp a,#LITW_IDX 
      009B2C 26 03            [ 1] 2300 	jrne 2$ 
      009B2C 1E 03 CF         [ 2] 2301 	jp kword_goto
      001CB5                       2302 2$:	_next  
      009B2F 00 2B 16         [ 2]    1         jp interp_loop 
                                   2303 ;-------------------------
                                   2304 ; if string condition 
                                   2305 ;--------------------------
                           000001  2306 	STR1=1 
                           000003  2307 	STR1_LEN=STR1+2
                           000005  2308 	STR2=STR1_LEN+2
                           000007  2309 	STR2_LEN=STR2+2 
                           000009  2310 	OP_REL=STR2_LEN+2 
                           00000A  2311 	YSAVE=OP_REL+1
                           00000B  2312 	VSIZE=YSAVE+1
      001CB8                       2313 if_string: 
      001CB8                       2314 	_vars VSIZE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 173.
Hexadecimal [24-Bits]



      009B32 05 81            [ 2]    1     sub sp,#VSIZE 
      009B34 0F 03            [ 1] 2315 	clr (STR1_LEN,sp)
      009B34 CD 85            [ 1] 2316 	clr (STR2_LEN,sp)
      009B36 E9 AE            [ 1] 2317 	incw y
      009B38 91 D2            [ 1] 2318 	cp a,#QUOTE_IDX
      009B3A CD 85            [ 1] 2319 	jrne 1$ 
      009B3C A3 CD            [ 2] 2320 	ldw (STR1,sp),y 
      009B3E 85               [ 1] 2321 	ldw x,y 
      009B3F E9 81 06         [ 4] 2322 	call strlen 
      009B41 6B 04            [ 1] 2323 	ld (STR1_LEN+1,sp),a
      009B41 A6 3F CD         [ 2] 2324 	addw x,(STR1_LEN,sp)
      009B44 85               [ 1] 2325 	incw x 
      009B45 2C 81            [ 1] 2326 	ldw y,x  
      009B47 20 0A            [ 2] 2327 	jra 2$ 
      001CD4                       2328 1$:	  
      009B47 9E A4 7F         [ 4] 2329 	call get_var_adr 
      009B4A CD 85 41         [ 4] 2330 	call get_string_slice 	
      009B4D 9F A4            [ 2] 2331 	ldw (STR1,sp),x 
      009B4F 7F CD            [ 1] 2332 	ld (STR1_LEN+1,sp),a 
      009B51 85 41            [ 1] 2333 2$: ld a,(y)
      009B53 81 10            [ 1] 2334 	cp a,#REL_LE_IDX 
      009B54 2B 04            [ 1] 2335 	jrmi 3$ 
      009B54 52 06            [ 1] 2336 	cp a,#OP_REL_LAST 
      009B56 0F 03            [ 2] 2337 	jrule 4$
      001CE8                       2338 3$:	
      009B58 CD 9B 47         [ 2] 2339 	jp syntax_error 
      001CEB                       2340 4$: 
      009B5B CD 9B            [ 1] 2341 	ld (OP_REL,sp),a 
      009B5D 41 5F            [ 1] 2342 	incw y 
                                   2343 ;expect second string 	
      001CEF                       2344 	_next_token 
      001CEF                          1         _get_char 
      009B5F 1F 01            [ 1]    1         ld a,(y)    ; 1 cy 
      009B61 1F 05            [ 1]    2         incw y      ; 1 cy 
      009B63 35 0A            [ 1] 2345 	cp a,#QUOTE_IDX
      009B65 00 0F            [ 1] 2346 	jrne 5$ 
      009B67 CD 85            [ 2] 2347 	ldw (STR2,sp),y 
      009B69 50               [ 1] 2348 	ldw x,y 
      009B6A A1 2D 26         [ 4] 2349 	call strlen 
      009B6D 04 03            [ 1] 2350 	ld (STR2_LEN+1,sp),a 
      009B6F 05 20 08         [ 2] 2351 	addw x,(STR2_LEN,sp)
      009B72 A1               [ 1] 2352 	incw x 
      009B73 24 26            [ 1] 2353 	ldw y,x 
      009B75 07 35            [ 2] 2354 	jra 54$
      009B77 10 00            [ 1] 2355 5$: cp a,#STR_VAR_IDX
      009B79 0F CD            [ 1] 2356 	jrne 3$
      009B7B 85 50 A1         [ 4] 2357 	call get_var_adr 
      009B7E 08 26 12         [ 4] 2358 	call get_string_slice 
      009B81 0D 06            [ 2] 2359 	ldw (STR2,sp),x 
      009B83 27 F5            [ 1] 2360 	ld (STR2_LEN+1,sp),a
      001D15                       2361 54$:
      009B85 CD 85            [ 1] 2362 	ld a,#THEN_IDX 
      009B87 D9 1E 01         [ 4] 2363 	call expect
                                   2364 ; compare strings 
      009B8A B6 0F            [ 2] 2365 	ldw (YSAVE,sp),y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 174.
Hexadecimal [24-Bits]



      009B8C 62 1F            [ 2] 2366 	ldw x,(STR1,sp)
      009B8E 01 0A            [ 2] 2367 	ldw y,(STR2,sp)
      001D20                       2368 6$:
      009B90 06 20            [ 1] 2369 	tnz (STR1_LEN+1,sp) 
      009B92 E7 12            [ 1] 2370 	jreq 7$ 
      009B93 0D 08            [ 1] 2371 	tnz (STR2_LEN+1,sp)
      009B93 CD 85            [ 1] 2372 	jreq 7$ 
      009B95 41               [ 1] 2373 	ld a,(x)
      009B96 A1 0D            [ 1] 2374 	cp a,(y)
      009B98 27 17            [ 1] 2375 	jrne 8$ 
      009B9A CD               [ 1] 2376 	incw x 
      009B9B 94 0C            [ 1] 2377 	incw y 
      009B9D 24 1A            [ 1] 2378 	dec (STR1_LEN+1,sp)
      009B9F 0C 06            [ 1] 2379 	dec (STR2_LEN+1,sp)
      009BA1 6B 04            [ 2] 2380 	jra 6$ 
      001D36                       2381 7$: ; string end  
      009BA3 1E 01            [ 1] 2382 	ld a,(STR1_LEN+1,sp)
      009BA5 B6 0F            [ 1] 2383 	cp a,(STR2_LEN+1,sp)
      001D3A                       2384 8$: ; no match  
      009BA7 CD 83            [ 1] 2385 	jrmi 9$ 
      009BA9 78 72            [ 1] 2386 	jrne 10$ 
                                   2387 ; STR1 == STR2  
      009BAB FB 03            [ 1] 2388 	ld a,(OP_REL,sp)
      009BAD 1F 01            [ 1] 2389 	cp a,#REL_EQU_IDX 
      009BAF 20 C9            [ 1] 2390 	jreq 11$ 
      009BB1 1E 01            [ 1] 2391 	jrmi 11$ 
      009BB3 0D 05            [ 2] 2392 	jra 13$ 
      001D48                       2393 9$: ; STR1 < STR2 
      009BB5 27 01            [ 1] 2394 	ld a,(OP_REL,sp)
      009BB7 50 13            [ 1] 2395 	cp a,#REL_LT_IDX 
      009BB8 27 10            [ 1] 2396 	jreq 11$
      009BB8 99 10            [ 1] 2397 	cp a,#REL_LE_IDX  
      009BB9 27 0C            [ 1] 2398 	jreq 11$
      009BB9 5B 06            [ 2] 2399 	jra 13$  
      001D54                       2400 10$: ; STR1 > STR2 
      009BBB 81 09            [ 1] 2401 	ld a,(OP_REL,sp)
      009BBC A1 14            [ 1] 2402 	cp a,#REL_GT_IDX 
      009BBC CD 9B            [ 1] 2403 	jreq 11$ 
      009BBE 47 CD            [ 1] 2404 	cp a,#REL_GE_IDX 
      009BC0 9B 41            [ 1] 2405 	jrne 13$ 
      001D5E                       2406 11$: ; accepted
      009BC2 4F CD            [ 2] 2407 	ldw y,(YSAVE,sp)
      001D60                       2408 	_drop VSIZE 
      009BC4 86 79            [ 2]    1     addw sp,#VSIZE 
      009BC6 AE 16            [ 1] 2409 	ld a,(y)
      009BC8 80 81            [ 1] 2410 	cp a,#LITW_IDX 
      009BCA 26 03            [ 1] 2411 	jrne 12$
      009BCA 72 00 00         [ 2] 2412 	jp kword_goto 
      001D6B                       2413 12$: _next 
      009BCD 3B 05 A6         [ 2]    1         jp interp_loop 
      001D6E                       2414 13$: ; rejected 
      009BD0 11 CC            [ 2] 2415 	ldw y,(YSAVE,sp)
      001D70                       2416 	_drop VSIZE
      009BD2 92 27            [ 2]    1     addw sp,#VSIZE 
      009BD4 CC 13 31         [ 2] 2417 	jp kword_remark  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 175.
Hexadecimal [24-Bits]



      001D75                       2418 	_next 
      009BD4 52 06 90         [ 2]    1         jp interp_loop 
                                   2419 
                                   2420 
                                   2421 ;------------------------
                                   2422 ; BASIC: FOR var=expr 
                                   2423 ; set variable to expression 
                                   2424 ; leave variable address 
                                   2425 ; on stack and set
                                   2426 ; FLOOP bit in 'flags'
                                   2427 ;-----------------
                           000001  2428 	FSTEP=1  ; variable increment int16
                           000003  2429 	LIMIT=FSTEP+INT_SIZE ; loop limit, int16  
                           000005  2430 	CVAR=LIMIT+INT_SIZE   ; control variable data field 
                           000007  2431 	LN_ADDR=CVAR+2   ;  line.addr saved
                           000009  2432 	BPTR=LN_ADDR+2 ; basicptr saved
                           00000A  2433 	VSIZE=BPTR+1  
      001D78                       2434 kword_for: ; { -- var_addr }
      001D78                       2435 	_vars VSIZE
      009BD7 F6 A1            [ 2]    1     sub sp,#VSIZE 
      001D7A                       2436 	_ldaz for_nest 
      009BD9 06 26                    1     .byte 0xb6,for_nest 
      009BDB 16 90            [ 1] 2437 	cp a,#8 
      009BDD 5C 93            [ 1] 2438 	jrmi 1$ 
      009BDF CD 85            [ 1] 2439 	ld a,#ERR_FORS
      009BE1 A3 90 93         [ 2] 2440 	jp tb_error 
      009BE4 CD               [ 1] 2441 1$: inc a 
      001D86                       2442 	_straz for_nest 
      009BE5 85 E9                    1     .byte 0xb7,for_nest 
      009BE7 90 F6 90         [ 2] 2443 	ldw x,#1 
      009BEA 5C A1            [ 2] 2444 	ldw (FSTEP,sp),x  
      009BEC 02 27            [ 1] 2445 	ld a,#VAR_IDX 
      009BEE 03 CC 92         [ 4] 2446 	call expect 
      009BF1 25 17 6D         [ 4] 2447 	call get_var_adr
      009BF2 1C 00 02         [ 2] 2448 	addw x,#2 
      009BF2 90 F6            [ 2] 2449 	ldw (CVAR,sp),x  ; control variable 
      001D9A                       2450 	_strxz ptr16 
      009BF4 90 5C                    1     .byte 0xbf,ptr16 
      009BF6 A1 02            [ 1] 2451 	ld a,#REL_EQU_IDX 
      009BF8 2B 5C A1         [ 4] 2452 	call expect 
      009BFB 09 27 07         [ 4] 2453 	call expression
      009BFE A1 0A 27 2E      [ 5] 2454 	ldw [ptr16],x
      009C02 CC 92            [ 1] 2455 	ld a,#TO_IDX 
      009C04 25 14 16         [ 4] 2456 	call expect 
                                   2457 ;-----------------------------------
                                   2458 ; BASIC: TO expr 
                                   2459 ; second part of FOR loop initilization
                                   2460 ; leave limit on stack and set 
                                   2461 ; FTO bit in 'flags'
                                   2462 ;-----------------------------------
      009C05                       2463 kword_to: ; { var_addr -- var_addr limit step }
      009C05 93 FE 1F         [ 4] 2464     call expression   
      001DB0                       2465 2$:
      009C08 05 1E            [ 2] 2466 	ldw (LIMIT,sp),x
      001DB2                       2467 	_next_token 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 176.
Hexadecimal [24-Bits]



      001DB2                          1         _get_char 
      009C0A 05 CD            [ 1]    1         ld a,(y)    ; 1 cy 
      009C0C 9B 54            [ 1]    2         incw y      ; 1 cy 
      009C0E 25 05            [ 1] 2468 	cp a,#STEP_IDX 
      009C10 CD 9B            [ 1] 2469 	jreq kword_step
      001DBA                       2470 	_unget_token
      009C12 34 20            [ 2]    1         decw y
      009C14 F4 05            [ 2] 2471 	jra store_loop_addr 
                                   2472 
                                   2473 ;----------------------------------
                                   2474 ; BASIC: STEP expr 
                                   2475 ; optional third par of FOR loop
                                   2476 ; initialization. 	
                                   2477 ;------------------------------------
      009C15                       2478 kword_step: ; {var limit -- var limit step}
      009C15 1F 03 CD         [ 4] 2479     call expression 
      001DC1                       2480 2$:	
      009C18 97 ED            [ 2] 2481 	ldw (FSTEP,sp),x ; step
                                   2482 ; leave loop back entry point on stack 
      001DC3                       2483 store_loop_addr:
      009C1A CD 98            [ 2] 2484 	ldw (BPTR,sp),y 
      001DC5                       2485 	_ldxz line.addr 
      009C1C 4C 7B                    1     .byte 0xbe,line.addr 
      009C1E 03 F7            [ 2] 2486 	ldw (LN_ADDR,sp),x   
      001DC9                       2487 	_next 
      009C20 7B 04 E7         [ 2]    1         jp interp_loop 
                                   2488 
                                   2489 ;--------------------------------
                                   2490 ; BASIC: NEXT var 
                                   2491 ; FOR loop control 
                                   2492 ; increment variable with step 
                                   2493 ; and compare with limit 
                                   2494 ; loop if threshold not crossed.
                                   2495 ; else stack. 
                                   2496 ;--------------------------------
                           000002  2497 	OFS=2 ; offset added by pushw y 
      001DCC                       2498 kword_next: ; {var limit step retl1 -- [var limit step ] }
                                   2499 ; skip over variable name 
      001DCC                       2500 	_tnz for_nest 
      009C23 01 41                    1     .byte 0x3d,for_nest 
      009C24 26 05            [ 1] 2501 	jrne 1$ 
      009C24 90 F6            [ 1] 2502 	ld a,#ERR_BAD_NEXT 
      009C26 90 5C A1         [ 2] 2503 	jp tb_error
      001DD5                       2504 1$:
      009C29 02 27 C6 90      [ 2] 2505 	addw y,#3 ; ignore variable token 
      009C2D 5A 20            [ 2] 2506 	ldw x,(CVAR,sp)
      001DDB                       2507 	_strxz ptr16 
      009C2F 26 12                    1     .byte 0xbf,ptr16 
                                   2508 	; increment variable 
      009C30 FE               [ 2] 2509 	ldw x,(x)  ; get var value 
      009C30 93 FE 1F         [ 2] 2510 	addw x,(FSTEP,sp) ; var+step 
      009C33 05 CD 9B BC      [ 5] 2511 	ldw [ptr16],x 
      009C37 CD 97 ED         [ 2] 2512 	subw x,(LIMIT,sp) 
      001DE8                       2513 	_strxz acc16 
      009C3A 1F 05                    1     .byte 0xbf,acc16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 177.
Hexadecimal [24-Bits]



      009C3C CD 97            [ 1] 2514 	jreq loop_back
      001DEC                       2515 	_ldaz acc16 
      009C3E 3F 17                    1     .byte 0xb6,acc16 
      009C40 01 90            [ 1] 2516 	xor a,(FSTEP,sp)
      009C42 AE 16            [ 1] 2517 	jrpl loop_done 
      001DF2                       2518 loop_back:
      009C44 80 CD            [ 2] 2519 	ldw y,(BPTR,sp)
      009C46 88 A0            [ 2] 2520 	ldw x,(LN_ADDR,sp)
      009C48 AE 16 80         [ 2] 2521 	ldw line.addr,x 
      001DF9                       2522 1$:	_next 
      009C4B CD 88 86         [ 2]    1         jp interp_loop 
      001DFC                       2523 loop_done:
      001DFC                       2524 	_decz for_nest 
      009C4E 1E 05                    1     .byte 0x3a,for_nest 
                                   2525 	; remove loop data from stack  
      001DFE                       2526 	_drop VSIZE 
      009C50 FE F7            [ 2]    1     addw sp,#VSIZE 
      001E00                       2527 	_next 
      009C52 16 01 20         [ 2]    1         jp interp_loop 
                                   2528 
                                   2529 ;----------------------------
                                   2530 ; called by goto/gosub
                                   2531 ; to get target line number 
                                   2532 ; output:
                                   2533 ;    x    line address 
                                   2534 ;---------------------------
      001E03                       2535 get_target_line:
      009C55 CE 14 F8         [ 4] 2536 	call expression 
      009C56                       2537 target01: 
      009C56 5B               [ 1] 2538 	clr a 
      009C57 06 CC 93 A6 0C   [ 2] 2539 	btjf flags,#FRUN,2$ 
      009C5B 72 C3 00 2B      [ 4] 2540 0$:	cpw x,[line.addr] 
      009C5B CD 94            [ 1] 2541 	jrult 2$ ; search from lomem 
      009C5D AF A1            [ 1] 2542 	jrugt 1$
      009C5F 02 24 03         [ 2] 2543 	ldw x,line.addr
      009C62 CC               [ 1] 2544 1$:	cpl a  ; search from this line#
      001E18                       2545 2$: 	
      009C63 92 25 A1         [ 4] 2546 	call search_lineno 
      009C66 03               [ 1] 2547 	tnz a ; 0 if not found  
      009C67 27 06            [ 1] 2548 	jrne 3$ 
      009C69 4B 00            [ 1] 2549 	ld a,#ERR_BAD_BRANCH  
      009C6B 4B 00 4B         [ 2] 2550 	jp tb_error 
      001E23                       2551 3$:
      009C6E 00               [ 4] 2552 	ret 
                                   2553 
                                   2554 ;------------------------
                                   2555 ; BASIC: GOTO line# 
                                   2556 ; jump to line# 
                                   2557 ; here cstack is 2 call deep from interpreter 
                                   2558 ;------------------------
      009C6F                       2559 kword_goto:
      001E24                       2560 kword_goto_1:
      009C6F 1E 06 F6         [ 4] 2561 	call get_target_line
      009C72 14 05 18 03 27   [ 2] 2562 	btjt flags,#FRUN,1$
                                   2563 ; goto line# from command line 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 178.
Hexadecimal [24-Bits]



      009C77 F9 5B 06 CC      [ 1] 2564 	bset flags,#FRUN 
      001E30                       2565 1$:
      001E30                       2566 jp_to_target:
      009C7B 93 A6 01         [ 2] 2567 	ldw line.addr,x 
      009C7E 02 04 08         [ 2] 2568 	addw x,#LINE_HEADER_SIZE
      009C81 10 20            [ 1] 2569 	ldw y,x   
      009C83 40 80 00 3B 03   [ 2] 2570 	btjf flags,#FTRACE,9$ 
      009C85 CD 13 60         [ 4] 2571 	call prt_line_no 
      001E40                       2572 9$:	_next
      009C85 CD 94 AF         [ 2]    1         jp interp_loop 
                                   2573 
                                   2574 
                                   2575 ;--------------------
                                   2576 ; BASIC: GOSUB line#
                                   2577 ; basic subroutine call
                                   2578 ; actual line# and basicptr 
                                   2579 ; are saved on stack
                                   2580 ;--------------------
                           000001  2581 	RET_BPTR=1 ; basicptr return point 
                           000003  2582 	RET_LN_ADDR=3  ; line.addr return point 
                           000004  2583 	VSIZE=4 
      001E43                       2584 kword_gosub:
      001E43                       2585 kword_gosub_1:
      001E43                       2586 	_ldaz gosub_nest 
      009C88 A1 02                    1     .byte 0xb6,gosub_nest 
      009C8A 27 03            [ 1] 2587 	cp a,#8 
      009C8C CC 92            [ 1] 2588 	jrmi 1$
      009C8E 25 07            [ 1] 2589 	ld a,#ERR_GOSUBS
      009C8F CC 11 A7         [ 2] 2590 	jp tb_error 
      009C8F AE               [ 1] 2591 1$: inc a
      001E4F                       2592 	_straz gosub_nest 
      009C90 9C 7D                    1     .byte 0xb7,gosub_nest 
      009C92 72 FB 02         [ 4] 2593 	call get_target_line 
      009C95 F6 1E 04         [ 2] 2594 	ldw ptr16,x ; target line address 
      001E57                       2595 kword_gosub_2: 
      001E57                       2596 	_vars VSIZE  
      009C98 FA F7            [ 2]    1     sub sp,#VSIZE 
                                   2597 ; save BASIC subroutine return point.   
      009C9A 5B 04            [ 2] 2598 	ldw (RET_BPTR,sp),y 
      001E5B                       2599 	_ldxz line.addr 
      009C9C CC 93                    1     .byte 0xbe,line.addr 
      009C9E A6 03            [ 2] 2600 	ldw (RET_LN_ADDR,sp),x
      009C9F                       2601 	_ldxz ptr16  
      009C9F CD 94                    1     .byte 0xbe,ptr16 
      009CA1 AF A1            [ 2] 2602 	jra jp_to_target
                                   2603 
                                   2604 ;------------------------
                                   2605 ; BASIC: RETURN 
                                   2606 ; exit from BASIC subroutine 
                                   2607 ;------------------------
      001E63                       2608 kword_return:
      009CA3 02 27 03 CC      [ 1] 2609 	tnz gosub_nest 
      009CA7 92 25            [ 1] 2610 	jrne 1$ 
      009CA9 A6 05            [ 1] 2611 	ld a,#ERR_BAD_RETURN 
      009CA9 AE 9C 7D         [ 2] 2612 	jp tb_error 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 179.
Hexadecimal [24-Bits]



      001E6E                       2613 1$:
      001E6E                       2614 	_decz gosub_nest
      009CAC 72 FB                    1     .byte 0x3a,gosub_nest 
      009CAE 02 F6            [ 2] 2615 	ldw y,(RET_BPTR,sp) 
      009CB0 43 1E            [ 2] 2616 	ldw x,(RET_LN_ADDR,sp)
      009CB2 04 F4 F7         [ 2] 2617 	ldw line.addr,x 
      001E77                       2618 	_drop VSIZE 
      009CB5 5B 04            [ 2]    1     addw sp,#VSIZE 
      001E79                       2619 	_next 
      009CB7 CC 93 A6         [ 2]    1         jp interp_loop 
                                   2620 
                                   2621 ;----------------------------------
                                   2622 ; BASIC: RUN [line#]
                                   2623 ; run BASIC program in RAM
                                   2624 ;----------------------------------- 
      009CBA                       2625 cmd_run: 
      009CBA CD 94 AF A1 02   [ 2] 2626 	btjf flags,#FRUN,1$  
      001E81                       2627 	_next ; already running 
      009CBF 27 03 CC         [ 2]    1         jp interp_loop 
      001E84                       2628 1$: 
      009CC2 92 25 62         [ 4] 2629 	call clear_state 
      009CC4 AE 17 FF         [ 2] 2630 	ldw x,#STACK_EMPTY
      009CC4 AE               [ 1] 2631 	ldw sp,x 
      009CC5 9C 7D 72         [ 4] 2632 	call arg_list 
      009CC8 FB               [ 1] 2633 	tnz  a 
      009CC9 02 F6            [ 1] 2634 	jreq 2$
      001E91                       2635 	_i16_pop
      009CCB 1E               [ 2]    1     popw x 
      009CCC 04               [ 1] 2636 	clr a  
      009CCD F8 F7 5B         [ 4] 2637 	call search_lineno 
      009CD0 04               [ 1] 2638 	tnz a
      009CD1 CC 93            [ 1] 2639 	jrne 3$ 
      009CD3 A6 0D            [ 1] 2640 	ld a,#ERR_RANGE 
      009CD4 CC 11 A7         [ 2] 2641 	jp tb_error 
      001E9E                       2642 2$:
      009CD4 CD 94 A4         [ 2] 2643 	ldw x,lomem 
      001EA1                       2644 3$:
      001EA1                       2645 	_strxz line.addr 
      009CD7 A1 02                    1     .byte 0xbf,line.addr 
      009CD9 27 03 CC         [ 2] 2646 	addw x,#LINE_HEADER_SIZE
      009CDC 92 25            [ 1] 2647 	ldw y,x 
      009CDE 72 10 00 3B      [ 1] 2648 	bset flags,#FRUN 
      001EAC                       2649 	_next 
      009CDE AE 9C 7D         [ 2]    1         jp interp_loop 
                                   2650 
                                   2651 
                                   2652 ;----------------------
                                   2653 ; BASIC: END
                                   2654 ; end running program
                                   2655 ;---------------------- 
                           000001  2656 	CHAIN_LN=1 
                           000003  2657 	CHAIN_BP=3
                           000005  2658 	CHAIN_TXTBGN=5
                           000007  2659 	CHAIN_TXTEND=7
                           000008  2660 	CHAIN_CNTX_SIZE=8  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 180.
Hexadecimal [24-Bits]



      001EAF                       2661 kword_end: 
                           000000  2662 .if 0
                                   2663 ; check for chained program 
                                   2664 	tnz chain_level
                                   2665 	jreq 8$
                                   2666 ; restore chain context 
                                   2667 	dec chain_level 
                                   2668 	ldw x,(CHAIN_LN,sp) ; chain saved in and count  
                                   2669 	ldw line.addr,x 
                                   2670 ;	ld a,(2,x)
                                   2671 ;	_straz count 
                                   2672 	ldw Y,(CHAIN_BP,sp) ; chain saved basicptr 
                                   2673 ;	ldw basicptr,Y 
                                   2674 	ldw x,(CHAIN_TXTBGN,sp)
                                   2675 	ldw lomem,x 
                                   2676 	ldw x,(CHAIN_TXTEND,sp)
                                   2677 	ldw himem,x 
                                   2678 	_drop CHAIN_CNTX_SIZE ; CHAIN saved data size  
                                   2679 	_next
                                   2680 .endif 	   
      001EAF                       2681 8$: ; clean stack 
      009CE1 72 FB 02         [ 2] 2682 	ldw x,#STACK_EMPTY
      009CE4 F6               [ 1] 2683 	ldw sp,x 
      001EB3                       2684 	_rst_pending 
      009CE5 1E 04 F4         [ 2]    1     ldw x,#pending_stack+PENDING_STACK_SIZE
      001EB6                          2     _strxz psp 
      009CE8 27 02                    1     .byte 0xbf,psp 
      009CEA A6 01 EE         [ 2] 2685 	jp warm_start
                                   2686 
                                   2687 ;---------------------------
                                   2688 ; BASIC: GET var 
                                   2689 ; receive a key in variable 
                                   2690 ; don't wait 
                                   2691 ;---------------------------
      009CEC                       2692 cmd_get:
      001EBB                       2693 	_next_token 
      001EBB                          1         _get_char 
      009CEC 5F 02            [ 1]    1         ld a,(y)    ; 1 cy 
      009CEE 5B 04            [ 1]    2         incw y      ; 1 cy 
      009CF0 81 09            [ 1] 2694 	cp a,#VAR_IDX 
      009CF1 27 03            [ 1] 2695 	jreq 0$
      009CF1 CD 94 AF         [ 2] 2696 	jp syntax_error 
      001EC6                       2697 0$: _get_addr 
      009CF4 A1               [ 1]    1         ldw x,y     ; 1 cy 
      009CF5 02               [ 2]    2         ldw x,(x)   ; 2 cy 
      009CF6 27 03 CC 92      [ 2]    3         addw y,#2   ; 2 cy 
      009CFA 25 00 12         [ 2] 2698 	ldw ptr16,x 
      009CFB CD 04 CA         [ 4] 2699 	call qgetc 
      009CFB 1E 03            [ 1] 2700 	jreq 2$
      009CFD 7B 02 F7         [ 4] 2701 	call getc  
      009D00 5B 04 CC 93      [ 4] 2702 2$: clr [ptr16]
      001EDB                       2703 	_incz ptr8 
      009D04 A6 13                    1     .byte 0x3c, ptr8 
      009D05 72 3F 00 12      [ 4] 2704 	clr [ptr16]
      001EE1                       2705 	_incz ptr8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 181.
Hexadecimal [24-Bits]



      009D05 CD 94                    1     .byte 0x3c, ptr8 
      009D07 A4 A1 01 27      [ 4] 2706 	ld [ptr16],a 
      001EE7                       2707 	_next 
      009D0B 03 CC 92         [ 2]    1         jp interp_loop 
                                   2708 
                                   2709 ;-----------------------
                                   2710 ; BASIC: TONE expr1,expr2
                                   2711 ; use TIMER2 channel 1
                                   2712 ; to produce a tone 
                                   2713 ; arguments:
                                   2714 ;    expr1   frequency 
                                   2715 ;    expr2   duration msec.
                                   2716 ;---------------------------
                           000001  2717 	DURATION=1 
                           000003  2718 	FREQ=DURATION+INT_SIZE
                           000005  2719 	YSAVE=FREQ+INT_SIZE 
                           000006  2720 	VSIZE=2*INT_SIZE+2    
      001EEA                       2721 cmd_tone:
      009D0E 25 85            [ 2] 2722 	pushw y
      009D10 F6 5F 97         [ 4] 2723 	call arg_list 
      009D13 81 02            [ 1] 2724 	cp a,#2 
      009D14 27 03            [ 1] 2725 	jreq 0$ 
      009D14 90 F6 A1         [ 2] 2726 	jp syntax_error
      001EF6                       2727 0$:  
      009D17 0A 27            [ 2] 2728 	ldw (YSAVE,sp),y 
      001EF8                       2729 	_i16_fetch  FREQ 
      009D19 1E A1            [ 2]    1     ldw x,(FREQ,sp)
      009D1B 06 27            [ 1] 2730 	ldw y,x 
      001EFC                       2731 	_i16_fetch  DURATION 
      009D1D 1A CD            [ 2]    1     ldw x,(DURATION,sp)
      009D1F 96 5A 5D         [ 4] 2732 	call tone  
      009D22 26 03            [ 2] 2733 	ldw y,(YSAVE,sp)
      001F03                       2734 	_drop VSIZE 
      009D24 CC 93            [ 2]    1     addw sp,#VSIZE 
      001F05                       2735 	_next 
      009D26 B1 A6 21         [ 2]    1         jp interp_loop 
                                   2736 
                                   2737 
                           000001  2738 .if 1
                                   2739 ;-----------------------
                                   2740 ; BASIC: STOP
                                   2741 ; stop progam execution  
                                   2742 ; without resetting pointers 
                                   2743 ; the program is resumed
                                   2744 ; with RUN 
                                   2745 ;-------------------------
      001F08                       2746 kword_stop:
      009D29 CD 94 96 3B 03   [ 2] 2747 	btjt flags,#FRUN,2$
      009D2C                       2748 	_next 
      009D2C 90 F6 A1         [ 2]    1         jp interp_loop 
      001F10                       2749 2$:	 
                                   2750 ; create space on cstack to save context 
      009D2F 08 26 03         [ 2] 2751 	ldw x,#stop_msg 
      009D32 CC 9E A4         [ 4] 2752 	call puts 
      001F16                       2753 	_ldxz line.addr
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 182.
Hexadecimal [24-Bits]



      009D35 CC 93                    1     .byte 0xbe,line.addr 
      009D37 A6               [ 2] 2754 	ldw x,(x)
      009D38 CD 07 AE         [ 4] 2755 	call print_int 
      009D38 52 0B 0F         [ 2] 2756 	ldw x,#con_msg 
      009D3B 03 0F 07         [ 4] 2757 	call puts 
      001F22                       2758 	_vars CTXT_SIZE ; context size 
      009D3E 90 5C            [ 2]    1     sub sp,#CTXT_SIZE 
      009D40 A1 06 26         [ 4] 2759 	call save_context 
      009D43 10 17 01 93      [ 1] 2760 	bres flags,#FRUN 
      009D47 CD 88 86 6B      [ 1] 2761 	bset flags,#FSTOP
      009D4B 04 72 FB         [ 2] 2762 	jp cmd_line  
                                   2763 
      009D4E 03 5C 90 93 20 0A 61  2764 stop_msg: .asciz "\nSTOP at line "
             74 20 6C 69 6E 65 20
             00
      009D54 2C 20 43 4F 4E 20 74  2765 con_msg: .asciz ", CON to resume.\n"
             6F 20 72 65 73 75 6D
             65 2E 0A 00
                                   2766 
                                   2767 ;--------------------------------------
                                   2768 ; BASIC: CON 
                                   2769 ; continue execution after a STOP 
                                   2770 ;--------------------------------------
      001F53                       2771 kword_con:
      009D54 CD 97 ED CD 97   [ 2] 2772 	btjt flags,#FSTOP,1$ 
      001F58                       2773 	_next 
      009D59 3F 1F 01         [ 2]    1         jp interp_loop 
      001F5B                       2774 1$:
      009D5C 6B 04 90         [ 4] 2775 	call rest_context 
      001F5E                       2776 	_drop CTXT_SIZE
      009D5F F6 A1            [ 2]    1     addw sp,#CTXT_SIZE 
      009D61 10 2B 04 A1      [ 1] 2777 	bres flags,#FSTOP 
      009D65 15 23 03 3B      [ 1] 2778 	bset flags,#FRUN 
      009D68 CC 13 26         [ 2] 2779 	jp interp_loop
                                   2780 
                                   2781 .endif 
                                   2782 
                                   2783 
                                   2784 ;-----------------------
                                   2785 ; BASIC: SCR (NEW)
                                   2786 ; from command line only 
                                   2787 ; free program memory
                                   2788 ; and clear variables 
                                   2789 ;------------------------
      001F6B                       2790 cmd_scr: 
      001F6B                       2791 cmd_new: 
      001F6B                       2792 0$:	_clrz flags 
      009D68 CC 92                    1     .byte 0x3f, flags 
      009D6A 25 12 83         [ 4] 2793 	call reset_basic 
      009D6B                       2794 	_next 
      009D6B 6B 09 90         [ 2]    1         jp interp_loop 
                                   2795 
                           000000  2796 .if 0
                                   2797 ;-----------------------------------
                                   2798 ; BASIC: ERASE \E | \F | name 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 183.
Hexadecimal [24-Bits]



                                   2799 ;  options:
                                   2800 ;     \E    erase EEPROM 
                                   2801 ;     \F    erase all block in range from 
                                   2802 ;  			'app_space' to FLASH end (0x27fff)
                                   2803 ;   name    erase that program only  
                                   2804 ;-----------------------------------
                                   2805 	LIMIT=1  ; 24 bits address 
                                   2806 	VSIZE = 3 
                                   2807 cmd_erase:
                                   2808 	_clrz farptr 
                                   2809 	_next_token
                                   2810 	cp a,#LABEL_IDX 
                                   2811 	jrne not_file
                                   2812 erase_program: 
                                   2813 	pushw y
                                   2814 	call skip_label 
                                   2815 	popw x 
                                   2816 	incw x 
                                   2817 	call search_program
                                   2818 	tnzw x 
                                   2819 	jreq 9$  ; not found 
                                   2820 	call erase_file  
                                   2821 9$:	_next 
                                   2822 not_file: 
                                   2823 	_vars VSIZE 
                                   2824 	cp a,#LITC_IDX 
                                   2825 	jreq 0$ 
                                   2826 	jp syntax_error	
                                   2827 0$: _get_char 
                                   2828 	and a,#0XDF 
                                   2829 	cp a,#'E
                                   2830 	jrne 1$
                                   2831 	ldw x,#EEPROM_BASE 
                                   2832 	ldw farptr+1,x 
                                   2833 	ldw x,#EEPROM_END
                                   2834 	clr a 
                                   2835 	jra 3$ 
                                   2836 1$: cp a,#'F 
                                   2837 	jreq 2$
                                   2838 	ldw x,#err_bad_value
                                   2839 	jp tb_error
                                   2840 2$:
                                   2841 	ldw x,#app_space  
                                   2842 	ldw farptr+1,x 
                                   2843 	ld a,#FLASH_END>>16 
                                   2844 	ldw x,#FLASH_END&0xffff	
                                   2845 3$:
                                   2846 	ld (LIMIT,sp),a 
                                   2847 	ldw (LIMIT+1,sp),x 
                                   2848 ; operation done from RAM
                                   2849 ; copy code to RAM in tib   
                                   2850 	call move_erase_to_ram
                                   2851 4$:	 
                                   2852     call scan_block 
                                   2853 	jreq 5$  ; block already erased 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 184.
Hexadecimal [24-Bits]



                                   2854     ld a,#'E 
                                   2855     call putc 
                                   2856 	call block_erase
                                   2857 	jra 6$   
                                   2858 ; this block is clean, next  
                                   2859 5$:	
                                   2860 	ld a,#'. 
                                   2861 	call putc 
                                   2862 6$:	ldw x,#BLOCK_SIZE
                                   2863 	call incr_farptr
                                   2864 ; check limit, 24 bit substraction  	
                                   2865 	ld a,(LIMIT,sp)
                                   2866 	ldw x,(LIMIT+1,sp)
                                   2867 	subw x,farptr+1
                                   2868 	sbc a,farptr 	 
                                   2869 	jrsge 4$ 
                                   2870 9$: call reset_basic
                                   2871 	ldw x,(LIMIT+1,sp)
                                   2872 	cpw x,#EEPROM_END
                                   2873 	jrne 10$
                                   2874 	call eefree 
                                   2875 10$:
                                   2876 	_drop VSIZE 
                                   2877 	_next 
                                   2878 	
                                   2879 ;---------------------------------------
                                   2880 ; BASIC: SAVE
                                   2881 ; write application from RAM to FLASH
                                   2882 ; at UFLASH address
                                   2883 ;--------------------------------------
                                   2884 	XTEMP=1
                                   2885 	COUNT=3  ; last count bytes written 
                                   2886 	CNT_LO=4 ; count low byte 
                                   2887 	TOWRITE=5 ; how bytes left to write  
                                   2888 	VSIZE=6 
                                   2889 cmd_save:
                                   2890 	pushw y 
                                   2891 	_vars VSIZE
                                   2892 	clr (COUNT,sp)
                                   2893 	call prog_size 
                                   2894 	jrne 0$
                                   2895 	_ldxz #NO_PROG 
                                   2896 	call puts  
                                   2897 	jp 9$ ; no program to save 
                                   2898 0$:	addw x,#FILE_HEADER_SIZE
                                   2899 	ldw (TOWRITE,sp),x ; program size
                                   2900 ; to save it first line must be a label 
                                   2901 	_ldxz lomem
                                   2902 	ld a,(3,x) ; first bytecode on line 
                                   2903 	cp a,#LABEL_IDX 
                                   2904 	jreq 1$
                                   2905 	jp 8$ ; can't be saved, not labeled 	
                                   2906 1$:	; check if file already exist 
                                   2907 	addw x,#LINE_HEADER_SIZE+1 ; *label 
                                   2908 	call search_program 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 185.
Hexadecimal [24-Bits]



                                   2909 	jreq 11$
                                   2910 	call erase_file 
                                   2911 11$:
                                   2912 	_clrz farptr 
                                   2913 	ldw x,(TOWRITE,sp)
                                   2914 	call search_fit
                                   2915 	tnzw x 
                                   2916 	jrne 2$
                                   2917 	ld a,#ERR_MEM_FULL
                                   2918 	jp tb_error 
                                   2919 2$: ; check if header bytes are zero's 
                                   2920 	ldw ptr16,x  
                                   2921 	ld a,(x)
                                   2922 	or a,(1,x)
                                   2923 	or a,(2,x)
                                   2924 	or a,(3,x)
                                   2925 	jreq 3$
                                   2926 	call erase_header ; preserve X and farptr 
                                   2927 3$: 
                                   2928 ; block programming flash
                                   2929 ; must be done from RAM
                                   2930 ; moved in tib  
                                   2931 	call move_prg_to_ram
                                   2932 ; initialize written bytes count  
                                   2933 	clr (COUNT,sp)
                                   2934 ; first bock 
                                   2935 ; containt signature 2 bytes 
                                   2936 ; and size 	2 bytes 
                                   2937 ; use Y as pointer to block_buffer
                                   2938 	call clear_block_buffer ; -- y=*block_buffer	
                                   2939 ; write signature
                                   2940 	ldw x,SIGNATURE ; "TB" 
                                   2941 	ldw (y),x 
                                   2942 	addw y,#2
                                   2943 	ldw x,(TOWRITE,sp)
                                   2944 	subw x,#FILE_HEADER_SIZE 
                                   2945 	ldw (y),x
                                   2946 	addw y,#2   
                                   2947 	ld a,#(BLOCK_SIZE-4)
                                   2948 	cpw x,#(BLOCK_SIZE-4) 
                                   2949 	jrugt 4$
                                   2950 	ld a,xl 
                                   2951 4$:	ld (CNT_LO,sp),a   
                                   2952 	_ldxz lomem 
                                   2953 	ldw (XTEMP,sp),x 
                                   2954 5$: 
                                   2955 	ldw x,(XTEMP,sp)
                                   2956 	ld a,(CNT_LO,sp)
                                   2957 	call fill_write_buffer 
                                   2958 	ldw (XTEMP,sp),x 
                                   2959 	ldw x,#block_buffer
                                   2960 	call write_buffer
                                   2961 	ldw x,#BLOCK_SIZE 
                                   2962 	call incr_farptr  
                                   2963 ; following blocks 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 186.
Hexadecimal [24-Bits]



                                   2964 	ldw x,(XTEMP,sp)
                                   2965 	cpw x,himem 
                                   2966 	jruge 9$ 
                                   2967 	ldw x,(TOWRITE,sp)
                                   2968 	subw x,(COUNT,sp)
                                   2969 	ldw (TOWRITE,sp),x 
                                   2970 	ld a,#BLOCK_SIZE 
                                   2971 	cpw x,#BLOCK_SIZE 
                                   2972 	jruge 6$ 
                                   2973 	ld a,xl 
                                   2974 6$:	ld (CNT_LO,sp),a 
                                   2975 	call clear_block_buffer 
                                   2976 	jra 5$ 
                                   2977 8$: ; no label can't save
                                   2978 	ldw x,#NO_LABEL 
                                   2979 	call puts 	
                                   2980 9$:	
                                   2981 	_drop VSIZE 
                                   2982     popw y 
                                   2983 	clr(y)
                                   2984 	_next 
                                   2985 
                                   2986 NO_PROG: .asciz "No program in RAM."
                                   2987 
                                   2988 ;---------------------
                                   2989 ; BASIC: DIR 
                                   2990 ; list programs saved 
                                   2991 ; in flash 
                                   2992 ;--------------------
                                   2993 	XTEMP=1 
                                   2994 cmd_dir:
                                   2995 	push base 
                                   2996 	ldw x,#app_space 
                                   2997 	pushw x 
                                   2998 1$: 
                                   2999 	_qsign 
                                   3000 	jrne 4$
                                   3001 	addw x,#4
                                   3002 	mov base,#16
                                   3003 	call print_int
                                   3004 	ld a,#SPACE 
                                   3005 	call putc 
                                   3006 	ldw x,(XTEMP,sp)
                                   3007 	ldw x,(2,x) ; program size 
                                   3008 	mov base,#10  
                                   3009 	call print_int 
                                   3010 	ldw x,#STR_BYTES
                                   3011 	call puts
                                   3012 	ld a,#', 
                                   3013 	call putc
                                   3014 	ldw x,(XTEMP,sp)
                                   3015 	addw x,#8 ; first token of program 
                                   3016 	call puts 
                                   3017 	ld a,#CR 
                                   3018 	call putc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 187.
Hexadecimal [24-Bits]



                                   3019 	ldw x,(1,sp)
                                   3020 3$:	call skip_to_next
                                   3021 	ldw (1,sp),x 
                                   3022 	jra 1$
                                   3023 4$: ; check if it is an erased program 
                                   3024 	_is_erased 
                                   3025 	jreq 3$ 
                                   3026 8$: ; done 
                                   3027 	_drop 2 
                                   3028 	pop base 
                                   3029 	_next 
                                   3030 
                                   3031 ;;;;;;;;;;;;;;;;;;;;;;;;;
                                   3032 ; check if farptr address 
                                   3033 ; read only zone 
                                   3034 ;;;;;;;;;;;;;;;;;;;;;;;;;
                                   3035 check_forbidden: 
                                   3036 	tnz farptr 
                                   3037 	jrne rw_zone 
                                   3038 ; memory 0x8000..0xffff	
                                   3039 	_ldxz ptr16 
                                   3040 	cpw x,#app_space
                                   3041 	jruge rw_zone 
                                   3042 	cpw x,#OPTION_END  
                                   3043 	jrugt forbidden  
                                   3044 	cpw x,#OPTION_BASE  
                                   3045 	jruge rw_zone 
                                   3046 1$:	cpw x,#EEPROM_END 
                                   3047 	jrugt forbidden 
                                   3048 	cpw x,#EEPROM_BASE 
                                   3049 	jrult forbidden
                                   3050 	ret 
                                   3051 forbidden:
                                   3052 	ld a,#ERR_BAD_VALUE
                                   3053 	jp tb_error 
                                   3054 rw_zone:	
                                   3055 	ret 
                                   3056 
                                   3057 ;---------------------
                                   3058 ; BASIC: WRITE expr1,expr2|char|string[,expr|char|string]* 
                                   3059 ; write 1 or more byte to FLASH or EEPROM
                                   3060 ; starting at address  
                                   3061 ; input:
                                   3062 ;   expr1  	is address 
                                   3063 ;   expr2,...,exprn   are bytes to write
                                   3064 ; output:
                                   3065 ;   none 
                                   3066 ;---------------------
                                   3067 cmd_write:
                                   3068 	call expression
                                   3069 	_straz farptr 
                                   3070 	_strxz ptr16
                                   3071 	call check_forbidden 
                                   3072 1$:	
                                   3073 	_next_token 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 188.
Hexadecimal [24-Bits]



                                   3074 	cp a,#COMMA_IDX 
                                   3075 	jreq 2$ 
                                   3076 	_unget_token
                                   3077 	jra 9$ ; no more data 
                                   3078 2$:	_next_token 
                                   3079 	cp a,#LITC_IDX 
                                   3080 	jreq 4$ 
                                   3081 	cp a,#QUOTE_IDX
                                   3082 	jreq 6$
                                   3083 	_unget_token 
                                   3084 	call expression
                                   3085 3$:
                                   3086 	ld a,xl 
                                   3087 	clrw x 
                                   3088 	call write_byte
                                   3089 	jra 1$ 
                                   3090 4$: ; write character 
                                   3091 	_get_char 
                                   3092 	clrw x 
                                   3093 	call write_byte 
                                   3094 	jra 1$ 
                                   3095 6$: ; write string 
                                   3096 	clrw x 
                                   3097 7$:	ld a,(y)
                                   3098 	jreq 8$ 
                                   3099 	incw y 
                                   3100 	call write_byte 
                                   3101 	jra 7$ 
                                   3102 8$:	incw y 
                                   3103 	jra 1$ 	
                                   3104 9$:
                                   3105 	_next 
                                   3106 
                                   3107 ;---------------------
                                   3108 ; BASIC: \letter 
                                   3109 ;---------------------
                                   3110 func_back_slash:
                                   3111 	_get_char 
                                   3112 	clrw x 
                                   3113 	rlwa x 
                                   3114 	ret   
                                   3115 
                                   3116 ;----------------------------
                                   3117 ;BASIC: CHAR(expr)
                                   3118 ; évaluate expression 
                                   3119 ; and take the 7 least 
                                   3120 ; bits as ASCII character
                                   3121 ; output: 
                                   3122 ; 	A:X ASCII code {0..127}
                                   3123 ;-----------------------------
                                   3124 func_char:
                                   3125 	call func_args 
                                   3126 	cp a,#1
                                   3127 	jreq 1$
                                   3128 	jp syntax_error
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 189.
Hexadecimal [24-Bits]



                                   3129 1$:	_i16_pop
                                   3130 	rrwa x 
                                   3131 	and a,#0x7f 
                                   3132 	rlwa x  
                                   3133 	ret 
                                   3134 
                                   3135 ;---------------------
                                   3136 ; BASIC: ASC(string|char|char function)
                                   3137 ; extract first character 
                                   3138 ; of string argument 
                                   3139 ; output:
                                   3140 ;    A:X    int24 
                                   3141 ;---------------------
                                   3142 func_ascii:
                                   3143 	ld a,#LPAREN_IDX
                                   3144 	call expect 
                                   3145 	_next_token 
                                   3146 	cp a,#QUOTE_IDX 
                                   3147 	jreq 1$
                                   3148 	cp a,#LITC_IDX 
                                   3149 	jreq 2$ 
                                   3150 	cp a,#CHAR_IDX  
                                   3151 	jreq 0$
                                   3152 	jp syntax_error
                                   3153 0$: ; 
                                   3154 	_call_code 
                                   3155 	jra 4$
                                   3156 1$: ; quoted string 
                                   3157 	ld a,(y)
                                   3158 	push a  
                                   3159 	call skip_string
                                   3160 	pop a  	
                                   3161 	jra 3$ 
                                   3162 2$: ; character 
                                   3163 	_get_char 
                                   3164 3$:	clrw x 
                                   3165 	rlwa x   
                                   3166 4$:	_i16_push  
                                   3167 5$:	ld a,#RPAREN_IDX 
                                   3168 	call expect
                                   3169 9$:	
                                   3170 	_i16_pop  
                                   3171 	ret 
                                   3172 
                                   3173 ;---------------------
                                   3174 ;BASIC: KEY
                                   3175 ; wait for a character 
                                   3176 ; received from STDIN 
                                   3177 ; input:
                                   3178 ;	none 
                                   3179 ; output:
                                   3180 ;	a:x  character 
                                   3181 ;---------------------
                                   3182 func_key:
                                   3183 	call getc 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 190.
Hexadecimal [24-Bits]



                                   3184 	clrw x 
                                   3185 	rlwa x  
                                   3186 	ret 
                                   3187 
                                   3188 ;----------------------
                                   3189 ; BASIC: QKEY
                                   3190 ; Return true if there 
                                   3191 ; is a character in 
                                   3192 ; waiting in STDIN 
                                   3193 ; input:
                                   3194 ;  none 
                                   3195 ; output:
                                   3196 ;   A     0|-1
                                   3197 ;-----------------------
                                   3198 func_qkey:: 
                                   3199 	clrw x 
                                   3200 	_ldaz rx1_head
                                   3201 	sub a,rx1_tail 
                                   3202 	jreq 9$ 
                                   3203 	cplw x
                                   3204 	ld a,#255    
                                   3205 9$: 
                                   3206 	ret 
                                   3207 
                                   3208 ;-------------------------
                                   3209 ; BASIC: UFLASH 
                                   3210 ; return free flash address
                                   3211 ; scan all block starting at 
                                   3212 ; app_space and return 
                                   3213 ; address of first free block 
                                   3214 ; below extended memory.  
                                   3215 ; return 0 if no free block 
                                   3216 ; input:
                                   3217 ;  none 
                                   3218 ; output:
                                   3219 ;	A:X		FLASH free address
                                   3220 ;---------------------------
                                   3221 func_uflash:
                                   3222 	_clrz farptr 
                                   3223 	ldw x,#app_space  
                                   3224 	pushw x 
                                   3225 1$:	ldw ptr16,x 
                                   3226 	call scan_block
                                   3227 	tnz a  
                                   3228 	jreq 8$
                                   3229 	ldw x,(1,sp)
                                   3230 	addw x,#BLOCK_SIZE 
                                   3231 	ldw (1,sp),x 
                                   3232 	jrne 1$  
                                   3233 8$: popw x 
                                   3234 	clr a
                                   3235 	ret 
                                   3236 
                                   3237 
                                   3238 ;------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 191.
Hexadecimal [24-Bits]



                                   3239 ; BASIC: BYE 
                                   3240 ; halt mcu in its lowest power mode 
                                   3241 ; wait for reset or external interrupt
                                   3242 ; do a cold start on wakeup.
                                   3243 ;------------------------------
                                   3244 cmd_bye:
                                   3245 	btjf UART_SR,#UART_SR_TC,.
                                   3246 	_swreset
                                   3247 
                                   3248 .endif 
                                   3249 
                                   3250 ;-------------------------------
                                   3251 ; BASIC: PAUSE expr 
                                   3252 ; suspend execution for n msec.
                                   3253 ; input:
                                   3254 ;	none
                                   3255 ; output:
                                   3256 ;	none 
                                   3257 ;------------------------------
      001F73                       3258 cmd_sleep:
      009D6E 5C 90 F6         [ 4] 3259 	call expression
      009D71 90 5C A1 06      [ 1] 3260 	bres sys_flags,#FSYS_TIMER 
      009D75 26 10 17         [ 2] 3261 	ldw timer,x
      009D78 05               [10] 3262 1$:	wfi 
      009D79 93 CD 88         [ 2] 3263 	ldw x,timer 
      009D7C 86 6B            [ 1] 3264 	jrne 1$
      001F83                       3265 	_next 
      009D7E 08 72 FB         [ 2]    1         jp interp_loop 
                                   3266 
                                   3267 ;------------------------------
                                   3268 ; BASIC: TICKS
                                   3269 ; return msec ticks counter value 
                                   3270 ; input:
                                   3271 ; 	none 
                                   3272 ; output:
                                   3273 ;	X 	msec since reset 
                                   3274 ;-------------------------------
      001F86                       3275 func_ticks:
      001F86                       3276 	_ldxz ticks 
      009D81 07 5C                    1     .byte 0xbe,ticks 
      009D83 90               [ 4] 3277 	ret
                                   3278 
                                   3279 ;---------------------------------
                                   3280 ; BASIC: CHR$(expr)
                                   3281 ; return ascci character 
                                   3282 ;---------------------------------
      001F89                       3283 func_char:
      009D84 93 20            [ 1] 3284 	ld a,#LPAREN_IDX 
      009D86 0E A1 0A         [ 4] 3285 	call expect 
      009D89 26 DD CD         [ 4] 3286 	call expression 
      009D8C 97               [ 1] 3287 	ld a,xl 
      009D8D ED               [ 1] 3288 	clrw x  
      009D8E CD 97            [ 1] 3289 	and a,#0x7f 
      009D90 3F               [ 1] 3290 	ld xl,a 
      009D91 1F 05            [ 1] 3291 	ld a,#RPAREN_IDX 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 192.
Hexadecimal [24-Bits]



      009D93 6B 08 16         [ 4] 3292 	call expect 
      009D95 81               [ 4] 3293 	ret 
                                   3294 
                                   3295 
                                   3296 ;------------------------------
                                   3297 ; BASIC: ABS(expr)
                                   3298 ; return absolute value of expr.
                                   3299 ; input:
                                   3300 ;   none
                                   3301 ; output:
                                   3302 ;   X   positive int16 
                                   3303 ;-------------------------------
      001F9C                       3304 func_abs:
      009D95 A6 21 CD         [ 4] 3305 	call func_args 
      009D98 94 96            [ 1] 3306 	cp a,#1 
      009D9A 17 0A            [ 1] 3307 	jreq 0$ 
      009D9C 1E 01 16         [ 2] 3308 	jp syntax_error
      001FA6                       3309 0$: 
      001FA6                       3310 	_i16_pop
      009D9F 05               [ 2]    1     popw x 
      009DA0 5D               [ 2] 3311 	tnzw x 
      009DA0 0D 04            [ 1] 3312 	jrpl 1$  
      009DA2 27               [ 2] 3313 	negw x 
      009DA3 12               [ 4] 3314 1$:	ret 
                                   3315 
                           000000  3316 .if 0
                                   3317 ;------------------------------
                                   3318 ; BASIC: LSHIFT(expr1,expr2)
                                   3319 ; logical shift left expr1 by 
                                   3320 ; expr2 bits 
                                   3321 ; output:
                                   3322 ; 	x 	result 
                                   3323 ;------------------------------
                                   3324 	SHIFT=1
                                   3325 	VALUE=SHIFT+INT_SIZE 
                                   3326 	VSIZE=2*INT_SIZE  
                                   3327 func_lshift:
                                   3328 	call func_args
                                   3329 	cp a,#2 
                                   3330 	jreq 1$
                                   3331 	jp syntax_error
                                   3332 1$: 
                                   3333 	ld a,(SHIFT+1,sp) ;  only low byte  
                                   3334 	_i16_fetch VALUE  
                                   3335 	tnz a 
                                   3336 	jreq 4$
                                   3337 2$:	sllw x   
                                   3338 	dec a  
                                   3339 	jrne 2$
                                   3340 4$: 
                                   3341 	_drop VSIZE 
                                   3342 	ret  
                                   3343 
                                   3344 ;------------------------------
                                   3345 ; BASIC: RSHIFT(expr1,expr2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 193.
Hexadecimal [24-Bits]



                                   3346 ; logical shift right expr1 by 
                                   3347 ; expr2 bits.
                                   3348 ; output:
                                   3349 ;   X 		result 
                                   3350 ;------------------------------
                                   3351 func_rshift:
                                   3352 	call func_args
                                   3353 	cp a,#2 
                                   3354 	jreq 1$
                                   3355 	jp syntax_error
                                   3356 1$: ld a,(SHIFT+1,sp) 
                                   3357 	_i16_fetch VALUE
                                   3358 	tnz a 
                                   3359 	jreq 4$
                                   3360 2$:	srlw x  
                                   3361 	dec a 
                                   3362 	jrne 2$
                                   3363 4$: 
                                   3364 	_drop VSIZE 
                                   3365 	ret 
                                   3366 
                                   3367 ;--------------------------
                                   3368 ; BASIC: FCPU integer
                                   3369 ; set CPU frequency 
                                   3370 ;-------------------------- 
                                   3371 cmd_fcpu:
                                   3372 	ld a,#LITW_IDX 
                                   3373 	call expect 
                                   3374     _get_word
                                   3375 	ld a,xl 
                                   3376 	and a,#7 
                                   3377 	ld CLK_CKDIVR,a 
                                   3378 	_next  
                                   3379 
                                   3380 .endif 
                                   3381 
                                   3382 ;---------------------------------
                                   3383 ; BASIC: RND(n)
                                   3384 ; return integer [0..n-1] 
                                   3385 ; ref: https://en.wikipedia.org/wiki/Xorshift
                                   3386 ;
                                   3387 ; 	x ^= x << 13;
                                   3388 ;	x ^= x >> 17;
                                   3389 ;	x ^= x << 5;
                                   3390 ;
                                   3391 ;---------------------------------
                                   3392 
                                   3393 
      001FAC                       3394 func_random:
      009DA4 0D 08 27         [ 4] 3395 	call func_args 
      009DA7 0E F6            [ 1] 3396 	cp a,#1
      009DA9 90 F1            [ 1] 3397 	jreq 1$
      009DAB 26 0D 5C         [ 2] 3398 	jp syntax_error
      001FB6                       3399 1$:
      009DAE 90 5C 0A         [ 4] 3400 	call prng 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 194.
Hexadecimal [24-Bits]



      009DB1 04 0A            [ 2] 3401 	pushw y 
      009DB3 08 20            [ 2] 3402 	ldw y,(3,sp)
      009DB5 EA               [ 2] 3403 	divw x,y 
      009DB6 51               [ 1] 3404 	exgw x,y 
      009DB6 7B 04            [ 2] 3405 	popw y 
      001FC1                       3406 	_drop 2 
      009DB8 11 08            [ 2]    1     addw sp,#2 
      009DBA 81               [ 4] 3407 	ret 
                                   3408 
                                   3409 ;---------------------------------
                                   3410 ; BASIC: RANDOMIZE expr 
                                   3411 ; intialize PRGN seed with expr 
                                   3412 ; or with ticks variable value 
                                   3413 ; if expr==0
                                   3414 ;---------------------------------
      001FC4                       3415 cmd_randomize:
      009DBA 2B 0C 26         [ 4] 3416 	call expression 
      009DBD 16               [ 2] 3417 	pushw x 
      009DBE 7B               [ 1] 3418 	push a 
      009DBF 09 A1            [ 1] 3419 	or a,(2,sp)
      009DC1 11 27            [ 1] 3420 	or a,(3,sp) 
      009DC3 1A               [ 1] 3421 	pop a 
      001FCE                       3422 	_drop 2 
      009DC4 2B 18            [ 2]    1     addw sp,#2 
      009DC6 20 26            [ 1] 3423 	jrne 2$
      009DC8 C6 00 04         [ 1] 3424 	ld a,ticks 
      009DC8 7B 09 A1         [ 2] 3425 	ldw x,ticks+1
      001FD8                       3426 2$:
      009DCB 13 27 10 A1      [ 1] 3427 	clr seedy 
      009DCF 10 27 0C         [ 1] 3428 	ld seedy+1,a 
      009DD2 20 1A 0B         [ 2] 3429 	ldw seedx,x 
      009DD4                       3430 	_next 
      009DD4 7B 09 A1         [ 2]    1         jp interp_loop 
                                   3431 
                                   3432 ;------------------------------
                                   3433 ; BASIC: SGN(expr)
                                   3434 ;    return -1 < 0 
                                   3435 ;    return 0 == 0
                                   3436 ;    return 1 > 0 
                                   3437 ;-------------------------------
      001FE5                       3438 func_sign:
      009DD7 14 27 04         [ 4] 3439 	call func_args 
      009DDA A1 12            [ 1] 3440 	cp a,#1 
      009DDC 26 10            [ 1] 3441 	jreq 0$ 
      009DDE CC 11 A5         [ 2] 3442 	jp syntax_error
      001FEF                       3443 0$:
      001FEF                       3444 	_i16_pop  
      009DDE 16               [ 2]    1     popw x 
      009DDF 0A 5B            [ 1] 3445 	jreq 9$
      009DE1 0B 90            [ 1] 3446 	jrmi 4$
      009DE3 F6 A1 08         [ 2] 3447 	ldw x,#1
      009DE6 26               [ 4] 3448 	ret
      009DE7 03 CC 9E         [ 2] 3449 4$: ldw x,#-1 
      009DEA A4 CC 93         [ 4] 3450 call print_int   
      009DED A6               [ 4] 3451 9$:	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 195.
Hexadecimal [24-Bits]



                                   3452 
                                   3453 ;-----------------------------
                                   3454 ; BASIC: LEN(var$||quoted string)
                                   3455 ;  return length of string 
                                   3456 ;----------------------------
      009DEE                       3457 func_len:
      009DEE 16 0A            [ 1] 3458 	ld a,#LPAREN_IDX 
      009DF0 5B 0B CC         [ 4] 3459 	call expect 
      002004                       3460 	_next_token 
      002004                          1         _get_char 
      009DF3 93 B1            [ 1]    1         ld a,(y)    ; 1 cy 
      009DF5 CC 93            [ 1]    2         incw y      ; 1 cy 
      009DF7 A6 06            [ 1] 3461 	cp a,#QUOTE_IDX
      009DF8 26 10            [ 1] 3462 	jrne 2$ 
      009DF8 52               [ 1] 3463 	ldw x,y 
      009DF9 0A B6 41         [ 4] 3464 	call strlen
      009DFC A1               [ 1] 3465 	push a 
      009DFD 08 2B            [ 1] 3466 	push #0 
      009DFF 05 A6 08         [ 2] 3467 	addw y,(1,sp)
      009E02 CC 92            [ 1] 3468 	incw y 
      002018                       3469 	_drop 2 
      009E04 27 4C            [ 2]    1     addw sp,#2 
      009E06 B7 41            [ 2] 3470 	jra 9$ 
      00201C                       3471 2$:
      009E08 AE 00            [ 1] 3472 	cp a,#STR_VAR_IDX 
      009E0A 01 1F            [ 1] 3473 	jreq 3$ 
      009E0C 01 A6 09         [ 2] 3474 	jp syntax_error
      002023                       3475 3$:
      009E0F CD 94 96         [ 4] 3476 	call get_var_adr  
      009E12 CD 97            [ 2] 3477 	ldw x,(2,x) 
      009E14 ED               [ 1] 3478 	incw x 
      009E15 1C 00 02         [ 4] 3479 	call strlen
      00202C                       3480 9$:
      009E18 1F               [ 1] 3481 	clrw x 
      009E19 05               [ 1] 3482 	ld xl,a 
      009E1A BF 12            [ 1] 3483 	ld a,#RPAREN_IDX
      009E1C A6 11 CD         [ 4] 3484 	call expect 
      009E1F 94               [ 4] 3485 	ret 
                                   3486 
                           000001  3487 .if 1
                                   3488 ;---------------------------------
                                   3489 ; BASIC: WORDS [\C]
                                   3490 ; affiche la listes des mots 
                                   3491 ; réservés ainsi que le nombre
                                   3492 ; de mots.
                                   3493 ; si l'option \C est présente 
                                   3494 ; affiche la valeur tokenizé des 
                                   3495 ; mots réservés 
                                   3496 ;---------------------------------
                           000001  3497 	COL_CNT=1 ; column counter 
                           000002  3498 	WCNT=COL_CNT+1 ; count words printed 
                           000003  3499 	NBR_COL=WCNT+1 ; display columns 
                           000004  3500 	WIDTH_DIV=NBR_COL+1 ; modulo divisor for column width 
                           000005  3501 	YSAVE=WIDTH_DIV+1
                           000007  3502 	XSAVE=YSAVE+2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 196.
Hexadecimal [24-Bits]



                           000008  3503 	VSIZE=XSAVE+1  	
      002034                       3504 cmd_words:
      002034                       3505 	_vars VSIZE
      009E20 96 CD            [ 2]    1     sub sp,#VSIZE 
      009E22 95 78            [ 1] 3506 	ld a,#4 ; default to 4 columns 
      009E24 72 CF            [ 1] 3507 	ld (COL_CNT,sp),a 
      009E26 00 12            [ 1] 3508 	ld (NBR_COL,sp),a 
      009E28 A6 27            [ 1] 3509 	clr (WCNT,sp)
      009E2A CD 94            [ 1] 3510 	ld a,#11 ; default width 10 characters + 1 
      009E2C 96 04            [ 1] 3511 	ld (WIDTH_DIV,sp),a ; modulo divisor 
      009E2D                       3512 	_clrz acc16  
      009E2D CD 95                    1     .byte 0x3f, acc16 
      009E2F 78 05            [ 2] 3513 	ldw (YSAVE,sp),y 
      009E30 90 F6            [ 1] 3514 	ld a,(y)
      009E30 1F 03            [ 1] 3515 	cp a,#LITC_IDX 
      009E32 90 F6            [ 1] 3516 	jrne 1$ 
      009E34 90 5C            [ 1] 3517 	incw y 
      00204E                       3518 	_get_char 
      009E36 A1 24            [ 1]    1         ld a,(y)    ; 1 cy 
      009E38 27 04            [ 1]    2         incw y      ; 1 cy 
      009E3A 90 5A            [ 1] 3519 	cp a,#'C 
      009E3C 20 05            [ 1] 3520 	jreq 0$ 
      009E3E CC 11 A5         [ 2] 3521 	jp syntax_error 
      002059                       3522 0$: 
      009E3E CD 95            [ 2] 3523 	ldw (YSAVE,sp),y 
      009E40 78 03            [ 1] 3524 	ld a,#3 ; 3 columns when showing token bytecode
      009E41 6B 01            [ 1] 3525 	ld (COL_CNT,sp),a  	
      009E41 1F 01            [ 1] 3526 	ld (NBR_COL,sp),a 
      009E43 A6 0A            [ 1] 3527 	ld a,#10 ; column width 13 characters - 4 + 1
      009E43 17 09            [ 1] 3528 	ld (WIDTH_DIV,sp),a ; modulo divisor 
      009E45 BE 2B 1F 07      [ 2] 3529 	ldw y,#all_words+2 ; special char. bytecode 
      009E49 CC 93            [ 2] 3530 	jra 2$
      00206B                       3531 1$: 
      009E4B A6 AE 23 CE      [ 2] 3532 	ldw y,#kword_dict+2 ; show only reserved words 
      009E4C                       3533 2$:
      009E4C 3D               [ 1] 3534 	ldw x,y
      009E4D 41               [ 1] 3535 	ld a,(x)
      009E4E 26               [ 1] 3536 	incw x  	
      009E4F 05 A6            [ 2] 3537 	ldw (XSAVE,sp),x 
      009E51 06               [ 1] 3538 	clrw x 
      009E52 CC               [ 1] 3539 	ld xl,a 
      009E53 92 27            [ 1] 3540 	ld a,(WIDTH_DIV,sp)
      009E55 62               [ 2] 3541 	div x,a 
      009E55 72 A9            [ 2] 3542 	ldw x,(XSAVE,sp)
      009E57 00               [ 1] 3543 	inc a 
      00207C                       3544 	_straz acc8 	 	
      009E58 03 1E                    1     .byte 0xb7,acc8 
      009E5A 05 BF            [ 1] 3545 	ld a,(NBR_COL,sp)
      009E5C 12 FE            [ 1] 3546 	cp a,#4 
      009E5E 72 FB            [ 1] 3547 	jreq 3$
      009E60 01 72            [ 1] 3548 	ld a,#'$
      009E62 CF 00 12         [ 4] 3549 	call putc 
      009E65 72 F0 03 BF      [ 4] 3550 	ld a,([acc16],x)
      009E69 18 27 06         [ 4] 3551 	call print_hex
      009E6C B6 18 18         [ 4] 3552 	call space   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 197.
Hexadecimal [24-Bits]



      002093                       3553 3$:
      009E6F 01 2A 0A         [ 4] 3554 	call puts 
      009E72 0C 02            [ 1] 3555 	inc (WCNT,sp)
      009E72 16 09            [ 1] 3556 	dec (COL_CNT,sp)
      009E74 1E 07            [ 1] 3557 	jreq 5$
      009E76 CF 00            [ 1] 3558 	ld a,(WIDTH_DIV,sp)
      009E78 2B CC 93         [ 1] 3559 	sub a,acc8 
      009E7B A6 02            [ 1] 3560 	jrpl 4$
      009E7C A6 09            [ 1] 3561 	ld a,#9
      009E7C 3A               [ 1] 3562 4$: clrw x 
      009E7D 41               [ 1] 3563 	ld xl,a 
      009E7E 5B 0A CC         [ 4] 3564 	call spaces 
      009E81 93 A6            [ 2] 3565 	jra 6$ 
      009E83 A6 0D            [ 1] 3566 5$: ld a,#CR 
      009E83 CD 95 78         [ 4] 3567 	call putc 
      009E86 7B 03            [ 1] 3568 	ld a,(NBR_COL,sp) 
      009E86 4F 72            [ 1] 3569 	ld (COL_CNT,sp),a 
      009E88 01 00 3B 0C      [ 2] 3570 6$:	subw y,#2 
      009E8C 72 C3            [ 2] 3571 	ldw y,(y)
      009E8E 00 2B            [ 1] 3572 	jrne 2$ 
      009E90 25 06            [ 1] 3573 	ld a,#CR 
      009E92 22 03 CE         [ 4] 3574 	call putc  
      009E95 00               [ 1] 3575 	clrw x 
      009E96 2B 43            [ 1] 3576 	ld a,(WCNT,sp)
      009E98 97               [ 1] 3577 	ld xl,a 
      009E98 CD 8B 2C         [ 4] 3578 	call print_int 
      009E9B 4D 26 05         [ 2] 3579 	ldw x,#words_count_msg
      009E9E A6 04 CC         [ 4] 3580 	call puts 
      009EA1 92 27            [ 2] 3581 	ldw y,(YSAVE,sp)
      009EA3                       3582 	_drop VSIZE 
      009EA3 81 08            [ 2]    1     addw sp,#VSIZE 
      009EA4                       3583 	_next 
      009EA4 CC 13 26         [ 2]    1         jp interp_loop 
      009EA4 CD 9E 83 72 00 00 3B  3584 words_count_msg: .asciz " words in dictionary\n"
             04 72 10 00 3B 63 74
             69 6F 6E 61 72 79 0A
             00
                                   3585 .endif 
                                   3586 
                                   3587 ;-----------------------------
                                   3588 ; BASIC: TIMER expr 
                                   3589 ; initialize count down timer 
                                   3590 ;-----------------------------
      009EB0                       3591 cmd_set_timer:
      009EB0 CD 14 2F         [ 4] 3592 	call arg_list
      009EB0 CF 00            [ 1] 3593 	cp a,#1 
      009EB2 2B 1C            [ 1] 3594 	jreq 1$
      009EB4 00 03 90         [ 2] 3595 	jp syntax_error
      0020F6                       3596 1$: 
      0020F6                       3597 	_i16_pop  
      009EB7 93               [ 2]    1     popw x 
      009EB8 72 0F 00 3B      [ 1] 3598 	bres sys_flags,#FSYS_TIMER  
      009EBC 03 CD 93         [ 2] 3599 	ldw timer,x
      0020FE                       3600 	_next 
      009EBF E0 CC 93         [ 2]    1         jp interp_loop 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 198.
Hexadecimal [24-Bits]



                                   3601 
                                   3602 ;------------------------------
                                   3603 ; BASIC: TIMEOUT 
                                   3604 ; return state of timer 
                                   3605 ; output:
                                   3606 ;   A:X     0 not timeout 
                                   3607 ;   A:X     -1 timeout 
                                   3608 ;------------------------------
      002101                       3609 func_timeout:
      009EC2 A6               [ 1] 3610 	clr a 
      009EC3 5F               [ 1] 3611 	clrw x 
      009EC3 72 01 00 0A 02   [ 2] 3612 	btjf sys_flags,#FSYS_TIMER,1$ 
      009EC3 B6               [ 1] 3613 	cpl a 
      009EC4 40               [ 2] 3614 	cplw x 
      009EC5 A1               [ 4] 3615 1$:	ret 
                                   3616  	
                           000000  3617 .if 0
                                   3618 ;------------------------------
                                   3619 ; BASIC: DO 
                                   3620 ; initiate a DO ... UNTIL loop 
                                   3621 ;------------------------------
                                   3622 	DOLP_ADR=1 
                                   3623 	DOLP_LN_ADDR=3
                                   3624 	VSIZE=4 
                                   3625 kword_do:
                                   3626 	_vars VSIZE 
                                   3627 	ldw (DOLP_ADR,sp),y
                                   3628 	_ldxz line.addr  
                                   3629 	ldw (DOLP_LN_ADDR,sp),x
                                   3630 	_next 
                                   3631 
                                   3632 ;--------------------------------
                                   3633 ; BASIC: UNTIL expr 
                                   3634 ; loop if exprssion is false 
                                   3635 ; else terminate loop
                                   3636 ;--------------------------------
                                   3637 kword_until: 
                                   3638 	call condition  
                                   3639 	tnz a 
                                   3640 	jrne 9$ 
                                   3641 	tnzw x 
                                   3642 	jrne 9$ 
                                   3643 	ldw y,(DOLP_ADR,sp)
                                   3644 ;	ldw basicptr,y 
                                   3645 	ldw x,(DOLP_LN_ADDR,sp)
                                   3646 	ldw line.addr,x
                                   3647 	btjf flags,#FRUN,8$ 
                                   3648 ;	ld a,(2,x)
                                   3649 ;	_straz count  
                                   3650 8$:	_next 
                                   3651 9$:	; remove loop data from stack  
                                   3652 	_drop VSIZE
                                   3653 	_next 
                                   3654 
                                   3655 const_hse:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 199.
Hexadecimal [24-Bits]



                                   3656 	ldw x,#CLK_SWR_HSE
                                   3657 	clr a 
                                   3658 	ret 
                                   3659 const_hsi:
                                   3660 	ldw x,#CLK_SWR_HSI
                                   3661 	clr a 
                                   3662 	ret 
                                   3663 .endif 
                                   3664 
                                   3665 ;-----------------------
                                   3666 ; memory area constants
                                   3667 ;-----------------------
      00210B                       3668 const_eeprom_base:
      009EC6 08               [ 1] 3669 	clr a  
      009EC7 2B 05 A6         [ 2] 3670 	ldw x,#EEPROM_BASE 
      009ECA 07               [ 4] 3671 	ret 
                                   3672 
                           000000  3673 .if 0
                                   3674 ;---------------------------
                                   3675 ; BASIC: DATA 
                                   3676 ; when the interpreter find 
                                   3677 ; a DATA line it skip over 
                                   3678 ;---------------------------
                                   3679 kword_data:
                                   3680 	jp kword_remark
                                   3681 
                                   3682 ;------------------------------
                                   3683 ; check if line is data line 
                                   3684 ; if so set data_pointers 
                                   3685 ; and return true 
                                   3686 ; else move X to next line 
                                   3687 ; and return false 
                                   3688 ; input:
                                   3689 ;    X     line addr 
                                   3690 ; outpu:
                                   3691 ;    A     0 not data 
                                   3692 ;          1 data pointers set 
                                   3693 ;    X     updated to next line addr 
                                   3694 ;          if not data line 
                                   3695 ;--------------------------------
                                   3696 is_data_line:
                                   3697 	ld a,(LINE_HEADER_SIZE,x)
                                   3698 	cp a,#DATA_IDX 
                                   3699 	jrne 1$
                                   3700 	_strxz data_line 
                                   3701 	addw x,#FIRST_DATA_ITEM
                                   3702 	_strxz data_ptr  
                                   3703 	ld a,#1 
                                   3704 	ret 
                                   3705 1$: clr acc16 
                                   3706 	ld a,(2,x)
                                   3707 	ld acc8,a 
                                   3708 	addw x,acc16
                                   3709 	clr a 
                                   3710 	ret  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 200.
Hexadecimal [24-Bits]



                                   3711 
                                   3712 ;---------------------------------
                                   3713 ; BASIC: RESTORE [line#]
                                   3714 ; set data_ptr to first data line
                                   3715 ; if no DATA found pointer set to
                                   3716 ; zero.
                                   3717 ; if a line# is given as argument 
                                   3718 ; a data line with that number 
                                   3719 ; is searched and the data pointer 
                                   3720 ; is set to it. If there is no 
                                   3721 ; data line with that number 
                                   3722 ; the program is interrupted. 
                                   3723 ;---------------------------------
                                   3724 cmd_restore:
                                   3725 	clrw x 
                                   3726 	ldw data_line,x 
                                   3727 	ldw data_ptr,x 
                                   3728 	_next_token 
                                   3729 	cp a,#CMD_END 
                                   3730 	jrugt 0$ 
                                   3731 	_unget_token 
                                   3732 	_ldxz lomem 
                                   3733 	jra 4$ 
                                   3734 0$:	cp a,#LITW_IDX
                                   3735 	jreq 2$
                                   3736 1$: jp syntax_error 	 
                                   3737 2$:	_get_word 
                                   3738 	call search_lineno  
                                   3739 	tnz a  
                                   3740 	jreq data_error 
                                   3741 	call is_data_line
                                   3742 	tnz a 
                                   3743 	jrne 9$ 
                                   3744 	jreq data_error
                                   3745 4$:
                                   3746 ; search first DATA line 	
                                   3747 5$:	
                                   3748 	cpw x,himem
                                   3749 	jruge data_error 
                                   3750 	call is_data_line 
                                   3751 	tnz a 
                                   3752 	jreq 5$ 
                                   3753 9$:	_next  
                                   3754 
                                   3755 data_error:	
                                   3756     ld a,#ERR_NO_DATA 
                                   3757 	jp tb_error 
                                   3758 
                                   3759 
                                   3760 ;---------------------------------
                                   3761 ; BASIC: READ 
                                   3762 ; return next data item | data error
                                   3763 ; output:
                                   3764 ;    A:X int24  
                                   3765 ;---------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 201.
Hexadecimal [24-Bits]



                                   3766 func_read_data:
                                   3767 read01:	
                                   3768 	ldw x,data_ptr
                                   3769 	ld a,(x)
                                   3770 	incw x 
                                   3771 	tnz a 
                                   3772 	jreq 4$ ; end of line
                                   3773 	cp a,#REM_IDX
                                   3774 	jreq 4$  
                                   3775 	cp a,#COMMA_IDX 
                                   3776 	jrne 1$ 
                                   3777 	ld a,(x)
                                   3778 	incw x 
                                   3779 1$:
                                   3780 .if 0
                                   3781 	cp a,#LIT_IDX 
                                   3782 	jreq 2$
                                   3783 .endif
                                   3784 	cp a,#LITW_IDX 
                                   3785 	jreq 14$
                                   3786 	jra data_error 
                                   3787 14$: ; word 
                                   3788 	clr a 
                                   3789 	_strxz data_ptr 	
                                   3790 	ldw x,(x)
                                   3791 .if 0	
                                   3792 	jra 24$
                                   3793 2$:	; int24  
                                   3794 	ld a,(x)
                                   3795 	incw x 
                                   3796 	_strxz data_ptr 
                                   3797 	ldw x,(x)
                                   3798 24$:
                                   3799 .endif 
                                   3800 	pushw x 
                                   3801 	_ldxz data_ptr 
                                   3802 	addw x,#2 
                                   3803 	_strxz data_ptr
                                   3804 	popw x 
                                   3805 3$:
                                   3806 	ret 
                                   3807 4$: ; check if next line is DATA  
                                   3808 	_ldxz data_line
                                   3809 	ld a,(2,x)
                                   3810 	ld acc8,a
                                   3811 	clr acc16  
                                   3812 	addw x,acc16 
                                   3813 	call is_data_line 
                                   3814 	tnz a 
                                   3815 	jrne read01  
                                   3816 	jra data_error 
                                   3817 
                                   3818 ;-------------------------------
                                   3819 ; BASIC: PAD 
                                   3820 ; Return pad buffer address.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 202.
Hexadecimal [24-Bits]



                                   3821 ;------------------------------
                                   3822 const_pad_ref:
                                   3823 	ldw x,#pad 
                                   3824 	clr a
                                   3825 	ret 
                                   3826 
                                   3827 ;-------------------------------
                                   3828 ; BASIC: CHAIN label
                                   3829 ; Execute another program like it 
                                   3830 ; is a sub-routine. When the 
                                   3831 ; called program terminate 
                                   3832 ; execution continue at caller 
                                   3833 ; after CHAIN command. 
                                   3834 ; if a line# is given, the 
                                   3835 ; chained program start execution 
                                   3836 ; at this line#.
                                   3837 ;---------------------------------
                                   3838 	CHAIN_ADDR=1 
                                   3839 	CHAIN_LNADR=3
                                   3840 	CHAIN_BP=5
                                   3841 	CHAIN_TXTBGN=7 
                                   3842 	CHAIN_TXTEND=9 
                                   3843 	VSIZE=10
                                   3844 	DISCARD=2
                                   3845 cmd_chain:
                                   3846 	_vars VSIZE 
                                   3847 	clr (CHAIN_LN,sp) 
                                   3848 	clr (CHAIN_LN+1,sp)  
                                   3849 	ld a,#LABEL_IDX 
                                   3850 	call expect 
                                   3851 	pushw y 
                                   3852 	call skip_label
                                   3853 	popw x 
                                   3854 	incw x
                                   3855 	call search_program 
                                   3856 	tnzw x  
                                   3857 	jrne 1$ 
                                   3858 0$:	ld a,#ERR_BAD_VALUE
                                   3859 	jp tb_error 
                                   3860 1$: addw x,#FILE_HEADER_SIZE 
                                   3861 	ldw (CHAIN_ADDR,sp), x ; program addr 
                                   3862 ; save chain context 
                                   3863 	_ldxz line.addr 
                                   3864 	ldw (CHAIN_LNADR,sp),x 
                                   3865 	ldw (CHAIN_BP,sp),y
                                   3866 	_ldxz lomem 
                                   3867 	ldw (CHAIN_TXTBGN,sp),x
                                   3868 	_ldxz himem 
                                   3869 	ldw (CHAIN_TXTEND,sp),x  
                                   3870 ; set chained program context 	
                                   3871 	ldw x,(CHAIN_ADDR,sp)
                                   3872 	ldw line.addr,x 
                                   3873 	ldw lomem,x 
                                   3874 	subw x,#2
                                   3875 	ldw x,(x)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 203.
Hexadecimal [24-Bits]



                                   3876 	addw x,(CHAIN_ADDR,sp)
                                   3877 	ldw himem,x  
                                   3878 	ldw y,(CHAIN_ADDR,sp)
                                   3879 	addw y,#LINE_HEADER_SIZE 
                                   3880     _incz chain_level
                                   3881 	_drop DISCARD
                                   3882 	_next 
                                   3883 
                                   3884 
                                   3885 ;-----------------------------
                                   3886 ; BASIC TRACE 0|1 
                                   3887 ; disable|enable line# trace 
                                   3888 ;-----------------------------
                                   3889 cmd_trace:
                                   3890 	_next_token
                                   3891 	cp a,#LITW_IDX
                                   3892 	jreq 1$ 
                                   3893 	jp syntax_error 
                                   3894 1$: _get_word 
                                   3895     tnzw x 
                                   3896 	jrne 2$ 
                                   3897 	bres flags,#FTRACE 
                                   3898 	_next 
                                   3899 2$: bset flags,#FTRACE 
                                   3900 	_next 
                                   3901 
                                   3902 .endif 
                                   3903 
                                   3904 ;-------------------------
                                   3905 ; BASIC: TAB expr 
                                   3906 ;  print spaces 
                                   3907 ;------------------------
      002110                       3908 cmd_tab:
      009ECB CC 92 27         [ 4] 3909 	call expression  
      009ECE 4C               [ 1] 3910 	clr a 
      009ECF B7               [ 1] 3911 	ld xh,a
      009ED0 40 CD 9E         [ 4] 3912 	call spaces 
      002118                       3913 	_next 
      009ED3 83 CF 00         [ 2]    1         jp interp_loop 
                                   3914 
                                   3915 ;---------------------
                                   3916 ; BASIC: CALL expr1 [,func_arg] 
                                   3917 ; execute a function written 
                                   3918 ; in binary code.
                                   3919 ; input:
                                   3920 ;   expr1	routine address
                                   3921 ;   expr2   optional argument passed in X  
                                   3922 ; output:
                                   3923 ;    none 
                                   3924 ;---------------------
                           000001  3925 	FN_ARG=1
                           000003  3926 	FN_ADR=3
      00211B                       3927 cmd_call::
      009ED6 12 14 2F         [ 4] 3928 	call arg_list 
      009ED7 A1 01            [ 1] 3929 	cp a,#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 204.
Hexadecimal [24-Bits]



      009ED7 52 04            [ 1] 3930 	jreq 1$
      009ED9 17 01            [ 1] 3931 	cp a,#2
      009EDB BE 2B            [ 1] 3932 	jreq 0$ 
      009EDD 1F 03 BE         [ 2] 3933 	jp syntax_error 
      002129                       3934 0$: 
      002129                       3935 	_i16_fetch FN_ADR  
      009EE0 12 20            [ 2]    1     ldw x,(FN_ADR,sp)
      00212B                       3936 	_strxz ptr16 
      009EE2 CD 12                    1     .byte 0xbf,ptr16 
      009EE3                       3937 	_i16_pop 
      009EE3 72               [ 2]    1     popw x 
      00212E                       3938 	_drop 2 
      009EE4 5D 00            [ 2]    1     addw sp,#2 
      009EE6 40 26 05 A6      [ 6] 3939 	call [ptr16]
      002134                       3940 	_next 
      009EEA 05 CC 92         [ 2]    1         jp interp_loop 
      002137                       3941 1$: _i16_pop 	
      009EED 27               [ 2]    1     popw x 
      009EEE FD               [ 4] 3942 	call (x)
      002139                       3943 	_next 
      009EEE 3A 40 16         [ 2]    1         jp interp_loop 
                                   3944 
                                   3945 ;------------------------
                                   3946 ; BASIC:AUTO expr1, expr2 
                                   3947 ; enable auto line numbering
                                   3948 ;  expr1   start line number 
                                   3949 ;  expr2   line# increment 
                                   3950 ;-----------------------------
      00213C                       3951 cmd_auto:
      009EF1 01 1E 03 CF 00   [ 2] 3952 	btjt flags,#FRUN,9$ 
      009EF6 2B 5B 04         [ 4] 3953 	call arg_list 
      009EF9 CC 93 A6         [ 2] 3954 	ldw x,#10 
      009EFC 4D               [ 1] 3955 	tnz a 
      009EFC 72 01            [ 1] 3956 	jreq 9$ 
      009EFE 00 3B            [ 1] 3957 	cp a,#1
      009F00 03 CC            [ 1] 3958 	jreq 1$
      009F02 93 A6            [ 1] 3959 	cp a,#2
      009F04 27 03            [ 1] 3960 	jreq 0$ 
      009F04 CD A1 E2         [ 2] 3961 	jp syntax_error 
      002155                       3962 0$: 
      002155                       3963 	_i16_pop 
      009F07 AE               [ 2]    1     popw x 
      002156                       3964 1$:	
      002156                       3965 	_strxz auto_step 
      009F08 17 FF                    1     .byte 0xbf,auto_step 
      002158                       3966 	 _i16_pop 
      009F0A 94               [ 2]    1     popw x 
      002159                       3967 	_strxz auto_line
      009F0B CD 94                    1     .byte 0xbf,auto_line 
      009F0D AF 4D 27 0D      [ 1] 3968 	bset flags,#FAUTO
      00215F                       3969 9$: 
      00215F                       3970 	_next 
      009F11 85 4F CD         [ 2]    1         jp interp_loop 
                                   3971 
                                   3972 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 205.
Hexadecimal [24-Bits]



      002162                       3973 clear_state:
      002162                       3974 	_ldxz dvar_bgn
      009F14 8B 2C                    1     .byte 0xbe,dvar_bgn 
      002164                       3975 	_strxz dvar_end 
      009F16 4D 26                    1     .byte 0xbf,dvar_end 
      009F18 08 A6 0D         [ 2] 3976 	ldw x,himem  
      002169                       3977 	_strxz heap_free  
      009F1B CC 92                    1     .byte 0xbf,heap_free 
      00216B                       3978 	_rst_pending 
      009F1D 27 00 54         [ 2]    1     ldw x,#pending_stack+PENDING_STACK_SIZE
      009F1E                          2     _strxz psp 
      009F1E CE 00                    1     .byte 0xbf,psp 
      002170                       3979 	_clrz gosub_nest 
      009F20 2F 40                    1     .byte 0x3f, gosub_nest 
      009F21                       3980 	_clrz for_nest
      009F21 BF 2B                    1     .byte 0x3f, for_nest 
      009F23 1C               [ 4] 3981 	ret 
                                   3982 
                                   3983 ;---------------------------
                                   3984 ; BASIC: CLR 
                                   3985 ; reset stacks 
                                   3986 ; clear all variables
                                   3987 ;----------------------------
      002175                       3988 cmd_clear:
      009F24 00 03 90 93 72   [ 2] 3989 	btjt flags,#FRUN,9$
      009F29 10 00 3B         [ 2] 3990 	ldw x,#STACK_EMPTY
      009F2C CC               [ 1] 3991 	ldw sp,x 
      009F2D 93 A6 62         [ 4] 3992 	call clear_state  
      009F2F                       3993 9$: 
      009F2F                       3994 	_next 
      009F2F AE 17 FF         [ 2]    1         jp interp_loop 
                                   3995 
                                   3996 ;----------------------------
                                   3997 ; BASIC: DEL val1,val2 	
                                   3998 ;  delete all programs lines 
                                   3999 ;  from val1 to val2 
                                   4000 ;----------------------------
                           000001  4001 	START_ADR=1
                           000003  4002 	END_ADR=START_ADR+ADR_SIZE 
                           000005  4003 	DEL_SIZE=END_ADR+ADR_SIZE 
                           000007  4004 	YSAVE=DEL_SIZE+INT_SIZE 
                           000008  4005 	VSIZE=4*INT_SIZE  
      002184                       4006 cmd_del:
      009F32 94 AE 00 54 BF   [ 2] 4007 	btjf flags,#FRUN,0$
      002189                       4008 	_next 
      009F37 42 CC 93         [ 2]    1         jp interp_loop 
      00218C                       4009 0$:
      00218C                       4010 	_vars VSIZE
      009F3A 6E 08            [ 2]    1     sub sp,#VSIZE 
      009F3B 5F               [ 1] 4011 	clrw x  
      009F3B 90 F6            [ 2] 4012 	ldw (END_ADR,sp),x  
      009F3D 90 5C A1         [ 4] 4013 	call arg_list 
      009F40 09 27            [ 1] 4014 	cp a,#2 
      009F42 03 CC            [ 1] 4015 	jreq 1$ 
      009F44 92 25            [ 1] 4016 	cp a,#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 206.
Hexadecimal [24-Bits]



      009F46 93 FE            [ 1] 4017 	jreq 2$ 
      009F48 72 A9 00         [ 2] 4018 	jp syntax_error 
      00219F                       4019 1$:	; range delete 
      00219F                       4020 	_i16_pop ; val2   
      009F4B 02               [ 2]    1     popw x 
      009F4C CF               [ 1] 4021 	clr a 
      009F4D 00 12 CD         [ 4] 4022 	call search_lineno 
      009F50 85               [ 1] 4023 	tnz a ; 0 not found 
      009F51 4A 27            [ 1] 4024 	jreq not_a_line 
                                   4025 ; this last line to be deleted 
                                   4026 ; skip at end of it 
      0021A7                       4027 	_strxz acc16 	
      009F53 03 CD                    1     .byte 0xbf,acc16 
      009F55 85 50            [ 1] 4028 	ld a,(2,x) ; line length 
      009F57 72               [ 1] 4029 	clrw x 
      009F58 3F               [ 1] 4030 	ld xl,a 
      009F59 00 12 3C 13      [ 2] 4031 	addw x,acc16 
      009F5D 72 3F            [ 2] 4032 	ldw (END_ADR+INT_SIZE,sp),x
      0021B3                       4033 2$: 
      0021B3                       4034 	_i16_pop ; val1 
      009F5F 00               [ 2]    1     popw x 
      009F60 12               [ 1] 4035 	clr a 
      009F61 3C 13 72         [ 4] 4036 	call search_lineno 
      009F64 C7               [ 1] 4037 	tnz a 
      009F65 00 12            [ 1] 4038 	jreq not_a_line 
      009F67 CC 93            [ 2] 4039 	ldw (START_ADR,sp),x 
      009F69 A6 03            [ 2] 4040 	ldw x,(END_ADR,sp)
      009F6A 26 0B            [ 1] 4041 	jrne 4$ 
                                   4042 ; END_ADR not set there was no val2 
                                   4043 ; skip end of this line for END_ADR 
      009F6A 90 89            [ 2] 4044 	ldw x,(START_ADR,sp)
      009F6C CD 94            [ 1] 4045 	ld a,(2,x)
      009F6E AF               [ 1] 4046 	clrw x 
      009F6F A1               [ 1] 4047 	ld xl,a 
      009F70 02 27 03         [ 2] 4048 	addw x,(START_ADR,sp)
      009F73 CC 92            [ 2] 4049 	ldw (END_ADR,sp),x 
      0021CC                       4050 4$: 
      009F75 25 F0 01         [ 2] 4051 	subw x,(START_ADR,sp)
      009F76 1F 05            [ 2] 4052 	ldw (DEL_SIZE,sp),x 
      009F76 17 05 1E         [ 2] 4053 	ldw x,progend 
      009F79 03 90 93         [ 2] 4054 	subw x,(END_ADR,sp)
      0021D7                       4055 	_strxz acc16 
      009F7C 1E 01                    1     .byte 0xbf,acc16 
      009F7E CD 82            [ 2] 4056 	ldw x,(START_ADR,sp)
      009F80 B9 16            [ 2] 4057 	ldw (YSAVE,sp),y 
      009F82 05 5B            [ 2] 4058 	ldw y,(END_ADR,sp)
      009F84 06 CC 93         [ 4] 4059 	call move 
      0021E2                       4060 	_ldxz progend 
      009F87 A6 33                    1     .byte 0xbe,progend 
      009F88 72 F0 05         [ 2] 4061 	subw x,(DEL_SIZE,sp)
      0021E7                       4062 	_strxz progend 
      009F88 72 00                    1     .byte 0xbf,progend 
      009F8A 00 3B            [ 2] 4063 	ldw y,(YSAVE,sp)
      0021EB                       4064 	_drop VSIZE
      009F8C 03 CC            [ 2]    1     addw sp,#VSIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 207.
Hexadecimal [24-Bits]



      0021ED                       4065 	_next 
      009F8E 93 A6 26         [ 2]    1         jp interp_loop 
      009F90                       4066 not_a_line:
      009F90 AE 9F            [ 1] 4067 	ld a,#ERR_RANGE 
      009F92 B2 CD 85         [ 2] 4068 	jp tb_error 
                                   4069 
                                   4070 
                                   4071 ;-----------------------------
                                   4072 ; BASIC: HIMEM = expr 
                                   4073 ; set end memory address of
                                   4074 ; BASIC program space.
                                   4075 ;------------------------------
      0021F5                       4076 cmd_himem:
      009F95 A3 BE 2B FE CD   [ 2] 4077 	btjf flags,#FRUN,1$
      0021FA                       4078 	_next 
      009F9A 88 2E AE         [ 2]    1         jp interp_loop 
      009F9D 9F C1            [ 1] 4079 1$: ld a,#REL_EQU_IDX 
      009F9F CD 85 A3         [ 4] 4080 	call expect 
      009FA2 52 04 CD         [ 4] 4081 	call expression 
      009FA5 9B 25 72         [ 2] 4082 	cpw x,lomem  
      009FA8 11 00            [ 2] 4083 	jrule bad_value 
      009FAA 3B 72 18         [ 2] 4084 	cpw x,#tib  
      009FAD 00 3B            [ 1] 4085 	jruge bad_value  
      00220F                       4086 	_strxz himem
      009FAF CC 93                    1     .byte 0xbf,himem 
      009FB1 71 0A            [ 2] 4087 	jra clear_prog_space  
      002213                       4088 	_next 
      009FB3 53 54 4F         [ 2]    1         jp interp_loop 
                                   4089 ;--------------------------------
                                   4090 ; BASIC: LOWMEM = expr 
                                   4091 ; set start memory address of 
                                   4092 ; BASIC program space. 	
                                   4093 ;---------------------------------
      002216                       4094 cmd_lomem:
      009FB6 50 20 61 74 20   [ 2] 4095 	btjf flags,#FRUN,1$
      00221B                       4096 	_next
      009FBB 6C 69 6E         [ 2]    1         jp interp_loop 
      009FBE 65 20            [ 1] 4097 1$: ld a,#REL_EQU_IDX 
      009FC0 00 2C 20         [ 4] 4098 	call expect 
      009FC3 43 4F 4E         [ 4] 4099 	call expression 
      009FC6 20 74 6F         [ 2] 4100 	cpw x,#free_ram 
      009FC9 20 72            [ 1] 4101 	jrult bad_value 
      009FCB 65 73 75         [ 2] 4102 	cpw x,himem  
      009FCE 6D 65            [ 1] 4103 	jruge bad_value 
      002230                       4104 	_strxz lomem
      009FD0 2E 0A                    1     .byte 0xbf,lomem 
      002232                       4105 clear_prog_space: 
      009FD2 00 21 62         [ 4] 4106 	call clear_state 
      009FD3                       4107 	_ldxz lomem 
      009FD3 72 08                    1     .byte 0xbe,lomem 
      002237                       4108 	_strxz progend 
      009FD5 00 3B                    1     .byte 0xbf,progend 
      009FD7 03 CC 93         [ 4] 4109 	call free 
      00223C                       4110 	_next 
      009FDA A6 13 26         [ 2]    1         jp interp_loop 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 208.
Hexadecimal [24-Bits]



      009FDB                       4111 bad_value:
      009FDB CD 9B            [ 1] 4112 	ld a,#ERR_RANGE 
      009FDD 2C 5B 04         [ 2] 4113 	jp tb_error 
                                   4114 
      002244                       4115 free: 
      009FE0 72 19 00         [ 2] 4116 	ldw x,himem 
      009FE3 3B 72 10 00      [ 2] 4117 	subw x,lomem 
      009FE7 3B CC 93         [ 4] 4118 	call print_int  
      009FEA A6 22 55         [ 2] 4119 	ldw x,#bytes_free   
      009FEB CD 05 23         [ 4] 4120 	call puts 
      009FEB 81               [ 4] 4121 	ret 
      009FEB 3F 3B CD 93 03 CC 93  4122 bytes_free: .asciz "bytes free" 
             A6 65 65 00
                                   4123 
                                   4124 ;------------------------------
                                   4125 ;      dictionary 
                                   4126 ; format:
                                   4127 ;   link:   2 bytes 
                                   4128 ;   name_length+flags:  1 byte, bits 0:3 lenght,4:8 kw type   
                                   4129 ;   cmd_name: 16 byte max 
                                   4130 ;   code_addr: 2 bytes 
                                   4131 ;------------------------------
                                   4132 	.macro _dict_entry len,name,token_id 
                                   4133 	.word LINK  ; point to next name field 
                                   4134 	LINK=.  ; name field 
                                   4135 	.byte len  ; name length 
                                   4136 	.asciz name  ; name 
                                   4137 	.byte token_id   ; TOK_IDX 
                                   4138 	.endm 
                                   4139 
                           000000  4140 	LINK=0
                                   4141 ; respect alphabetic order for BASIC names from Z-A
                                   4142 ; this sort order is for a cleaner WORDS cmd output. 	
      009FF3                       4143 dict_end:
      002260                       4144 	_dict_entry,5,"WORDS",WORDS_IDX 
      009FF3 CD 95                    1 	.word LINK  ; point to next name field 
                           002262     2 	LINK=.  ; name field 
      009FF5 78                       3 	.byte 5  ; name length 
      009FF6 72 11 00 0A CF 00        4 	.asciz "WORDS"  ; name 
      009FFC 06                       5 	.byte WORDS_IDX   ; TOK_IDX 
      00226A                       4145 	_dict_entry,4,"TONE",TONE_IDX 
      009FFD 8F CE                    1 	.word LINK  ; point to next name field 
                           00226C     2 	LINK=.  ; name field 
      009FFF 00                       3 	.byte 4  ; name length 
      00A000 06 26 FA CC 93           4 	.asciz "TONE"  ; name 
      00A005 A6                       5 	.byte TONE_IDX   ; TOK_IDX 
      00A006                       4146 	_dict_entry,2,"TO",TO_IDX
      00A006 BE 04                    1 	.word LINK  ; point to next name field 
                           002275     2 	LINK=.  ; name field 
      00A008 81                       3 	.byte 2  ; name length 
      00A009 54 4F 00                 4 	.asciz "TO"  ; name 
      00A009 A6                       5 	.byte TO_IDX   ; TOK_IDX 
      00227A                       4147 	_dict_entry,5,"TICKS",TICKS_IDX 
      00A00A 04 CD                    1 	.word LINK  ; point to next name field 
                           00227C     2 	LINK=.  ; name field 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 209.
Hexadecimal [24-Bits]



      00A00C 94                       3 	.byte 5  ; name length 
      00A00D 96 CD 95 78 9F 5F        4 	.asciz "TICKS"  ; name 
      00A013 A4                       5 	.byte TICKS_IDX   ; TOK_IDX 
      002284                       4148 	_dict_entry,4,"THEN",THEN_IDX 
      00A014 7F 97                    1 	.word LINK  ; point to next name field 
                           002286     2 	LINK=.  ; name field 
      00A016 A6                       3 	.byte 4  ; name length 
      00A017 05 CD 94 96 81           4 	.asciz "THEN"  ; name 
      00A01C 21                       5 	.byte THEN_IDX   ; TOK_IDX 
      00228D                       4149 	_dict_entry,3,"TAB",TAB_IDX 
      00A01C CD 94                    1 	.word LINK  ; point to next name field 
                           00228F     2 	LINK=.  ; name field 
      00A01E A4                       3 	.byte 3  ; name length 
      00A01F A1 01 27 03              4 	.asciz "TAB"  ; name 
      00A023 CC                       5 	.byte TAB_IDX   ; TOK_IDX 
      002295                       4150 	_dict_entry,4,"STOP",STOP_IDX
      00A024 92 25                    1 	.word LINK  ; point to next name field 
                           002297     2 	LINK=.  ; name field 
      00A026 04                       3 	.byte 4  ; name length 
      00A026 85 5D 2A 01 50           4 	.asciz "STOP"  ; name 
      00A02B 81                       5 	.byte STOP_IDX   ; TOK_IDX 
      00A02C                       4151 	_dict_entry,4,"STEP",STEP_IDX
      00A02C CD 94                    1 	.word LINK  ; point to next name field 
                           0022A0     2 	LINK=.  ; name field 
      00A02E A4                       3 	.byte 4  ; name length 
      00A02F A1 01 27 03 CC           4 	.asciz "STEP"  ; name 
      00A034 92                       5 	.byte STEP_IDX   ; TOK_IDX 
      0022A7                       4152 	_dict_entry,5,"SLEEP",SLEEP_IDX 
      00A035 25 A0                    1 	.word LINK  ; point to next name field 
                           0022A9     2 	LINK=.  ; name field 
      00A036 05                       3 	.byte 5  ; name length 
      00A036 CD 83 2E 90 89 16        4 	.asciz "SLEEP"  ; name 
      00A03C 03                       5 	.byte SLEEP_IDX   ; TOK_IDX 
      0022B1                       4153 	_dict_entry,3,"SGN",SGN_IDX
      00A03D 65 51                    1 	.word LINK  ; point to next name field 
                           0022B3     2 	LINK=.  ; name field 
      00A03F 90                       3 	.byte 3  ; name length 
      00A040 85 5B 02 81              4 	.asciz "SGN"  ; name 
      00A044 2B                       5 	.byte SGN_IDX   ; TOK_IDX 
      0022B9                       4154 	_dict_entry,3,"SCR",NEW_IDX
      00A044 CD 95                    1 	.word LINK  ; point to next name field 
                           0022BB     2 	LINK=.  ; name field 
      00A046 78                       3 	.byte 3  ; name length 
      00A047 89 88 1A 02              4 	.asciz "SCR"  ; name 
      00A04B 1A                       5 	.byte NEW_IDX   ; TOK_IDX 
      0022C1                       4155 	_dict_entry 3,"RUN",RUN_IDX
      00A04C 03 84                    1 	.word LINK  ; point to next name field 
                           0022C3     2 	LINK=.  ; name field 
      00A04E 5B                       3 	.byte 3  ; name length 
      00A04F 02 26 06 C6              4 	.asciz "RUN"  ; name 
      00A053 00                       5 	.byte RUN_IDX   ; TOK_IDX 
      0022C9                       4156 	_dict_entry,3,"RND",RND_IDX
      00A054 04 CE                    1 	.word LINK  ; point to next name field 
                           0022CB     2 	LINK=.  ; name field 
      00A056 00                       3 	.byte 3  ; name length 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 210.
Hexadecimal [24-Bits]



      00A057 05 4E 44 00              4 	.asciz "RND"  ; name 
      00A058 2A                       5 	.byte RND_IDX   ; TOK_IDX 
      0022D1                       4157 	_dict_entry,6,"RETURN",RET_IDX
      00A058 72 5F                    1 	.word LINK  ; point to next name field 
                           0022D3     2 	LINK=.  ; name field 
      00A05A 00                       3 	.byte 6  ; name length 
      00A05B 0D C7 00 0E CF 00 0B     4 	.asciz "RETURN"  ; name 
      00A062 CC                       5 	.byte RET_IDX   ; TOK_IDX 
      0022DC                       4158 	_dict_entry 3,"REM",REM_IDX
      00A063 93 A6                    1 	.word LINK  ; point to next name field 
                           0022DE     2 	LINK=.  ; name field 
      00A065 03                       3 	.byte 3  ; name length 
      00A065 CD 94 A4 A1              4 	.asciz "REM"  ; name 
      00A069 01                       5 	.byte REM_IDX   ; TOK_IDX 
      0022E4                       4159 	_dict_entry 5,"PRINT",PRINT_IDX 
      00A06A 27 03                    1 	.word LINK  ; point to next name field 
                           0022E6     2 	LINK=.  ; name field 
      00A06C CC                       3 	.byte 5  ; name length 
      00A06D 92 25 49 4E 54 00        4 	.asciz "PRINT"  ; name 
      00A06F 3C                       5 	.byte PRINT_IDX   ; TOK_IDX 
      0022EE                       4160 	_dict_entry,4,"POKE",POKE_IDX 
      00A06F 85 27                    1 	.word LINK  ; point to next name field 
                           0022F0     2 	LINK=.  ; name field 
      00A071 0C                       3 	.byte 4  ; name length 
      00A072 2B 04 AE 00 01           4 	.asciz "POKE"  ; name 
      00A077 81                       5 	.byte POKE_IDX   ; TOK_IDX 
      0022F7                       4161 	_dict_entry,4,"PEEK",PEEK_IDX 
      00A078 AE FF                    1 	.word LINK  ; point to next name field 
                           0022F9     2 	LINK=.  ; name field 
      00A07A FF                       3 	.byte 4  ; name length 
      00A07B CD 88 2E 81 00           4 	.asciz "PEEK"  ; name 
      00A07F 29                       5 	.byte PEEK_IDX   ; TOK_IDX 
      002300                       4162 	_dict_entry,2,"OR",OR_IDX  
      00A07F A6 04                    1 	.word LINK  ; point to next name field 
                           002302     2 	LINK=.  ; name field 
      00A081 CD                       3 	.byte 2  ; name length 
      00A082 94 96 90                 4 	.asciz "OR"  ; name 
      00A085 F6                       5 	.byte OR_IDX   ; TOK_IDX 
      002307                       4163 	_dict_entry,3,"NOT",NOT_IDX
      00A086 90 5C                    1 	.word LINK  ; point to next name field 
                           002309     2 	LINK=.  ; name field 
      00A088 A1                       3 	.byte 3  ; name length 
      00A089 06 26 10 93              4 	.asciz "NOT"  ; name 
      00A08D CD                       5 	.byte NOT_IDX   ; TOK_IDX 
      00230F                       4164 	_dict_entry,3,"NEW",NEW_IDX
      00A08E 88 86                    1 	.word LINK  ; point to next name field 
                           002311     2 	LINK=.  ; name field 
      00A090 88                       3 	.byte 3  ; name length 
      00A091 4B 00 72 F9              4 	.asciz "NEW"  ; name 
      00A095 01                       5 	.byte NEW_IDX   ; TOK_IDX 
      002317                       4165 	_dict_entry,4,"NEXT",NEXT_IDX 
      00A096 90 5C                    1 	.word LINK  ; point to next name field 
                           002319     2 	LINK=.  ; name field 
      00A098 5B                       3 	.byte 4  ; name length 
      00A099 02 20 10 54 00           4 	.asciz "NEXT"  ; name 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 211.
Hexadecimal [24-Bits]



      00A09C 1C                       5 	.byte NEXT_IDX   ; TOK_IDX 
      002320                       4166 	_dict_entry,3,"MOD",MOD_IDX 
      00A09C A1 0A                    1 	.word LINK  ; point to next name field 
                           002322     2 	LINK=.  ; name field 
      00A09E 27                       3 	.byte 3  ; name length 
      00A09F 03 CC 92 25              4 	.asciz "MOD"  ; name 
      00A0A3 0E                       5 	.byte MOD_IDX   ; TOK_IDX 
      002328                       4167 	_dict_entry,5,"LOMEM",LOMEM_IDX 
      00A0A3 CD 97                    1 	.word LINK  ; point to next name field 
                           00232A     2 	LINK=.  ; name field 
      00A0A5 ED                       3 	.byte 5  ; name length 
      00A0A6 EE 02 5C CD 88 86        4 	.asciz "LOMEM"  ; name 
      00A0AC 34                       5 	.byte LOMEM_IDX   ; TOK_IDX 
      002332                       4168 	_dict_entry 4,"LIST",LIST_IDX
      00A0AC 5F 97                    1 	.word LINK  ; point to next name field 
                           002334     2 	LINK=.  ; name field 
      00A0AE A6                       3 	.byte 4  ; name length 
      00A0AF 05 CD 94 96 81           4 	.asciz "LIST"  ; name 
      00A0B4 38                       5 	.byte LIST_IDX   ; TOK_IDX 
      00233B                       4169 	_dict_entry 3,"LET",LET_IDX
      00A0B4 52 08                    1 	.word LINK  ; point to next name field 
                           00233D     2 	LINK=.  ; name field 
      00A0B6 A6                       3 	.byte 3  ; name length 
      00A0B7 04 6B 01 6B              4 	.asciz "LET"  ; name 
      00A0BB 03                       5 	.byte LET_IDX   ; TOK_IDX 
      002343                       4170 	_dict_entry 3,"LEN",LEN_IDX  
      00A0BC 0F 02                    1 	.word LINK  ; point to next name field 
                           002345     2 	LINK=.  ; name field 
      00A0BE A6                       3 	.byte 3  ; name length 
      00A0BF 0B 6B 04 3F              4 	.asciz "LEN"  ; name 
      00A0C3 18                       5 	.byte LEN_IDX   ; TOK_IDX 
      00234B                       4171 	_dict_entry,5,"INPUT",INPUT_IDX 
      00A0C4 17 05                    1 	.word LINK  ; point to next name field 
                           00234D     2 	LINK=.  ; name field 
      00A0C6 90                       3 	.byte 5  ; name length 
      00A0C7 F6 A1 07 26 1F 90        4 	.asciz "INPUT"  ; name 
      00A0CD 5C                       5 	.byte INPUT_IDX   ; TOK_IDX 
      002355                       4172 	_dict_entry,2,"IF",IF_IDX 
      00A0CE 90 F6                    1 	.word LINK  ; point to next name field 
                           002357     2 	LINK=.  ; name field 
      00A0D0 90                       3 	.byte 2  ; name length 
      00A0D1 5C A1 43                 4 	.asciz "IF"  ; name 
      00A0D4 27                       5 	.byte IF_IDX   ; TOK_IDX 
      00235C                       4173 	_dict_entry,5,"HIMEM",HIMEM_IDX 
      00A0D5 03 CC                    1 	.word LINK  ; point to next name field 
                           00235E     2 	LINK=.  ; name field 
      00A0D7 92                       3 	.byte 5  ; name length 
      00A0D8 25 49 4D 45 4D 00        4 	.asciz "HIMEM"  ; name 
      00A0D9 33                       5 	.byte HIMEM_IDX   ; TOK_IDX 
      002366                       4174 	_dict_entry,4,"GOTO",GOTO_IDX  
      00A0D9 17 05                    1 	.word LINK  ; point to next name field 
                           002368     2 	LINK=.  ; name field 
      00A0DB A6                       3 	.byte 4  ; name length 
      00A0DC 03 6B 01 6B 03           4 	.asciz "GOTO"  ; name 
      00A0E1 A6                       5 	.byte GOTO_IDX   ; TOK_IDX 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 212.
Hexadecimal [24-Bits]



      00236F                       4175 	_dict_entry,5,"GOSUB",GOSUB_IDX 
      00A0E2 0A 6B                    1 	.word LINK  ; point to next name field 
                           002371     2 	LINK=.  ; name field 
      00A0E4 04                       3 	.byte 5  ; name length 
      00A0E5 90 AE A4 CB 20 04        4 	.asciz "GOSUB"  ; name 
      00A0EB 1D                       5 	.byte GOSUB_IDX   ; TOK_IDX 
      002379                       4176 	_dict_entry,3,"FOR",FOR_IDX 
      00A0EB 90 AE                    1 	.word LINK  ; point to next name field 
                           00237B     2 	LINK=.  ; name field 
      00A0ED A4                       3 	.byte 3  ; name length 
      00A0EE 4E 4F 52 00              4 	.asciz "FOR"  ; name 
      00A0EF 1B                       5 	.byte FOR_IDX   ; TOK_IDX 
      002381                       4177 	_dict_entry,3,"END",END_IDX 
      00A0EF 93 F6                    1 	.word LINK  ; point to next name field 
                           002383     2 	LINK=.  ; name field 
      00A0F1 5C                       3 	.byte 3  ; name length 
      00A0F2 1F 07 5F 97              4 	.asciz "END"  ; name 
      00A0F6 7B                       5 	.byte END_IDX   ; TOK_IDX 
      002389                       4178 	_dict_entry,3,"DIM",DIM_IDX 
      00A0F7 04 62                    1 	.word LINK  ; point to next name field 
                           00238B     2 	LINK=.  ; name field 
      00A0F9 1E                       3 	.byte 3  ; name length 
      00A0FA 07 4C B7 19              4 	.asciz "DIM"  ; name 
      00A0FE 7B                       5 	.byte DIM_IDX   ; TOK_IDX 
      002391                       4179 	_dict_entry,3,"DEL",DEL_IDX 
      00A0FF 03 A1                    1 	.word LINK  ; point to next name field 
                           002393     2 	LINK=.  ; name field 
      00A101 04                       3 	.byte 3  ; name length 
      00A102 27 0F A6 24              4 	.asciz "DEL"  ; name 
      00A106 CD                       5 	.byte DEL_IDX   ; TOK_IDX 
      002399                       4180 	_dict_entry,3,"CON",CON_IDX 
      00A107 85 2C                    1 	.word LINK  ; point to next name field 
                           00239B     2 	LINK=.  ; name field 
      00A109 72                       3 	.byte 3  ; name length 
      00A10A D6 00 18 CD              4 	.asciz "CON"  ; name 
      00A10E 88                       5 	.byte CON_IDX   ; TOK_IDX 
      0023A1                       4181 	_dict_entry,3,"CLR",CLR_IDX 
      00A10F 1C CD                    1 	.word LINK  ; point to next name field 
                           0023A3     2 	LINK=.  ; name field 
      00A111 86                       3 	.byte 3  ; name length 
      00A112 06 4C 52 00              4 	.asciz "CLR"  ; name 
      00A113 36                       5 	.byte CLR_IDX   ; TOK_IDX 
      0023A9                       4182 	_dict_entry,4,"CHR$",CHAR_IDX  
      00A113 CD 85                    1 	.word LINK  ; point to next name field 
                           0023AB     2 	LINK=.  ; name field 
      00A115 A3                       3 	.byte 4  ; name length 
      00A116 0C 02 0A 01 27           4 	.asciz "CHR$"  ; name 
      00A11B 10                       5 	.byte CHAR_IDX   ; TOK_IDX 
      0023B2                       4183 	_dict_entry,4,"CALL",CALL_IDX
      00A11C 7B 04                    1 	.word LINK  ; point to next name field 
                           0023B4     2 	LINK=.  ; name field 
      00A11E C0                       3 	.byte 4  ; name length 
      00A11F 00 19 2A 02 A6           4 	.asciz "CALL"  ; name 
      00A124 09                       5 	.byte CALL_IDX   ; TOK_IDX 
      0023BB                       4184 	_dict_entry,4,"AUTO",AUTO_IDX 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 213.
Hexadecimal [24-Bits]



      00A125 5F 97                    1 	.word LINK  ; point to next name field 
                           0023BD     2 	LINK=.  ; name field 
      00A127 CD                       3 	.byte 4  ; name length 
      00A128 86 0C 20 09 A6           4 	.asciz "AUTO"  ; name 
      00A12D 0D                       5 	.byte AUTO_IDX   ; TOK_IDX 
      0023C4                       4185 	_dict_entry,3,"AND",AND_IDX  
      00A12E CD 85                    1 	.word LINK  ; point to next name field 
                           0023C6     2 	LINK=.  ; name field 
      00A130 2C                       3 	.byte 3  ; name length 
      00A131 7B 03 6B 01              4 	.asciz "AND"  ; name 
      00A135 72                       5 	.byte AND_IDX   ; TOK_IDX 
      0023CC                       4186 kword_dict::
      0023CC                       4187 	_dict_entry,3,"ABS",ABS_IDX 
      00A136 A2 00                    1 	.word LINK  ; point to next name field 
                           0023CE     2 	LINK=.  ; name field 
      00A138 02                       3 	.byte 3  ; name length 
      00A139 90 FE 26 B2              4 	.asciz "ABS"  ; name 
      00A13D A6                       5 	.byte ABS_IDX   ; TOK_IDX 
                                   4188 ; the following are not searched
                                   4189 ; by compiler
      0023D4                       4190 	_dict_entry,1,"'",REM_IDX 
      00A13E 0D CD                    1 	.word LINK  ; point to next name field 
                           0023D6     2 	LINK=.  ; name field 
      00A140 85                       3 	.byte 1  ; name length 
      00A141 2C 5F                    4 	.asciz "'"  ; name 
      00A143 7B                       5 	.byte REM_IDX   ; TOK_IDX 
      0023DA                       4191 	_dict_entry,1,"?",PRINT_IDX 
      00A144 02 97                    1 	.word LINK  ; point to next name field 
                           0023DC     2 	LINK=.  ; name field 
      00A146 CD                       3 	.byte 1  ; name length 
      00A147 88 2E                    4 	.asciz "?"  ; name 
      00A149 AE                       5 	.byte PRINT_IDX   ; TOK_IDX 
      0023E0                       4192 	_dict_entry,1,"#",REL_NE_IDX 
      00A14A A1 56                    1 	.word LINK  ; point to next name field 
                           0023E2     2 	LINK=.  ; name field 
      00A14C CD                       3 	.byte 1  ; name length 
      00A14D 85 A3                    4 	.asciz "#"  ; name 
      00A14F 16                       5 	.byte REL_NE_IDX   ; TOK_IDX 
      0023E6                       4193 	_dict_entry,2,"<>",REL_NE_IDX
      00A150 05 5B                    1 	.word LINK  ; point to next name field 
                           0023E8     2 	LINK=.  ; name field 
      00A152 08                       3 	.byte 2  ; name length 
      00A153 CC 93 A6                 4 	.asciz "<>"  ; name 
      00A156 20                       5 	.byte REL_NE_IDX   ; TOK_IDX 
      0023ED                       4194 	_dict_entry,1,">",REL_GT_IDX
      00A157 77 6F                    1 	.word LINK  ; point to next name field 
                           0023EF     2 	LINK=.  ; name field 
      00A159 72                       3 	.byte 1  ; name length 
      00A15A 64 73                    4 	.asciz ">"  ; name 
      00A15C 20                       5 	.byte REL_GT_IDX   ; TOK_IDX 
      0023F3                       4195 	_dict_entry,1,"<",REL_LT_IDX
      00A15D 69 6E                    1 	.word LINK  ; point to next name field 
                           0023F5     2 	LINK=.  ; name field 
      00A15F 20                       3 	.byte 1  ; name length 
      00A160 64 69                    4 	.asciz "<"  ; name 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 214.
Hexadecimal [24-Bits]



      00A162 63                       5 	.byte REL_LT_IDX   ; TOK_IDX 
      0023F9                       4196 	_dict_entry,2,">=",REL_GE_IDX
      00A163 74 69                    1 	.word LINK  ; point to next name field 
                           0023FB     2 	LINK=.  ; name field 
      00A165 6F                       3 	.byte 2  ; name length 
      00A166 6E 61 72                 4 	.asciz ">="  ; name 
      00A169 79                       5 	.byte REL_GE_IDX   ; TOK_IDX 
      002400                       4197 	_dict_entry,1,"=",REL_EQU_IDX 
      00A16A 0A 00                    1 	.word LINK  ; point to next name field 
                           002402     2 	LINK=.  ; name field 
      00A16C 01                       3 	.byte 1  ; name length 
      00A16C CD 94                    4 	.asciz "="  ; name 
      00A16E AF                       5 	.byte REL_EQU_IDX   ; TOK_IDX 
      002406                       4198 	_dict_entry,2,"<=",REL_LE_IDX 
      00A16F A1 01                    1 	.word LINK  ; point to next name field 
                           002408     2 	LINK=.  ; name field 
      00A171 27                       3 	.byte 2  ; name length 
      00A172 03 CC 92                 4 	.asciz "<="  ; name 
      00A175 25                       5 	.byte REL_LE_IDX   ; TOK_IDX 
      00A176                       4199 	_dict_entry,1,"*",MULT_IDX 
      00A176 85 72                    1 	.word LINK  ; point to next name field 
                           00240F     2 	LINK=.  ; name field 
      00A178 11                       3 	.byte 1  ; name length 
      00A179 00 0A                    4 	.asciz "*"  ; name 
      00A17B CF                       5 	.byte MULT_IDX   ; TOK_IDX 
      002413                       4200 	_dict_entry,1,"%",MOD_IDX 
      00A17C 00 06                    1 	.word LINK  ; point to next name field 
                           002415     2 	LINK=.  ; name field 
      00A17E CC                       3 	.byte 1  ; name length 
      00A17F 93 A6                    4 	.asciz "%"  ; name 
      00A181 0E                       5 	.byte MOD_IDX   ; TOK_IDX 
      002419                       4201 	_dict_entry,1,"/",DIV_IDX 
      00A181 4F 5F                    1 	.word LINK  ; point to next name field 
                           00241B     2 	LINK=.  ; name field 
      00A183 72                       3 	.byte 1  ; name length 
      00A184 01 00                    4 	.asciz "/"  ; name 
      00A186 0A                       5 	.byte DIV_IDX   ; TOK_IDX 
      00241F                       4202 	_dict_entry,1,"-",SUB_IDX 
      00A187 02 43                    1 	.word LINK  ; point to next name field 
                           002421     2 	LINK=.  ; name field 
      00A189 53                       3 	.byte 1  ; name length 
      00A18A 81 00                    4 	.asciz "-"  ; name 
      00A18B 0C                       5 	.byte SUB_IDX   ; TOK_IDX 
      002425                       4203 	_dict_entry,1,"+",ADD_IDX
      00A18B 4F AE                    1 	.word LINK  ; point to next name field 
                           002427     2 	LINK=.  ; name field 
      00A18D 40                       3 	.byte 1  ; name length 
      00A18E 00 81                    4 	.asciz "+"  ; name 
      00A190 0B                       5 	.byte ADD_IDX   ; TOK_IDX 
      00242B                       4204 	_dict_entry,1,'"',QUOTE_IDX
      00A190 CD 95                    1 	.word LINK  ; point to next name field 
                           00242D     2 	LINK=.  ; name field 
      00A192 78                       3 	.byte 1  ; name length 
      00A193 4F 95                    4 	.asciz '"'  ; name 
      00A195 CD                       5 	.byte QUOTE_IDX   ; TOK_IDX 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 215.
Hexadecimal [24-Bits]



      002431                       4205 	_dict_entry,1,")",RPAREN_IDX 
      00A196 86 0C                    1 	.word LINK  ; point to next name field 
                           002433     2 	LINK=.  ; name field 
      00A198 CC                       3 	.byte 1  ; name length 
      00A199 93 A6                    4 	.asciz ")"  ; name 
      00A19B 05                       5 	.byte RPAREN_IDX   ; TOK_IDX 
      002437                       4206 	_dict_entry,1,"(",LPAREN_IDX 
      00A19B CD 94                    1 	.word LINK  ; point to next name field 
                           002439     2 	LINK=.  ; name field 
      00A19D AF                       3 	.byte 1  ; name length 
      00A19E A1 01                    4 	.asciz "("  ; name 
      00A1A0 27                       5 	.byte LPAREN_IDX   ; TOK_IDX 
      00243D                       4207 	_dict_entry,1,^/";"/,SCOL_IDX
      00A1A1 15 A1                    1 	.word LINK  ; point to next name field 
                           00243F     2 	LINK=.  ; name field 
      00A1A3 02                       3 	.byte 1  ; name length 
      00A1A4 27 03                    4 	.asciz ";"  ; name 
      00A1A6 CC                       5 	.byte SCOL_IDX   ; TOK_IDX 
      002443                       4208 	_dict_entry,1,^/","/,COMMA_IDX 
      00A1A7 92 25                    1 	.word LINK  ; point to next name field 
                           002445     2 	LINK=.  ; name field 
      00A1A9 01                       3 	.byte 1  ; name length 
      00A1A9 1E 03                    4 	.asciz ","  ; name 
      00A1AB BF                       5 	.byte COMMA_IDX   ; TOK_IDX 
      002449                       4209 all_words:
      002449                       4210 	_dict_entry,1,":",COLON_IDX 
      00A1AC 12 85                    1 	.word LINK  ; point to next name field 
                           00244B     2 	LINK=.  ; name field 
      00A1AE 5B                       3 	.byte 1  ; name length 
      00A1AF 02 72                    4 	.asciz ":"  ; name 
      00A1B1 CD                       5 	.byte COLON_IDX   ; TOK_IDX 
                                   4211 
      002480                       4212 	.bndry 128 
      002480                       4213 app: 
      002480                       4214 app_space:
                           000000  4215 .if 0
                                   4216 ; program to test CALL command 
                                   4217 blink:
                                   4218 	_led_toggle 
                                   4219 	ldw x,#250 
                                   4220 	_strxz timer 
                                   4221 	bres sys_flags,#FSYS_TIMER 
                                   4222 1$:	
                                   4223 	wfi 
                                   4224 	btjf sys_flags,#FSYS_TIMER,1$
                                   4225 	call qgetc 
                                   4226 	jreq blink 
                                   4227 	call getc 
                                   4228 	ret 
                                   4229 .endif 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 216.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ABS_IDX =  000028     |     ACK     =  000006 
    ADC_CR1 =  005401     |     ADC_CR1_=  000000     |     ADC_CR1_=  000001 
    ADC_CR1_=  000004     |     ADC_CR1_=  000005     |     ADC_CR1_=  000006 
    ADC_CR2 =  005402     |     ADC_CR2_=  000003     |     ADC_CR2_=  000004 
    ADC_CR2_=  000005     |     ADC_CR2_=  000006     |     ADC_CR2_=  000001 
    ADC_CR3 =  005403     |     ADC_CR3_=  000007     |     ADC_CR3_=  000006 
    ADC_CSR =  005400     |     ADC_CSR_=  000006     |     ADC_CSR_=  000004 
    ADC_CSR_=  000000     |     ADC_CSR_=  000001     |     ADC_CSR_=  000002 
    ADC_CSR_=  000003     |     ADC_CSR_=  000007     |     ADC_CSR_=  000005 
    ADC_DRH =  005404     |     ADC_DRL =  005405     |     ADC_TDRH=  005406 
    ADC_TDRL=  005407     |     ADDR    =  000003     |     ADD_IDX =  00000B 
    ADR_SIZE=  000002     |     AFR     =  004803     |     AFR0_ADC=  000000 
    AFR1_TIM=  000001     |     AFR2_CCO=  000002     |     AFR3_TIM=  000003 
    AFR4_TIM=  000004     |     AFR5_TIM=  000005     |     AFR6_I2C=  000006 
    AFR7_BEE=  000007     |     ALIGN   =  000003     |     AND_IDX =  000017 
    APP_VARS=  000028 G   |     ARGN    =  000004     |     ARG_OFS =  000002 
    ARG_SIZE=  000002     |     ARITHM_V=  000004     |     ARROW_LE=  000080 
    ARROW_RI=  000081     |     ATTRIB  =  000002     |     AUTO_IDX=  000032 
    AWU_APR =  0050F1     |     AWU_CSR =  0050F0     |     AWU_CSR_=  000004 
    AWU_TBR =  0050F2     |     B0_MASK =  000001     |     B1      =  000001 
    B115200 =  000006     |     B19200  =  000003     |     B1_MASK =  000002 
    B230400 =  000007     |     B2400   =  000000     |     B2_MASK =  000004 
    B38400  =  000004     |     B3_MASK =  000008     |     B460800 =  000008 
    B4800   =  000001     |     B4_MASK =  000010     |     B57600  =  000005 
    B5_MASK =  000020     |     B6_MASK =  000040     |     B7_MASK =  000080 
    B921600 =  000009     |     B9600   =  000002     |   4 BACKSPAC   000964 R
    BAUD_RAT=  01C200     |     BEEP_BIT=  000004     |     BEEP_CSR=  0050F3 
    BEEP_MAS=  000010     |     BEEP_POR=  00000F     |     BELL    =  000007 
    BIT     =  000001     |     BIT0    =  000000     |     BIT1    =  000001 
    BIT2    =  000002     |     BIT3    =  000003     |     BIT4    =  000004 
    BIT5    =  000005     |     BIT6    =  000006     |     BIT7    =  000007 
    BLOCK_SI=  000080     |   4 BLSKIP     000998 R   |     BOOL_OP_=  000018 
    BOOT_ROM=  006000     |     BOOT_ROM=  007FFF     |     BPTR    =  000009 
    BS      =  000008     |     BUFOUT  =  000003     |     C       =  000001 
    CALL_IDX=  00003A     |     CAN     =  000018     |     CAN_DGR =  005426 
    CAN_FPSR=  005427     |     CAN_IER =  005425     |     CAN_MCR =  005420 
    CAN_MSR =  005421     |     CAN_P0  =  005428     |     CAN_P1  =  005429 
    CAN_P2  =  00542A     |     CAN_P3  =  00542B     |     CAN_P4  =  00542C 
    CAN_P5  =  00542D     |     CAN_P6  =  00542E     |     CAN_P7  =  00542F 
    CAN_P8  =  005430     |     CAN_P9  =  005431     |     CAN_PA  =  005432 
    CAN_PB  =  005433     |     CAN_PC  =  005434     |     CAN_PD  =  005435 
    CAN_PE  =  005436     |     CAN_PF  =  005437     |     CAN_RFR =  005424 
    CAN_TPR =  005423     |     CAN_TSR =  005422     |     CC_C    =  000000 
    CC_H    =  000004     |     CC_I0   =  000003     |     CC_I1   =  000005 
    CC_N    =  000002     |     CC_V    =  000007     |     CC_Z    =  000001 
    CELL_SIZ=  000002 G   |     CFG_GCR =  007F60     |     CFG_GCR_=  000001 
    CFG_GCR_=  000000     |     CHAIN_BP=  000003     |     CHAIN_CN=  000008 
    CHAIN_LN=  000001     |     CHAIN_TX=  000005     |     CHAIN_TX=  000007 
    CHAR_ARR=  000005     |     CHAR_IDX=  00002E     |     CHK_TIMO=  00000B G
    CLKOPT  =  004807     |     CLKOPT_C=  000002     |     CLKOPT_E=  000003 
    CLKOPT_P=  000000     |     CLKOPT_P=  000001     |     CLK_CCOR=  0050C9 
    CLK_CKDI=  0050C6     |     CLK_CKDI=  000000     |     CLK_CKDI=  000001 
    CLK_CKDI=  000002     |     CLK_CKDI=  000003     |     CLK_CKDI=  000004 
    CLK_CMSR=  0050C3     |     CLK_CSSR=  0050C8     |     CLK_ECKR=  0050C1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 217.
Hexadecimal [24-Bits]

Symbol Table

    CLK_ECKR=  000000     |     CLK_ECKR=  000001     |     CLK_HSIT=  0050CC 
    CLK_ICKR=  0050C0     |     CLK_ICKR=  000002     |     CLK_ICKR=  000000 
    CLK_ICKR=  000001     |     CLK_ICKR=  000003     |     CLK_ICKR=  000004 
    CLK_ICKR=  000005     |     CLK_PCKE=  0050C7     |     CLK_PCKE=  000000 
    CLK_PCKE=  000001     |     CLK_PCKE=  000007     |     CLK_PCKE=  000005 
    CLK_PCKE=  000006     |     CLK_PCKE=  000004     |     CLK_PCKE=  000002 
    CLK_PCKE=  000003     |     CLK_PCKE=  0050CA     |     CLK_PCKE=  000003 
    CLK_PCKE=  000002     |     CLK_PCKE=  000007     |     CLK_SWCR=  0050C5 
    CLK_SWCR=  000000     |     CLK_SWCR=  000001     |     CLK_SWCR=  000002 
    CLK_SWCR=  000003     |     CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4 
    CLK_SWR_=  0000B4     |     CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2 
    CLR_IDX =  000036     |     CLS     =  000005 G   |     CMD_END =  000001 
    CMD_LAST=  00003E     |     COLON   =  00003A     |     COLON_ID=  000001 
    COL_CNT =  000001     |     COMMA   =  00002C     |     COMMA_ID=  000002 
    CON_IDX =  000026     |     COUNT   =  000006     |     CPOS    =  000001 
    CPU_A   =  007F00     |     CPU_CCR =  007F0A     |     CPU_PCE =  007F01 
    CPU_PCH =  007F02     |     CPU_PCL =  007F03     |     CPU_SPH =  007F08 
    CPU_SPL =  007F09     |     CPU_XH  =  007F04     |     CPU_XL  =  007F05 
    CPU_YH  =  007F06     |     CPU_YL  =  007F07     |     CR      =  00000D 
    CTRL_A  =  000001     |     CTRL_B  =  000002     |     CTRL_C  =  000003 
    CTRL_D  =  000004     |     CTRL_E  =  000005     |     CTRL_F  =  000006 
    CTRL_G  =  000007     |     CTRL_H  =  000008     |     CTRL_I  =  000009 
    CTRL_J  =  00000A     |     CTRL_K  =  00000B     |     CTRL_L  =  00000C 
    CTRL_M  =  00000D     |     CTRL_N  =  00000E     |     CTRL_O  =  00000F 
    CTRL_P  =  000010     |     CTRL_Q  =  000011     |     CTRL_R  =  000012 
    CTRL_S  =  000013     |     CTRL_T  =  000014     |     CTRL_U  =  000015 
    CTRL_V  =  000016     |     CTRL_W  =  000017     |     CTRL_X  =  000018 
    CTRL_Y  =  000019     |     CTRL_Z  =  00001A     |     CTXT_SIZ=  000004 
    CURR    =  000002     |     CVAR    =  000005     |     DBLDIVDN=  000005 
    DBLHI   =  000001     |     DBLLO   =  000003     |     DC1     =  000011 
    DC2     =  000012     |     DC3     =  000013     |     DC4     =  000014 
    DEBUG   =  000000     |     DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF 
    DELBK   =  000006 G   |     DELIM_LA=  000006     |     DEL_IDX =  000035 
    DEL_SIZE=  000005     |     DEST    =  000001     |     DEST_ADR=  000005 
    DEST_SIZ=  000003     |     DEVID_BA=  0048CD     |     DEVID_EN=  0048D8 
    DEVID_LO=  0048D2     |     DEVID_LO=  0048D3     |     DEVID_LO=  0048D4 
    DEVID_LO=  0048D5     |     DEVID_LO=  0048D6     |     DEVID_LO=  0048D7 
    DEVID_LO=  0048D8     |     DEVID_WA=  0048D1     |     DEVID_XH=  0048CE 
    DEVID_XL=  0048CD     |     DEVID_YH=  0048D0     |     DEVID_YL=  0048CF 
  4 DIG        0009C4 R   |     DIGIT   =  000003     |     DIM_IDX =  000019 
    DIM_SIZE=  000003     |     DIVDHI  =  000001     |     DIVDLO  =  000003 
    DIVDNDHI=  00000B     |     DIVDNDLO=  00000D     |     DIVISOR =  000001 
    DIVISR  =  000005     |     DIVR    =  000005     |     DIV_IDX =  00000D 
    DLE     =  000010     |     DM_BK1RE=  007F90     |     DM_BK1RH=  007F91 
    DM_BK1RL=  007F92     |     DM_BK2RE=  007F93     |     DM_BK2RH=  007F94 
    DM_BK2RL=  007F95     |     DM_CR1  =  007F96     |     DM_CR2  =  007F97 
    DM_CSR1 =  007F98     |     DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A 
    DPROD   =  000003     |     DURATION=  000001     |   4 ECHO       000A2A R
    EEPROM_B=  004000     |     EEPROM_E=  0043FF     |     EEPROM_S=  000400 
    EM      =  000019     |     END_ADR =  000003     |     END_IDX =  00001A 
    ENQ     =  000005     |     EOF     =  0000FF     |   4 EOL        000991 R
    EOL_IDX =  000000     |     EOT     =  000004     |     ERR_BAD_=  000004 G
    ERR_BAD_=  000006 G   |     ERR_BAD_=  000005 G   |     ERR_DIM =  00000C G
    ERR_DIV0=  000012 G   |     ERR_END =  000009 G   |     ERR_FORS=  000008 G
    ERR_GOSU=  000007 G   |     ERR_GT25=  000003 G   |     ERR_GT32=  000002 G
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 218.
Hexadecimal [24-Bits]

Symbol Table

    ERR_IDX =  000013     |     ERR_MEM_=  00000A G   |     ERR_NONE=  000000 G
    ERR_PROG=  000011 G   |     ERR_RANG=  00000D G   |     ERR_RETY=  000010 G
    ERR_STRI=  00000F G   |     ERR_STR_=  00000E G   |     ERR_SYNT=  000001 G
    ERR_TOO_=  00000B G   |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1 
    FAUTO   =  000006     |     FCOMP   =  000005     |     FF      =  00000C 
    FHSE    =  7A1200     |     FHSI    =  F42400     |     FILE_DAT=  000004 
    FILE_HEA=  000004     |     FILE_SIG=  000000     |     FILE_SIZ=  000002 
    FIRST   =  000001     |     FIRST_CH=  000001     |     FIRST_DA=  000004 
    FLASH_BA=  008000     |     FLASH_CR=  00505A     |     FLASH_CR=  000002 
    FLASH_CR=  000000     |     FLASH_CR=  000003     |     FLASH_CR=  000001 
    FLASH_CR=  00505B     |     FLASH_CR=  000005     |     FLASH_CR=  000004 
    FLASH_CR=  000007     |     FLASH_CR=  000000     |     FLASH_CR=  000006 
    FLASH_DU=  005064     |     FLASH_DU=  0000AE     |     FLASH_DU=  000056 
    FLASH_EN=  017FFF     |     FLASH_FP=  00505D     |     FLASH_FP=  000000 
    FLASH_FP=  000001     |     FLASH_FP=  000002     |     FLASH_FP=  000003 
    FLASH_FP=  000004     |     FLASH_FP=  000005     |     FLASH_IA=  00505F 
    FLASH_IA=  000003     |     FLASH_IA=  000002     |     FLASH_IA=  000006 
    FLASH_IA=  000001     |     FLASH_IA=  000000     |   4 FLASH_ME   001945 R
    FLASH_NC=  00505C     |     FLASH_NF=  00505E     |     FLASH_NF=  000000 
    FLASH_NF=  000001     |     FLASH_NF=  000002     |     FLASH_NF=  000003 
    FLASH_NF=  000004     |     FLASH_NF=  000005     |     FLASH_PU=  005062 
    FLASH_PU=  000056     |     FLASH_PU=  0000AE     |     FLASH_SI=  010000 
    FLASH_WS=  00480D     |     FLSI    =  01F400     |     FMSTR   =  000010 
    FN_ADR  =  000003     |     FN_ARG  =  000001     |     FOPT    =  000001 
    FOR_IDX =  00001B     |     FREQ    =  000003     |     FRUN    =  000000 
    FS      =  00001C     |     FSLEEP  =  000003     |     FSTEP   =  000001 
    FSTOP   =  000004     |     FSYS_TIM=  000000 G   |     FSYS_TON=  000001 G
    FSYS_UPP=  000002 G   |     FTRACE  =  000007     |     FUNC_LAS=  00002E 
    F_ARRAY =  000001     |     GETC    =  000003 G   |   4 GETLINE    000956 R
    GETLN   =  000007 G   |     GET_RND =  00000D G   |     GOSUB_ID=  00001D 
  4 GOTNUMBE   0009DA R   |     GOTO_IDX=  00001F     |   4 GO_BASIC   00094A R
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GS      =  00001D     |     HEAP_ADR=  000001 
  4 HEXSHIFT   0009C7 R   |     HIMEM_ID=  000033     |     HOME    =  000082 
    HSE     =  000000     |     HSECNT  =  004809     |     HSI     =  000001 
    I2C_BASE=  005210     |     I2C_CCRH=  00521C     |     I2C_CCRH=  000080 
    I2C_CCRH=  0000C0     |     I2C_CCRH=  000080     |     I2C_CCRH=  000000 
    I2C_CCRH=  000001     |     I2C_CCRH=  000000     |     I2C_CCRH=  000006 
    I2C_CCRH=  000007     |     I2C_CCRL=  00521B     |     I2C_CCRL=  00001A 
    I2C_CCRL=  000002     |     I2C_CCRL=  00000D     |     I2C_CCRL=  000050 
    I2C_CCRL=  000090     |     I2C_CCRL=  0000A0     |     I2C_CR1 =  005210 
    I2C_CR1_=  000006     |     I2C_CR1_=  000007     |     I2C_CR1_=  000000 
    I2C_CR2 =  005211     |     I2C_CR2_=  000002     |     I2C_CR2_=  000003 
    I2C_CR2_=  000000     |     I2C_CR2_=  000001     |     I2C_CR2_=  000007 
    I2C_DR  =  005216     |     I2C_FREQ=  005212     |     I2C_ITR =  00521A 
    I2C_ITR_=  000002     |     I2C_ITR_=  000000     |     I2C_ITR_=  000001 
    I2C_OARH=  005214     |     I2C_OARH=  000001     |     I2C_OARH=  000002 
    I2C_OARH=  000006     |     I2C_OARH=  000007     |     I2C_OARL=  005213 
    I2C_OARL=  000000     |     I2C_OAR_=  000813     |     I2C_OAR_=  000009 
    I2C_PECR=  00521E     |     I2C_READ=  000001     |     I2C_SR1 =  005217 
    I2C_SR1_=  000003     |     I2C_SR1_=  000001     |     I2C_SR1_=  000002 
    I2C_SR1_=  000006     |     I2C_SR1_=  000000     |     I2C_SR1_=  000004 
    I2C_SR1_=  000007     |     I2C_SR2 =  005218     |     I2C_SR2_=  000002 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 219.
Hexadecimal [24-Bits]

Symbol Table

    I2C_SR2_=  000001     |     I2C_SR2_=  000000     |     I2C_SR2_=  000003 
    I2C_SR2_=  000005     |     I2C_SR3 =  005219     |     I2C_SR3_=  000001 
    I2C_SR3_=  000007     |     I2C_SR3_=  000004     |     I2C_SR3_=  000000 
    I2C_SR3_=  000002     |     I2C_TRIS=  00521D     |     I2C_TRIS=  000005 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_WRIT=  000000 
    ICHAR   =  000001     |     IDX     =  000001     |     IF_IDX  =  000020 
    INCR    =  000001     |     INPUT_DI=  000000     |     INPUT_EI=  000001 
    INPUT_FL=  000000     |     INPUT_ID=  000037     |     INPUT_PU=  000001 
    INT_ADC2=  000016     |     INT_AUAR=  000012     |     INT_AWU =  000001 
    INT_CAN_=  000008     |     INT_CAN_=  000009     |     INT_CLK =  000002 
    INT_EXTI=  000003     |     INT_EXTI=  000004     |     INT_EXTI=  000005 
    INT_EXTI=  000006     |     INT_EXTI=  000007     |     INT_FLAS=  000018 
    INT_I2C =  000013     |     INT_SIZE=  000002 G   |     INT_SPI =  00000A 
    INT_TIM1=  00000C     |     INT_TIM1=  00000B     |     INT_TIM2=  00000E 
    INT_TIM2=  00000D     |     INT_TIM3=  000010     |     INT_TIM3=  00000F 
    INT_TIM4=  000017     |     INT_TLI =  000000     |     INT_UART=  000011 
    INT_UART=  000015     |     INT_UART=  000014     |     INT_VECT=  008060 
    INT_VECT=  00800C     |     INT_VECT=  008028     |     INT_VECT=  00802C 
    INT_VECT=  008010     |     INT_VECT=  008014     |     INT_VECT=  008018 
    INT_VECT=  00801C     |     INT_VECT=  008020     |     INT_VECT=  008024 
    INT_VECT=  008068     |     INT_VECT=  008054     |     INT_VECT=  008000 
    INT_VECT=  008030     |     INT_VECT=  008038     |     INT_VECT=  008034 
    INT_VECT=  008040     |     INT_VECT=  00803C     |     INT_VECT=  008048 
    INT_VECT=  008044     |     INT_VECT=  008064     |     INT_VECT=  008008 
    INT_VECT=  008004     |     INT_VECT=  008050     |     INT_VECT=  00804C 
    INT_VECT=  00805C     |     INT_VECT=  008058     |     IPOS    =  000003 
    ITC_SPR1=  007F70     |     ITC_SPR2=  007F71     |     ITC_SPR3=  007F72 
    ITC_SPR4=  007F73     |     ITC_SPR5=  007F74     |     ITC_SPR6=  007F75 
    ITC_SPR7=  007F76     |     ITC_SPR8=  007F77     |     ITC_SPR_=  000001 
    ITC_SPR_=  000000     |     ITC_SPR_=  000003     |     IWDG_KEY=  000055 
    IWDG_KEY=  0000CC     |     IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0 
    IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2     |     KEY_END =  000083 
    KWORD_LA=  000027     |     KW_TYPE_=  0000F0     |     LAST    =  000003 
    LAST_BC =  000004     |     LB      =  000002     |     LED_BIT =  000005 
    LED_MASK=  000020     |     LED_PORT=  00500A     |     LEN     =  000005 
    LEN_IDX =  00002C     |     LET_IDX =  000022     |     LF      =  00000A 
    LIMIT   =  000003     |     LINENO  =  000005     |   4 LINES_RE   0019F6 R
    LINE_HEA=  000003     |   4 LINK    =  00244B R   |     LIST_IDX=  000038 
    LITC_IDX=  000007     |     LITW_IDX=  000008     |     LIT_LAST=  000008 
    LL      =  000001     |     LLEN    =  000007     |     LL_HB   =  000001 
    LNADR   =  000003     |     LN_ADDR =  000007     |     LN_PTR  =  000005 
    LOMEM_ID=  000034     |     LPAREN_I=  000004     |     MAJOR   =  000001 
    MASK    =  000003     |     MASKED  =  000005     |     MAX_LINE=  007FFF 
    MINOR   =  000000     |   4 MOD8CHK    000A21 R   |     MODE    =  000030 
    MOD_IDX =  00000E     |     MULOP   =  000005     |     MULT_IDX=  00000F 
    N       =  000001     |     N1      =  000001     |     N2      =  000003 
    NAFR    =  004804     |     NAK     =  000015     |     NAME_SIZ=  000002 
    NBR_COL =  000003     |     NCLKOPT =  004808     |     NEG     =  000001 
    NEW_IDX =  000039     |   4 NEXTCHAR   00096D R   |   4 NEXTHEX    0009B4 R
  4 NEXTITEM   00099A R   |     NEXT_IDX=  00001C     |     NFIELD  =  000002 
    NFLASH_W=  00480E     |     NHSECNT =  00480A     |     NLEN    =  000001 
    NLEN_MAS=  00000F     |     NONE_IDX=  0000FF     |     NOPT1   =  004802 
    NOPT2   =  004804     |     NOPT3   =  004806     |     NOPT4   =  004808 
    NOPT5   =  00480A     |     NOPT6   =  00480C     |     NOPT7   =  00480E 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 220.
Hexadecimal [24-Bits]

Symbol Table

    NOPTBL  =  00487F     |   4 NOTHEX     0009D2 R   |   4 NOTREAD    0009E7 R
    NOT_IDX =  000016     |     NOT_OP  =  000001     |     NUBC    =  004802 
    NUCLEO_8=  000001     |     NUCLEO_8=  000000     |     NWDGOPT =  004806 
    NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF 
    NWDGOPT_=  FFFFFFFE     |   4 NXTPRNT    0009FD R   |   4 NonHandl   000000 R
    OFS     =  000002     |     OFS_UART=  000002     |     OFS_UART=  000003 
    OFS_UART=  000004     |     OFS_UART=  000005     |     OFS_UART=  000006 
    OFS_UART=  000007     |     OFS_UART=  000008     |     OFS_UART=  000009 
    OFS_UART=  000001     |     OFS_UART=  000009     |     OFS_UART=  00000A 
    OFS_UART=  000000     |     OP      =  000003     |     OPT0    =  004800 
    OPT1    =  004801     |     OPT2    =  004803     |     OPT3    =  004805 
    OPT4    =  004807     |     OPT5    =  004809     |     OPT6    =  00480B 
    OPT7    =  00480D     |     OPTBL   =  00487E     |     OPTION_B=  004800 
    OPTION_E=  00487F     |     OPTION_S=  000080     |     OP_ARITH=  00000F 
    OP_REL  =  000009     |     OP_REL_L=  000015     |     OR_IDX  =  000018 
    OUTPUT_F=  000001     |     OUTPUT_O=  000000     |     OUTPUT_P=  000001 
    OUTPUT_S=  000000     |     OVRWR   =  000004     |   4 P1BASIC    00129C GR
    PA      =  000000     |     PAD_SIZE=  000080     |     PA_BASE =  005000 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  000005 
    PB_BASE =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
    PC      =  00000A     |     PC_BASE =  00500A     |     PC_CR1  =  00500D 
    PC_CR2  =  00500E     |     PC_DDR  =  00500C     |     PC_IDR  =  00500B 
    PC_ODR  =  00500A     |     PD      =  00000F     |     PD_BASE =  00500F 
    PD_CR1  =  005012     |     PD_CR2  =  005013     |     PD_DDR  =  005011 
    PD_IDR  =  005010     |     PD_ODR  =  00500F     |     PE      =  000014 
    PEEK_IDX=  000029     |     PENDING_=  000010     |     PE_BASE =  005014 
    PE_CR1  =  005017     |     PE_CR2  =  005018     |     PE_DDR  =  005016 
    PE_IDR  =  005015     |     PE_ODR  =  005014     |     PF      =  000019 
    PF_BASE =  005019     |     PF_CR1  =  00501C     |     PF_CR2  =  00501D 
    PF_DDR  =  00501B     |     PF_IDR  =  00501A     |     PF_ODR  =  005019 
    PG      =  00001E     |     PG_BASE =  00501E     |     PG_CR1  =  005021 
    PG_CR2  =  005022     |     PG_DDR  =  005020     |     PG_IDR  =  00501F 
    PG_ODR  =  00501E     |     PH      =  000023     |     PH_BASE =  005023 
    PH_CR1  =  005026     |     PH_CR2  =  005027     |     PH_DDR  =  005025 
    PH_IDR  =  005024     |     PH_ODR  =  005023     |     PI      =  000028 
    PI_BASE =  005028     |     PI_CR1  =  00502B     |     PI_CR2  =  00502C 
    PI_DDR  =  00502A     |     PI_IDR  =  005029     |     PI_ODR  =  005028 
    POKE_IDX=  00003B     |     POK_ADR =  000003     |   4 PRBYTE     000A26 R
  4 PRDATA     000A11 R   |     PREV    =  000001     |     PRINT_ID=  00003C 
    PRIORITY=  000003     |   4 PROG_ADD   00191B R   |   4 PROG_SIZ   00192D R
    PRT_INT =  000009 G   |     PRT_STR =  000008 G   |     PSTR    =  000001 
    PUTC    =  000002 G   |     QCHAR   =  000004 G   |     QUOTE_ID=  000006 
    RAM_BASE=  000000     |     RAM_END =  0017FF     |   4 RAM_MEM    001956 R
    RAM_SIZE=  001800     |     REL_EQU_=  000011     |     REL_GE_I=  000012 
    REL_GT_I=  000014     |     REL_LE_I=  000010     |     REL_LT_I=  000013 
    REL_NE_I=  000015     |     REL_OP  =  000005     |     REM_IDX =  000023 
    RES_LEN =  000007     |     RET_BPTR=  000001     |     RET_IDX =  00001E 
    RET_LN_A=  000003     |     REV     =  000000     |     RND_IDX =  00002A 
    ROP     =  004800     |     RPAREN_I=  000005     |     RS      =  00001E 
    RST_SR  =  0050B3     |   4 RUN        0009F4 R   |     RUN_IDX =  00003D 
    RXCHAR  =  000001     |     RX_QUEUE=  000008 G   |     SCOL_IDX=  000003 
    SEED_PRN=  00000E G   |     SEMIC   =  00003B     |     SEMICOL =  000001 
    SEPARATE=  000000     |   4 SETMODE    000996 R   |     SET_TIME=  00000A G
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 221.
Hexadecimal [24-Bits]

Symbol Table

    SFR_BASE=  005000     |     SFR_END =  0057FF     |     SGN_IDX =  00002B 
    SHARP   =  000023     |     SI      =  00000F     |     SIGN    =  000005 
    SIGNATUR=  005042     |     SIZE    =  000009     |     SIZE_FIE=  000003 
    SKIP    =  000003     |     SLEEP_ID=  00002F     |     SLEN    =  000002 
    SLOT    =  000004     |     SO      =  00000E     |     SOH     =  000001 
    SPACE   =  000020     |     SPI_CR1 =  005200     |     SPI_CR1_=  000003 
    SPI_CR1_=  000000     |     SPI_CR1_=  000001     |     SPI_CR1_=  000007 
    SPI_CR1_=  000002     |     SPI_CR1_=  000006     |     SPI_CR2 =  005201 
    SPI_CR2_=  000007     |     SPI_CR2_=  000006     |     SPI_CR2_=  000005 
    SPI_CR2_=  000004     |     SPI_CR2_=  000002     |     SPI_CR2_=  000000 
    SPI_CR2_=  000001     |     SPI_CRCP=  005205     |     SPI_CS_F=  000001 G
    SPI_CS_R=  000000 G   |     SPI_DR  =  005204     |     SPI_ICR =  005202 
    SPI_RXCR=  005206     |     SPI_SR  =  005203     |     SPI_SR_B=  000007 
    SPI_SR_C=  000004     |     SPI_SR_M=  000005     |     SPI_SR_O=  000006 
    SPI_SR_R=  000000     |     SPI_SR_T=  000001     |     SPI_SR_W=  000003 
    SPI_TXCR=  005207     |     SPR_ADDR=  000001     |     SQUOT   =  000006 
    SRC     =  000003     |     SRC_ADR =  000007     |     SREMDR  =  000005 
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     START_AD=  000001 
    START_TO=  00000C G   |     STDOUT  =  000001     |     STEP_IDX=  000024 
    STOP_IDX=  000025     |     STOR    =  00003A     |     STORADR =  00002C 
    STR1    =  000001     |     STR1_LEN=  000003     |     STR2    =  000005 
    STR2_LEN=  000007     |   4 STR_BYTE   00193E R   |     STR_VAR_=  00000A 
    STX     =  000002     |     SUB     =  00001A     |     SUB_IDX =  00000C 
    SUP     =  000084     |     SWIM_CSR=  007F80     |     SYMB_LAS=  00000A 
    SYN     =  000016     |     SYS_RST =  000000 G   |     SYS_TICK=  000001 
    SYS_VARS=  000004     |     SYS_VARS=  000012 G   |     TAB     =  000009 
    TAB_IDX =  000031     |     TAB_WIDT=  000004     |     TCHAR   =  000001 
    TEMP    =  000001     |     TERMIOS_=  00000E G   |     THEN_IDX=  000021 
    TIB_SIZE=  000080     |     TICK    =  000027     |     TICKS_ID=  00002D 
    TIM1_ARR=  005262     |     TIM1_ARR=  005263     |     TIM1_BKR=  00526D 
    TIM1_CCE=  00525C     |     TIM1_CCE=  00525D     |     TIM1_CCM=  005258 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  005259 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525A 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525B 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCR=  005265 
    TIM1_CCR=  005266     |     TIM1_CCR=  005267     |     TIM1_CCR=  005268 
    TIM1_CCR=  005269     |     TIM1_CCR=  00526A     |     TIM1_CCR=  00526B 
    TIM1_CCR=  00526C     |     TIM1_CNT=  00525E     |     TIM1_CNT=  00525F 
    TIM1_CR1=  005250     |     TIM1_CR2=  005251     |     TIM1_CR2=  000000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 222.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_CR2=  000002     |     TIM1_CR2=  000004     |     TIM1_CR2=  000005 
    TIM1_CR2=  000006     |     TIM1_DTR=  00526E     |     TIM1_EGR=  005257 
    TIM1_EGR=  000007     |     TIM1_EGR=  000001     |     TIM1_EGR=  000002 
    TIM1_EGR=  000003     |     TIM1_EGR=  000004     |     TIM1_EGR=  000005 
    TIM1_EGR=  000006     |     TIM1_EGR=  000000     |     TIM1_ETR=  005253 
    TIM1_ETR=  000006     |     TIM1_ETR=  000000     |     TIM1_ETR=  000001 
    TIM1_ETR=  000002     |     TIM1_ETR=  000003     |     TIM1_ETR=  000007 
    TIM1_ETR=  000004     |     TIM1_ETR=  000005     |     TIM1_IER=  005254 
    TIM1_IER=  000007     |     TIM1_IER=  000001     |     TIM1_IER=  000002 
    TIM1_IER=  000003     |     TIM1_IER=  000004     |     TIM1_IER=  000005 
    TIM1_IER=  000006     |     TIM1_IER=  000000     |     TIM1_OIS=  00526F 
    TIM1_PSC=  005260     |     TIM1_PSC=  005261     |     TIM1_RCR=  005264 
    TIM1_SMC=  005252     |     TIM1_SMC=  000007     |     TIM1_SMC=  000000 
    TIM1_SMC=  000001     |     TIM1_SMC=  000002     |     TIM1_SMC=  000004 
    TIM1_SMC=  000005     |     TIM1_SMC=  000006     |     TIM1_SR1=  005255 
    TIM1_SR1=  000007     |     TIM1_SR1=  000001     |     TIM1_SR1=  000002 
    TIM1_SR1=  000003     |     TIM1_SR1=  000004     |     TIM1_SR1=  000005 
    TIM1_SR1=  000006     |     TIM1_SR1=  000000     |     TIM1_SR2=  005256 
    TIM1_SR2=  000001     |     TIM1_SR2=  000002     |     TIM1_SR2=  000003 
    TIM1_SR2=  000004     |     TIM2_ARR=  00530D     |     TIM2_ARR=  00530E 
    TIM2_CCE=  005308     |     TIM2_CCE=  000000     |     TIM2_CCE=  000001 
    TIM2_CCE=  000004     |     TIM2_CCE=  000005     |     TIM2_CCE=  005309 
    TIM2_CCM=  005305     |     TIM2_CCM=  005306     |     TIM2_CCM=  005307 
    TIM2_CCM=  000000     |     TIM2_CCM=  000004     |     TIM2_CCM=  000003 
    TIM2_CCR=  00530F     |     TIM2_CCR=  005310     |     TIM2_CCR=  005311 
    TIM2_CCR=  005312     |     TIM2_CCR=  005313     |     TIM2_CCR=  005314 
    TIM2_CLK=  00F424     |     TIM2_CNT=  00530A     |     TIM2_CNT=  00530B 
    TIM2_CR1=  005300     |     TIM2_CR1=  000007     |     TIM2_CR1=  000000 
    TIM2_CR1=  000003     |     TIM2_CR1=  000001     |     TIM2_CR1=  000002 
    TIM2_EGR=  005304     |     TIM2_EGR=  000001     |     TIM2_EGR=  000002 
    TIM2_EGR=  000003     |     TIM2_EGR=  000006     |     TIM2_EGR=  000000 
    TIM2_IER=  005301     |     TIM2_PSC=  00530C     |     TIM2_SR1=  005302 
    TIM2_SR2=  005303     |     TIM3_ARR=  00532B     |     TIM3_ARR=  00532C 
    TIM3_CCE=  005327     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCE=  000004     |     TIM3_CCE=  000005     |     TIM3_CCE=  000000 
    TIM3_CCE=  000001     |     TIM3_CCM=  005325     |     TIM3_CCM=  005326 
    TIM3_CCM=  000000     |     TIM3_CCM=  000004     |     TIM3_CCM=  000003 
    TIM3_CCR=  00532D     |     TIM3_CCR=  00532E     |     TIM3_CCR=  00532F 
    TIM3_CCR=  005330     |     TIM3_CNT=  005328     |     TIM3_CNT=  005329 
    TIM3_CR1=  005320     |     TIM3_CR1=  000007     |     TIM3_CR1=  000000 
    TIM3_CR1=  000003     |     TIM3_CR1=  000001     |     TIM3_CR1=  000002 
    TIM3_EGR=  005324     |     TIM3_IER=  005321     |     TIM3_PSC=  00532A 
    TIM3_SR1=  005322     |     TIM3_SR2=  005323     |     TIM4_ARR=  005346 
    TIM4_CNT=  005344     |     TIM4_CR1=  005340     |     TIM4_CR1=  000007 
    TIM4_CR1=  000000     |     TIM4_CR1=  000003     |     TIM4_CR1=  000001 
    TIM4_CR1=  000002     |     TIM4_EGR=  005343     |     TIM4_EGR=  000000 
    TIM4_IER=  005341     |     TIM4_IER=  000000     |     TIM4_PSC=  005345 
    TIM4_PSC=  000000     |     TIM4_PSC=  000007     |     TIM4_PSC=  000004 
    TIM4_PSC=  000001     |     TIM4_PSC=  000005     |     TIM4_PSC=  000002 
    TIM4_PSC=  000006     |     TIM4_PSC=  000003     |     TIM4_PSC=  000000 
    TIM4_PSC=  000001     |     TIM4_PSC=  000002     |     TIM4_SR =  005342 
    TIM4_SR_=  000000     |     TIM_CR1_=  000007     |     TIM_CR1_=  000000 
    TIM_CR1_=  000006     |     TIM_CR1_=  000005     |     TIM_CR1_=  000004 
    TIM_CR1_=  000003     |     TIM_CR1_=  000001     |     TIM_CR1_=  000002 
    TOKEN   =  000001     |     TOK_IDX =  00003F     |     TOK_POS =  000001 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 223.
Hexadecimal [24-Bits]

Symbol Table

  4 TONEXTIT   0009F2 R   |     TONE_IDX=  000030     |     TOS     =  000001 
    TO_IDX  =  000027     |     TYPE_CON=  000020     |     TYPE_DVA=  000010 
    TYPE_MAS=  0000F0     |   4 Timer4Up   000205 R   |   4 TrapHand   000167 GR
    U1      =  000001     |     UART    =  000002     |     UART1   =  000000 
    UART1_BA=  005230     |     UART1_BR=  005232     |     UART1_BR=  005233 
    UART1_CR=  005234     |     UART1_CR=  005235     |     UART1_CR=  005236 
    UART1_CR=  005237     |     UART1_CR=  005238     |     UART1_DR=  005231 
    UART1_GT=  005239     |     UART1_PO=  000000     |     UART1_PS=  00523A 
    UART1_RX=  000004     |     UART1_SR=  005230     |     UART1_TX=  000005 
    UART2   =  000001     |     UART3   =  000002     |     UART3_BA=  005240 
    UART3_BR=  005242     |     UART3_BR=  005243     |     UART3_CR=  005244 
    UART3_CR=  005245     |     UART3_CR=  005246     |     UART3_CR=  005247 
    UART3_CR=  005249     |     UART3_DR=  005241     |     UART3_PO=  00000F 
    UART3_RX=  000006     |     UART3_SR=  005240     |     UART3_TX=  000005 
    UART_BRR=  005242     |     UART_BRR=  005243     |     UART_CR1=  005244 
    UART_CR1=  000004     |     UART_CR1=  000002     |     UART_CR1=  000000 
    UART_CR1=  000001     |     UART_CR1=  000007     |     UART_CR1=  000006 
    UART_CR1=  000005     |     UART_CR1=  000003     |     UART_CR2=  005245 
    UART_CR2=  000004     |     UART_CR2=  000002     |     UART_CR2=  000005 
    UART_CR2=  000001     |     UART_CR2=  000000     |     UART_CR2=  000006 
    UART_CR2=  000003     |     UART_CR2=  000007     |     UART_CR3=  000003 
    UART_CR3=  000001     |     UART_CR3=  000002     |     UART_CR3=  000000 
    UART_CR3=  000006     |     UART_CR3=  000004     |     UART_CR3=  000005 
    UART_CR4=  000000     |     UART_CR4=  000001     |     UART_CR4=  000002 
    UART_CR4=  000003     |     UART_CR4=  000004     |     UART_CR4=  000006 
    UART_CR4=  000005     |     UART_CR5=  000003     |     UART_CR5=  000001 
    UART_CR5=  000002     |     UART_CR5=  000004     |     UART_CR5=  000005 
    UART_CR6=  000004     |     UART_CR6=  000007     |     UART_CR6=  000001 
    UART_CR6=  000002     |     UART_CR6=  000000     |     UART_CR6=  000005 
    UART_DR =  005241     |     UART_PCK=  000003     |     UART_POR=  00500D 
    UART_POR=  00500E     |     UART_POR=  00500C     |     UART_POR=  00500B 
    UART_POR=  00500A     |     UART_RX_=  000006     |     UART_SR =  005240 
    UART_SR_=  000001     |     UART_SR_=  000004     |     UART_SR_=  000002 
    UART_SR_=  000003     |     UART_SR_=  000000     |     UART_SR_=  000005 
    UART_SR_=  000006     |     UART_SR_=  000007     |     UART_TX_=  000005 
    UBC     =  004801     |   4 UPPER      000982 R   |     US      =  00001F 
  4 UartRxHa   00040F R   |     VAL1    =  000003     |     VAL2    =  000001 
    VALUE   =  000001     |     VAR_ADR =  000005     |     VAR_IDX =  000009 
    VAR_NAME=  000005     |     VAR_TYPE=  000009     |     VAR_VALU=  000003 
    VNAME   =  000002     |     VSIZE   =  000008     |     VSIZE2  =  00000A 
    VT      =  00000B     |     WCNT    =  000002     |     WDGOPT  =  004805 
    WDGOPT_I=  000002     |     WDGOPT_L=  000003     |     WDGOPT_W=  000000 
    WDGOPT_W=  000001     |     WIDTH   =  000001     |     WIDTH_DI=  000004 
    WORDS_ID=  00003E     |   4 WOZMON     00094D GR  |     WWDG_CR =  0050D1 
    WWDG_WR =  0050D2     |     XAM     =  000000     |     XAMADR  =  00002A 
  4 XAMNEXT    000A1D R   |   4 XAM_BLOC   0009F7 R   |     XAM_BLOK=  00002E 
    XMASK   =  000001     |     XOFF    =  000013     |     XON     =  000011 
    XSAVE   =  000007     |     YSAV    =  000028     |     YSAVE   =  000007 
    YTEMP   =  000009     |   7 acc16      000018 R   |   7 acc24      000017 R
  7 acc32      000016 R   |   7 acc8       000019 R   |   4 accept_c   0006F1 R
  4 all_word   002449 R   |   4 and_cond   0015B4 R   |   4 and_fact   00158E R
  4 app        002480 R   |   4 app_spac   002480 R   |   4 arg_list   00142F R
  7 arithm_v   00001A R   |   4 atoi16     0013A3 GR  |   9 auto_lin   00003C R
  9 auto_ste   00003E R   |   4 bad_valu   00223F R   |   2 base       00000F R
  9 basicptr   00002D GR  |   4 beep_1kh   00022A GR  |   4 bkslsh_t   000D56 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 224.
Hexadecimal [24-Bits]

Symbol Table

  4 bksp       000559 R   |   6 block_bu   001700 GR  |   4 buf_putc   0004B2 R
  4 bytes_fr   002255 R   |   4 char_to_   00138C R   |   4 check_fo   0017AB R
  4 check_sy   000C53 R   |   4 clear_pr   002232 R   |   4 clear_st   002162 R
  4 clock_in   000004 R   |   4 clr_scre   00056F R   |   4 cmd_auto   00213C R
  4 cmd_bit_   001C1F R   |   4 cmd_bit_   001C05 R   |   4 cmd_bit_   001C3A R
  4 cmd_call   00211B GR  |   4 cmd_clea   002175 R   |   4 cmd_del    002184 R
  4 cmd_get    001EBB R   |   4 cmd_hime   0021F5 R   |   4 cmd_inpu   001B4A R
  4 cmd_line   0012F1 R   |   4 cmd_list   001965 R   |   4 cmd_lome   002216 R
  4 cmd_new    001F6B R   |   4 cmd_poke   001C71 R   |   4 cmd_prin   001A2D R
  4 cmd_rand   001FC4 R   |   4 cmd_run    001E7C R   |   4 cmd_scr    001F6B R
  4 cmd_set_   0020EC R   |   4 cmd_slee   001F73 R   |   4 cmd_spi_   0008B0 R
  4 cmd_tab    002110 R   |   4 cmd_tone   001EEA R   |   4 cmd_wait   001BDB R
  4 cmd_word   002034 R   |   4 code_add   000A2E R   |   4 cold_sta   0000A5 R
  4 colon_ts   000D79 R   |   4 comma_ts   000D84 R   |   4 comment    00109D R
  4 comp_msg   001186 R   |   4 compile    000E95 GR  |   4 compile_   000C1C R
  4 con_msg    001F41 R   |   4 cond_acc   001CAC R   |   4 conditio   0015DA R
  4 const_ee   00210B R   |   4 convert_   000BEA R   |   4 convert_   0004F1 R
  4 copy_com   000DC9 R   |   4 copyrigh   001204 R   |   9 count      00002A GR
  4 create_b   00090C R   |   4 create_v   001740 R   |   4 ctrl_c_m   0012C7 R
  4 ctrl_c_s   0012D4 R   |   8 ctrl_c_v   00001C R   |   4 cursor_c   00057A R
  4 cursor_s   0005CA R   |   4 dash_tst   000D9A R   |   4 dbl_sign   0003A2 R
  4 decomp_e   0010AF R   |   4 decomp_l   000FEA R   |   4 decompil   000FC6 GR
  4 del_line   000ADE R   |   4 delete_l   00075D R   |   4 delete_u   00074F R
  4 dict_end   002260 R   |   4 digit_te   000D3B R   |   4 dim_next   00183F R
  4 display_   000787 R   |   4 div32_16   0003AC R   |   4 divide     0003EE R
  4 dneg       000399 R   |   4 do_nothi   001326 R   |   4 dump_cod   000116 R
  9 dvar_bgn   000035 GR  |   9 dvar_end   000037 GR  |   4 eql_tst    000E20 R
  4 erase_li   000598 R   |   4 err_bad_   0010F1 R   |   4 err_bad_   001107 R
  4 err_bad_   0010FC R   |   4 err_dim    001138 R   |   4 err_div0   00116B R
  4 err_end    001122 R   |   4 err_err    00119C R   |   4 err_gt25   0010EC R
  4 err_gt32   0010E5 R   |   4 err_gt8_   00111A R   |   4 err_gt8_   001110 R
  4 err_mem_   001126 R   |   4 err_msg_   0010B8 R   |   4 err_prog   00115E R
  4 err_rang   00113C R   |   4 err_rety   001152 R   |   4 err_star   001197 R
  4 err_str_   001142 R   |   4 err_stri   00114B R   |   4 err_synt   0010DE R
  4 err_too_   00112F R   |   4 error_me   0010DE R   |   4 escaped    000BFF GR
  4 expect     001416 R   |   4 expect_i   00137A R   |   4 expressi   0014F8 R
  4 factor     001452 R   |   2 farptr     000011 R   |   4 final_te   0006EA R
  9 flags      00003B GR  |   2 fmstr      000010 R   |   9 for_nest   000041 R
  4 free       002244 R   |   A free_ram   000100 R   |   4 func_abs   001F9C R
  4 func_arg   001424 R   |   4 func_bit   001C54 R   |   4 func_cha   001F89 R
  4 func_len   001FFF R   |   4 func_pee   001C85 R   |   4 func_ran   001FAC R
  4 func_sig   001FE5 R   |   4 func_tic   001F86 R   |   4 func_tim   002101 R
  4 get_arra   0017CC R   |   4 get_arra   001451 R   |   4 get_esca   0004FD R
  4 get_stri   0016BF R   |   4 get_stri   00180A R   |   4 get_targ   001E03 R
  4 get_var_   00176D R   |   4 getc       0004D0 GR  |   9 gosub_ne   000040 R
  4 gt_tst     000E2B R   |   4 heap_all   001721 R   |   9 heap_fre   000039 GR
  9 himem      000031 GR  |   4 if_strin   001CB8 R   |   9 in         000029 GR
  9 in.w       000028 GR  |   4 input_ex   001BD6 R   |   4 input_in   001AD4 R
  4 input_pr   001AC1 R   |   4 input_st   001B3C R   |   4 insert_c   0005E2 R
  4 insert_l   000B4C R   |   4 integer    000D42 R   |   4 interp_l   001326 R
  4 is_alnum   0008A7 GR  |   4 is_alpha   00087F GR  |   4 is_digit   000890 GR
  4 is_hex_d   000899 GR  |   4 itoa       0007B9 GR  |   4 itoa_loo   0007DE R
  4 jp_to_ta   001E30 R   |   2 kvars_en   000016 R   |   4 kword_co   001F53 R
  4 kword_di   0023CC GR  |   4 kword_di   00183D R   |   4 kword_en   001EAF R
  4 kword_fo   001D78 R   |   4 kword_go   001E43 R   |   4 kword_go   001E43 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 225.
Hexadecimal [24-Bits]

Symbol Table

  4 kword_go   001E57 R   |   4 kword_go   001E24 R   |   4 kword_go   001E24 R
  4 kword_if   001C94 R   |   4 kword_le   00160D GR  |   4 kword_le   00161E R
  4 kword_ne   001DCC R   |   4 kword_re   001331 GR  |   4 kword_re   001E63 R
  4 kword_st   001DBE R   |   4 kword_st   001F08 R   |   4 kword_to   001DAD R
  4 let_int_   001620 R   |   4 let_stri   001640 R   |   4 let_stri   001642 R
  9 line.add   00002B GR  |   4 list_exi   0019EE R   |   4 list_loo   0019CA R
  4 list_to    0019A8 R   |   4 lit_word   001070 R   |   9 lomem      00002F GR
  4 long_div   000384 R   |   4 loop_bac   001DF2 R   |   4 loop_don   001DFC R
  4 lt_tst     000E52 R   |   4 modulo     00040A R   |   4 mon_str    00093A R
  4 move       000830 GR  |   4 move_dow   000850 R   |   4 move_exi   00086F R
  4 move_loo   000855 R   |   4 move_str   00076D R   |   4 move_str   000776 R
  4 move_to_   0005B8 R   |   4 move_up    000842 R   |   4 multiply   000347 R
  4 nbr_tst    000D33 R   |   4 neg_acc1   0002E9 R   |   4 new_line   000569 R
  4 next_lin   00133E R   |   4 no_match   0013FE R   |   4 not_a_li   0021F0 R
  4 open_gap   000B17 R   |   4 other      000E79 R   |   4 other_te   000D4B R
  8 out        00001A R   |   4 overwrit   000715 R   |   6 pad        001700 GR
  4 parse_in   000C07 R   |   4 parse_ke   000CA0 R   |   4 parse_le   000D08 R
  4 parse_qu   000BB4 R   |   4 parse_sy   000C29 R   |   9 pending_   000044 R
  4 plus_tst   000DF4 R   |   4 power2     001BFD R   |   4 prcnt_ts   000E15 R
  4 print_co   00123C R   |   4 print_er   0011EB R   |   4 print_he   00079C GR
  4 print_in   0007AE R   |   4 print_li   0019AD R   |   4 print_va   001AC7 R
  4 prng       0002AE GR  |   4 prog_siz   0018D1 R   |   9 progend    000033 GR
  4 program_   0018D8 R   |   4 prt_basi   001A1F R   |   4 prt_i8     0007AC R
  4 prt_line   001360 R   |   4 prt_loop   001A31 R   |   4 prt_quot   000F4A R
  4 prt_spac   001050 R   |   4 prt_var_   000F92 R   |   9 psp        000042 R
  2 ptr16      000012 GR  |   2 ptr8       000013 R   |   4 push_it    000C99 R
  4 putc       0004AC R   |   4 puts       000523 GR  |   4 qgetc      0004CA GR
  4 qmark_ts   000DB0 R   |   4 quoted_s   0010A9 R   |   4 readln     0005F9 GR
  4 readln_l   000617 R   |   4 readln_q   000731 R   |   4 relation   001534 R
  4 reset_ba   001283 R   |   4 reset_se   001A2F R   |   4 rest_con   001AAC R
  4 restore_   0005AD R   |   4 retype     001AB4 R   |   4 right_al   000F2F GR
  4 rparnt_t   000D6E R   |   4 rt_msg     001174 R   |   8 rx1_head   00001E R
  8 rx1_queu   000020 R   |   8 rx1_tail   00001F R   |   4 save_con   001AA5 R
  4 save_cur   0005A4 R   |   4 search_d   0013EB GR  |   4 search_e   001413 R
  4 search_l   000AAC GR  |   4 search_n   0013F1 R   |   4 search_v   00180F R
  2 seedx      00000B R   |   2 seedy      00000D R   |   4 semic_ts   000D8F R
  4 send_csi   00052E R   |   4 send_par   00053B R   |   4 set_int_   00006E GR
  4 set_outp   000498 R   |   4 set_seed   0002D0 R   |   4 sharp_ts   000DA5 R
  4 skip       000CF7 R   |   4 skip_dis   00061F R   |   4 skip_str   00136D R
  4 slash_ts   000E0A R   |   4 sll_xy_3   0002A0 R   |   4 space      000586 R
  4 spaces     00058C GR  |   4 spi_clea   0008DF R   |   4 spi_dese   00092B R
  4 spi_disa   0008C9 R   |   4 spi_rcv_   000901 R   |   4 spi_sele   00091B R
  4 spi_send   0008EB R   |   4 srl_xy_3   0002A7 R   |   6 stack_fu   001780 GR
  6 stack_un   001800 R   |   4 star_tst   000DFF R   |   4 stop_msg   001F32 R
  4 store_lo   001DC3 R   |   4 str_matc   00140A R   |   4 str_tst    000D21 R
  4 strcmp     000811 GR  |   4 strcpy     000820 GR  |   4 strlen     000806 GR
  4 symb_loo   000C30 R   |   4 syntax_e   0011A5 GR  |   2 sys_flag   00000A R
  4 syscall_   000201 R   |   4 syscall_   000171 R   |   4 target01   001E06 R
  4 tb_error   0011A7 GR  |   4 term       0014B3 R   |   4 term01     0014BA R
  4 term_exi   0014F3 R   |   8 term_var   000028 R   |   4 test       000106 R
  6 tib        001680 GR  |   4 tick_tst   000DBF R   |   2 ticks      000004 R
  2 timer      000006 R   |   4 timer2_i   000025 R   |   4 timer4_i   000032 R
  4 to_hex_c   000791 GR  |   4 to_upper   000874 R   |   4 tok_to_n   000F9D R
  4 token_ch   000E8E R   |   4 token_ex   000E92 R   |   4 tone       000239 GR
  2 tone_ms    000008 R   |   4 tone_off   000279 R   |   2 trap_ret   000014 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 226.
Hexadecimal [24-Bits]

Symbol Table

  4 uart_get   0004D0 GR  |   4 uart_ini   000440 R   |   4 uart_put   0004C1 GR
  4 uart_qge   0004CA GR  |   4 udiv32_1   000372 R   |   4 umstar     000307 R
  4 umul16_8   0002F8 R   |   4 update_c   00061A R   |   4 variable   001055 R
  4 warm_ini   001271 R   |   4 warm_sta   0012EE R   |   4 words_co   0020D6 R
  4 xor_seed   000284 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 227.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 DATA       size      0   flags    8
   2 DATA0      size     12   flags    8
   3 HOME       size     80   flags    0
   4 CODE       size   2480   flags    0
   5 SSEG       size      0   flags    8
   6 SSEG1      size    180   flags    8
   7 DATA2      size      4   flags    8
   8 DATA3      size      E   flags    8
   9 DATA4      size     2C   flags    8
   A DATA5      size      0   flags    8

