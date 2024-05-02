//*****************************************************************************
// Name: Carlos Aguilera
// Program: String2.s
// Class: CS 3B
// Date: March 30, 2024 at 9:04 PM
// Purpose:
//     Some sicko string operations
//*****************************************************************************

  .global String_toLowerCase
  .global String_toUpperCase
  .global String_indexOf_1
  .global String_indexOf_2
  .global String_indexOf_3
  .global String_lastIndexOf_1
  .global String_lastIndexOf_2
  .global String_lastIndexOf_3
  .global String_replace

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
// Subroutine String_toLowerCase:
//      return the string pointed by X0 but lower case
// X0: Must contain null terminated string
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_toLowerCase:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0  // move the address of the first string into X4

  MOV X0, X19  // move the address of the first string into X4
  BL String_length

  MOV  X0, X0 // move the value of 16 into X0
  BL   malloc // branch link to malloc 

  MOV X1, #0  // move 0 into X5
  toLowerCase_loop:
    LDRB W2, [X19, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ toLowerCase_loop_end  // branch if equal to

    // if W2 >= 65 && <= 90
    CMP W2, #65
    B.LT toLowerCase_continue

    CMP W2, #90
    B.GT toLowerCase_continue

    // condition was true
    ADD W2, W2, #32  // increment X4 by one

    toLowerCase_continue:
      STRB W2, [X0, X1]
      ADD X1, X1, #1  // increment X4 by one

    B toLowerCase_loop
  toLowerCase_loop_end:

  MOV W2, #0         // set W2 equal to 0
  STRB W2, [X0, X1]  // set null terminating character

  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET

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

// String_indexOf_1 helper function
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
index_of_char:
  STR X30, [SP, #-16]! // push link register onto the stack

  index_of_char_loop:
    LDRB W3, [X0, X2]          // load the value at the address X4 with offset X5
    CMP W3, 0                  // X6 - 0 and set CPSR register
    B.EQ index_of_char_end    // branch if equal to

    // if W2 == character
    CMP W3, W1
    B.NE index_of_char_continue

    // we have found character return index
    MOV X0, X2
    LDR X30, [SP], #16   // pop link register off the stack
    RET

    index_of_char_continue:
      ADD X2, X2, #1  // increment X2 by one

    B index_of_char_loop
  index_of_char_end:

  MOV X0, -1         // set W2 equal to 0

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_1:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_indexOf_1:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, #0  // set starting point to zero
  BL index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_2:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_indexOf_2:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, X2  // set starting point to zero
  BL index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_indexOf_3:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain string to match against also null terminated
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.

// Psuedo
// index = 0
// for each char0 in x0
//   char0 = x0[index]
//   if char0 == \0
//     return -1

//   inner_index = 0
//   matched = true
//   for_each_matched_character
//       if [x0, index + inner_index] != [x1, inner_index]
//         matched = false
//         break
  
//   if matched:
//     return index
  
//   ++index
String_indexOf_3:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the value of x0 into x19
  MOV X20, X1  // move the value of x1 into x20

  MOV X0, #0  // move the value of 0 into X0 (this is our index)
  indexOf_3_loop:
    LDRB W1, [X19, X0]          // load the value at the address X4 with offset X5
    CMP W1, 0                  // X6 - 0 and set CPSR register
    B.EQ indexOf_3_end    // branch if equal to

    MOV X1, #0  // move the value of 0 into x1 this is our inner index
    MOV X2, #1  // this is our matched variable set to true

    indexOf_3_inner_loop:
      LDRB W3, [X20, X1]             // load the value at the address X4 with offset X5
      CMP W3, 0                      // X6 - 0 and set CPSR register
      B.EQ indexOf_3_inner_loop_end  // branch if equal to

      ADD X3, X0, X1      // add both inner and index
      LDRB W4, [X19, X3]  // load the value at the address X4 with offset X5
      LDRB W5, [X20, X1]  // load the value at the address X4 with offset X5

      CMP W4, W5  // W4 - W5 and store result into the CPSR register
      B.EQ indexOf_3_inner_loop_continue

      // they did not equal lets break and set matched to false
      MOV X2, #0  // set X2 equal to false
      B indexOf_3_inner_loop_end

      indexOf_3_inner_loop_continue:
        ADD X1, X1, #1  // increment inner_index by one
        B indexOf_3_inner_loop
    indexOf_3_inner_loop_end:

    CMP X2, #1  // is matched true
    B.EQ indexOf_3_return

    ADD X0, X0, #1  // increment index by one
    B indexOf_3_loop
  indexOf_3_end:

  MOV X0, -1  // no string found 

  indexOf_3_return:
    LDR X20, [SP], #16   // pop X20 off the stack
    LDR X19, [SP], #16   // pop X19 off the stack
    LDR X30, [SP], #16   // pop link register off the stack

    RET

// String_lastIndexOf helper function
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
last_index_of_char:
  STR X30, [SP, #-16]! // push link register onto the stack

  last_index_of_char_loop:
    CMP X2, 0                  // X6 - 0 and set CPSR register
    B.EQ last_index_of_char_end    // branch if equal to

    LDRB W3, [X0, X2]          // load the value at the address X4 with offset X5

    // if W2 == character
    CMP W3, W1
    B.NE last_index_of_char_continue

    // we have found character return index
    MOV X0, X2
    LDR X30, [SP], #16   // pop link register off the stack
    RET

    last_index_of_char_continue:
      SUB X2, X2, #1  // sub X2 by one

    B last_index_of_char_loop
  last_index_of_char_end:

  MOV X0, -1         // set W2 equal to 0

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_1:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_1:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0
  MOV X20, X1

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  MOV X2, X0  // set starting point to zero
  MOV X0, X19  // move string into X0
  MOV X1, X20  // set params
  BL last_index_of_char

  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X19, [SP], #16   // pop link X19 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_2:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain char to match against
// X2: Must contain starting point
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_2:
  STR X30, [SP, #-16]! // push link register onto the stack

  MOV X0, X0  // move string into X0
  MOV X1, X1  // set params
  MOV X2, X2  // set starting point to zero
  BL last_index_of_char

  LDR X30, [SP], #16   // pop link register off the stack

  RET

// Subroutine String_lastIndexOf_3:
//      return the index of the found char otherwise return -1
// X0: Must contain null terminated string
// X1: Must contain string to match against also null terminated
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_lastIndexOf_3:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack

  MOV X19, X0  // move the value of x0 into x19
  MOV X20, X1  // move the value of x1 into x20

  MOV X0, X19  // move the address of the first string into X4
  BL count_bytes

  SUB X0, X0, #1
  MOV X0, X0  // move the value of 0 into X0 (this is our index)
  lastIndexOf_3_loop:
    CMP X0, 0                  // X6 - 0 and set CPSR register
    B.LT lastIndexOf_3_end    // branch if equal to

    STR X0, [SP, #-16]! // push X20 onto the stack
    MOV X0, X20  // move the address of the first string into X4
    BL count_bytes

    SUB X0, X0, #1
    MOV X1, X0
    LDR X0, [SP], #16   // pop X20 off the stack

    MOV X2, #1  // this is our matched variable set to true
    MOV X6, #0  // inner index loop

    lastIndexOf_3_inner_loop:
      CMP X1, 0                  // X6 - 0 and set CPSR register
      B.LT lastIndexOf_3_inner_loop_end    // branch if equal to

      SUB X3, X0, X6      // add both inner and index
      LDRB W4, [X19, X3]  // load the value at the address X4 with offset X5
      LDRB W5, [X20, X1]  // load the value at the address X4 with offset X5

      CMP W4, W5  // W4 - W5 and store result into the CPSR register
      B.EQ lastIndexOf_3_inner_loop_continue

      // they did not equal lets break and set matched to false
      MOV X2, #0  // set X2 equal to false
      B lastIndexOf_3_inner_loop_end

      lastIndexOf_3_inner_loop_continue:
        SUB X1, X1, #1  // decrement inner_index by one
        ADD X6, X6, #1  // increment inner index by one
        B lastIndexOf_3_inner_loop
    lastIndexOf_3_inner_loop_end:

    CMP X2, #1  // is matched true
    B.NE lastIndexOf_3_continue

    SUB X6, X6, #1
    SUB X0, X0, X6
    B lastIndexOf_3_return

    lastIndexOf_3_continue:
      SUB X0, X0, #1  // increment index by one
      B lastIndexOf_3_loop
  lastIndexOf_3_end:

  MOV X0, -1  // no string found 

  lastIndexOf_3_return:
    LDR X20, [SP], #16   // pop X20 off the stack
    LDR X19, [SP], #16   // pop X19 off the stack
    LDR X30, [SP], #16   // pop link register off the stack

    RET

// Subroutine String_replace:
//      return new allocated string with replaced char if found
// X0: Must contain null terminated string
// X1: Must contain old char to match against
// X2: Must contain new char to replace
// LR: Must contain the return address
// All AAPCS required registers are preserved,  X19-X29 and SP.
String_replace:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X20, [SP, #-16]! // push X20 onto the stack
  STR X21, [SP, #-16]! // push X21 onto the stack

  MOV X20, X1  // store old char
  MOV X21, X2  // store new char

  BL string_copy

  MOV X1, #0  // move 0 into X5
  replace_loop:
    LDRB W2, [X0, X1]          // load the value at the address X4 with offset X5
    CMP W2, 0                  // X6 - 0 and set CPSR register
    B.EQ replace_loop_end  // branch if equal to

    CMP W2, W20
    B.NE replace_loop_continue

    STRB W21, [X0, X1]  // given index of old char replace with new char

    replace_loop_continue:
      ADD X1, X1, #1  // increment X4 by one
      B replace_loop
  replace_loop_end:

  LDR X21, [SP], #16   // pop link X21 off the stack
  LDR X20, [SP], #16   // pop link X20 off the stack
  LDR X30, [SP], #16   // pop link register off the stack

  RET


