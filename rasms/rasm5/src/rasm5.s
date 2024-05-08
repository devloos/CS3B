//*****************************************************************************
// Name: Carlos Aguilera
// Program: RASM5.s
// Class: CS 3B
// Lab: RASM5
// Date: May 07, 2024 at 8:00 PM
// Purpose:
//      For this assignment, you will create a Menu driven program in C/C++ that
//      executes the following menu. The assignment aims to demonstrate calling
//      Assembly language macros from C/C++.  Do not load automatically, only via
//      the menu.
//*****************************************************************************

// set global start as the main entry
.global _main

.equ BUFFER, 512

.section .data

  szBuffer:         .skip     BUFFER
  szTemp:           .skip     BUFFER                                            //Hold previous changes
  szUserInput:      .asciz    "Enter a choice: "

  szErrorInvalidOption:  .asciz "[ERROR]: Invalid option choose again.\n\n"

  chTab:            .ascii    "\t"
  iIndex:           .word     0
  szIndex:          .skip     BUFFER
  dbCounter:         .quad     0

  chCr: .byte 10

.section .text

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

_main:

  Menu:
    BL print_menu // prints menu

    ldr x0,=chCr                    // Loads the Address of chCr into x0
    bl  putch                       // Display the newline characther to the console

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
    b.eq exit_program        // Branch and link to option5

    // if it gets here input was not a valid option
    B option_invalid


    Option1:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    Option2:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    Option3:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    Option4:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    Option5:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    Option6:

      B   Menu // display menu again
    //-----------------------------------------------------------------------------------------------

    //-----------------------------------------------------------------------------------------------
    option_invalid:
      LDR X0, =szErrorInvalidOption     // Loads the Address of szErrorInvalidOption
      BL  putstring                     // Displays the Prompt to the Console
      B Menu

  exit_program:
    MOV   X0, #0   						// Use 0 return code
    MOV   X8, #93  						// Service Command Code 93 terminates this program
    SVC   0        						// Call linux to terminate the program
