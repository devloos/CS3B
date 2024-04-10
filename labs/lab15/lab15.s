// Programmer: Carlos Aguilera
// Lab #15
// Purpose: 
//    Create assembly program to read the integer values in the input.txt 
//    file and store them into an integer array. Provide a memory dump of the array.
// Author: Carlos Aguilera
// Date Last Modified: 04/09/24

// set global start as the main entry
  .global _start

  .equ buffer, 1
  .equ intBuffer, 11 // only 11 because largest integer we can store is 2^31
  .equ dfd, -100
  .equ mode, 0100
  .equ permissions, 0660

  .data
    szFilename: .asciz "input.txt"
    szInt:      .skip intBuffer
    szBuffer:   .skip buffer
    dbArray:    .quad   0, 0, 0, 0, 0, -100
    chCr:       .byte   10
  .section .text

_start:
  MOV X0, #dfd          // mov dfd (current directory) into X0
  LDR X1, =szFilename   // load the address of filename into X0
  MOV X2, #mode         // load mode into X0
  MOV X3, #permissions  // give read write perms
  MOV X8, #56           // sys call openat
  SVC #0                // call sys

  MOV X19, X0  // store file descriptor

  MOV X20, #0  // our index for szInt
  MOV X21, #0  // our index for szInt
  read_loop:
    MOV X0, X19        // get file descriptor set it to second param of write sys call
    LDR X1, =szBuffer  // load the address of szString into X0
    MOV X2, #buffer        // move the value of 15 into X2
    MOV X8, #63        // sys call write
    SVC #0             // call sys

    # Check for EOF
    CMP X0, #0
    B.EQ read_loop_end

    LDR X0, =szBuffer  // load the address of szString into X0
    LDRB W0, [X0]      // only need one byte from what was stored in szBuffer
    CMP W0, #10        // W0 - 10 is it a new line if so handle int
    B.EQ handle_int

    LDR X1, =szInt // load the address of szBuffer into X0
    STRB W0, [X1, X20]

    ADD X20, X20, #1
    B read_loop

    handle_int:
      LDR X1, =szInt // load the address of szBuffer into X0
      MOV W0, #0     // we are putting null terminator

      ADD X20, X20, #1    // add one to index
      STRB W0, [X1, X20]  // store null terminator

      LDR X0, =szInt // load the address of szBuffer into X0
      BL ascint64

      LDR X1, =dbArray   // load the address of szBuffer into X0
      STR X0, [X1, X21]  // store null terminator

      MOV X20, #0  // reset szInt index
      ADD X21, X21, #1
      B read_loop
  read_loop_end:

  MOV X0, X19    // get file descriptor
  MOV X8, #0x39  // sys call close
  SVC #0         // call sys

  MOV  X0, #0   // Setup the parameters to exit the program
  MOV  X8, #93  // and then call Linux to do it.

  SVC  0 // use 0 return code
