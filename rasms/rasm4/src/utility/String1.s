//*****************************************************************************
// Name: Shiv
// Program: String1.s
// Class: CS 3B
// Date: March 30, 2024 at 9:04 PM
// Purpose:
//    DO SOMETHING LOL
//*****************************************************************************

// set global start as the main entry
  .global String_equalsIgnoreCase
  .global String_copy
  .global String_substring_1
  .global String_substring_2
  .global String_charAt
  .global String_startsWith_1
  .global String_startsWith_2
  .global String_endsWith
  .section .data
  .section .text
//EQUALS IGNORE CASE

String_equalsIgnoreCase:
     str x30, [SP, #-16]!	      		// store the link register on the stack
     mov x4, #0                			// Initialize index I = 0

	String_equalsIgnoreCaseLoop:
	    ldrb w5, [x0, x4]         		// Load byte from string 1
	    ldrb w6, [x1, x4]         		// Load byte from string 2

	    // Check and convert character from x0 to uppercase if it's lowercase
	    cmp w5, #0x61             		// Check if w5 is >= 'a'
	    blt NotLowercaseX0
	    cmp w5, #0x7A             		// Check if w5 is <= 'z'
	    bgt NotLowercaseX0
	    sub w5, w5, #0x20         		// Convert to uppercase

	NotLowercaseX0:
	    // Check and convert character from x1 to uppercase if it's lowercase
	    cmp w6, #0x61             		// Check if w6 is >= 'a'
	    blt NotLowercaseX1
	    cmp w6, #0x7A             		// Check if w6 is <= 'z'
	    bgt NotLowercaseX1
	    sub w6, w6, #0x20         		// Convert to uppercase

	NotLowercaseX1:
	    cmp w5, w6                		 // Compare the (potentially converted) characters
	    b.ne String_not_equal_ignoreCase     // If not equal, go to String_not_equal
	    cmp w5, #0                		 // Check if we've reached the end of string 1
	    b.eq String_equal_ignoreCase         // If so, strings are equal
	    add x4, x4, #1         	         // Increment index
	    b String_equalsIgnoreCaseLoop 	 // Continue loop

	String_not_equal_ignoreCase:
	    mov x0, #0                		// Return 0 for not equal
 	    ldr x30, [SP], #16	      		// Pop the link register off the stack
	    ret

	String_equal_ignoreCase:
	    mov x0, #1                		// Return 1 for equal
 	    ldr x30, [SP], #16	      		// Pop the link register off the stack
	    ret


String_copy:
	str x30, [SP, #-16]!				// Store the link register on the stack
	
	mov x19, x0					// Whatever is in x0 move it to x19
	str x19, [SP, #-16]!				// Push x19 onto the stack [x19 hold the address of the string that we are trying to copy]	
	mov x20, x1					// move x1 into x21
	str x20, [SP, # -16]!				// Push x1 onto the register	
	bl String_length				// Branch and Link to String Length to get the number of bytes to create dynamically
	bl malloc					// call malloc to get the number of bytes and store the address in x0
	String_copy_loop:	
		ldrb w5, [x19]				// load the first characther of our string argument into w5
		cmp w5, #00				// is w5 equal to a null characther
		b.eq end_String_copy			// then just branch to this 
		strb w5, [x0]				// store the characther into the dynamically created strings
		
		add x0, x0, #1				// increment our dynamically allocated strings memory address
		add x19, x19, #1			// increment our argument string memory address
		
		b String_copy_loop			// branch to String_copy_loop



	end_String_copy:
		ldr x20, [SP], #16			// pop x20 off the stack [x20 contains the address of the string we want to copy too]
		mov x6, x0				// x0 is now stored in x3
		ldr x19, [SP], #16			// return back to the original address of the dynamically created string
		mov x0, x19 				// x19 is now in x0
		bl String_length			// get the length of the string back (x0 now has the string_lenght)
		sub x0, x6, x0				// x0 = x3 - x0 gives the original string address back
		str x0, [x20]				// sstore the address into x20				
		ldr x30, [SP], #16			// pop the link register off the stack frame
		ret					// return back
	
String_substring_1:
	str x30, [SP, #-16]!				// Store the link register onto the stack	
	mov x19, x0					// Our x19 will hold the string that we are trying to substring
	mov x20, x1					// Our x20 will hold the begin index
	mov x21, x2					// Our x21 will hold the end index
	str x21, [SP, #-16]!				// Store x21 onto the stack
	str x20, [SP, #-16]!				// Store x20 onto the stack	
	str x19, [SP, #-16]!				// Store x19 onto the stack
	

	//How many bytes do we need?
	sub x0, x21, x20				// x0 = (x21 - x20)
	bl malloc					// generate those bytes in the heap and store the address in x0
	
	ldr x19, [SP], #16				// Pop x19 off the stack and load it back into x19 which will hold the string
	ldr x20, [SP], #16				// Pop x20 off the stack and load it back into x20 hold the begin index
	ldr x21, [SP], #16				// Pop x21 off the stack and load it back into x21 hold the end index	
	ldrb w5, [x19, x21]				// Load into w5 the last last characther in the substring	
	add x19, x19 , x20				// The memory address of the begin index	
	String_substring_1_loop:
		ldrb w4, [x19]				// load a byte into w4 from whatever is in x19
		cmp  w4, w5				// compare w4 with w5 
		b.eq end_substring_1_loop		// then branch to this
		strb w4, [x0]				// store that byte in x0 which is the dynamiclly created string		
		add x19, x19, #1			// move on to the next byte
		add x0, x0, #1				// move on to the next byte for x0
		b String_substring_1_loop		// branch to String_substring_1_loop

	end_substring_1_loop:
		sub x6, x21, x20			// x3 = (x21 - x20)
		sub x0, x0, x6				// x0 = (x0 - x3)
		ldr x30, [SP], #16			// pop the link register off the stack
		ret


String_substring_2:
	mov x19, x0					// mov x0 into x19
	mov x20, x1					// mov x1 into x20	
	str x30, [SP, #-16]!				// Store the link register onto the stack
	str x19, [SP, #-16]!				// Store x19 onto the stack
	str x20, [SP, #-16]!				// Store x20 onto the stack
	bl String_length				// call string length which has the length of the string in x0
	sub x0, x0, x20					// x0 = (length of the string - begin index)
	bl  malloc					// reserve that many bytes on the heap
	mov x7, x0					// move malloc address in x7
	ldr x20, [SP], #16				// pop x20 off the stack and load it back into x20 which holds the begin index 
	ldr x19, [SP], #16				// pop x19 off the stack and load it back into x19 which hold the the string
		
	mov x0, x19					// move x19 into x0
	bl String_length				// branch and link to string length which has the length of the string in x0
	add x3, x0,x19		
	sub x3, x3, #1		
	ldrb w6, [x3]				// loads the last characther in the string in w5
	add x19, x19, x20				// loads the begin index charactehr	
	String_substring_2_loop:
		ldrb w4, [x19]				// load a byte into w4 from whatever is in x19
		strb w4, [x7]				// store that byte in x0 which is the dynamiclly created string		
		add x19, x19, #1			// move on to the next byte
		add x7, x7, #1				// move on to the next byte for x0
		cmp  w4, w6				// compare w4 with w5 
		b.eq end_substring_2_loop		// then branch to this
		b String_substring_2_loop		// branch to String_substring_1_loop

	end_substring_2_loop:
		sub x6, x21, x20			// x3 = (x21 - x20)
		sub x7, x7, x6				// x0 = (x0 - x3)
		sub x7, x7 , #1				// this is because of the 0th index
		mov x0, x7				// mov it back into x0
		ldr x30, [SP], #16			// pop the link register off the stack
		ret	


String_charAt:
	str     x30, [SP, #-16]!      			

	mov     x19, x0              // x19 now holds the base address of the string.
	mov     x20, x1              // x20 now holds the position we're interested in.

   
	bl      String_length        // x0 now holds the length of the string.
	mov     x2, x0               // Move length into x2 for comparison.

    
	cmp     x20, x2
 	b.hs    impossible           // If position >= string length, jump to impossible.


	add     x19, x19, x20        // Calculate the actual address of the character.
 	mov     x0, x19		     // Put the address back into x0
   	b       char_at_end          // Jump to exit.

	impossible:
    		mov     x0, #0               // If impossible, return 0.

	char_at_end:
    		LDR x30, [SP], #16        // Pop the register off the stack
    		ret			// Return to caller.




String_startsWith_1:
	mov x19, x0 			// Moves x0 into x19
	mov x20, x1			// Moves x1 into x20
	mov x21, x2			// Moves x2, into x21
	str x30, [SP, #-16]!		// Store the link register onto the stack
	
	mov x0, x21			// mov the string prefix into x0
	bl String_length		// get the length of the string prefix and return it in x0
	mov x6, x0			// store that value in x6

	add x0, x19, x20		// add the string address with the offset
	mov x4, x0			// store the address in x4

	mov x5, x21			// hold the address of the string prefix

	compareLoop:
		subs x6, x6, #1		// decrment the prefix length to make sure we check through the whole prefix
		cmp x6, #0		// check if it is less than 0
		b.lt loopedPrefix	// if it is less than 0 then jump to loopedPrefix
	
		ldrb w1, [x4], #1	// load a byte into x1 and increment and the original string
		ldrb w2, [x5], #1	// load a byte into x2 and increment from the string prefix
	
		cmp w1, w2		// compare the two characthers together
		b.ne false_startsWith	// if it doesn't equal than jump to label
		b compareLoop		// if not keep looping


	loopedPrefix:
		mov x0, #1		// true
		b exit_starts_with_1	// exit 
	false_startsWith:
		mov x0, #0		// false
		
	exit_starts_with_1:
		ldr x30, [SP], #16	// pop the link register off the stack
		ret			// return to the caller


String_startsWith_2:
	mov x19, x0			// moves x0 into x19
	mov x20, x1			// moves x1 into x30
	str x30, [SP, #-16]!		// store the link register onto the stack
	
	mov x0, x20			// move the string prefix into x0 for String_length
	bl String_length		// get the length of the string prefix and store it into x0
	mov x6, x0			// mov x0 into x6 which stores the length of the prefix x6 = n	
	
	compare_startsWith_2:
		subs x6, x6, #1		// decreae the length of the strPrefix to ensure that we looped through the prefix
		cmp x6, #0		// comapre x6 to 0
		b.lt true_startsWith2	// branch and link to true_startsWith_2
		
		ldrb w2, [x19], #1	// load a byte and increment string1 address
		ldrb w3, [x20], #1	// load a byte and increment stringprefix address
		
		cmp w2, w3		// comapre the characthers together
		b.ne false_startsWith2	// if they are not equal jump to the branch

		b compare_startsWith_2	// continue looping through the loop

	true_startsWith2:
		mov x0, #1		// true
		b exit_startsWith_2	// branch to this label
	false_startsWith2:
		mov x0, #0		// false

	exit_startsWith_2:
		ldr x30, [SP], #16	// pop the linker off the stack
		ret			// return to the caller


String_endsWith:
	
	str x30, [SP, #-16]!		// Store the link register onto the stack
	
	mov x19, x0			// mov x0 into x19
	mov x20, x1			// mov x1 into x20 

	mov x0, x19			// we are going to get the length of the string
	bl String_length		// length of the string is returend in x0

	mov x2, x0			// the length of string1 is in = x2

	mov x0, x20			// mov x20 into x0
	bl String_length		// get the length of the string prefix and store it into x0
	
	mov x3, x0			// store that number into x3

	cmp x3, x2			// compare them
	b.gt endsWith_false		// if the prefix is larger thatn the string than false


	sub x4, x2, x3			// startin index for string 1 for comparison
	add x19, x19, x4		// x19 to point to the start of the comparison string1

	compareEndsWith:
		subs x3, x3, #1		// decrement the prefix length
		b.lt trueEndsWith	// branch to trueEndsWith if this is true

		ldrb w5, [x19, x3]	// load a byte from string 1
		ldrb w6, [x20, x3]	// load a byte from prefix

		cmp w5, w6 		// comapre the two characthers togehter
		b.ne endsWith_false	// if they are not equal branch to that label

		b compareEndsWith	// continue looping

	trueEndsWith:
		mov x0, #1		// true
		b exitEndsWith		// hard branch to this label

	endsWith_false:
		mov x0, #0		// false
	exitEndsWith:
		ldr x30, [SP], #16	// pop x30 off the stack
		
		ret			// return to the caller
        