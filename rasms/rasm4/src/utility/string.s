.global string_copy
.global string_push_char

.global String_equalsIgnoreCase
.global String_substring_1
.global String_substring_2
.global String_charAt
.global String_startsWith_1
.global String_startsWith_2
.global String_endsWith

.global String_toLowerCase
.global String_toUpperCase
.global String_indexOf_1
.global String_indexOf_2
.global String_indexOf_3
.global String_lastIndexOf_1
.global String_lastIndexOf_2
.global String_lastIndexOf_3
.global String_replace

count_bytes:
  MOV X1, #0  // move 0 into X5
  count_bytes_loop:
    LDRB W2, [X0, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ count_bytes_loop_end  // branch if equal to

    ADD X1, X1, #1  // increment X4 by one
    B count_bytes_loop
  count_bytes_loop_end:

  MOV X0, X1

  RET  // return

string_copy:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0  // move the address of the first string into X4

  MOV X0, X19  // move the address of the first string into X4
  BL String_length

  MOV  X0, X0 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  string_copy_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ string_copy_loop_end  // branch if equal to

    STRB W2, [X0, X1]
    ADD X1, X1, #1  // increment X4 by one

    B string_copy_loop
  string_copy_loop_end:

  MOV W2, #0
  STRB W2, [X0, X1]

  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET  // return  .global String_replace

string_push_char:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the address of the first string into X19
  MOV W20, W1  // move move the value of the char to be added into X20

  MOV X0, X19  // move the address of the first string into X4
  BL String_length

  ADD X0, X0, #1  // add 1 to length, because we push last char
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  string_push_char_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ string_push_char_loop_end  // branch if equal to

    STRB W2, [X0, X1]
    ADD X1, X1, #1  // increment X4 by one

    B string_push_char_loop
  string_push_char_loop_end:

  STRB W20, [X0, X1]  // store char in second to last index
  ADD X1, X1, #1  // increment X4 by one

  MOV W2, #0
  STRB W2, [X0, X1]  // store null term in last index

  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET  


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
        
// String_concat helper function
concat_string:
  LDRB W3, [X4, X2]       // load the value at the address X4 with offset X2
  CMP W3, 0               // W3 - 0 and set CPSR register
  B.EQ concat_string_end  // branch if equal to

  STRB W3, [X0, X1]
  ADD X1, X1, #1  // increment X1 by one
  ADD X2, X2, #1  // increment X2 by one

  B concat_string

  concat_string_end:

  RET

// Subroutine String_concat:
//      return the concatenated string of X0, X1
// X0: Must contain null terminated string
// X1: Must contain null terminated string
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_concat:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the address of the first string into X4
  MOV X20, X1  // move the address of the first string into X4

  MOV X1, #0   // move 0 into X2
  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  ADD X1, X1, X0  // X1 = X1 + X0

  MOV X0, X20  // move the address of the first string into X4
  BL count_bytes

  ADD X1, X1, X0  // X1 = X1 + X0
  ADD X1, X1, #1  // X2 = X2 + 1 (for null terminator)

  MOV  X0, X1 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0   // move 0 into X1
  MOV X2, #0   // move 0 into X2
  MOV X4, X19  // move X19 into X4
  BL concat_string

  MOV X2, #0   // move 0 into X2
  MOV X4, X20  // move X20 into X1
  BL concat_string

  MOV W2, #0         // set W2 equal to 0
  STRB W2, [X0, X1]  // set null terminating character

  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET


// Subroutine String_toLowerCase:
//      return the string pointed by X0 but lower case
// X0: Must contain null terminated string
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_toLowerCase:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0  // move the address of the first string into X4

  MOV X0, X19  // move the address of the first string into X4
  BL String_length

  MOV  X0, X0 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  toLowerCase_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ toLowerCase_loop_end  // branch if equal to

    // if W2 >= 65 && <= 90
    CMP W2, #65
    B.LT toLowerCase_continue

    CMP W2, #90
    B.GT toLowerCase_continue

    // condition was true
    ADD W2, W2, #32  // increment X4 by one

    toLowerCase_continue:
      STRB W2, [X0, X1]
      ADD X1, X1, #1  // increment X4 by one

    B toLowerCase_loop
  toLowerCase_loop_end:

  MOV W2, #0         // set W2 equal to 0
  STRB W2, [X0, X1]  // set null terminating character

  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_toUpperCase:
//      return the string pointed by X0 but upper case
// X0: Must contain null terminated string
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_toUpperCase:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0  // move the address of the first string into X4

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  MOV  X0, X0 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  toUpperCase_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ toUpperCase_loop_end  // branch if equal to

    // if W2 >= 97 && <= 122
    CMP W2, #97
    B.LT toUpperCase_continue

    CMP W2, #122
    B.GT toUpperCase_continue

    // condition was true
    SUB W2, W2, #32  // increment X4 by one

    toUpperCase_continue:
      STRB W2, [X0, X1]
      ADD X1, X1, #1  // increment X4 by one

    B toUpperCase_loop
  toUpperCase_loop_end:

  MOV W2, #0         // set W2 equal to 0
  STRB W2, [X0, X1]  // set null terminating character

  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET

// String_indexOf_1 helper function
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
index_of_char:
  STR X30, [SP, #-16]! // push link register onto the stack

  index_of_char_loop:
    LDRB W3, [X0, X2]          // load the value at the address X4 with offset X5
    CMP W3, 0                  // X6 - 0 and set CPSR register
    B.EQ index_of_char_end    // branch if equal to

    // if W2 == character
    CMP W3, W1
    B.NE index_of_char_continue

    // we have found character return index
    MOV X0, X2
    LDR X30, [SP], #16   // pop link register off the stack
    RET

    index_of_char_continue:
      ADD X2, X2, #1  // increment X2 by one

    B index_of_char_loop
  index_of_char_end:

  MOV X0, -1         // set W2 equal to 0

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_1:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_indexOf_1:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, #0  // set starting point to zero
  BL index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_2:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_indexOf_2:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, X2  // set starting point to zero
  BL index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_3:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain string to match against also null terminated
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.

// Psuedo
// index = 0
// for each char0 in x0
//   char0 = x0[index]
//   if char0 == \0
//     return -1

//   inner_index = 0
//   matched = true
//   for_each_matched_character
//       if [x0, index + inner_index] != [x1, inner_index]
//         matched = false
//         break
  
//   if matched:
//     return index
  
//   ++index
String_indexOf_3:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the value of x0 into x19
  MOV X20, X1  // move the value of x1 into x20

  MOV X0, #0  // move the value of 0 into X0 (this is our index)
  indexOf_3_loop:
    LDRB W1, [X19, X0]          // load the value at the address X4 with offset X5
    CMP W1, 0                  // X6 - 0 and set CPSR register
    B.EQ indexOf_3_end    // branch if equal to

    MOV X1, #0  // move the value of 0 into x1 this is our inner index
    MOV X2, #1  // this is our matched variable set to true

    indexOf_3_inner_loop:
      LDRB W3, [X20, X1]             // load the value at the address X4 with offset X5
      CMP W3, 0                      // X6 - 0 and set CPSR register
      B.EQ indexOf_3_inner_loop_end  // branch if equal to

      ADD X3, X0, X1      // add both inner and index
      LDRB W4, [X19, X3]  // load the value at the address X4 with offset X5
      LDRB W5, [X20, X1]  // load the value at the address X4 with offset X5

      CMP W4, W5  // W4 - W5 and store result into the CPSR register
      B.EQ indexOf_3_inner_loop_continue

      // they did not equal lets break and set matched to false
      MOV X2, #0  // set X2 equal to false
      B indexOf_3_inner_loop_end

      indexOf_3_inner_loop_continue:
        ADD X1, X1, #1  // increment inner_index by one
        B indexOf_3_inner_loop
    indexOf_3_inner_loop_end:

    CMP X2, #1  // is matched true
    B.EQ indexOf_3_return

    ADD X0, X0, #1  // increment index by one
    B indexOf_3_loop
  indexOf_3_end:

  MOV X0, -1  // no string found 

  indexOf_3_return:
    LDR X20, [SP], #16   // pop X20 off the stack
    LDR X19, [SP], #16   // pop X19 off the stack
    LDR X30, [SP], #16   // pop link register off the stack

    RET

// String_lastIndexOf helper function
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
last_index_of_char:
  STR X30, [SP, #-16]! // push link register onto the stack

  last_index_of_char_loop:
    CMP X2, 0                  // X6 - 0 and set CPSR register
    B.EQ last_index_of_char_end    // branch if equal to

    LDRB W3, [X0, X2]          // load the value at the address X4 with offset X5

    // if W2 == character
    CMP W3, W1
    B.NE last_index_of_char_continue

    // we have found character return index
    MOV X0, X2
    LDR X30, [SP], #16   // pop link register off the stack
    RET

    last_index_of_char_continue:
      SUB X2, X2, #1  // sub X2 by one

    B last_index_of_char_loop
  last_index_of_char_end:

  MOV X0, -1         // set W2 equal to 0

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_1:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_1:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0
  MOV X20, X1

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  MOV X2, X0  // set starting point to zero
  MOV X0, X19  // move string into X0
  MOV X1, X20  // set params
  BL last_index_of_char

  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_2:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_2:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, X2  // set starting point to zero
  BL last_index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_3:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain string to match against also null terminated
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_3:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the value of x0 into x19
  MOV X20, X1  // move the value of x1 into x20

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  SUB X0, X0, #1
  MOV X0, X0  // move the value of 0 into X0 (this is our index)
  lastIndexOf_3_loop:
    CMP X0, 0                  // X6 - 0 and set CPSR register
    B.LT lastIndexOf_3_end    // branch if equal to

    STR X0, [SP, #-16]! // push X20 onto the stack
    MOV X0, X20  // move the address of the first string into X4
    BL count_bytes

    SUB X0, X0, #1
    MOV X1, X0
    LDR X0, [SP], #16   // pop X20 off the stack

    MOV X2, #1  // this is our matched variable set to true
    MOV X6, #0  // inner index loop

    lastIndexOf_3_inner_loop:
      CMP X1, 0                  // X6 - 0 and set CPSR register
      B.LT lastIndexOf_3_inner_loop_end    // branch if equal to

      SUB X3, X0, X6      // add both inner and index
      LDRB W4, [X19, X3]  // load the value at the address X4 with offset X5
      LDRB W5, [X20, X1]  // load the value at the address X4 with offset X5

      CMP W4, W5  // W4 - W5 and store result into the CPSR register
      B.EQ lastIndexOf_3_inner_loop_continue

      // they did not equal lets break and set matched to false
      MOV X2, #0  // set X2 equal to false
      B lastIndexOf_3_inner_loop_end

      lastIndexOf_3_inner_loop_continue:
        SUB X1, X1, #1  // decrement inner_index by one
        ADD X6, X6, #1  // increment inner index by one
        B lastIndexOf_3_inner_loop
    lastIndexOf_3_inner_loop_end:

    CMP X2, #1  // is matched true
    B.NE lastIndexOf_3_continue

    SUB X6, X6, #1
    SUB X0, X0, X6
    B lastIndexOf_3_return

    lastIndexOf_3_continue:
      SUB X0, X0, #1  // increment index by one
      B lastIndexOf_3_loop
  lastIndexOf_3_end:

  MOV X0, -1  // no string found 

  lastIndexOf_3_return:
    LDR X20, [SP], #16   // pop X20 off the stack
    LDR X19, [SP], #16   // pop X19 off the stack
    LDR X30, [SP], #16   // pop link register off the stack

    RET

// Subroutine String_replace:
//      return new allocated string with replaced char if found
// X0: Must contain null terminated string
// X1: Must contain old char to match against
// X2: Must contain new char to replace
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_replace:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack
  STR X21, [SP, #-16]! // push X21 onto the stack

  MOV X20, X1  // store old char
  MOV X21, X2  // store new char

  BL string_copy

  MOV X1, #0  // move 0 into X5
  replace_loop:
    LDRB W2, [X0, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ replace_loop_end  // branch if equal to

    CMP W2, W20
    B.NE replace_loop_continue

    STRB W21, [X0, X1]  // given index of old char replace with new char

    replace_loop_continue:
      ADD X1, X1, #1  // increment X4 by one
      B replace_loop
  replace_loop_end:

  LDR X21, [SP], #16   // pop link X21 off the stack
  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET
