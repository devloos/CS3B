// Programmer: Carlos Aguilera
// Linked List Class
// Purpose: 
//     Manage all our linked list needs
// Author: Carlos Aguilera and Shiv
// Date Last Modified: 04/20/24

// set global start as the main entry
  .global get_head
  .global get_tail
  .global get_size
  .global insert
  .global foreach
  .global isEmpty
  .global deleteNode
  .global free_list

  .data
    headPtr:    .quad  0
    tailPtr:    .quad  0
    size:       .quad  0
  .section .text

//                NODE -> also has address
// ------------------------------------------------------
// |       *DATA              |         *NEXT           |
// | 00 00 00 00 00 00 00 00  | 00 00 00 00 00 00 00 00 |
// ------------------------------------------------------

// Subroutine get_head:
//      returns head pointer in X0
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.
get_head:
  STR X30, [SP, #-16]! // push link register onto the stack

  LDR X0, =headPtr    // load the address of headPtr into X0

  LDR X30, [SP], #16  // pop link register off the stack
  RET                 // return from function

// Subroutine get_tail:
//      returns tail pointer in X0
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.
get_tail:
  STR X30, [SP, #-16]! // push link register onto the stack

  LDR X0, =tailPtr    // load the address of headPtr into X0

  LDR X30, [SP], #16  // pop link register off the stack
  RET                 // return from function

// Subroutine inser:
// insert node into the back of the list
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

// Subroutine get_size:
//      get size of linked list and store in X0
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.
get_size:
  STR X30, [SP, #-16]! // push link register onto the stack

  LDR X0, =size    // load the address of headPtr into X0
  LDR X0, [X0]

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


//  Subroutine for isEmpt:
//         Returns True (1) or False (0) if the linkedlist is empty in x0
isEmpty:
  str x30, [SP, #-16]!            // Push the Link Register onto the Stack

  ldr x0,=headPtr                 // Loads the Address of headPtr into x0    
  ldr x0, [x0]    
  cmp x0, #0                      // If the HeadPtr is pointing to nothing that the list is empty
  b.eq   trueEmptyLinkList        // Branch to emptyLinkList if the list is empty

  falseEmptyLinkList:
      mov x0, #0                  // If emptyLinkList is false then put 0 into x0 and return
      ldr x30, [SP], #16          // Pop the Link Register Off the Stack
      ret                         // Return
  trueEmptyLinkList:
      mov x0, #1                  // If true emptyLinkList then put 1 into x0 and return
      ldr x30, [SP], #16          // Pop the Link Register off the Stack
      ret                         // Return


// Subroutine for deleteNode:
deleteNode:
  str x30, [SP, #-16]!      // Push the Link Register onto the stack
  str x19, [SP, #-16]!      // Push x19 onto the stack

  mov x19, x0               // Saves a copy of the user input index

  //----Check If Empty---------------------------------------------
  bl isEmpty                // Branch and Link to isEmpty
  cmp x0, #1                // Check if x0 equal 1 (list is empty)
  b.eq endDeleteNode        // If true, endDeleteNode and branch to the label 
  //---------------------------------------------------------------
  // X5 is the counter
  mov x5, #0
  ldr x0,=headPtr       // Load the Address of headPtr into x0
  deleteNodeLoop:
      cmp x19, x5           // is the counter equal to the user index
      b.eq  nodeFound       // Branch to this Label
      ldr x0, [x0]          // Load the value which is an Address of headPtr
      add x0, x0, #8        // Load the Address of the nextPtr into x0
      add x5, x5, #1        // x5++;
      b deleteNodeLoop      // Loop Again
  
  //----Node Found--------------------------------------------------
  nodeFound:
      // stitching
      ldr x1, [x0]          // Load Whatever is in the nextPtr of the node into x1
      add x1, x1, #8        // add 8 and get the nextPtr of that Node
      ldr x2, [x1]          // Get the address of the next next Node
      str x2, [x0]          // Set the Previous Node equal to the next next Node
      sub x1, x1, #8        // Subtract to get the address back of the node that needs to be freed now

      MOV X19, X1       // store node
      LDR X0, [X1]      // load the string adr
      BL free           // free string

      mov x0, x19       // load node
      bl free           // free that memory space
  //----------------------------------------------------------------
  endDeleteNode:
      ldr x19, [SP], #16        // Pop x19 off the stack
      ldr x30, [SP], #16        // Pop the Link Register off the stack
      ret                       // Return

free_list:
  STR X30, [SP, #-16]! // push link register onto the stack

  LDR X0, =headPtr  // load the address of headPtr into X1
  LDR X0, [X0]      // load the value at the address stored by X1 into X1

  free_list_inner:
    CMP X0, 0         // compare X1 and 0 if equal then branch to push_empty_list
    B.EQ free_list_return

    STR X0, [SP, #-16]! // push X0 onto the stack

    LDR X0, [X0]      // load the value at the address stored by X1 into X1
    BL free

    LDR X0, [SP], #16  // pop X0 off the stack

    LDR X19, [X0, #8]  // load into x1 the value of next*
    STR X19, [SP, #-16]! // push X0 onto the stack

    BL free

    LDR X0, [SP], #16  // pop X0 off the stack

    B free_list_inner

  free_list_return:
    LDR X30, [SP], #16  // pop link register off the stack
    RET                 // return from function