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
  .global _main

  .equ BUFFER, 512

  .section .data

  szBuffer:  .skip BUFFER

  szStudents:			.asciz		"Students: Shiv Patel Carlos Aguilera"
  szClass:			.asciz		"Class: CS3B"
  szProject:			.asciz		"Project: RASM3"
  szDate:			.asciz		"4/11/2024"

  szEnterS1:			.asciz 		"Enter the value for S1: "
  szEnterS2:			.asciz		"Enter the value for S2: "
  szEnterS3:			.asciz		"Enter the value for S3: "

  szStringIndexOf1:  		.asciz 		"String_indexOf_1(s2,'g') = "
  szStringIndexOf2:  		.asciz 		"String_indexOf_2(s2,'g',9) = "
  szStringIndexOf3:  		.asciz 		"String_indexOf_3(s2,\"eggs\") = "

  szStringLastIndexOf1:  	.asciz 		"String_lastIndexOf_1(s2,'g') = "
  szStringLastIndexOf2:  	.asciz 		"String_lastIndexOf_2(s2,'g',6) = "
  szStringLastIndexOf3:  	.asciz 		"String_lastIndexOf_3(s2,\"eggs\") = "

  szStringReplace:      	.asciz 		"String_replace(s1,'a','o') =  "
  szStringToLower:      	.asciz 		"String_toLowerCase(s1) = "
  szStringToUpper:      	.asciz 		"String_toUpperCase(s1) = "
  szStringConcatSpace:  	.asciz 		"String_concat(s1, " ");"
  szStringConcat:       	.asciz 		"String_concat(s1, s2) = "

  szEggTest:  			.asciz 		"egg"
  szSpaceTest:  		.asciz 		" "
  chLF:				.byte		0xa
  s1:				.space		BUFFER
  s2:				.space		BUFFER
  s3:				.space		BUFFER
  szStartsWith1:		.asciz		"hat."
  szStartsWith2:		.asciz		"Cat"
  szEndsWith:			.asciz		"in the hat."
  szEndsWithMsg:		.asciz		"String_endsWith(s1, in the hat.) = "
  ptrS4:			.quad		0
  ptrSubstring1:		.quad		0
  ptrSubstring2:		.quad		0
  szPromptForS1Length:		.asciz		"s1.length() = "
  szPromptForS2Length:		.asciz		"s2.length() = "
  szPromptForS3Length:		.asciz		"s3.length() = "
  szAnswerForS1Length:		.space		BUFFER
  szAnswerForS2Length:		.space		BUFFER
  szAnswerForS3Length:		.space		BUFFER
  szPromptForEqual1:		.asciz		"String_equals(s1,s3) = "
  szPromptForEqual2:		.asciz		"String_equals(s1, s1) = "
  szPromptForIgnoreEqual1:	.asciz		"String_equalsIgnoreCase(s1, s3) = "
  szPromptForIgnoreEqual2:	.asciz		"String_equalsIgnoreCase(s1, s2) = "
  szAnswerForEqualTrue: 	.asciz		"TRUE "
  szAnswerForEqualFalse:	.asciz		"FALSE "
  szStringCopyMsg1:		.asciz		"s4 = String_copy(s1)"
  szStringCopyMsg2:		.asciz		"s1 = "
  szStringCopyMsg3:		.asciz		"s4 = "
  szSubstring1Msg1:		.asciz		"String_substring_1(s3,4,14) = "
  szSubstring2Msg1:		.asciz		"String_substring_2(s3,7) = "
  szCharAtMsg1:			.asciz		"String_charAt(s2, 4) = "
  szStartsWith1Msg:		.asciz		"String_startsWith_1(s1, 11, hat.) = "
  szStartWith2Msg:		.asciz		"String_startsWith_2(s1, Cat) = "

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

_main:

