//*****************************************************************************
// Name: Carlos Aguilera
// Program: RASM2.s
// Class: CS 3B
// Lab: RASM2
// Date: March 10, 2024 at 8:21 PM
// Purpose:
//  Input numeric information from the keyboard, perform addition, subtraction,
//  multiplication, and division. Check for overflow upon all operations.
//*****************************************************************************

// set global start as the main entry
  .global _start

  .equ BUFFER, 512

  .section .data

  szBuffer:  .skip BUFFER

  dbFirst:  .quad 0
  dbSecond: .quad 0
  dbTemp:   .quad 0

  szEnterFirstNumber: .asciz   "Enter your first number: "
  szEnterSecondNumber: .asciz   "Enter your second number: "

  szSum:         .asciz "The sum is "
  szDifference:  .asciz "The difference is "
  szProduct:     .asciz "The product is "
  szQuotient:    .asciz "The quotient is "
  szRemainder:   .asciz "The remainder is "

  szName:    .asciz   "    Name:      Carlos Aguilera"
  szProgram: .asciz   "    Program:   rasm2.s"
  szClass:   .asciz   "    Class:     CS 3B"
  szDate:    .asciz   "    Date:      March 10, 2024"

  szProgramResponse: .asciz "Thanks for using my program!! Good Day!"

  szDivByZero:     .asciz "You cannot divide by 0. Thus, there is NO quotient or remainder\n"
  szOverflowAdd:   .asciz "OVERFLOW occurred when ADDING\n"
  szOverflowSub:   .asciz "OVERFLOW occurred when SUBTRACTING\n"
  szErrorMul:      .asciz "RESULT OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RANGE WHEN MULTIPLYING\n"

  szInvalidString: .asciz "INVALID NUMERIC STRING. RE-ENTER VALUE\n"
  szOutsideQuad:   .asciz "NUMBER OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RE-ENTER VALUE"

  chCr: .byte 10

  .section .text
