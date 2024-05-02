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
  .global _main
  .global printStringWithIndexAndNewLine
  .global String_containsIgnoreCase

  .equ BUFFER, 512

  .section .data

    szBuffer:         .skip     BUFFER
    szTemp:           .skip     BUFFER                                            //Hold previous changes
    szUserInput:      .asciz    "Enter a choice: "
    szUserInput2:     .asciz    "Press Enter to Return: "
    szUserInput3:     .asciz    "Enter the index to be deleted: "
    szUserInput4:     .asciz    "What are you looking for: "
    szUserInput5:     .asciz    "Input: "
    szUserInput6:     .asciz    "Enter the index to be edited: "
    szUserInput7:     .asciz    "Enter new string: "

    szErrorInvalidOption:  .asciz "[ERROR]: Invalid option choose again.\n\n"

    szPrintEmpty:     .asciz    "[EMPTY]"
    chLeftBracket:    .ascii    "["
    chRightBracket:   .ascii    "]"
    chTab:            .ascii    "\t"
    iIndex:           .word     0
    szIndex:          .skip     BUFFER

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

// Preconditions: x0 must have the address of the string in the node
// Postconditions: Displays the string with an index and a newline.
// printStringWithIndexAndNewLine---------------------------------------------------------------------------
printStringWithIndexAndNewLine:
  STR X30, [SP, #-16]!            // Push the Link Register onto the Stack

  mov x19, x0                     // Save a copy of the address of the string node

  // Load the current index and convert to string
  ldr x0, =iIndex                       // Load the address of iIndex
  ldr w1, [x0]                          // Load the value of iIndex into w1
  mov w0, w1                            // Move the index value to x0 for conversion
  ldr x1, =szIndex                      // Load the address of the buffer szIndex
  bl int64asc                           // Convert the integer index to a string in szIndex

  // Print opening bracket
  ldr x0, =chLeftBracket                // Load the address of chLeftBracket
  bl putch                              // Display the opening bracket to the console

  // Print the index
  ldr x0, =szIndex                      // Load the address of the buffer containing the index string
  bl putstring                          // Display the index string

  // Print closing bracket
  ldr x0, =chRightBracket               // Load the address of chRightBracket
  bl putch                              // Display the closing bracket

  // Print closing bracket
  ldr x0, =chTab                        // Load the address of chRightBracket
  bl putch                              // Display the closing bracket

  // Print the string from the node
  mov x0, x19                           // Move the copy address back into x0
  bl putstring                          // Display the string

  // Increment and store the index
  ldr x0, =iIndex                       // Load the address of iIndex
  ldr w1, [x0]                          // Load the current index value
  add w1, w1, #1                        // Increment the index
  str w1, [x0]                          // Store the incremented index back to iIndex

  LDR X30, [SP], #16                    // Pop the Link Register off the stack
  ADR x19, printStringWithIndexAndNewLine  // Making sure the CallBack function doesn't change
  RET                                   // Return from the functionn
//---------------------------------------------------------------------------------------------------------

// Subroutine get_input:
//      return input from user in X0 (this is as a string)
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
get_input:
  STR X30, [SP, #-16]!            // Push the Link Register onto the Stack

  // print user input string
  ldr x0,=szUserInput             // Loads the Address of szUserInput into x0
  bl  putstring                   // Display the Prompt to the Console

  // get input and store it in buffer
  ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
  mov x1, BUFFER                  // Loads the Buffer amount into x1
  bl  getstring                   // Get the String and Store 

  ldr x0,=szBuffer                // Loads the Address of szBuffer into x0

  LDR X30, [SP], #16                    // Pop the Link Register off the stack
  RET                                   // Return from the functionn
//---------------------------------------------------------------------------------------------------------



//-- CheckString------------------------------------------------------------------------------
//x0 contains the address of the string 
//x1- contains the substring
//x0 contains the address of the string 
//x1- contains the substring
String_containsIgnoreCase: 
    // Save registers
    STR X30, [SP, #-16]!    // Save the link register
    STR X19, [SP, #-16]! // push X19 onto the stack
    STR X20, [SP, #-16]! // push X19 onto the stack
    STR X21, [SP, #-16]! // push X19 onto the stack
    STR X22, [SP, #-16]! // push X19 onto the stack

    ldr x1,=szBuffer
	  mov x19, x0				// Move the address of the string node into x19
	  mov x20, x1				// Move the address of the substring into x20
	// LowerCase for node String----------------------------------------
	mov x0, x19				// Move the address of the string node back into x0
	bl String_toLowerCase	// Branch and Link to String_toLowerCase
	mov x21, x0				// Contains the lowercase dynamically created version of string node
	//-------------------------------------------------------------------

	// LowerCase for substring String----------------------------------------
	mov x0, x20				// Move the address of the string node back into x0
	bl String_toLowerCase		// Branch and Link to String_toLowerCase
	mov x22, x0					// Contains the dynamically created lowercase version of substring node
	//-------------------------------------------------------------------


	//Check if substring exists in the string-----------------------------------
	mov x0, x21					// The address of the string node moves into x0 (Argument)
	mov x1, x22					// The address of the substring moves into x1   (Argument)
	bl String_indexOf_3			// Returns a number which is the index that the substring occurs
	//--------------------------------------------------------------------------

	cmp x0, #0					// Compare x0 with 0
	b.ge stringExists			// If greater than 0 stringExists
	b cleanup			// Branch to this If does Not exists

  stringExists:
		// Load the current index and convert to string
    ldr x0, =iIndex                       // Load the address of iIndex
    ldr w1, [x0]                          // Load the value of iIndex into w1
    mov w0, w1                            // Move the index value to x0 for conversion
    ldr x1, =szIndex                      // Load the address of the buffer szIndex
    bl int64asc                           // Convert the integer index to a string in szIndex

    // Print opening bracket
    ldr x0, =chLeftBracket                // Load the address of chLeftBracket
    bl putch                              // Display the opening bracket to the console

    // Print the index
    ldr x0, =szIndex                      // Load the address of the buffer containing the index string
    bl putstring                          // Display the index string

    // Print closing bracket
    ldr x0, =chRightBracket               // Load the address of chRightBracket
    bl putch                              // Display the closing bracket

    // Print closing bracket
    ldr x0, =chTab // Load the address of chTab
    bl putch                              // Display the closing bracket

    // Print the string from the node
    mov x0, x19                           // Move the copy address back into x0
    bl putstring                          // Display the string


  cleanup:
		mov x0, x21								// Free the block in x0
		bl free

    mov x21, #0x0               // set to null		

		mov x0, x22								// Free the block in x0
		bl free

    mov x22, #0x0               // set to null		

    // Increment and store the index
    ldr x0, =iIndex                       // Load the address of iIndex
    ldr w1, [x0]                          // Load the current index value
    add w1, w1, #1                        // Increment the index
    str w1, [x0]                          // Store the incremented index back to iIndex

    ldr x22, [SP], #16						// Pop the lr off the stack
    ldr x21, [SP], #16						// Pop the lr off the stack
    ldr x20, [SP], #16						// Pop the lr off the stack
    ldr x19, [SP], #16						// Pop the lr off the stack
		ldr x30, [SP], #16						// Pop the lr off the stack
		adr x19, String_containsIgnoreCase
		ret
	//--------------------------------------------------------------------------ction

//---------------------------------------------------------------------------------------------------------






_main:
  BL print_header // Print the Header Information

  Menu:
    BL print_menu // prints menu

    //------------------------------------------------------------------------------------------------

    //---Get Data from User Keyboard------------------------------------------------------------------
    BL get_input

    MOV X0, X0          // setup params
    bl  ascint64        // Conver the user input into a number to compare

    cmp x0, #1          // Check if user entered option 1
    b.eq Option1        // Branch and link to Option1

    cmp x0, #2          // Check if user entered option 1
    b.eq Option2        // Branch and link to Option1

    cmp x0, #3          // Check if user entered option 3
    b.eq Option3        // Branch and link to Option3

    cmp x0, #4          // Check if user entered option 3
    b.eq Option4        // Branch and link to Option3

    cmp x0, #5          // Check if user enetered option 5
    b.eq Option5        // Branch and link to option5

    cmp x0, #6          // Check if user enetered option 5
    b.eq Option6        // Branch and link to option5

    cmp x0, #7          // Check if user entered option7
    b.eq exit_program   // branch and link to exit program

    // if it gets here input was not a valid option
    B invalid_option

  //------------------------------------------------------------------------------------------------ 
    
  // Preconditions - x0 must have the headPtr
  //---Option 1 - View Strings---------------------------------------------------------------------
  Option1:
    // Check if the LinkedList is Empty----------------------------------------------

    bl isEmpty                        // Returns True or False in x0 if the linked list is empty
    cmp x0, #1                        // Compares to True
    b.eq printEmpty                   // Branch to printEmpty label

    //-----Print the Strings----------------------------------------------------------

    bl ViewStrings                    // Branch and Link to ViewStrings
    b  endOption1                     // Branch to endOption1

    //-------------------------------------------------------------------------------

    // printEmpty label to print if the linkedList is Empty
    printEmpty:
      ldr x0,=szPrintEmpty              // Loads the Address of szPrintEmpty into x0
      bl  putstring                     // Display this to the Console

      ldr x0,=chCr                      // Loads the Address of chCr into x0
      bl  putch                         // Display the newline characther to the console

      ldr x0,=chCr                      // Loads the Address of chCr into x0
      bl  putch                         // Display the newline characther to the console
      
    endOption1:
      // Clear Buffer----------------------------------------------------------------
      ldr x0,=szBuffer                  // Loads the address of szBuffer into x0
      mov x1, #0                        // Loads 0 into x1
      str x1, [x0]                      // Clears the content of szBuffer by putting it to all 0
      //--------------------------------------------------------------------------------

      ldr x0,=szUserInput2              // Loads the address of szUserInput2
      bl  putstring                     // Displays the prompt to the Screen
      ldr x0,=szBuffer                  // Loads the Address of szBuffer into x0
      mov x1, BUFFER                    // Loads the Buffer amount into x1
      bl  getstring                     // Get the String and Store 
      
      ldr x0,=szBuffer                  // Loads into x0 szBuffer
      ldr x0, [x0]                      // Loads the Value of szBuffer into x0
      cmp x0, #0x00                       // If it equals to 0
      b.eq clearOption1                 // Branch to this Label
      b endOption1                      // Get the Input Again


      clearOption1:
        //Line Feed
        ldr x0,=chCr                    // Loads the Address of chCr into x0
        bl  putch                       // Display the newline characther to the console

        ldr x0,=iIndex                // Loads the Address of iIndex into x0
        mov x1, #0                    // x1 = 0
        str x1, [x0]                  // Store the 0 into iIndex - Reset iIndex
        b   Menu                      // Display the Menu again 
    //-----------------------------------------------------------------------------------------------

    // Preconditions - none
    //---Option 2 - Add String---------------------------------------------------------------------
    Option2:
      BL print_option2_menu

      LDR x0,=chCr    // Loads the Address of chCr into x0
      BL  putch       // Display the newline characther to the console

      BL get_input

      LDRB W0, [X0]

      CMP W0, #97            // Check if user entered option a
      B.EQ option_keyboard   // Branch and link to option_keyboard

      CMP W0, #98        // Check if user entered option b
      B.EQ option_file   // Branch and link to option_file

      B try_again   // Branch and link to try_again

      option_keyboard:
        LDR x0,=szUserInput5   // Loads the Address of szUserInput4
        BL  putstring          // Displays the Prompt to the Console

        LDR X0,=szBuffer     // Loads the Address of szBuffer into x0
        MOV X1, BUFFER       // Loads the Buffer amount into x1
        BL  getstring        // Get the String and Store 

        LDR X0,=szBuffer     // Loads the Address of szBuffer into x0
        MOV W1, #10         // stores \n
        BL string_push_char  // returns new allocated string with char pushed back

        MOV X0, X0  // setup insert params
        BL insert   // branch link into insert

        LDR X0,=chCr  // Loads the Address of chCr into x0
        BL  putch     // Display the newline characther to the console

        B Menu  // branch to menu

      option_file:

        BL load_from_file

        LDR X0,=chCr  // Loads the Address of chCr into x0
        BL  putch     // Display the newline characther to the console
        B Menu

      try_again:
        LDR X0, =szErrorInvalidOption     // Loads the Address of szErrorInvalidOption
        BL  putstring                     // Displays the Prompt to the Console
        B Option2


    //---Option 3 - Delete Strings-------------------------------------------------------------------
    // Precondition: x0 contains the index of the string that is to be deleted
    Option3:
      //---Get Data from User Keyboard------------------------------------------------------------------

      ldr x0,=szUserInput3             // Loads the Address of szUserInput into x0
      bl  putstring                   // Display the Prompt to the Console

      ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
      mov x1, BUFFER                  // Loads the Buffer amount into x1
      bl  getstring                   // Get the String and Store 
      ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
      bl  ascint64                    // Conver the user input into a number to compare

      bl Delete                       // x0 has the index to be deleted

      b Menu                          // Loop back to the Menu

    //---Option 4 - Edit String-------------------------------------------------------------------
    // Precondition: x0 contains the index of the string that is to be deleted
    Option4:
      ldr x0,=szUserInput6             // Loads the Address of szUserInput into x0
      bl  putstring                   // Display the Prompt to the Console

      ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
      mov x1, BUFFER                  // Loads the Buffer amount into x1
      bl  getstring                   // Get the String and Store 
      ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
      bl  ascint64                    // Conver the user input into a number to compare

      MOV X19, X0   // store the index

      ldr x0,=szUserInput7             // Loads the Address of szUserInput into x0
      bl  putstring                   // Display the Prompt to the Console

      ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
      mov x1, BUFFER                  // Loads the Buffer amount into x1
      bl  getstring                   // Get the String and Store 

      LDR X0,=szBuffer     // Loads the Address of szBuffer into x0
      MOV W1, #10         // stores \n
      BL string_push_char  // returns new allocated string with char pushed back

      MOV X20, X0   // store the new string

      MOV X0, X19      // set param for index
      MOV X1, X20      // set param for new string
      BL edit_string

      LDR X0,=chCr  // Loads the Address of chCr into x0
      BL  putch     // Display the newline characther to the console
      b Menu                          // Loop back to the Menu

      //-----------------------------------------------------------------------------------------------

    //---Option 5 - Search Strings-------------------------------------------------------------------
    Option5:
    
      //-------Get User Input -----------------------------------------------------
      ldr x0,=szUserInput4              // Loads the Address of szUserInput4
      bl  putstring                     // Displays the Prompt to the Console
      ldr x0,=szBuffer                  // Loads the Address of szBuffer into x0
      mov x1, BUFFER                    // Loads the Buffer amount into x1
      bl  getstring                     // Get the String and Store 

      ldr x0,=szBuffer
      bl Search

      ldr x0,=iIndex                // Loads the Address of iIndex into x0
      mov x1, #0                    // x1 = 0
      str x1, [x0]                  // Store the 0 into iIndex - Reset iIndex

      ldr x0,=chCr                    // Loads the Address of chCr into x0
      bl  putch                       // Display the newline characther to the console

      b Menu                          // Loop back to the Menu
      //=---------------------------------------------------------------------------

    //---Option 5 - Search Strings-------------------------------------------------------------------
    Option6:
      BL save_file
    
      ldr x0,=chCr                    // Loads the Address of chCr into x0
      bl  putch                       // Display the newline characther to the console

      b Menu                          // Loop back to the Menu
      //=---------------------------------------------------------------------------

    //-----------------------------------------------------------------------------------------------
    invalid_option:
      LDR X0, =szErrorInvalidOption     // Loads the Address of szErrorInvalidOption
      BL  putstring                     // Displays the Prompt to the Console
      B Menu

  exit_program:
    BL free_list

    MOV   X0, #0   						// Use 0 return code
    MOV   X8, #93  						// Service Command Code 93 terminates this program
    SVC   0        						// Call linux to terminate the program