//Load program information

	ldr x0,=szStudents		// Loads the Address of szStudents into x0
	bl  putstring			// Displays this to the screen
	

	//LINE FEED 
	ldr x0,=chLF			// This Loads the Address of a Line Feed into x0
	bl  putch			// This Displays the Line Feed to the Screen
	
	ldr x0,=szClass			// Loads the Address of szClass into x0
	bl  putstring			// Displays this to the screen

	//LINE FEED 
	ldr x0,=chLF			// This Loads the Address of a Line Feed into x0
	bl  putch			// This Displays the Line Feed to the Screen	

	
	ldr x0,=szProject		// This loads the address of szProject into x0
	bl  putstring			// This Displays it to the screen

	
	//LINE FEED 
	ldr x0,=chLF			// This Loads the Address of a Line Feed into x0
	bl  putch			// This Displays the Line Feed to the Screen


	ldr x0,=szDate			// Thie loads the address of szDate into x0
	bl  putstring			// This displays it to the class


	//LINE FEED 
	ldr x0,=chLF			// This Loads the Address of a Line Feed into x0
	bl  putch			// This Displays the Line Feed to the Screen

	//LINE FEED 
	ldr x0,=chLF			// This Loads the Address of a Line Feed into x0
	bl  putch			// This Displays the Line Feed to the Screen






// Get User Input:

	ldr x0,=szEnterS1		// Loads the address of szEnterS1 into x0
	bl  putstring			// Displays the prompt to the screen

	ldr x0,=s1			// loads teh address of s1 into x0 
	mov x1, #BUFFER			// Moves the Buffer Size into x1
	bl getstring			// Allows the user to enter the value

	ldr x0,=szEnterS2		// Loads the address of szEnterS2 into x0
	bl  putstring			// Displays the prompt to the screen
	
	ldr x0,=s2			// Loads the address of s2 into x0
	mov x1, #BUFFER			// Moves the Buffer Size into x1
	bl getstring			// Gets user input

	ldr x0,=szEnterS3		// Loads the address of szEnterS1 into x0
	bl  putstring			// Displays the prompt to the screen


	ldr x0,=s3			// Loads the Address of s3 into x0
	mov x1, #BUFFER			// Moves the Buffer size into x1
	bl  getstring			// Gets the user input
	

	//LINE FEED 
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen




// THIS IS FOR THE S1 LENGTH FUNCTION

	ldr x0,=szPromptForS1Length				// This Loads the Address of the Length Prompt for S1
	bl  putstring						// Displays the "s1.length() = " to the Screen
	
	ldr x0,=s1						// This Loads the Address of S1
	bl  String_length					// This function will length of the string in x0
	
	ldr x1,=szAnswerForS1Length				// This Loads the Address of szAnswerForS1Length into x1 for int64asc
	bl  int64asc						// This calls int64asc which converts the integer in x0 to ascii

	ldr x0,=szAnswerForS1Length				// This Loads the Address of szAnswerForS1Length into x0 to Print
	bl  putstring						// This Prints the Answer for the S1 Length to the Screen


	//LINE FEED 
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen



	// THIS IS FOR S2 LENGTH FUNCTION

	ldr x0,=szPromptForS2Length				// This Loads the Address of the Length Prompt for S2
	bl  putstring						// Displays the "s2.length() = " to the Screen
	
	ldr x0,=s2						// This Loads the Address of S2
	bl  String_length					// This function will length of the string in x0
	
	ldr x1,=szAnswerForS2Length				// This Loads the Address of szAnswerForS2Length into x1 for int64asc
	bl  int64asc						// This calls int64asc which converts the integer in x0 to ascii

	ldr x0,=szAnswerForS2Length				// This Loads the Address of szAnswerForS2Length into x0 to Print
	bl  putstring						// This Prints the Answer for the S2 Length to the Screen

	
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen



	// THIS IS FOR S3 LENGTH FUNCTION


	ldr x0,=szPromptForS3Length				// This Loads the Address of the Length Prompt for S3
	bl  putstring						// Displays the "s3.length() = " to the Screen
	
	ldr x0,=s3						// This Loads the Address of S3
	bl  String_length					// This function will length of the string in x0
	
	ldr x1,=szAnswerForS3Length				// This Loads the Address of szAnswerForS3Length into x1 for int64asc
	bl  int64asc						// This calls int64asc which converts the integer in x0 to ascii

	ldr x0,=szAnswerForS3Length				// This Loads the Address of szAnswerForS3Length into x0 to Print
	bl  putstring						// This Prints the Answer for the S3 Length to the Screen



	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen


	// THIS IS FOR EQUALS FUNCTION Part 1

	ldr x0,=szPromptForEqual1				// Loads the Address of szPromptForEqual1 into x0
	bl  putstring						// Displays "String_equals(s1,s3) = " to the Screen


	ldr x0,=s1						// 1st Argument -- Loads s1 into x0
	ldr x1,=s3						// 2nd Argument -- Loads s2 into x1

	bl String_equals					// Branches to String_equals 
	
	// Display True or False
	cmp x0, #0						// If x0 - 0 = True then Display False
	b.eq string_equals_false_1				// if x0 = 0 then branch to false
	cmp x0, #1						// if x0 = 1 then display true
	b.eq string_equals_true_1				// if x0 = 1 then branch to true
	string_equals_false_1:
		ldr x0,=szAnswerForEqualFalse			// Loads the Address of szAnswerForEqualFalse into x0
		bl  putstring					// Display this to the screen
		b   endOfStringEqualsPart1			// Branch to the endOfStringEqualsPart1
	string_equals_true_1:	
		ldr x0,=szAnswerForEqualTrue			// Loads the Address of szAnswerForEqualTrue into x0
		bl  putstring					// Displays this to the screen

endOfStringEqualsPart1:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	

	// THIS IS FOR EQUALS FUNCTION Part 2
	ldr x0,=szPromptForEqual2				// Loads the Address of szPromptForEqual2 into x0
	bl  putstring						// Displays "String_equals(s1,s1) = " to the Screen


	ldr x0,=s1						// 1st Argument -- Loads s1 into x0
	ldr x1,=s1						// 2nd Argument -- Loads s1 into x1

	bl String_equals					// Branches to String_equals 
	
	// Display True or False
	cmp x0, #0						// If x0 - 0 = True then Display False
	b.eq string_equals_false_2				// if x0 = 0 then branch to false
	cmp x0, #1						// if x0 = 1 then display true
	b.eq string_equals_true_2				// if x0 = 1 then branch to true
	string_equals_false_2:
		ldr x0,=szAnswerForEqualFalse			// Loads the Address of szAnswerForEqualFalse into x0
		bl  putstring					// Display this to the screen
		b   endOfStringEqualsPart2			// Branch to the endOfStringEqualsPart1
	string_equals_true_2:	
		ldr x0,=szAnswerForEqualTrue			// Loads the Address of szAnswerForEqualTrue into x0
		bl  putstring					// Displays this to the screen

endOfStringEqualsPart2:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	
	// THIS IS STRING_EQUALSIGNORE PART 1

	ldr x0,=szPromptForIgnoreEqual1				// This Loads the Address of szPromptForIgnoreEqual1 into x0
	bl  putstring						// Displays it to the screen "String_equals(s1,s3) = "



	ldr x0,=s1						// 1st Argument -- Loads s1 into x0
	ldr x1,=s3						// 2nd Argument -- Loads s3 into x0

	bl  String_equalsIgnoreCase				// Call the function String_equalsIgnoreCase which compares the two string disregarding the Case
	// Display True or False
	cmp x0, #0						// x0 = 0 then False
	b.eq string_equals_ignoreCase_false_part1		// if false go to string_equals_ignoreCase_false_part1
	cmp x0, #1						// if x0 = 1 then True
	b.eq string_equals_ignoreCase_true_part1		// if true go to string_equals_ignoreCase_true_part1
	
	string_equals_ignoreCase_false_part1:
		ldr x0,=szAnswerForEqualFalse			// load into x0 the address of szAnswerForEqualFalse
		bl  putstring					// Display False to the Screen
		b endOfStringEqualsIgnoreCasePart1		// then Jump to the end of part 1 of this case
	string_equals_ignoreCase_true_part1:
		ldr x0,=szAnswerForEqualTrue			//loads into x0 the address of szAnswerForEqualTrue
		bl  putstring					// Display True to the screen

endOfStringEqualsIgnoreCasePart1:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	

	// THIS IS STRING_EQUALSIGNORE PART 2

	ldr x0,=szPromptForIgnoreEqual2				// This Loads the Address of szPromptForIgnoreEqual2 into x0
	bl  putstring						// Displays it to the screen "String_equals(s1,s2) = "



	ldr x0,=s1						// 1st Argument -- Loads s1 into x0
	ldr x1,=s2						// 2nd Argument -- Loads s2 into x0

	bl  String_equalsIgnoreCase				// Call the function String_equalsIgnoreCase which compares the two string disregarding the Case
	// Display True or False
	cmp x0, #0						// x0 = 0 then False
	b.eq string_equals_ignoreCase_false_part2		// if false go to string_equals_ignoreCase_false_part2
	cmp x0, #1						// if x0 = 1 then True
	b.eq string_equals_ignoreCase_true_part2		// if true go to string_equals_ignoreCase_true_part2
	
	string_equals_ignoreCase_false_part2:
		ldr x0,=szAnswerForEqualFalse			// load into x0 the address of szAnswerForEqualFalse
		bl  putstring					// Display False to the Screen
		b endOfStringEqualsIgnoreCasePart2		// then Jump to the end of part 1 of this case
	string_equals_ignoreCase_true_part2:
		ldr x0,=szAnswerForEqualTrue			//loads into x0 the address of szAnswerForEqualTrue
		bl  putstring					// Display True to the screen

endOfStringEqualsIgnoreCasePart2:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen


	// THIS PART IS FOR STRING COPY FUNCTION (LEAVE OFF HERE)
	
	ldr x0,=szStringCopyMsg1				// Loads the Address of szStringCopyMsg1 into x0
	bl  putstring						// Displays the Prompt to the Screen

	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen

	ldr x0,=szStringCopyMsg2					// Loads the Address of szStringCopyMsg2 into x0
	bl  putstring						// Display the prompt to the screen
	ldr x0,=s1						// Loads the Address of s1 into x0
	bl  putstring						// Display s1 to the screen

	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
		
	ldr x0,=s1						// Loads the Address of s1 into x0	
	ldr x1,=ptrS4						// Loads the Address of s4 into x1
	bl String_copy						// branch and link to String_copy


	ldr x0,=szStringCopyMsg3				// Loads the Address of szStringCopyMsg3 into x0
	bl  putstring						// Displays that prompt to the screen

	ldr x0,=ptrS4						// Load into x0 the memory address of ptrS4
	ldr x0,[x0]						// Load into x0 the contents of ptrS4 which is a memory address
	bl  putstring						// Display that memory address which is a string
	
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	
	// THIS PART IS FOR String_substring_1 (LEAVE OFF HERE)
	
	ldr x0,=szSubstring1Msg1				// This Loads the Address of szSubstring1Msg1 into x0
	bl  putstring						// Display the the prompt to the screen
	
	ldr x0,=s3						// This Loads the Address of s3 into x0 (Argument 1)
	mov x1,#4						// Loads into x1 the Begin Index	(Argument 2)
	mov x2, #14						// Loads into x2 the End Index		(Argument 3)
	bl String_substring_1					// Branch and link to String_substring_1
	
	ldr x1,=ptrSubstring1					// load into x1 the address of ptrSubstring1
	str x0, [x1]						// store the memory address of the dynamically created string into ptrSubstring1

	ldr x0,=ptrSubstring1					// load into x0 the address of ptrSubstring1
	ldr x0, [x0]						// load the contents of ptrSubstring1 into x0 
	bl  putstring						// Display that string to the screen


	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen

	// THIS PART IS FOR String_substring_2 (LEAVE OFF HERE)
	
	ldr x0,=szSubstring2Msg1				// This loads the address of szSubstring2Msg1 into x0
	bl  putstring						// Display this prompt to the screen

	ldr x0,=s3						// (Argument) loads the address of s3 into x0
	mov x1, #7						// (Argument) moves the begin index into x1	
	bl String_substring_2


	ldr x1,=ptrSubstring2
	str x0, [x1]
	ldr x0,=ptrSubstring2
	ldr x0, [x0]
	bl putstring


	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen

	// THIS PART OF CHARAT
	ldr x0,=szCharAtMsg1					// This loads the szCharAtMsg1 into x0
	bl putstring						// Displays this to the screen
	ldr x0,=s2						// This Loads the Address of s2 into x0 (ARGUMENT)
	mov x1, #4						// This Loads 4 into x1 which is the index of the char (Argument)
	bl  String_charAt					// Branch and Link to String_charAt
	bl putch 						// display that string to the screen

	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen

	// ThIS PART OF startsWith1
	ldr x0,=szStartsWith1Msg				// load the address of szStartWith1Msg into x0
	bl  putstring						// display the prompt to the screen 

	ldr x0,=s1						// This Loads the Address of s1 into x0 (Argument)
	mov x1, #11						// This Loads into x1 the offset of 11  (Argument)
	ldr x2,=szStartsWith1					// Loads the String Prefix we are going to compare too (Argument)
	bl String_startsWith_1					// Branches and Links to String_startsWith_1
	// Display True or False
	cmp x0, #0						// If x0 - 0 = True then Display False
	b.eq string_startsWith_false_1				// if x0 = 0 then branch to false
	cmp x0, #1						// if x0 = 1 then display true
	b.eq string_startsWith_true_1				// if x0 = 1 then branch to true
	string_startsWith_false_1:
		ldr x0,=szAnswerForEqualFalse			// Loads the Address of szAnswerForEqualFalse into x0
		bl  putstring					// Display this to the screen
		b   endOfStringStartsWithPart1			// Branch to the endOfStringStartsWithPart1
	string_startsWith_true_1:	
		ldr x0,=szAnswerForEqualTrue			// Loads the Address of szAnswerForEqualTrue into x0
		bl  putstring					// Displays this to the screen


