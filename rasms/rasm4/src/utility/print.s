.global print_menu
.global print_header
.global print_option2_menu

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

  chCr: .byte 10

.text

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
