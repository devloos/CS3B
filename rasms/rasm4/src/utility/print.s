.global print_menu
.global print_header
.global print_option2_menu

.equ BUFFER, 512

.data
  szStudents:		    .asciz		"Students: Shiv Patel and Carlos Aguilera"
  szClass:			    .asciz		"Class: CS3B"
  szProject:		    .asciz		"Project: RASM4"
  szDate:			      .asciz		"04/20/2024"

  szOption1:        .asciz    "<1> View all Strings."
  szOption2:        .asciz    "<2> Add String."
  szOption3:        .asciz    "<3> Delete String."
  szOption4:        .asciz    "<4> Edit String."
  szOption5:        .asciz    "<5> String Search."
  szOption6:        .asciz    "<6> Save File."
  szOption7:        .asciz    "<7> Quit."

  szOption2a:       .asciz    "<a> from Keyboard."
  szOption2b:       .asciz    "<b> from File."

  szInfo1:       .asciz    "              RASM4 TEXT EDITOR"
  szInfo2:       .asciz    "Data Structure Heap Memory Consumption: "
  szInfo3:       .asciz    " bytes"
  szInfo4:       .asciz    "Number of Nodes: "

  szBuffer:         .skip     BUFFER

  dbConsumption:  .quad   0

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

increment_byte_consumption:
  STR X30, [SP, #-16]! 			// push link register onto the stack
  STR X19, [SP, #-16]! 			// push link register onto the stack

  MOV X19, X0   // store string into X19

  MOV X0, X19   // move string ptr into X0
  BL String_length

  MOV X0, X0                    // size of string
  LDR X1, =dbConsumption   			// load the address of szBuffer into X0
  LDR X1, [X1]                  // Loads the Address of dbConsumption into x0

  ADD X0, X0, #1                // increment string count by 1 because of null term
  ADD X1, X1, X0                // increment consumption by string length
  ADD X1, X1, #16               // increment consumption by node size

  LDR X0, =dbConsumption   			// load the address of szBuffer into X0
  STR X1, [X0]                  // store incremented consumption into dbConsumption

  LDR X19, [SP], #16 			// pop link register off the stack
  LDR X30, [SP], #16 			// pop link register off the stack
  RET


print_info:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  ldr x0,=szInfo1               // Loads the Address of szInfo1 into x0
  bl  putstring                    // Display the String to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo2               // Loads the Address of szInfo2 into x0
  bl  putstring                    // Display the String to the Console

  ADR X0, increment_byte_consumption
  BL foreach

  LDR X0, =dbConsumption        // Loads the Address of dbConsumption into x0
  LDR X0, [X0]                  // Loads the Address of dbConsumption into x0
  BL convert_and_print_number

  LDR X0, =dbConsumption        // Loads the Address of dbConsumption into x0
  MOV X1, #0                    // reset dbConsumption back to 0
  STR X1, [X0]                  // store 0 into dbConsumption

  ldr x0,=szInfo3               // Loads the Address of szInfo2 into x0
  bl  putstring                    // Display the String to the Console

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szInfo4               // Loads the Address of szInfo4 into x0
  bl  putstring                    // Display the String to the Console

  BL get_size
  BL convert_and_print_number

  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  LDR X30, [SP], #16 			// pop link register off the stack
  RET


print_header:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  ldr x0,=szStudents               // Loads the Address of szStudents into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szClass               // Loads the Address of szClass into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szProject               // Loads the Address of szProject into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szDate               // Loads the Address of szDate into x0
  bl  putstring                    // Display the String to the Console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  LDR X30, [SP], #16 			// pop link register off the stack
  RET

print_menu:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  BL print_info            // print info onto term

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

  ldr x0,=szOption7               // Loads the Address of szOPtion7 into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  LDR X30, [SP], #16 			// pop link register off the stack
  RET

print_option2_menu:
  STR X30, [SP, #-16]! 			// push link register onto the stack

  ldr x0,=szOption2a               // Loads the Address of szOption2a into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  ldr x0,=szOption2b               // Loads the Address of szOption2b into x0
  bl putstring                    // Display this to the console

  //Line Feed
  ldr x0,=chCr                    // Loads the Address of chCr into x0
  bl  putch                       // Display the newline characther to the console

  LDR X30, [SP], #16 			// pop link register off the stack
  RET