endOfStringStartsWithPart1:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	

	// THIS IS PART OF STARTS WITH 2
	
	ldr x0,=szStartWith2Msg					// This Loads the Address of szStartWith2Msg
	bl  putstring						// Display the Prompt to the Screen
	


	ldr x0,=s1						// (Argument) sThis Loads the Address of s1 into x0
	ldr x1,=szStartsWith2					// (Argument) This loads szStartWith2 into x1
	bl  String_startsWith_2					//  Branch and Link into String_startsWith_2
	// Display True or False
	cmp x0, #0						// If x0 - 0 = True then Display False
	b.eq string_startsWith_false_2				// if x0 = 0 then branch to false
	cmp x0, #1						// if x0 = 1 then display true
	b.eq string_startsWith_true_2				// if x0 = 1 then branch to true
	string_startsWith_false_2:
		ldr x0,=szAnswerForEqualFalse			// Loads the Address of szAnswerForEqualFalse into x0
		bl  putstring					// Display this to the screen
		b   endOfStringStartsWithPart2			// Branch to the endOfStringStartsWithPart1
	string_startsWith_true_2:	
		ldr x0,=szAnswerForEqualTrue			// Loads the Address of szAnswerForEqualTrue into x0
		bl  putstring					// Displays this to the screen



endOfStringStartsWithPart2:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch						// This Displays the Line Feed to the Screen
	

	// START OF ENDSWITH
		
	ldr x0,=szEndsWithMsg					// load the address of szEndsWithMsg into x0
	bl  putstring						// display the prompt to the screen


	ldr x0,=s1						// (ARGUMENT) this loads the address of s1 into x0
	ldr x1,=szEndsWith					// (ARGUMENT) This loads the address of szEndwith suffix
	
	bl String_endsWith					// Branch and Link to String_endsWith
	

	// Display True or False
	cmp x0, #0						// If x0 - 0 = True then Display False
	b.eq string_endsWith_false_2				// if x0 = 0 then branch to false
	cmp x0, #1						// if x0 = 1 then display true
	b.eq string_endsWith_true_2				// if x0 = 1 then branch to true
	string_endsWith_false_2:
		ldr x0,=szAnswerForEqualFalse			// Loads the Address of szAnswerForEqualFalse into x0
		bl  putstring					// Display this to the screen
		b   endOfStringEndsWithPart2			// Branch to the endOfStringStartsWithPart1
	string_endsWith_true_2:	
		ldr x0,=szAnswerForEqualTrue			// Loads the Address of szAnswerForEqualTrue into x0
		bl  putstring					// Displays this to the screen

