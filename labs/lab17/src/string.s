.global string_length

string_length:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // set string pointer
  MOV X1, #0  // move 0 into X5
  string_length_loop:
    LDRB W2, [X0, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ string_length_loop_end  // branch if equal to

    ADD X1, X1, #1  // increment X4 by one
    B string_length_loop
  string_length_loop_end:

  MOV X0, X1

  LDR X30, [SP], #16   // pop link register off the stack

  RET  // return  .global String_replace
