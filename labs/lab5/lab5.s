// Programmer: Carlos Aguilera
// Lab #5
// Purpose: print 100 - -10000 + 10000000 - -10000000000 = 10,010,010,100
// Author: Carlos Aguilera
// Date Last Modified: 02/04/24

// set global start as the main entry
  .global _start
  .section .text

_start:
  // ----------------- GET and SET DATA ------------------ //
  // Ask user to enter A
  LDR X0, =szAskA
  BL putstring

  // get user input
  LDR X0, =szA
  MOV X1, #21
  BL getstring

  // Ask user to enter B
  LDR X0, =szAskB
  BL putstring

  // get user input
  LDR X0, =szB
  MOV X1, #21
  BL getstring

  // Ask user to enter C
  LDR X0, =szAskC
  BL putstring

  // get user input
  LDR X0, =szC
  MOV X1, #21
  BL getstring

  // Ask user to enter D
  LDR X0, =szAskD
  BL putstring

  // get user input
  LDR X0, =szD
  MOV X1, #21
  BL getstring
  
  // ---------------- STORE DATA -------------------- //
  
  // load address of szA then branch link to ascint64
  // store return value into dbA
  LDR X0, =szA
  BL ascint64
  LDR X1, =dbA
  STR X0, [X1]

  // load address of szB then branch link to ascint64
  // store return value into dbB
  LDR X0, =szB
  BL ascint64
  LDR X1, =dbB
  STR X0, [X1]

  // load address of szC then branch link to ascint64
  // store return value into dbC
  LDR X0, =szC
  BL ascint64
  LDR X1, =dbC
  STR X0, [X1]

  // load address of szD then branch link to ascint64
  // store return value into dbD
  LDR X0, =szD
  BL ascint64
  LDR X1, =dbD
  STR X0, [X1]

  // ----------------- COMPUTE RESULT ------------------ //

  // store value of dbA into X0
  LDR X0, =dbA
  LDR X0, [X0]

  // store value of dbB into X1
  LDR X1, =dbB
  LDR X1, [X1]

  // store value of dbC into X2
  LDR X2, =dbC
  LDR X2, [X2]

  // store value of dbD into X3
  LDR X3, =dbD
  LDR X3, [X3]

  SUB X4, X0, X1 // X4 = X0 - X1
  SUB X5, X2, X3 // X5 = X2 - X3
  ADD X6, X4, X5 // X6 = X4 - X5  

  LDR X0, =dbSum
  STR X6, [X0]

  // ----------------- PRINT RESULT ------------------ //

  // print szA
  LDR X0, =szA
  BL putstring

  // print szSub
  LDR X0, =szSub
  BL putstring

  // print szB
  LDR X0, =szB
  BL putstring

  // print szPlus
  LDR X0, =szPlus
  BL putstring

  // print szC
  LDR X0, =szC
  BL putstring

  // print szSub
  LDR X0, =szSub
  BL putstring

  // print szD
  LDR X0, =szD
  BL putstring

  // print szEqual
  LDR X0, =szEqual
  BL putstring

  // store value of dbSum in X0 and convert into ascii
  LDR X0, =dbSum
  LDR X0, [X0]
  LDR X1, =szTemp
  BL int64asc

  LDR X0, =szTemp
  BL putstring

  LDR X0, =chCr
  BL putch

  MOV  X0, #0   // Setup the parameters to exit the program
  MOV  X8, #93  // and then call Linux to do it.

  SVC  0 // use 0 return code

  .data
  szA: .skip 21
  szB: .skip 21
  szC: .skip 21
  szD: .skip 21
  szTemp: .skip 21

  dbA: .quad 0
  dbB: .quad 0
  dbC: .quad 0
  dbD: .quad 0
  dbSum: .quad 0

  szPlus: .asciz " + "
  szSub: .asciz " - "
  szEqual: .asciz " = "
  szAskA: .asciz "Enter A: "
  szAskB: .asciz "Enter B: "
  szAskC: .asciz "Enter C: "
  szAskD: .asciz "Enter D: "

  chCr: .byte 10
