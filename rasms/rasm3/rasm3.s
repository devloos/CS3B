//*****************************************************************************
// Name: Carlos Aguilera and Shiv
// Program: RASM3.s
// Class: CS 3B
// Lab: RASM3
// Date: March 30, 2024 at 9:04 PM
// Purpose:
//    DO SOMETHING LOL
//*****************************************************************************

// set global start as the main entry
  .global _start

  .equ BUFFER, 512

  .section .data

  szBuffer:  .skip BUFFER

  szTest1: .asciz   "beginnersbook is for beginners"
  szTest2: .asciz   "beginners"
  szTest3: .asciz   "cat in the hat."

  chCr: .byte 10

  .section .text

_start:
  LDR X0, =szTest1   // load the address of szTest1 into X0
  LDR X1, =szTest2   // load the address of szTest1 into X0
  BL String_lastIndexOf_3 // branch link to String_concat

  LDR X1, =szBuffer   // load the address of szBuffer into X0
  BL int64asc         // branch link to int64asc

  LDR X0, =szBuffer   // load the address of szBuffer into X0
  BL putstring

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  MOV   X0, #0   // Use 0 return code
  MOV   X8, #93  // Service Command Code 93 terminates this program
  SVC   0        // Call linux to terminate the program
