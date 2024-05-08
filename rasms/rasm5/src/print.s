.global print_menu
.global convert_and_print_number

.equ BUFFER, 512

.data
  szOption1:        .asciz    "<1> Load input file."
  szOption2:        .asciz    "<2> Sort using C Bubblesort algorithm."
  szOption3:        .asciz    "<3> Sort using Assembly Bubblesort algorithm."
  szOption4:        .asciz    "<4> Sort using C insertionSort algorithm."
  szOption5:        .asciz    "<5> Sort using Assembly insertionSort algorithm."
  szOption6:        .asciz    "<6> Quit."

  szInfo1:       .asciz    "              RASM5 C vs Assembly"
  szInfo2:       .asciz    "            File Element Count: "
  szInfo3:       .asciz    "C        Bubblesort Time: "
  szInfo4:       .asciz    "Assembly Bubblesort Time: "

  szInfo5:       .asciz    "C        Insertion Sort Time: "
  szInfo6:       .asciz    "Assembly Insertion Sort Time: "

  szSeparator:  .asciz    "------------------------------------------------"

  szBuffer:         .skip     BUFFER

  chCr: .byte 10

.text

convert_and_print_number:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  MOV X0, X0                // set param for number
  LDR X1, =szBuffer   			// load the address of szBuffer into X0
  BL int64asc         			// branch link to int64asc

  LDR X0, =szBuffer   			// load the address of szBuffer into X0
  BL putstring

  LDR X30, [SP], #16 			// pop link register off the stack

  RET

print_menu:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  ldr x0,=szInfo1                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo2                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szSeparator                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo3                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo4                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo5                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo6                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szSeparator                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption1                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption2                 // Loads the Address of sOption1 into x0
  bl  putstring                     // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption3               // Loads the Address of szOption3 into x0
  bl  putstring                   // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption4               // Loads the Address of szOption3 into x0
  bl  putstring                   // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption5               // Loads the Address of szOption5 into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption6               // Loads the Address of szOption3 into x0
  bl  putstring                   // Display the Menue Option to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  LDR X30, [SP], #16 			// pop link register off the stack
  RET
