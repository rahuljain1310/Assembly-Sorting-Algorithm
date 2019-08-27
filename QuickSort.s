.global _start

.swap:
	ldr r7,[r5]
	str r8,[r5]
	str r7,[r6]
	add r5,r5,#1
	bx lr

.next:
	sub r9,r9,#8
	cmp r9,#0x3240 
	moveq pc,#0x3240
	ldr r3,[r9]
	ldr r4,[r9,#4]
	bx lr

.partition:
	ldr r8,[r6]
	cmp r8,r2 
	blle .swap
	add r6,r6,#4
	cmp r6,r4
	blt .partition
	ldr r7,[r5]
	str r2,[r5]
	str r7,[r4]

.qs:
	cmp r3,r4
	bleq .next
	mov r5,r3
	mov r6,r3
	bl .partition
	add r5,r5,#4
	str r5,[r9]
	str r4,[r9,#4]
	sub r5,r5,#2
	mov r4,r5
	b .qs

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
	mov r5,#0x3240
	mov r9,r5
	add r9,r9,#8
	mov r3,r0
	mov r4,r1
	str pc,[r5]
	b .qs
	mov r5,#5