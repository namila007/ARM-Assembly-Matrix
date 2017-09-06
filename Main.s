	.text 	@ instruction memory
	

	.global main

//***********************
flip:
	mov r4, #0 //col count
	mov r10, #1 //row count
	 
	//mul r12, r6,r11 //stack allocated for col size 
	ldr r0, =formatFL
		bl printf

loopFLrow:
		mul r12,r6,r10
		mov r11,#4
		mul r9,r12,r11
		sub r9,r9,#4 //sub one stack
		mov r4, #0
		
		
		
loopFLcol:
		
		ldr r11, [sp,r9]
		ldr r0, =formatprint
		mov r1,r11
		bl printf
		add r4, r4, #1
		sub r9, r9, #4
		cmp r4,r6
		blt loopFLcol
		ldr r0, =formatn
		bl printf
		
		cmp r10,r5
		add r10,r10 ,#1
		blt loopFLrow
		b exit2
//*****************	






//********ROTATE FUNC**********
rotate:
	mov r4, #0 //col count
	mov r10, #0 //row count
	mov r11,#4 
	mul r9, r8,r11 //stack allocated size 
	sub r9,r9,#4 //sub one stack 
	ldr r0, =formatRO
	bl printf

loopROrow:
		mov r4, #0
		add r10,r10 ,#1
		
		
loopROcol:
		
		ldr r11, [sp,r9]
		ldr r0, =formatprint
		mov r1,r11
		bl printf
		add r4, r4, #1
		sub r9, r9, #4
		cmp r4,r6
		blt loopROcol
		ldr r0, =formatn
		bl printf
		cmp r10,r5
		blt loopROrow
		b exit2
//***************************

//*********INVERSE Function************
inverse:
	mov r4, #0 //col count
	mov r10, #0 //row count
	mov r9, #0 //stack
	ldr r0, =formatIN
		bl printf

loopINrow:
		mov r4, #0
		add r10,r10 ,#1

		
loopINcol:
		
		ldr r11, [sp,r9]
		rsb r11,r11, #255
		ldr r0, =formatprint
		mov r1,r11
		bl printf
		add r4, r4, #1
		add r9, r9, #4
		cmp r4,r6
		blt loopINcol
		ldr r0, =formatn
		bl printf
		cmp r10,r5
		blt loopINrow
		beq exit2
//************************



//*************************
original:
	mov r4, #0 //col count
	mov r10, #0 //row count
	mov r9, #0 //stack
	ldr r0, =formatOR
		bl printf

loopORrow:
		mov r4, #0
		add r10,r10 ,#1
		
		
loopORcol:
		
		ldr r11, [sp,r9]
		ldr r0, =formatprint
		mov r1,r11
		bl printf
		add r4, r4, #1
		add r9, r9, #4
		cmp r4,r6
		blt loopORcol
		ldr r0, =formatn
		bl printf
		cmp r10,r5
		blt loopORrow
		b exit2
//***********************

exit2:	
		ldr r0, =formatn
		bl printf
		ldr lr, [sp, #0]
		b exit

			



main:
	@r5 row size, r6 col size ,r7 function 
	sub sp, sp, #4
	str lr, [sp, #0]

	//******1
	sub sp, sp , #4 //1

	ldr	r0, =formatget
	mov	r1, sp
	bl	scanf	@scanf("%s",sp)
	ldr r5, [sp, #0] //row


	ldr	r0, =formatget
	mov	r1, sp
	bl	scanf	@scanf("%s",sp)
	ldr r6, [sp, #0] //col

	ldr	r0, =formatget
	mov	r1, sp
	bl	scanf	@scanf("%s",sp)
	ldr r7, [sp, #0] //operation
	
	
	add sp,sp, #4 //1
	//*********1

	//getting data*****
	
	mov r4, #0

	mov r9, #4
	mul r8,r5,r6 //r8= row*col
	sub sp,sp ,r8,LSL #2 //allocating stack for r8*4bytes size
	sub sp,sp, #4 //2
	

loop1:	
		ldr	r0, =formatget
		mov	r1, sp
		bl	scanf
		
		ldr r12, [sp]
		str r12, [sp,r9] 
		add r4, r4, #1
		add r9, r9, #4
		
		cmp r4,r8
		blt loop1

	add sp,sp, #4 //2

	cmp r7, #0
	beq original
	cmp r7, #1
	beq inverse
	cmp r7, #2
	beq rotate
	cmp r7, #3
	beq flip
	
	
	ldr r0,=formatinv
	bl printf
	
	
exit:
	add sp,sp,r8,lsl #2		
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr







	.data	@ data memory
formatinv : .asciz "Invalid operation\n"	
formatFL : .asciz "Flip\n"	
formatRO : .asciz "Rotation by 180\n"	
formatOR : .asciz "Original\n"
formatIN : .asciz "Inversion\n"	
formatget: .asciz "%d"
formatn: .asciz "\n"
formatprint: .asciz "%d "
