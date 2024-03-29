// Programmer: Carlos Aguilera
// Lab #4
// Purpose: print 100 + 10000 + 10000000 + 10000000000 = (the actual result)
// Author: Carlos Aguilera
// Date Last Modified: 02/03/24

// set global start as the main entry
  .global _start
  .section .text

_start:
  // ----------------- SET DATA ------------------ //
  LDR X0, =dbA  // load the address of dbA in register X0
  MOV X1, #100  // mov immediate value of 100 into X1
  STR X1, [X0]  // store value of 100 in dbA

  LDR X0, =dbB  // load the address of dbB in register X0
  MOV X1, #10000  // mov immediate value of 10000 into X1
  STR X1, [X0]  // store value of 10000 in dbB

  LDR X0, =dbC  // load the address of dbC in register X0
  MOV X1, #0x9680  // mov immediate value of 0x9680 into X1
  STR X1, [X0]  // store value of 0x9680 in dbC

  MOV X1, #0x98  // mov immediate value of 0x98 into X1
  STR X1, [X0, #2]  // store value of 0x98 in dbC 2 bytes to the left

  LDR X0, =dbD  // load the address of dbD in register X0
  MOV X1, #0xE400  // mov immediate value of 0xE400 into X1
  STR X1, [X0]  // store value of 0xE400 in dbD

  MOV X1, #0x540B  // mov immediate value of 0x540B into X1
  STR X1, [X0, #2]  // store value of 0x540B in dbD 2 bytes to the left

  MOV X1, #0x2  // mov immediate value of 0x2 into X1
  STR X1, [X0, #4]  // store value of 0x2 in dbD 4 bytes to the left

  // ----------------- SET DATA ------------------ //

  // ----------------- COMPUTE RESULT ------------------ //
  LDR X0, =dbA  // load the address of dbA in register X0
  LDR X0, [X0]  // store value of dbA in X0

  LDR X1, =dbB  // load the address of dbB in register X1
  LDR X1, [X1]  // store value of dbB in X1

  LDR X2, =dbC  // load the address of dbC in register X2
  LDR X2, [X2]  // store value of dbC in X2

  LDR X3, =dbD  // load the address of dbD in register X3
  LDR X3, [X3]  // store value of dbD in X3

  ADD X4, X0, X1  // X4 = dbA + dbB
  ADD X5, X2, X3  // X5 = dbC + dbD
  ADD X6, X4, X5  // X6 = X4 + X5

  LDR X0, =dbSum
  STR X6, [X0]

  // ----------------- COMPUTE RESULT ------------------ //

  // ----------------- PRINT RESULT ------------------ //

  // ------------- PRINT dbA -------------- //
  LDR X0, =dbA  // load the address of dbA
  LDR X0, [X0]  // load the value of dbA 
  LDR X1, =szTemp // load the address of szTemp
  BL int64asc // branch link to subroutine int64asc

  LDR X0, =szTemp // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT + -------------- //
  LDR X0, =szPlus // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT dbB -------------- //
  LDR X0, =dbB  // load the address of dbA
  LDR X0, [X0]  // load the value of dbA 
  LDR X1, =szTemp // load the address of szTemp
  BL int64asc // branch link to subroutine int64asc

  LDR X0, =szTemp // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT + -------------- //
  LDR X0, =szPlus // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT dbC -------------- //
  LDR X0, =dbC  // load the address of dbA
  LDR X0, [X0]  // load the value of dbA 
  LDR X1, =szTemp // load the address of szTemp
  BL int64asc // branch link to subroutine int64asc

  LDR X0, =szTemp // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT + -------------- //
  LDR X0, =szPlus // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT dbD -------------- //
  LDR X0, =dbD  // load the address of dbA
  LDR X0, [X0]  // load the value of dbA 
  LDR X1, =szTemp // load the address of szTemp
  BL int64asc // branch link to subroutine int64asc

  LDR X0, =szTemp // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT = -------------- //
  LDR X0, =szEqual // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT dbD -------------- //
  LDR X0, =dbSum  // load the address of dbA
  LDR X0, [X0]  // load the value of dbA 
  LDR X1, =szTemp // load the address of szTemp
  BL int64asc // branch link to subroutine int64asc

  LDR X0, =szTemp // load the value of X1 in register X0
  BL putstring  // branch link to subroutine putstring

  // ------------- PRINT NEW LINE -------------- //
  LDR X0, =chCr // load the address of chCr in register X0
  BL putch      // branch link to subroutine putch

  // ----------------- PRINT RESULT ------------------ //

  MOV  X0, #0   // Setup the parameters to exit the program
  MOV  X8, #93  // and then call Linux to do it.

  SVC  0 // use 0 return code

  .data
  dbA: .quad 0
  dbB: .quad 0
  dbC: .quad 0
  dbD: .quad 0
  dbSum: .quad 0
  szTemp: .skip 21
  szPlus: .asciz " + "
  szEqual: .asciz " = "
  chCr: .byte 10
