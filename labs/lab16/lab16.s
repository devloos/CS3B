// Programmer: Carlos Aguilera
// Lab #16
// Purpose: 
//     This lab is meant to help you get started with RASM-4 and linked list.
// Author: Carlos Aguilera
// Date Last Modified: 04/16/24

// set global start as the main entry
  .global _start

  .equ buffer, 21

  .data
    szBuffer:   .skip buffer
    chCr:       .byte   10

    str1:  .asciz "The Cat in the Hat\n"
    str2:  .asciz "\n"
    str3:  .asciz  "By Dr. Seuss\n"
    str4:  .asciz  "\n"
    str5:  .asciz "The sun did not shine.\n"
    headPtr:  .quad  0
    tailPtr:  .quad  0
  .section .text

_start:

  MOV  X0, #0   // Setup the parameters to exit the program
  MOV  X8, #93  // and then call Linux to do it.

  SVC  0 // use 0 return code
