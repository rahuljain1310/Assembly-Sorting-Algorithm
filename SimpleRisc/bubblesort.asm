.swap:
	st r8,[r6]
	st r9,4[r6]
	b .swapret

.bubblesort:
	@ ADD YOUR CODE HERE
	cmp r1,r0
	beq .returnbs
	ld r9,[r6]
	ld r8,4[r6]
	cmp r9,r8
	bgt .swap
	.swapret:
	add r6,r6,4
	cmp r1,r6
	bgt .bubblesort
	sub r1,r1,4
	mov r6,r0
	b .bubblesort
	@cmp r1,r0
	@bgt .bubblesort
	@b .returnbs

.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7	@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   @ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0       @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 6	@ REPLACE 6 WITH N, where, N is the number of numbers being sorted
	
	@ ADD YOUR CODE HERE
	sub r2,r3,1
	mul r1,r2,4
	add r1,r1,r0
	mov r6,r0
	call .bubblesort
	.returnbs:
	
	@ ADD YOUR CODE HERE

	@ Print statements
	ld r1, 0[r0]
	.print r1
	ld r1, 4[r0]
	.print r1
	ld r1, 8[r0]
	.print r1
	ld r1, 12[r0]
	.print r1
	ld r1, 16[r0]
	.print r1
	ld r1, 20[r0]
	.print r1
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

