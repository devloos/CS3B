//*****************************************************************************
// Name: Carlos Aguilera and Shiv
// Program: RASM4.s
// Class: CS 3B
// Lab: RASM3
// Date: April 20, 2024 at 10:20 AM
// Purpose:
// 			For this assignment, you will be creating a Menu driver program that serves as a text
// 			editor and save the resulting text to a file. You must be able to enter new strings manually
//      and/or via a file (input.txt). All additions are additive (i.e. i can call 2b 5 x times and 5
//      copies of the text file would be stored in the data structure (linked list of strings). Use the
//      enclosed file for possible input. Do not load automatically, only via the menu.
//*****************************************************************************

// set global start as the main entry
  .global _start

  .equ BUFFER, 512

  .section .data

  szBuffer:  .skip BUFFER

  szStudents:		.asciz		"Students: Shiv Patel and Carlos Aguilera"
  szClass:			.asciz		"Class: CS3B"
  szProject:		.asciz		"Project: RASM4"
  szDate:			  .asciz		"04/20/2024"

  chCr: .byte 10

  .section .text

convert_and_print_number:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  LDR X1, =szBuffer   			// load the address of szBuffer into X0
  BL int64asc         			// branch link to int64asc

  LDR X0, =szBuffer   			// load the address of szBuffer into X0
  BL putstring

  LDR X0, =chCr  			// load the address of chCr into X0
  BL putch       			// branch link to putch and print out chCr

  LDR X30, [SP], #16 			// pop link register off the stack

  RET

_start:

  MOV   X0, #0   						// Use 0 return code
  MOV   X8, #93  						// Service Command Code 93 terminates this program
  SVC   0        						// Call linux to terminate the program
