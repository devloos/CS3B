.global bubble_sort
.global insertion_sort

.equ BUFFER, 512

.data
  szBuffer:         .skip     BUFFER
  szAsmBubbleSort:     .asciz    "ASM BUBBLE SORT!"
  szAsmInsertionSort:     .asciz    "ASM INSERTION SORT!"
  chCr: .byte 10

.text

bubble_sort:
  STR X30, [SP, #-16]! 			// push link register onto the stack
  STR X19, [SP, #-16]! 			// push link register onto the stack
  STR X20, [SP, #-16]! 			// push link register onto the stack

  MOV X19, X0  // move starting address of array
  MOV X20, X1  // move length of array into X20
  MOV X0, #8
  MUL X20, X20, X0

  MOV X0, #0            // set counter i
  bubble_sort_loop:
    CMP X0, X20          // is i < length
    B.GE bubble_sort_loop_end

    MOV X1, #0          // set up our j counter
    SUB X2, X20, X0    
    SUB X2, X2, #8
    bubble_sort_inner_loop:
      CMP X1, X2          // is j < length - i - 1
      B.GE bubble_sort_inner_loop_end

      MOV X3, X1      // set j + 1
      ADD X3, X3, #8

      LDR X4, [X19, X3]   // X4 = arr[j + 1]
      LDR X5, [X19, X1]   // X5 = arr[j]

      CMP X4, X5      // is X4 >= X5
      B.GE bubble_sort_inner_loop_continue

      STR X4, [X19, X1]   // a[j] = a[j + 1]
      STR X5, [X19, X3]   // a[j + 1] = temp

    bubble_sort_inner_loop_continue:
      ADD X1, X1, #8   // ++j
      B bubble_sort_inner_loop
    bubble_sort_inner_loop_end:

    ADD X0, X0, #8    // ++i
    B bubble_sort_loop
  bubble_sort_loop_end:

  LDR X20, [SP], #16 			// pop link register off the stack
  LDR X19, [SP], #16 			// pop link register off the stack
  LDR X30, [SP], #16 			// pop link register off the stack
  RET

insertion_sort:
  STR X30, [SP, #-16]! 			// push link register onto the stack
  STR X19, [SP, #-16]! 			// push link register onto the stack
  STR X20, [SP, #-16]! 			// push link register onto the stack

  MOV X19, X0  // move starting address of array
  MOV X20, X1  // move length of array into X20

  LDR X20, [SP], #16 			// pop link register off the stack
  LDR X19, [SP], #16 			// pop link register off the stack
  LDR X30, [SP], #16 			// pop link register off the stack
  RET
