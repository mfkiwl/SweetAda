
//
// llkernel.S - Low-level kernel routines and exception handling.
//
// Copyright (C) 2020-2025 Gabriele Galeotti
//
// This work is licensed under the terms of the MIT License.
// Please consult the LICENSE.txt file located in the top-level directory.
//

#define __ASSEMBLER__ 1

////////////////////////////////////////////////////////////////////////////////

                .macro SAVE_REGISTERS
                lea     %sp@(-16),%sp           // space for 4 registers
                movem.l %d0-%d1/%a0-%a1,%sp@
                .endm

                .macro RESTORE_REGISTERS
                movem.l %sp@,%d0-%d1/%a0-%a1
                lea     %sp@(16),%sp            // space for 4 registers
                .endm

////////////////////////////////////////////////////////////////////////////////

                .sect   .vectors,"ax"

                .extern _start

                .global vectors_table
vectors_table:
                                                // #   offset
initialsp:      .long   0                       // 000 0x0000 -
initialpc:      .long   _start                  // 001 0x0004 -
accesserr:      .long   VH_accesserr            // 002 0x0008 -
addresserr:     .long   VH_addresserr           // 003 0x000C -
illinstr:       .long   VH_illinstr             // 004 0x0010 -
div0:           .long   VH_div0                 // 005 0x0014 -
reserved1:      .long   VH_default              // 006 0x0018 -
reserved2:      .long   VH_default              // 007 0x001C -
privilegev:     .long   VH_privilegev           // 008 0x0020 -
trace:          .long   VH_trace                // 009 0x0024 -
lineA:          .long   VH_lineA                // 010 0x0028 -
lineF:          .long   VH_lineF                // 011 0x002C -
debugint:       .long   VH_debugint             // 012 0x0030 -
reserved3:      .long   VH_default              // 013 0x0034 -
formaterr:      .long   VH_formaterr            // 014 0x0038 -
reserved4:      .long   VH_default              // 015 0x003C -
reserved5:      .long   VH_default              // 016 0x0040 -
reserved6:      .long   VH_default              // 017 0x0044 -
reserved7:      .long   VH_default              // 018 0x0048 -
reserved8:      .long   VH_default              // 019 0x004C -
reserved9:      .long   VH_default              // 020 0x0050 -
reserved10:     .long   VH_default              // 021 0x0054 -
reserved11:     .long   VH_default              // 022 0x0058 -
reserved12:     .long   VH_default              // 023 0x005C -
spuriousint:    .long   VH_spuriousint          // 024 0x0060 -
reserved13:     .long   VH_default              // 025 0x0064 -
reserved14:     .long   VH_default              // 026 0x0068 -
reserved15:     .long   VH_default              // 027 0x006C -
reserved16:     .long   VH_default              // 028 0x0070 -
reserved17:     .long   VH_default              // 029 0x0074 -
reserved18:     .long   VH_default              // 030 0x0078 -
reserved19:     .long   VH_default              // 031 0x007C -
trap0:          .long   VH_trap0                // 032 0x0080 -
trap1:          .long   VH_trap1                // 033 0x0084 -
trap2:          .long   VH_trap2                // 034 0x0088 -
trap3:          .long   VH_trap3                // 035 0x008C -
trap4:          .long   VH_trap4                // 036 0x0090 -
trap5:          .long   VH_trap5                // 037 0x0094 -
trap6:          .long   VH_trap6                // 038 0x0098 -
trap7:          .long   VH_trap7                // 039 0x009C -
trap8:          .long   VH_trap8                // 040 0x00A0 -
trap9:          .long   VH_trap9                // 041 0x00A4 -
trap10:         .long   VH_trap10               // 042 0x00A8 -
trap11:         .long   VH_trap11               // 043 0x00AC -
trap12:         .long   VH_trap12               // 044 0x00B0 -
trap13:         .long   VH_trap13               // 045 0x00B4 -
trap14:         .long   VH_trap14               // 046 0x00B8 -
trap15:         .long   VH_trap15               // 047 0x00BC -
reserved20:     .long   VH_default              // 048 0x00C0 -
reserved21:     .long   VH_default              // 049 0x00C4 -
reserved22:     .long   VH_default              // 050 0x00C8 -
reserved23:     .long   VH_default              // 051 0x00CC -
reserved24:     .long   VH_default              // 052 0x00D0 -
reserved25:     .long   VH_default              // 053 0x00D4 -
reserved26:     .long   VH_default              // 054 0x00D8 -
reserved27:     .long   VH_default              // 055 0x00DC -
reserved28:     .long   VH_default              // 056 0x00E0 -
reserved29:     .long   VH_default              // 057 0x00E4 -
reserved30:     .long   VH_default              // 058 0x00E8 -
reserved31:     .long   VH_default              // 059 0x00EC -
reserved32:     .long   VH_default              // 060 0x00F0 -
reserved33:     .long   VH_default              // 061 0x00F4 -
reserved34:     .long   VH_default              // 062 0x00F8 -
reserved35:     .long   VH_default              // 063 0x00FC -

