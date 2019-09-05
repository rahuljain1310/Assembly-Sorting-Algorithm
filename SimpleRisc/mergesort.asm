.addArrayr6:
  add r9,r9,4
  ld r8,[r6]
  st r8,[r9]
  add r6,r6,4
  cmp r6,r4
  bgt .mergereturn
  b .addArrayr6

.addArrayr3:
  add r9,r9,4
  ld r8,[r3]
  st r8,[r9]
  add r3,r3,4
  cmp r3,r5
  bgt .mergereturn
  b .addArrayr3

.r2inr9:
  st r2,[r9]
  add r3,r3,4
  b .merge

.swap:
	ld r7,[r5]
	st r8,[r5]
	st r7,[r6]
	add r5,r5,4
	ret

.partition:
  mov r5,r4
  cmp r3,r4
  bgt .partitionReturn
  add r3,r3,4
  sub r4,r4,4
  b .partition
  .partitionReturn:
  ret

.copyArray:
  cmp r3,r4
  bgt .careturn
  ld r8,[r9]
  st r8,[r3]
  add r3,r3,4
  add r9,r9,4
  b .copyArray
  .careturn:
  ret

.merge:
  cmp r3,r5
  bgt .addArrayr6
  cmp r6,r4
  bgt .addArrayr3

  add r9,r9,4
  ld r2,[r3]
  ld r8,[r6]

  cmp r8,r2
  bgt .r2inr9

  st r8,[r9]
  add r6,r6,4
  b .merge

  .mergereturn:
  ret

.mergeArray:
  @ Stack Allocate
  add r9,r9,16
  mov r7,r9
  st ra,[r9]
  st r3,4[r9]
  st r5,8[r9]
  st r6,12[r9]
  st r4,16[r9]

  add r9,r9,16
  call .merge

  @ Copy The Array From r9,20 to ..
  mov r9,r7
  ld r3,4[r9]
  ld r4,16[r9]
  add r9,r7,20
  call .copyArray

  @ Stack Deallocate
  mov r9,r7
  ld ra,[r9]
  sub r9,r9,16
  ret

.mergesort:
  @ Base Case
	cmp r3,r4
	bgt .msReturn
	beq .msReturn

  @ Allocate Stack Memory And Save Pointer
  add r9,r9,16
  st ra,[r9]

  @ Get Center r5 lo = r3, hi = r4
  st r3,4[r9]
  st r4,12[r9]
  call .partition 
  st r5,8[r9]

  @ Recursion
  ld r3,4[r9]
  mov r4,r5
  call .mergesort
  ld r4,12[r9]
  ld r5,8[r9]
  add r3,r5,4
	call .mergesort

  @ Merging Two Arrays
  ld r3,4[r9]
  ld r5,8[r9]
  ld r4,12[r9]
  add r6,r5,4
  call .mergeArray
 
  @ Deallocate Memory And Restore Return
  ld ra,[r9]
  sub r9,r9,16
	.msReturn:
  ret

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

	mov r2, 0          @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 5	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	
	@ ADD YOUR CODE HERE 
	
  mov r9,sp
	mov r0,r2
	mov r1,r4
	mov r3,r0
	mov r4,r1
	call .mergesort

	@ ADD YOUR CODE HERE 
	@ Print statements for the result
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

