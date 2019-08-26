.global _start

.swap:
	str r8,[r6]
	str r9,[r6,#4]
	bx lr

.bs:
	ldr r9,[r6]
	ldr r8,[r6,#4]
	cmp r9,r8
	blgt .swap
	add r6,r6,#4
	cmp r6,r1
	blt .bs
	sub r1,r1,#4
	mov r6,r0
	cmp r1,r0
	bgt .bs
	mov pc,r5

_start:
	mov r0,#0x2240
	mov r1,#9
	str r1, [r0]
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

	// Bubble Sort
	mov r6,r0
	mov r5,pc
	b .bs
	mov r5,#5