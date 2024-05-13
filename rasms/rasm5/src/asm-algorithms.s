.global bubble_sort
.global insertion_sort

.equ BUFFER, 512

.data
  szBuffer:         .skip     BUFFER
  szAsmBubbleSort:     .asciz    "ASM BUBBLE SORT!\n"
  szAsmInsertionSort:     .asciz    "ASM INSERTION SORT!\n"
  chCr: .byte 10

.text

bubble_sort:
  STR X30, [SP, #-16]! 			// push link register onto the stack
  STR X19, [SP, #-16]! 			// push link register onto the stack
  STR X20, [SP, #-16]! 			// push link register onto the stack

  MOV X19, X0  // move starting address of array
  MOV X20, X1  // move length of array into X20

  LDR X0, =szAsmBubbleSort
  BL putstring

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

  LDR X0, =szAsmInsertionSort
  BL putstring

  LDR X20, [SP], #16 			// pop link register off the stack
  LDR X19, [SP], #16 			// pop link register off the stack
  LDR X30, [SP], #16 			// pop link register off the stack
  RET
