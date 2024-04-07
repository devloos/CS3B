//*****************************************************************************
// Name: Carlos Aguilera
// Program: String2.s
// Class: CS 3B
// Date: March 30, 2024 at 9:04 PM
// Purpose:
//    DO SOMETHING LOL
//*****************************************************************************

  .global String_concat

  .section .data

  szBuffer:  .skip 21

  chCr: .byte 10

  .section .text

// String_concat helper function
concat_count_bytes:
  MOV X4, #0  // move 0 into X5
  count_bytes_loop:
    LDRB W5, [X3, X4]          // load the value at the address X4 with offset X5
    CMP W5, 0                  // X6 - 0 and set CPSR register
    B.EQ count_bytes_loop_end  // branch if equal to

    ADD X4, X4, #1  // increment X4 by one
    B count_bytes_loop
  count_bytes_loop_end:

  RET  // return

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

  MOV X2, #0   // move 0 into X2
  MOV X3, X19  // move the address of the first string into X4
  BL concat_count_bytes

  ADD X2, X2, X4  // X2 = X2 + X4

  MOV X3, X20  // move the address of the first string into X4
  BL concat_count_bytes

  ADD X2, X2, X4  // X2 = X2 + X4
  ADD X2, X2, #1  // X2 = X2 + 1 (for null terminator)

  MOV  X0, X2 // move the value of 16 into X0
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
