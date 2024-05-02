//*****************************************************************************
// Name: Carlos Aguilera
// Program: carlos-functions.s
// Class: CS 3B
// Date: April 20, 2024 at 10:20 AM
// Purpose:
//     Some sicko string operations
//*****************************************************************************

.global load_from_file

.equ BUFFER, 512
.equ dfd, -100
.equ mode, 0100
.equ permissions, 0660

.data
  szUserInputFile:  .asciz    "Filename: "
  szBuffer:         .skip     BUFFER

.section .text

getline:
  STR X30, [SP, #-16]! 			// push link register onto the stack
  STR X19, [SP, #-16]! 			// push link register onto the stack
  STR X20, [SP, #-16]! 			// push link register onto the stack

  MOV X19, X0   // move file descriptor into X19

  MOV X20, #0   // start at index 0
  getline_loop:
    MOV X0, X19        // get file descriptor set it to second param of write sys call
    LDR X1, =szBuffer  // load the address of szString into X0
    ADD X1, X1, X20    // offset szBuffer
    MOV X2, #1        // read only one byte
    MOV X8, #63        // sys call read
    SVC #0             // call sys

    # Check for EOF
    CMP X0, #0
    B.EQ end_of_file

    // check if end of line
    LDR X0, =szBuffer  // load the address of szString into X0
    LDRB W0, [X0, X20] // store null term at end of szBuffer
    CMP W0, #10
    B.EQ getline_loop_end

    ADD X20, X20, #1
    B getline_loop

    end_of_file:
      MOV X0, 0  // move into X0 0 to indicate end of file
      B getline_return

  getline_loop_end:
    LDR X0, =szBuffer  // load the address of szString into X0
    ADD X20, X20, #1   // add one more for our null term
    MOV W1, #0         // store null term in W1
    STRB W1, [X0, X20] // store null term at end of szBuffer

    LDR X0, =szBuffer  // load the address of szString into X0
    BL string_copy

  getline_return:
    LDR X20, [SP], #16 			// pop link register off the stack
    LDR X19, [SP], #16 			// pop link register off the stack
    LDR X30, [SP], #16 			// pop link register off the stack

    RET


load_from_file:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  LDR x0,=szUserInputFile   // Loads the Address of szUserInputFile
  BL  putstring          // Displays the Prompt to the Console

  LDR X0,=szBuffer     // Loads the Address of szBuffer into x0
  MOV X1, BUFFER       // Loads the Buffer amount into x1
  BL  getstring        // Get the String and Store 

  MOV X0, #dfd          // mov dfd (current directory) into X0
  LDR X1, =szBuffer   // load the address of filename into X0
  MOV X2, #mode         // load mode into X0
  MOV X3, #permissions  // give read write perms
  MOV X8, #56           // sys call openat
  SVC #0                // call sys

  MOV X19, X0  // store file descriptor

  load_from_file_loop:
    MOV X0, X19  // store file descriptor
    BL getline

    CMP X0, #0               // check if end of file
    B.EQ load_from_file_loop_end

    MOV X0, X0  // move allocated string into x0
    BL insert
    B load_from_file_loop

  load_from_file_loop_end:

  MOV X0, X19    // get file descriptor
  MOV X8, #0x39  // sys call close
  SVC #0         // call sys   

  LDR X30, [SP], #16 			// pop link register off the stack

  RET