//*****************************************************************************
// Name: Shiv
// Program: shiv-functions.s
// Class: CS 3B
// Date: April 20, 2024 at 10:20 AM
// Purpose:
//    DO SOMETHING LOL
//*****************************************************************************
// set global start as the main entry
	.global String_equals
	.global ViewStrings
	.global print_string
    .section .text

String_equals:
    str x30, [SP, #-16]!	      		// store the link register on the stack
    mov x4, #0               	      	// Initialize index I = 0
   				      					// Assume x0 and x1 point to the strings to compare

	String_equals_loop:
	    ldrb w5, [x0, x4]         		// Load byte from string 1
	    ldrb w6, [x1, x4]         		// Load byte from string 2
	    cmp w5, w6                		// Compare bytes
	    b.ne String_not_equal     		// Branch if not equal
	    cmp w5, #0                		// Check if we've reached the end of string 1
	    b.eq String_equal         		// If so, strings are equal
	    add x4, x4, #1            		// Increment index
	    b String_equals_loop      		// Loop

	String_not_equal:
	    mov x0, #0                		// Return 1 for not equal
	    ldr x30, [SP], #16	      		// Pop the link register off the stack
	    ret

	String_equal:
	    mov x0, #1                		// Return 0 for equal
	    ldr x30, [SP], #16	      		// Pop the link register off the stack
	    ret
//--1 - View Strings---------------------------------------------------------------------------
ViewStrings:
  	STR X30, [SP, #-16]! 						// push link register onto the stack
  	ADR X0,printStringWithIndexAndNewLine		// x0 has the address of a callback function called printStringWithIndexAndNewLine
  	BL foreach									// method to loop through each item in the linkedlist
	LDR X30, [SP], #16  						// pop link register off the stack
	RET											// return to main menu