endOfStringEndsWithPart2:
	//LINE FEED
	ldr x0,=chLF						// This Loads the Address of a Line Feed into x0
	bl  putch



  // ----------------------- TEST #13 --------------------------- //
  LDR X0, =szStringIndexOf1   					// load the address of szStringIndexOf1 into X0
  BL putstring

  LDR X0, =s2     						// load the address of szTest2 into X0
  MOV X1, #103         						// move 'g' into X1
  BL String_indexOf_1

  MOV X0, X0  							// set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #14 --------------------------- //
  LDR X0, =szStringIndexOf2  					 // load the address of szStringIndexOf1 into X0
  BL putstring

  LDR X0, =s2     						// load the address of szTest2 into X0
  MOV X1, #103         						// move 'g' into X1
  MOV X2, #9           						// move 9 into X2
  BL String_indexOf_2

  MOV X0, X0  							// set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #15 --------------------------- //
  LDR X0, =szStringIndexOf3   					// load the address of szStringIndexOf1 into X0
  BL putstring

  LDR X0, =s2      						// load the address of szTest2 into X0
  LDR X1, =szEggTest    					// load the address of szEggTest into X0
  BL String_indexOf_3

  MOV X0, X0  // set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #16 --------------------------- //
  LDR X0, =szStringLastIndexOf1   				// load the address of szStringIndexOf1 into X0
  BL putstring

  LDR X0, =s2     						// load the address of szTest2 into X0
  MOV X1, #103         						// move 'g' into X1
  BL String_lastIndexOf_1

  MOV X0, X0  							// set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #17 --------------------------- //
  LDR X0, =szStringLastIndexOf2   				// load the address of szStringIndexOf1 into X0
  BL putstring

  LDR X0, =s2     						// load the address of szTest2 into X0
  MOV X1, #103         						// move 'g' into X1
  MOV X2, #6           						// move 9 into X2
  BL String_lastIndexOf_2

  MOV X0, X0  							// set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #18 --------------------------- //
  LDR X0, =szStringLastIndexOf3   				// load the address of szStringLastIndexOf3 into X0
  BL putstring

  LDR X0, =s2         						// load the address of szTest2 into X0
  LDR X1, =szEggTest       					// load the address of szEggTest into X0
  BL String_lastIndexOf_3

  MOV X0, X0  							// set param for convert_and_print_number
  BL convert_and_print_number

  // ----------------------- TEST #19 --------------------------- //
  LDR X0, =szStringReplace   					// load the address of szStringLastIndexOf3 into X0
  BL putstring

  LDR X0, =s1 	        					// load the address of szTest2 into X0
  MOV X1, #97              					// load the address of szEggTest into X0
  MOV X2, #111              					// load the address of szEggTest into X0
  BL String_replace

  MOV X0, X0  							// set param for putstring
  BL putstring 

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  // ----------------------- TEST #20 --------------------------- //
  LDR X0, =szStringToLower   					// load the address of szStringLastIndexOf3 into X0
  BL putstring

  LDR X0, =s1         						// load the address of szTest2 into X0
  BL String_toLowerCase 

  MOV X0, X0  							// set param for putstring
  BL putstring 

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  // ----------------------- TEST #21 --------------------------- //
  LDR X0, =szStringToUpper   					// load the address of szStringLastIndexOf3 into X0
  BL putstring

  LDR X0, =s1         						// load the address of szTest2 into X0
  BL String_toUpperCase 

  MOV X0, X0  							// set param for putstring
  BL putstring 

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  // ----------------------- TEST #22 --------------------------- //
  LDR X0, =szStringConcatSpace   				// load the address of szStringLastIndexOf3 into X0
  BL putstring

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  LDR X0, =szStringConcat   					// load the address of szStringLastIndexOf3 into X0
  BL putstring
		
  LDR X0, =s1      						// load the address of szTest2 into X0
  LDR X1, =szSpaceTest         					// load the address of szTest2 into X0
  BL String_concat 

  LDR X1, =s2  							// load the address of szTest2 into X0
  BL String_concat 

  MOV X0, X0  							// set param for putstring
  BL putstring 

  LDR X0, =chCr  						// load the address of chCr into X0
  BL putch       						// branch link to putch and print out chCr

  MOV   X0, #0   						// Use 0 return code
  MOV   X8, #93  						// Service Command Code 93 terminates this program
  SVC   0        						// Call linux to terminate the program
