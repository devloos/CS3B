  .global string_copy

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
