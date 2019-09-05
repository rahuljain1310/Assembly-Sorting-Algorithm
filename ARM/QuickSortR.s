.global _start

.swap:
	ldr r7,[r5]
	str r8,[r5]
	str r7,[r6]
	add r5,r5,#4
	bx lr

.iterate:
	ldr r8,[r6]
	cmp r8,r2 
	blle .swap
	add r6,r6,#4
	cmp r6,r4
	blt .iterate
	ldr r7,[r5]
	str r2,[r5]
	str r7,[r4]
  ldr pc,[r9,#4]

.partition:
  str lr,[r9,#4]
  ldr r2,[r4] 
  mov r5,r3
  mov r6,r3
  b .iterate

.qs:
  // Base Case
	cmp r3,r4
	bxge lr

  // Allocate Stack Memory
  // And Save Pointer
  add r9,r9,#16
  str lr,[r9]

  // Get pivot r5; lo = r3, hi = r4
  bl .partition 

  // Store Parameter Right Segment Recursion
	add r5,r5,#4
	str r5,[r9,#4]
	str r4,[r9,#8]

  // Recursion on Left Segment
	sub r4,r5,#8
  bl .qs

  // Recursion on Right Segment
  ldr r3,[r9,#4]
  ldr r4,[r9,#8]
	bl .qs

  // Deallocate Memory
  // And Restore Return
  ldr lr,[r9]
  sub r9,r9,#16
  bx lr

_start:
	mov r0,#0x2240
	mov r1,#9
	str r1,[r0]
	mov r1,#8
	str r1,[r0,#4]
	mov r1,#7	
	str r1, [r0,#8]
	mov r1,#5
	str r1,[r0,#12]
	mov r1,#30
	str r1, [r0,#16]
	mov r1,#2
	str r1,[r0,#20]
	mov r1,#5
	str r1,[r0,#24]

	// No. of Integers N to sort - r2 <- N-1
	mov r2,#6
	mov r7,#4
	mla r1,r2,r7,r0

	// Quick Sort
  mov r9,#0x3240
	mov r3,r0
	mov r4,r1
	bl .qs
	mov r5,#5