// User Defined Vectors

                .long   VH_default              // 064 INTC0 0  Not Used
                .long   VH_default              // 065 INTC0 1  EPORT Edge port flag 1
                .long   VH_default              // 066 INTC0 2  EPORT Edge port flag 2
                .long   VH_default              // 067 INTC0 3  EPORT Edge port flag 3
                .long   VH_default              // 068 INTC0 4  EPORT Edge port flag 4
                .long   VH_default              // 069 INTC0 5  EPORT Edge port flag 5
                .long   VH_default              // 070 INTC0 6  EPORT Edge port flag 6
                .long   VH_default              // 071 INTC0 7  EPORT Edge port flag 7
                .long   VH_default              // 072 INTC0 8  DMA   DMA Channel 0 transfer complete
                .long   VH_default              // 073 INTC0 9  DMA   DMA Channel 1 transfer complete
                .long   VH_default              // 074 INTC0 10 DMA   DMA Channel 2 transfer complete
                .long   VH_default              // 075 INTC0 11 DMA   DMA Channel 3 transfer complete
                .long   VH_default              // 076 INTC0 12 DMA   DMA Channel 4 transfer complete
                .long   VH_default              // 077 INTC0 13 DMA   DMA Channel 5 transfer complete
                .long   VH_default              // 078 INTC0 14 DMA   DMA Channel 6 transfer complete
                .long   VH_default              // 079 INTC0 15 DMA   DMA Channel 7 transfer complete
                .long   VH_default              // 080 INTC0 16 DMA   DMA Channel 8 transfer complete
                .long   VH_default              // 081 INTC0 17 DMA   DMA Channel 9 transfer complete
                .long   VH_default              // 082 INTC0 18 DMA   DMA Channel 10 transfer complete
                .long   VH_default              // 083 INTC0 19 DMA   DMA Channel 11 transfer complete
                .long   VH_default              // 084 INTC0 20 DMA   DMA Channel 12 transfer complete
                .long   VH_default              // 085 INTC0 21 DMA   DMA Channel 13 transfer complete
                .long   VH_default              // 086 INTC0 22 DMA   DMA Channel 14 transfer complete
                .long   VH_default              // 087 INTC0 23 DMA   DMA Channel 15 transfer complete
                .long   VH_default              // 088 INTC0 24 DMA   DMA Error Interrupt
                .long   VH_default              // 089 INTC0 25 SCM   Core Watchdog Timeout
                .long   VH_default              // 090 INTC0 26 UART0 UART0 Interrupt Request
                .long   VH_default              // 091 INTC0 27 UART1 UART1 Interrupt Request
                .long   VH_default              // 092 INTC0 28 UART2 UART2 Interrupt Request
                .long   VH_default              // 093 INTC0 29 Not Used
                .long   VH_default              // 094 INTC0 30 I2C   I2C Interrupt
                .long   VH_default              // 095 INTC0 31 QSPI  QSPI interrupt
                .long   VH_default              // 096 INTC0 32 DTIM0 Timer 0 interrupt
                .long   VH_default              // 097 INTC0 33 DTIM1 Timer 1 interrupt
                .long   VH_default              // 098 INTC0 34 DTIM2 Timer 2 interrupt
                .long   VH_default              // 099 INTC0 35 DTIM3 Timer 3 interrupt
                .long   VH_default              // 100 INTC0 36 FEC   Transmit frame interrupt
                .long   VH_default              // 101 INTC0 37 FEC   Transmit buffer interrupt
                .long   VH_default              // 102 INTC0 38 FEC   Transmit FIFO underrun
                .long   VH_default              // 103 INTC0 39 FEC   Collision retry limit
                .long   VH_default              // 104 INTC0 40 FEC   Receive frame interrupt
                .long   VH_default              // 105 INTC0 41 FEC   Receive buffer interrupt
                .long   VH_default              // 106 INTC0 42 FEC   MII interrupt
                .long   VH_default              // 107 INTC0 43 FEC   Late collision
                .long   VH_default              // 108 INTC0 44 FEC   Heartbeat error
                .long   VH_default              // 109 INTC0 45 FEC   Graceful stop complete
                .long   VH_default              // 110 INTC0 46 FEC   Ethernet bus error
                .long   VH_default              // 111 INTC0 47 FEC   Babbling transmit error
                .long   VH_default              // 112 INTC0 48 FEC   Babbling receive error
                .long   VH_default              // 113 INTC0 49 Not Used
                .long   VH_default              // 114 INTC0 50 Not Used
                .long   VH_default              // 115 INTC0 51 Not Used
                .long   VH_default              // 116 INTC0 52 Not Used
                .long   VH_default              // 117 INTC0 53 Not Used
                .long   VH_default              // 118 INTC0 54 Not Used
                .long   VH_default              // 119 INTC0 55 Not Used
                .long   VH_default              // 120 INTC0 56 Not Used
                .long   VH_default              // 121 INTC0 57 Not Used
                .long   VH_default              // 122 INTC0 58 Not Used
                .long   VH_default              // 123 INTC0 59 Not Used
                .long   VH_default              // 124 INTC0 60 Not Used
                .long   VH_default              // 125 INTC0 61 Not Used
                .long   VH_default              // 126 INTC0 62 SCM   Core bus error interrupt
                .long   VH_default              // 127 INTC0 63 Not Used
                .long   VH_default              // 128 INTC1 0  Not Used
                .long   VH_default              // 129 INTC1 1  Not Used
                .long   VH_default              // 130 INTC1 2  Not Used
                .long   VH_default              // 131 INTC1 3  Not Used
                .long   VH_default              // 132 INTC1 4  Not Used
                .long   VH_default              // 133 INTC1 5  Not Used
                .long   VH_default              // 134 INTC1 6  Not Used
                .long   VH_default              // 135 INTC1 7  Not Used
                .long   VH_default              // 136 INTC1 8  Not Used
                .long   VH_default              // 137 INTC1 9  Not Used
                .long   VH_default              // 138 INTC1 10 Not Used
                .long   VH_default              // 139 INTC1 11 Not Used
                .long   VH_default              // 140 INTC1 12 Not Used
                .long   VH_default              // 141 INTC1 13 Not Used
                .long   VH_default              // 142 INTC1 14 Not Used
                .long   VH_default              // 143 INTC1 15 Not Used
                .long   VH_default              // 144 INTC1 16 Not Used
                .long   VH_default              // 145 INTC1 17 Not Used
                .long   VH_default              // 146 INTC1 18 Not Used
                .long   VH_default              // 147 INTC1 19 Not Used
                .long   VH_default              // 148 INTC1 20 Not Used
                .long   VH_default              // 149 INTC1 21 Not Used
                .long   VH_default              // 150 INTC1 22 Not Used
                .long   VH_default              // 151 INTC1 23 Not Used
                .long   VH_default              // 152 INTC1 24 Not Used
                .long   VH_default              // 153 INTC1 25 Not Used
                .long   VH_default              // 154 INTC1 26 Not Used
                .long   VH_default              // 155 INTC1 27 Not Used
                .long   VH_default              // 156 INTC1 28 Not Used
                .long   VH_default              // 157 INTC1 29 Not Used
                .long   VH_default              // 158 INTC1 30 Not Used
                .long   VH_default              // 159 INTC1 31 Not Used
                .long   VH_default              // 160 INTC1 32 Not Used
                .long   VH_default              // 161 INTC1 33 Not Used
                .long   VH_default              // 162 INTC1 34 Not Used
                .long   VH_default              // 163 INTC1 35 Not Used
                .long   VH_default              // 164 INTC1 36 Not Used
                .long   VH_default              // 165 INTC1 37 Not Used
                .long   VH_default              // 166 INTC1 38 Not Used
                .long   VH_default              // 167 INTC1 39 Not Used
                .long   VH_default              // 168 INTC1 40 RNG      RNG interrupt flag
                .long   VH_default              // 169 INTC1 41 SKHA     SKHA interrupt flag
                .long   VH_default              // 170 INTC1 42 MDHA     MDHA interrupt flag
                .long   VH_default              // 171 INTC1 43 PIT0     PIT interrupt flag
                .long   VH_default              // 172 INTC1 44 PIT1     PIT interrupt flag
                .long   VH_default              // 173 INTC1 45 PIT2     PIT interrupt flag
                .long   VH_default              // 174 INTC1 46 PIT3     PIT interrupt flag
                .long   VH_default              // 175 INTC1 47 USB OTG  USB OTG interrupt
                .long   VH_default              // 176 INTC1 48 USB Host USB host interrupt
                .long   VH_default              // 177 INTC1 49 SSI      SSI interrupt
                .long   VH_default              // 178 INTC1 50 PWM      PWM interrupt
                .long   VH_default              // 179 INTC1 51 Not Used
                .long   VH_default              // 180 INTC1 52 RTC      Real time clock interrupt
                .long   VH_default              // 181 INTC1 53 CCM      USB status Interrupt
                .long   VH_default              // 182 INTC1 54 Not Used
                .long   VH_default              // 183 INTC1 55 Not Used
                .long   VH_default              // 184 INTC1 56 Not Used
                .long   VH_default              // 185 INTC1 57 Not Used
                .long   VH_default              // 186 INTC1 58 Not Used
                .long   VH_default              // 187 INTC1 59 Not Used
                .long   VH_default              // 188 INTC1 60 Not Used
                .long   VH_default              // 189 INTC1 61 Not Used
                .long   VH_default              // 190 INTC1 62 Not Used
                .long   VH_default              // 191 INTC1 63 Not Used

