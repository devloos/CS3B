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

  .equ BUFFER, 512

  .section .data

  szBuffer:         .skip     BUFFER
  szStudents:		    .asciz		"Students: Shiv Patel and Carlos Aguilera"
  szClass:			    .asciz		"Class: CS3B"
  szProject:		    .asciz		"Project: RASM4"
  szDate:			      .asciz		"04/20/2024"
  szUserInput:      .asciz    "Enter a choice: "
  szUserInput2:     .asciz    "Press Enter to Return: "
  szUserInput3:     .asciz    "Enter the index to be deleted: "
  szUserInput4:     .asciz    "What are you looking for: "
  szClearScreen:    .asciz    "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  szOption1:        .asciz    "<1> View all Stirngs"
  szOption3:        .asciz    "<3> Delete String "
  szOption5:        .asciz    "<5> String Search"
  szOption7:        .asciz    "<7> Quit"
  szPrintEmpty:     .asciz     "[EMPTY]"
  data1:            .asciz     "The Cat in the Hat"
  data2:            .asciz     "By Dr. Seuss"
  data3:            .asciz     "The sun did not shine."
  data4:            .asciz     "It was too wet to play."
  data5:            .asciz     "So we sat in the house"
  data6:            .asciz     "All that cold, cold, wet day."
  data7:            .asciz      "\n"
  data8:            .asciz      "I sat there with Sally."
  data9:            .asciz      "We sat there, we two"
  data10:           .asciz      "We had something to do!"
  chLeftBracket:    .ascii    "["
  chRightBracket:   .ascii    "]"
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

  // Print the string from the node
  mov x0, x19                           // Move the copy address back into x0
  bl putstring                          // Display the string

  // Print a newline
  ldr x0, =chCr                         // Load the address of the newline character
  bl putch                              // Display the newline

  // Increment and store the index
  ldr x0, =iIndex                       // Load the address of iIndex
  ldr w1, [x0]                          // Load the current index value
  add w1, w1, #1                        // Increment the index
  str w1, [x0]                          // Store the incremented index back to iIndex

  LDR X30, [SP], #16                    // Pop the Link Register off the stack
  ADR x19, printStringWithIndexAndNewLine  // Making sure the CallBack function doesn't change
  RET                                   // Return from the functionn
//---------------------------------------------------------------------------------------------------------


_main:

  // Test Information

  ldr x0,=data1
  bl insert
  ldr x0,=data2
  bl insert
  ldr x0,=data3
  bl insert
  ldr x0,=data4
  bl insert
  ldr x0,=data5
  bl insert
  ldr x0,=data6
  bl insert
  ldr x0,=data7
  bl insert
  ldr x0,=data8
  bl insert
  ldr x0,=data9
  bl insert
  ldr x0,=data10
  bl insert


  // Print the Header Information  -----------------------------------------------------------------

  ldr x0,=szStudents               // Loads the Address of szStudents into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szClass               // Loads the Address of szClass into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szProject               // Loads the Address of szProject into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szDate               // Loads the Address of szDate into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console


  //------------------------------------------------------------------------------------------------


  //----- Print Menu -------------------------------------------------------------------------------
  Menu:
  ldr x0,=szOption1                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption3               // Loads the Address of szOption3 into x0
  bl  putstring                   // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption5               // Loads the Address of szOption5 into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption7               // Loads the Address of szOPtion7 into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console


  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  //------------------------------------------------------------------------------------------------

  //---Get Data from User Keyboard------------------------------------------------------------------

  ldr x0,=szUserInput             // Loads the Address of szUserInput into x0
  bl  putstring                   // Display the Prompt to the Console

  ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
  mov x1, BUFFER                  // Loads the Buffer amount into x1
  bl  getstring                   // Get the String and Store 
  ldr x0,=szBuffer                // Loads the Address of szBuffer into x0
  bl  ascint64                    // Conver the user input into a number to compare

  cmp x0, #1                      // Check if user entered option 1
  b.eq Option1                    // Branch and link to Option1

  cmp x0, #3                      // Check if user entered option 3
  b.eq Option3                    // Branch and link to Option3

  cmp x0, #5                      // Check if user enetered option 5
  b.eq Option5                    // Branch and link to option5

  cmp x0, #7                      // Check if user entered option7
  b.eq Option7                    // branch and link to option 7

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
            //Line Feed
            ldr x0,=chCr                      // Loads the Address of chCr into x0
            bl  putch                         // Display the newline characther to the console
          
        endOption1:
            ldr x0,=szUserInput2              // Loads the address of szUserInput2
            bl  putstring                     // Displays the prompt to the Screen
            ldr x0,=szBuffer                  // Loads the Address of szBuffer into x0
            mov x1, BUFFER                    // Loads the Buffer amount into x1
            bl  getstring                     // Get the String and Store 
            
            ldr x0,=szBuffer                  // Loads into x0 szBuffer
            ldr x0, [x0]                      // Loads the Value of szBuffer into x0
            cmp x0, #0                        // If it equals to 0
            b.eq clearOption1                 // Branch to this Label
            b endOption1                      // Get the Input Again


            clearOption1:
                ldr x0,=szClearScreen         // Loads the Address of szClearScreen into x0
                bl  putstring                 // Display this to the console
                ldr x0,=iIndex                // Loads the Address of iIndex into x0
                mov x1, #0                    // x1 = 0
                str x1, [x0]                  // Store the 0 into iIndex - Reset iIndex
                b   Menu                      // Display the Menu again 
  //-----------------------------------------------------------------------------------------------

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

      //-----------------------------------------------------------------------------------------------

    //---Option 5 - Search Strings-------------------------------------------------------------------
    Option5:
    
    //-------Get User Input -----------------------------------------------------
    ldr x0,=szUserInput4              // Loads the Address of szUserInput4
    bl  putstring                     // Displays the Prompt to the Console
    ldr x0,=szBuffer                  // Loads the Address of szBuffer into x0
    mov x1, BUFFER                    // Loads the Buffer amount into x1
    bl  getstring                     // Get the String and Store 
    //=---------------------------------------------------------------------------

    
    //-----------------------------------------------------------------------------------------------



//---Option 7 - Quit-------------------------------------------------------------------------
Option7:
  MOV   X0, #0   						// Use 0 return code
  MOV   X8, #93  						// Service Command Code 93 terminates this program
  SVC   0        						// Call linux to terminate the program
