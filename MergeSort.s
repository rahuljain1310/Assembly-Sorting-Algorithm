.global _start

.swap:
	ldr r7,[r5]
	str r8,[r5]
	str r7,[r6]
	add r5,r5,#4
	bx lr

.partition:
  mov r5,r4
  cmp r3,r4
  bxgt lr
  add r3,r3,#4
  sub r4,r4,#4
  b .partition

.copyArray:
  cmp r3,r4
  bxgt lr
  ldr r8,[r9]
  str r8,[r3]
  add r3,r3,#4
  add r9,r9,#4
  b .copyArray

.merge: 
  mov r2,#0
  cmp r3,r5
  addgt r2,r2,#1
  cmp r6,r4
  addgt r2,r2,#1
  cmp r2,#2
  bxeq lr

  add r9,r9,#4

  ldr r2,[r3]
  ldr r8,[r6]

  cmp r3,r5
  addgt r6,r6,#4
  strgt r8,[r9]
  bgt .merge

  cmp r6,r4
  addgt r3,r3,#4
  strgt r2,[r9]
  bgt .merge

  cmp r2,r8
  strlt r2,[r9]
  addlt r3,r3,#4
  strge r8,[r9]
  addge r6,r6,#4

  b .merge


.mergeArray:
  // Stack Allocate
  add r9,r9,#16
  mov r7,r9
  str lr,[r9]
  str r3,[r9,#4]
  str r5,[r9,#8]
  str r6,[r9,#12]
  str r4,[r9,#16]

  add r9,r9,#16
  bl .merge

  // Copy The Array From r9,20 to ..
  mov r9,r7
  ldr r3,[r9,#4]
  ldr r4,[r9,#16]
  add r9,r7,#20
  bl .copyArray

  // Stack Deallocate
  mov r9,r7
  ldr lr,[r9]
  sub r9,r9,#16
  bx lr

.ms:
  // Base Case
	cmp r3,r4
	bxge lr

  // Allocate Stack Memory And Save Pointer
  add r9,r9,#16
  str lr,[r9]

  // Get Center r5; lo = r3, hi = r4
  str r3,[r9,#4]
  str r4,[r9,#12]
  bl .partition 
  str r5,[r9,#8]

  // Recursion
  ldr r3,[r9,#4]
  mov r4,r5
  bl .ms
  ldr r4,[r9,#12]
  ldr r5,[r9,#8]
  add r3,r5,#4
	bl .ms

  // Merging Two Arrays
  ldr r3,[r9,#4]
  ldr r5,[r9,#8]
  ldr r4,[r9,#12]
  add r6,r5,#4
  bl .mergeArray
 
  // Deallocate Memory And Restore Return
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

	// Merge Sort
  mov r9,#0x3240
	mov r3,r0
	mov r4,r1
	bl .ms
	mov r5,#5