////////////////////////////////////////////////////////////////////////////////

                .sect   .text,"ax"

                .extern exception_process
                .extern irq_process

VH_accesserr:
VH_addresserr:
VH_illinstr:
VH_div0:
VH_privilegev:
VH_trace:
VH_lineA:
VH_lineF:
VH_debugint:
VH_formaterr:
VH_spuriousint:
VH_trap0:
VH_trap1:
VH_trap2:
VH_trap3:
VH_trap4:
VH_trap5:
VH_trap6:
VH_trap7:
VH_trap8:
VH_trap9:
VH_trap10:
VH_trap11:
VH_trap12:
VH_trap13:
VH_trap14:
VH_trap15:
                jmp     exception_process

VH_PIT0:
                //pea     PIT0_IRQID
                jmp     irq_entry

irq_entry:
                SAVE_REGISTERS
                move.l  %sp@(16),%d0            // get exception identifier
                move.l  %sp,%d1
                move.l  %d1,%sp@-               // push as 2nd argument
                move.l  %d0,%sp@-               // push as 1st argument
                jsr     exception_process
                addq.l  #8,%sp                  // unstacks the arguments
                RESTORE_REGISTERS
                //addq.l  #4,%sp                // unstack identifier pushed by "pea" instruction in stub handler
                rte

VH_default:
                jmp     .