// X19: szInputLabel
// X20: dbStorage 
GET_INPUT:
  STR X30, [sp, #-16]! // push link register on to the stack for "safe keeping"

  GET_INPUT_LOOP:
    MOV X0, X19   // move the address of X19 into X0
    BL putstring  // branch link to putstring and print out X19

    LDR X0, =szBuffer  // load the address of szBuffer into X0
    MOV X1, BUFFER     // mov the value of BUFFER into X1
    BL getstring       // branch link to putstring and print out szBuffer

    // ---------------------- IS szBuffer EMPTY ----------------------- //
    LDR X0, =szBuffer  // load the address of szBuffer into X0
    LDRB W0, [X0]      // load the first byte pointed at by X0 into W0
    CMP W0, #0         // compare W0 and 0 in other words (szBuffer == '')
    B.EQ END_PROGRAM   // branch if equal to END_PROGRAM

    LDR X0, =szBuffer   // load the address of szBuffer into X0
    BL String_length

    MOV X8, X0
    MOV X9, #0
    FOR_EACH_CHARACTER:
      CMP X9, X8
      B.GE FOR_EACH_CHARACTER_END

      LDR X0, =szBuffer  // load the address of szBuffer into X0
      ADD X0, X0, X9     // X0 = X0 + X9
      LDRB W0, [X0]      // load one byte from X0 into W0

      CMP X9, 0             // check if at index 0
      B.NE SKIP_SIGN_CHECK  // if not equals skip sign check

      CMP W0, 43            // compare W0 and 57 store flags in CPSR
      B.EQ CHARACTER_VALID  // branch greater than to INVALID_INPUt

      CMP W0, 45            // compare W0 and 57 store flags in CPSR
      B.EQ CHARACTER_VALID  // branch greater than to INVALID_INPUt

      SKIP_SIGN_CHECK:

      CMP W0, 48          // compare W0 and 48 store flags in CPSR
      B.LT INVALID_INPUT  // branch less than INVALID_INPUT

      CMP W0, 57          // compare W0 and 57 store flags in CPSR
      B.GT INVALID_INPUT  // branch greater than to INVALID_INPUt

      B CHARACTER_VALID  // branch to CHARACTER_VALID

      INVALID_INPUT:
        LDR X0, =szInvalidString  // load the address of szOutsideQuad into X1
        BL putstring            // branch link to putstring and print out szOutsideQuad
        B GET_INPUT_LOOP  // branch to GET_INPUT_LOOP

      CHARACTER_VALID:
        ADD X9, X9, #1  // X9 = X9 + 1
        B FOR_EACH_CHARACTER  // branch to FOR_EACH_CHARACTER
    FOR_EACH_CHARACTER_END:

    LDR X0, =szBuffer  // load the address of szBuffer into X0
    BL ascint64        // branch link to putstring and print out szBuffer
    B.VC INPUT_VALID

    LDR X0, =szOutsideQuad  // load the address of szOutsideQuad into X1
    BL putstring            // branch link to putstring and print out szOutsideQuad

    LDR X0, =chCr  // load the address of chCr into X0
    BL putch       // branch link to putch and print out chCr

    B GET_INPUT_LOOP  // branch to GET_INPUT_LOOP

    INPUT_VALID:
      STR X0, [X20]      // store the value of X0 into X20

  LDR X30, [sp], #16  // pop link register off the stack for use

  RET

// X0: dbValue unwrapped (FUNCTION MODIFIES X0)
// X21: szLabel 
PRINT_RESULT:
  STR X30, [sp, #-16]! // push link register on to the stack for "safe keeping"

  LDR X1, =szBuffer  // load the address of szBuffer into X1
  BL int64asc        // branch link to int64asc 

  MOV X0, X21   // move the address of X21 into X1
  BL putstring  // branch link to putstring and print out szProduct

  LDR X0, =szBuffer  // load the address of szBuffer into X1
  BL putstring       // branch link to putstring and print out szSum

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  LDR X30, [sp], #16  // pop link register off the stack for use

  RET

_start:
  // ---------------------- PRINT HEADER ----------------------- //
  LDR X0, =szName  // load the address of szName into X0
  BL putstring     // branch link to putstring and print out szName

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  LDR X0, =szProgram  // load the address of szProgram into X0
  BL putstring        // branch link to putstring and print out szProgram

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  LDR X0, =szClass  // load the address of szClass into X0
  BL putstring      // branch link to putstring and print out szClass

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  LDR X0, =szDate  // load the address of szDate into X0
  BL putstring     // branch link to putstring and print out szDate

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  LDR X0, =chCr  // load the address of chCr into X0
  BL putch       // branch link to putch and print out chCr

  MAIN_LOOP:
    LDR X19, =szEnterFirstNumber  // load the address of szEnterFirstNumber into X19
    LDR X20, =dbFirst             // load the address of dbFirst into X20
    BL GET_INPUT                  // branch link to putstring and print out szEnterFirstNumber

    LDR X19, =szEnterSecondNumber  // load the address of szEnterSecondNumber into X19
    LDR X20, =dbSecond             // load the address of dbSecond into X20
    BL GET_INPUT                   // branch link to putstring and print out szEnterSecondNumber

    LDR X19, =dbFirst  // load the address of dbFirst into X0
    LDR X19, [X19]     // load the value at X19 into X19
    LDR X20, =dbSecond // load the address of dbSecond into X1
    LDR X20, [X20]     // load the value at X20 into X20

    // ---------------------- CALCULATE & PRINT SUM ----------------------- //
    ADDS X0, X19, X20        // X21 = X19 + X20
    B.VS OVERFLOW_ADD_ERROR  // branch if equal to

    LDR X21, =szSum   // load the address of szSum into 21
    BL PRINT_RESULT   // branch link to PRINT_RESULT and print result

    B OVERFLOW_ADD_ERROR_END // branch over OVERFLOW_ADD_ERROR_END 

    OVERFLOW_ADD_ERROR:
      LDR X0, =szOverflowAdd  // load the address of szOverflowAdd into X0
      BL putstring            // branch link to putstring and print out szOverflowAdd
    OVERFLOW_ADD_ERROR_END:

    // ---------------------- CALCULATE & PRINT DIFFERENCE ----------------------- //
    SUBS X0, X19, X20        // X21 = X19 - X20
    B.VS OVERFLOW_SUB_ERROR  // branch if equal to

    LDR X21, =szDifference  // load the address of szDifference into X21
    BL PRINT_RESULT         // branch link to PRINT_RESULT and print result

    B OVERFLOW_SUB_ERROR_END // branch over OVERFLOW_SUB_ERROR_END 

    OVERFLOW_SUB_ERROR:
      LDR X0, =szOverflowSub  // load the address of szOverflowAdd into X0
      BL putstring            // branch link to putstring and print out szOverflowAdd
    OVERFLOW_SUB_ERROR_END:

    // ---------------------- CALCULATE & PRINT PRODUCT ----------------------- //
    MOV X0, #0  // init sum
    MOV X8, #0  // init index
    MULTIPLY_LOOP:
      CMP X8, X20  // index - X20 store flags in CPSR
      B.GE MULTIPLY_LOOP_END;

      ADDS X0, X0, X19     // X0 = X0 + X19
      B.VC NO_MULTIPLY_ERROR  // branch if equal to

      LDR X0, =szErrorMul  // load the address of szErrorMul into X0
      BL putstring         // branch link to putstring and print out szErrorMul
      B MULTIPLY_END

      NO_MULTIPLY_ERROR:
        ADD X8, X8, #1
        B MULTIPLY_LOOP
    MULTIPLY_LOOP_END:

    MOV X0, X0
    LDR X21, =szProduct  // load the address of szProduct into X21
    BL PRINT_RESULT      // branch link to PRINT_RESULT and print result

    MULTIPLY_END:

    // ---------------------- CALCULATE & PRINT QUOTIENT/REMAINDER  ----------------------- //
    CMP X20, #0                    // check if divisor is equal to 0
    B.EQ QUOTIENT_REMAINDER_ERROR  // branch if equal to

    SDIV X0, X19, X20     // X0 = X19 / X20
    LDR X21, =szQuotient  // load the address of szQuotient into X21
    BL PRINT_RESULT       // branch link to PRINT_RESULT and print result

    SDIV X0, X19, X20      // X0 = X19 / X20
    MSUB X0, X0, X20, X19  // multiply dividend and quotient and subtract divisor
    LDR X21, =szRemainder  // load the address of szQuotient into X21
    BL PRINT_RESULT        // branch link to PRINT_RESULT and print result

    B QUOTIENT_REMAINDER_ERROR_END // branch over QUOTIENT_REMAINDER_ERROR 

    QUOTIENT_REMAINDER_ERROR:
      LDR X0, =szDivByZero  // load the address of szDivByZero into X0
      BL putstring          // branch link to putstring and print out szDivByZero
    QUOTIENT_REMAINDER_ERROR_END:

    LDR X0, =chCr  // load the address of chCr into X0
    BL putch       // branch link to putch and print out chCr
  
    B MAIN_LOOP

  // ---------------------- END PROGRAM ----------------------- //
  END_PROGRAM:
    LDR X0, =chCr  // load the address of chCr into X0
    BL putch       // branch link to putch and print out chCr
  
    LDR X0, =szProgramResponse  // load the address of szProgramResponse into X0
    BL putstring                // branch link to putstring and print out szDate

    LDR X0, =chCr  // load the address of chCr into X0
    BL putch       // branch link to putch and print out chCr

    LDR X0, =chCr  // load the address of chCr into X0
    BL putch       // branch link to putch and print out chCr

    MOV   X0, #0   // Use 0 return code
    MOV   X8, #93  // Service Command Code 93 terminates this program
    SVC   0        // Call linux to terminate the program
