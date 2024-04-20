// Programmer: Carlos Aguilera
// Lab #16
// Purpose: 
//     This lab is meant to help you get started with RASM-4 and linked list.
// Author: Carlos Aguilera
// Date Last Modified: 04/16/24

// set global start as the main entry
  .global _start

  .data
    headPtr:  .quad  0
    tailPtr:  .quad  0
  .section .text

// ------------------------------------------------------
// |       *DATA              |         *NEXT           |
// | 00 00 00 00 00 00 00 00  | 00 00 00 00 00 00 00 00 |
// ------------------------------------------------------

// Subroutine push:
//      push back node into list
// X0: Must contain the address of data
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.
insert:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0 // store X0 into X19
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X0, #16 // move 16 into X0
  BL malloc   // branch link into malloc

  LDR X19, [SP], #16 // pop X19 off the stack

  // X0 holds the node address
  // X19 holds the data address

  // HERE IS WHERE WE STORE THE DATA IN THE NODE
  STR X19, [X0]  // set the data address

  LDR X1, =headPtr  // load the address of headPtr into X1
  LDR X1, [X1]      // load the value at the address stored by X1 into X1
  CMP X1, 0         // compare X1 and 0 if equal then branch to push_empty_list
  B.EQ insert_empty_list

  LDR X1, =tailPtr  // load the address of tailPtr into X1
  LDR X1, [X1]
  STR X0, [X1, #8]      // load the value at the address stored by X1 into X1

  LDR X1, =tailPtr  // load the address of tailPtr into X1
  STR X0, [X1]      // load the value at the address stored by X1 into X1

  B insert_return

  insert_empty_list:
    LDR X1, =headPtr  // load the address of headPtr into X1
    STR X0, [X1]      // load the value at the address stored by X1 into X1

    LDR X1, =tailPtr  // load the address of tailPtr into X1
    STR X0, [X1]      // load the value at the address stored by X1 into X1

  insert_return:
    LDR X19, [SP], #16  // pop X19 off the stack
    LDR X30, [SP], #16  // pop link register off the stack
    RET                 // return from function

// Subroutine foreach:
//      for each every node in the linked list
// X0: Must contain the address of the callback
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.
foreach:
  STR X30, [SP, #-16]! // push link register onto the stack
  STR X19, [SP, #-16]! // push X19 onto the stack

  MOV X19, X0 // store X0 into X19

  LDR X0, =headPtr  // load the address of headPtr into X1
  LDR X0, [X0]      // load the value at the address stored by X1 into X1

  foreach_inner:
    CMP X0, 0         // compare X1 and 0 if equal then branch to push_empty_list
    B.EQ foreach_return

    STR X0, [SP, #-16]! // push X0 onto the stack

    LDR X0, [X0]      // load the value at the address stored by X1 into X1
    BLR X19           // branch link to the callback given in X19

    LDR X0, [SP], #16  // pop X0 off the stack

    LDR X0, [X0, #8]  // load into x1 the value of next*
    B foreach_inner

  foreach_return:
    LDR X19, [SP], #16  // pop X19 off the stack
    LDR X30, [SP], #16  // pop link register off the stack
    RET                 // return from function

