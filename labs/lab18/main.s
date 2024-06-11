.global main

.section .data
  value_one: .float 2.343

.section .text

main:
  ldr  x0, =value_one
  add x0, x0, :lo12:value_one
  ldr s0, [x0]

  // fmov s0, #2.343 // move the floating-point number 2.0 into s0
  // fmov s1, #5.3 // move the floating-point number 3.0 into s0

  // fadd s2, s0, s1  // s0 = s1 + s2 (single precision)

  // fmov s0, #3.5343425445 // move the floating-point number 2.0 into s0
  // fmov s1, #1.534443455 // move the floating-point number 3.0 into s0

  // fadd s2, s0, s1  // s0 = s1 + s2 (single precision)

  // fmov s0, #3.14e12 // move the floating-point number 2.0 into s0
  // fmov s1, #5.55e-10 // move the floating-point number 3.0 into s0

  // fadd s2, s0, s1  // s0 = s1 + s2 (single precision)

  mov  x0, #0   // setup the parameters to exit the program
  mov  x8, #93  // and then call linux to do it.

  svc  0 // use 0 return code
