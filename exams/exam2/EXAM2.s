//*****************************************************************************
// Name: Carlos Aguilera
// Program: EXAM2.s
// Class: CS 3B
// Lab: EXAM2
// Date: April 30, 2024 at 4:44 PM
// Purpose:
// 			Create the external function String_toUpperCase, which takes a pointer argument in X0,
//			points to a CString, and converts the string to upper case. You may already have this
//			from RASM-3. If you do, you must provide your partner's name in the comments section of
//			your code so that I know that you guys worked together earlier on it.
//*****************************************************************************

// set global start as the main entry
  .global _start

  .equ BUFFER, 20

  .section .data

  szBuffer:  .skip BUFFER

  szEnterS1:			.asciz 		"Enter String #1: "
  szEnterS2:			.asciz		"Enter String #2: "

  szDisplayS1:			.asciz		"Displaying string #1: "
  szDisplayS2:			.asciz		"Displaying string #2: "

  szConverting:			.asciz		"Converting to Upper Case ..."

  szS1:  .skip BUFFER
  szS2:  .skip BUFFER

  chCr: .byte 10

  .section .text

_start:
	// ------------------------------- GET FIRST STRING -------------------------------- // 
  LDR X0, =szEnterS1 // load the address of szEnterS1 into X0
  BL putstring

	LDR X0, =szBuffer
	MOV X1, #20
	BL getstring

	LDR X0, =szBuffer
	BL copy_string

	LDR X1, =szS1
	STR X0, [X1]

	// ------------------------------- GET SECOND STRING -------------------------------- // 
  LDR X0, =szEnterS2 // load the address of szEnterS1 into X0
  BL putstring

	LDR X0, =szBuffer
	MOV X1, #21
	BL getstring

	LDR X0, =szBuffer
	BL copy_string

	LDR X1, =szS2
	STR X0, [X1]

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

	// ------------------------------- DISPLAY STRING 1 -------------------------------- // 
  LDR X0, =szDisplayS1 // load the address of szDisplayS1 into X0
  BL putstring

	LDR X0, =szS1
	LDR X0, [X0]
  BL putstring

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

	// ------------------------------- DISPLAY STRING 2 -------------------------------- // 
  LDR X0, =szDisplayS2 // load the address of szDisplayS2 into X0
  BL putstring

	LDR X0, =szS2
	LDR X0, [X0]
  BL putstring

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  LDR X0, =szConverting // load the address of szConverting into X0
  BL putstring

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

	// ------------------------------- CONVERTING STRING 1 -------------------------------- // 
  LDR X0, =szDisplayS1 // load the address of szDisplayS1 into X0
  BL putstring

	LDR X0, =szS1
	LDR X0, [X0]
  BL String_toUpperCase 

	MOV X19, X0  // store the replaced string

  MOV X0, X0  							// set param for putstring
  BL putstring 

	MOV X0, X19
	BL free

	LDR X0, =szS1
	LDR X0, [X0]
	BL free

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

	// ------------------------------- CONVERTING STRING 2 -------------------------------- // 
  LDR X0, =szDisplayS2 // load the address of szDisplayS2 into X0
  BL putstring

	LDR X0, =szS2
	LDR X0, [X0]
  BL String_toUpperCase 

	MOV X19, X0  // store the replaced string

  MOV X0, X0  							// set param for putstring
  BL putstring 

	MOV X0, X19
	BL free

	LDR X0, =szS2
	LDR X0, [X0]
	BL free

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  MOV   X0, #0   						// Use 0 return code
  MOV   X8, #93  						// Service Command Code 93 terminates this program
  SVC   0        						// Call linux to terminate the program
