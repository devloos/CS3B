//*****************************************************************************
// Name: Carlos Aguilera
// Program: String_toUpperCase.s
// Class: CS 3B
// Date: April 30, 2024 at 4:38 PM
// Purpose:
//     Some sicko string operations
//*****************************************************************************

  .global String_toUpperCase
  .global copy_string

  .section .text

// global helper function
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

// global helper function
copy_string:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0  // move the address of the first string into X4

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  MOV  X0, X0 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  copy_string_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ copy_string_loop_end  // branch if equal to

    STRB W2, [X0, X1]
    ADD X1, X1, #1  // increment X4 by one

    B copy_string_loop
  copy_string_loop_end:

  MOV W2, #0
  STRB W2, [X0, X1]

  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET  // return

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
