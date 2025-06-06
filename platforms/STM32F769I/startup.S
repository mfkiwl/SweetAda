
//
// startup.S - Low-level startup.
//
// Copyright (C) 2020-2025 Gabriele Galeotti
//
// This work is licensed under the terms of the MIT License.
// Please consult the LICENSE.txt file located in the top-level directory.
//

#define __ASSEMBLER__ 1

////////////////////////////////////////////////////////////////////////////////

                .syntax unified

                .sect   .startup,"ax"

                .thumb_func
                .type   _start,%function
                .global _start
_start:

                //
                // Setup stack pointer.
                //
                ldr     r0,=kernel_stack
                mov     sp,r0

                //
                // Initialize .bss section.
                //
                .extern _sbss
                .extern _ebss
                ldr     r1,=_sbss
                ldr     r2,=_ebss
                mov     r0,#0
                b       2f
1:              stm     r1!,{r0}
2:              cmp     r1,r2
                bne     1b

                //
                // Jump to high-level code.
                //
                .extern _ada_main
                bl      _ada_main

dead:           b       .

                .size   _start,.-_start

////////////////////////////////////////////////////////////////////////////////

                .sect   .bss

                .align  8
                .space  1024
kernel_stack:

