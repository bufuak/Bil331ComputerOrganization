 .data

buffer:
 .space 4

firstdecimal:
 .asciiz	"Enter the decimal part of first number "

firstfloat:
 .asciiz	"Enter the floating part of first number "

operator:
 .asciiz	"Enter the operator +,- or * "

seconddecimal:
 .asciiz	"Enter the decimal part of second number "

secondfloat:
 .asciiz	"Enter the floating part of second number "

dot:
 .asciiz	"."

equals:
 .asciiz	" = "

zero:
 .asciiz "0"

err:
 .asciiz	"Floating part can not be negative!\n"

err2:
 .asciiz	"Operators can be only + - or *\n"

exitText:
 .asciiz	"\nExiting program\n"

	
 .text
 .globl main

main:
 li $v0, 4		# system call code for print_str
 la $a0, firstdecimal   # loading firstdecimal to system
 syscall		# print firstdecimal

 li $v0, 5		# system call code for read_int
 syscall		# read firstdecimal

 move $t0,$v0           # store firstdecimal

 li $v0, 4		# system call code for print_str
 la $a0, firstfloat     # loading firstfloat to system
 syscall		# print firstfloat

 li $v0, 5		# system call code for read_int
 syscall		# read firstfloat

 move $t1,$v0           # store firstfloat
 blt $t1,$0,error       # Checking firstfloat is negative

 li $v0, 4		# system call code for print_str
 la $a0, operator 	# loading operator to system
 syscall		# print operator

 li $v0, 8		# system call code for read_str
 la $a0, buffer		# setting buffer for read_str
 li $a1, 4		# setting buffer for read_str
 syscall  		# reading operator

 lw $t4,0($a0)		# loading operator to t2 2602 for *,2603 for +, 2605 for -
 move $t8,$a0		# loading operator for later

 li $v0, 4		# system call code for print_str
 la $a0, seconddecimal  # loading seconddecimal to system
 syscall		# print seconddecimal

 li $v0, 5		# system call code for read_int
 syscall		# read seconddecimal

 move $t2,$v0           # store seconddecimal

 li $v0, 4		# system call code for print_str
 la $a0, secondfloat     # loading secondfloat to system
 syscall		# print secondfloat

 li $v0, 5		# system call code for read_int
 syscall		# read secondfloat

 move $t3,$v0           # store secondfloat

 blt $t3,$0,error       # Checking secondfloat is negative
 
 move $a0,$t1		# make argument is firstfloat
 jal digit		# digit(firstfloat)
 move $t5,$v0		# t5=digit(firstfloat)

 move $a0,$t3		# make argument is secondfloat
 jal digit		# digit(secondfloat)
 move $t6,$v0		# t6=digit(secondfloat)

 sub $t7,$t5,$t6	# store difference of digits in t7
 li $s0,10 

 beq $t5,$t6,sections	# if(digit(firstfloat)==digit(secondfloat) j sections
 blt $t5,$t6 addzerofirst # else add zero to firstfloat
 addzerosecond:		  # else add zero to secondfloat
	addi $t7,-1	  # difference-=1
	addi $t6, 1	  # digit#ofsecond+=1
	mult $t3,$s0	  
 	mflo $t3	  # secondfloat*=10
	bgt $t7,$0,addzerosecond # difference>0 j addzerosecond
	j sections
 addzerofirst:
 	addi $t7,1	# difference+=1
	addi $t5,1	# digit#offirst+=1
	mult $t1,$s0	
 	mflo $t1	# firstfloat*=10
	blt $t7,$0,addzerofirst	# difference<0 j addzerofirst
 	j sections
 sections:
	move $t9,$t6	# Saving digit# of float for later
 	beq $t4,2602,multiplysection
 	beq $t4,2603,addsection
 	beq $t4,2605,subtractsection
 j error2
 j exit


addsection:
 addi $sp,-4	# Getting room for Fifth argument
 sw $t5,0($sp)	# Fifth argument digit of biggest float
 bge $t0,$zero,plusadd # Jump if first operand is +
 bgt $t2,$zero,negativepositiveadd # jump if -/+
 #negativenegative # -/-
 move $a0,$t0   # First argument, first decimal
 move $a1,$t1	# Second argument, first float
 sub $t0,$zero,$t0 # Making first decimal postive
 sub $t2,$zero,$t2 # Making second decimal positive
 move $a2,$t2	# Third argument, second decimal
 move $a3,$t3	# Fourth argument, second float
 jal subtract   # call addition
 sub $t0,$zero,$t0 # Making first decimal normal
 sub $t2,$zero,$t2 # Making second decimal normal
 move $t4,$v0	# Addition of decimals
 sub $v0,$zero,$v0 # Making result negative
 move $t5,$v1	# Addition of floats
 addi $sp,4	# Giving room to system
 j print	# Print result
 plusadd: # First operand +
	# +/+
 	blt $t2,$zero,plusnegativeadd # Jump if +/-
	move $a0,$t0   # First argument, first decimal
 	move $a1,$t1	# Second argument, first float
 	move $a2,$t2	# Third argument, second decimal
 	move $a3,$t3	# Fourth argument, second float
 	jal addition   # call addition
	move $t4,$v0	# Addition of decimals
	move $t5,$v1	# Addition of floats
	addi $sp,4	# Giving room to system
	j print	# Print result
	plusnegativeadd: # +/-
 		move $a0,$t0   # First argument, first decimal
 		move $a1,$t1	# Second argument, first float
		sub $t2,$zero,$t2 # Making second decimal positive
 		move $a2,$t2	# Third argument, second decimal
 		move $a3,$t3	# Fourth argument, second float
 		jal subtract   # call addition
		sub $t2,$zero,$t2 # Making second decimal normal
		move $t4,$v0	# Addition of decimals
		move $t5,$v1	# Addition of floats
		addi $sp,4	# Giving room to system
		j print	# Print result
 negativepositiveadd: # -/-
	sub $t0,$zero,$t0 # Making first decimal positive
 	move $a0,$t2   # First argument, second decimal
 	move $a1,$t3	# Second argument, second float
 	move $a2,$t0	# Third argument, first decimal
 	move $a3,$t1	# Fourth argument, first float
 	jal subtract   # call addition
	sub $t0,$zero,$t0 # Making first decimal normal
	move $t4,$v0	# Addition of decimals
	move $t5,$v1	# Addition of floats
	addi $sp,4	# Giving room to system
	j print	# Print result

subtractsection:
 addi $sp,-4	# Getting room for Fifth argument
 sw $t5,0($sp)	# Fifth argument digit of biggest float
 bge $t0,$zero,plussub # Jump if first operand is +
 bgt $t2,$zero,negativepositivesub # jump if -/+

 # negativenegativesub
 sub $t0,$zero,$t0 # Making first decimal positive
 sub $t2,$zero,$t2 # Making second decimal positive
 move $a0,$t2   # First argument, second decimal
 move $a1,$t3	# Second argument, second float
 move $a2,$t0	# Third argument, first decimal
 move $a3,$t1	# Fourth argument, first float
 jal subtract	# call subtract
 sub $t0,$zero,$t0 # Making first decimal normal
 sub $t2,$zero,$t2 # Making second decimal normal
 move $t4,$v0	# Subtraction of decimals
 move $t5,$v1	# Subtraction of floats
 addi $sp,4	# Giving room to system
 j print	# Print result
 plussub:
	# +/+
	blt $t2,$zero,plusnegativesub # Jump if +/-
	move $a0,$t0   # First argument, first decimal
	move $a1,$t1	# Second argument, first float
	move $a2,$t2	# Third argument, second decimal
 	move $a3,$t3	# Fourth argument, second float
	jal subtract	# call subtract
	move $t4,$v0	# Subtraction of decimals
 	move $t5,$v1	# Subtraction of floats
 	addi $sp,4	# Giving room to system
	j print	# Print result

	plusnegativesub:
		move $a0,$t0   # First argument, first decimal
		move $a1,$t1	# Second argument, first float
  		sub $t2,$zero,$t2 # Making second decimal positive
		move $a2,$t2	# Third argument, second decimal
 		move $a3,$t3	# Fourth argument, second float
		jal addition	# call subtract
		sub $t2,$zero,$t2 # Making second decimal normal
		move $t4,$v0	# Subtraction of decimals
 		move $t5,$v1	# Subtraction of floats
 		addi $sp,4	# Giving room to system
		j print	# Print result
 negativepositivesub:
	sub $t0,$zero,$t0 # Making first decimal positive
	move $a0,$t0   # First argument, first decimal
	move $a1,$t1	# Second argument, first float
	move $a2,$t2	# Third argument, second decimal
 	move $a3,$t3	# Fourth argument, second float
	jal addition	# call subtract
	sub $t0,$zero,$t0 # Making first decimal normal
	move $t4,$v0	# Subtraction of decimals
	sub $t4,$zero,$t4 # Making returndecimal negative
 	move $t5,$v1	# Subtraction of floats
 	addi $sp,4	# Giving room to system
	j print	# Print result
 

multiplysection:
 addi $sp,-4	# Getting room for Fifth argument
 sw $t5,0($sp)	# Fifth argument digit of biggest float
 bge $t0,$zero,plusmult # Jump if first operand is +
 bgt $t2,$zero,negativepositivemult # jump if -/+

 # negativenegativemult
 sub $t0,$zero,$t0 # Making first decimal positive
 sub $t2,$zero,$t2 # Making second decimal positive
 move $a0,$t0   # First argument, first decimal
 move $a1,$t1	# Second argument, first float
 move $a2,$t2	# Third argument, second decimal
 move $a3,$t3	# Fourth argument, second float
 jal multiply
 sub $t0,$zero,$t0 # Making first decimal normal
 sub $t2,$zero,$t2 # Making second decimal normal
 move $t4,$v0	# Multipation of decimals
 move $t5,$v1	# Multipation of floats
 addi $sp,4	# Giving room to system
 j print	# Print result
 plusmult:
	# +/+
	blt $t2,$zero,plusnegativemult # Jump if +/-
	move $a0,$t0   # First argument, first decimal
	move $a1,$t1	# Second argument, first float
	move $a2,$t2	# Third argument, second decimal
 	move $a3,$t3	# Fourth argument, second float
 	jal multiply
 	move $t4,$v0	# Multipation of decimals
	move $t5,$v1	# Multipation of floats
	addi $sp,4	# Giving room to system
	j print	# Print result

	plusnegativemult: # +/-
		move $a0,$t0   # First argument, first decimal
		move $a1,$t1	# Second argument, first float
		sub $t2,$zero,$t2 # Making second decimal positive
		move $a2,$t2	# Third argument, second decimal
 		move $a3,$t3	# Fourth argument, second float
 		jal multiply
		sub $t2,$zero,$t2 # Making second decimal normal
 		move $t4,$v0	# Multipation of decimals
		sub $t4,$zero,$t4 # Making result negative
		move $t5,$v1	# Multipation of floats
		addi $sp,4	# Giving room to system
		j print	# Print result

 negativepositivemult: # -/-
 sub $t0,$zero,$t0 # Making first decimal positive
 move $a0,$t0   # First argument, first decimal
 move $a1,$t1	# Second argument, first float
 move $a2,$t2	# Third argument, second decimal
 move $a3,$t3	# Fourth argument, second float
 jal multiply
 sub $t0,$zero,$t0 # Making first decimal normal
 move $t4,$v0	# Multipation of decimals
 sub $t4,$zero,$t4 # Making result negative
 move $t5,$v1	# Multipation of floats
 addi $sp,4	# Giving room to system
 j print	# Print result

addition:
 lw $s4,0($sp)	# Getting Fifth argument / digit # of float
 addi $sp,-4	# Getting room for return adress
 sw $ra,0($sp)
 move $s0,$a0	# Getting First argument FirstDecimal
 move $s1,$a1	# Getting Second argument Firstfloat
 move $s2,$a2	# Getting Third argument SecondDecimal
 move $s3,$a3	# Getting Fourth argument Secondfloat
 addu $s1,$s1,$s3	# ReturnFloat=FirstFloat+secondFloat
 move $a0,$s1		# Make argument is Returnfloat
 jal digit		# digit(returnfloat)
 move $s5,$v0		# s5=digit(returnfloat)
 beq $s4,$s5,endadd	# if(digit(returnfloat)==digit(firstfloat)) j endadd /no overflow
 li $s6,1		# i=1
 li $s7,10		# j=10
 addi $s5,-1		# s5-=1
 overflowadd:		# Calculating overflow
 	addi $s5,-1	#s5-=1
	mult $s6,$s7	
	mflo $s6	# i=i*j
	bgt $s5,$zero,overflowadd # if s5>0 j overflowadd
	addu $s0,$s0,1		  # firstdecimal = Firstdecimal+1 /overflow
	subu $s1,$s1,$s6	  # Returnfloat = firstfloat+secondfloat-s6
 endadd:
	addu $s0,$s0,$s2	  # Returndecimal = firstdecimal + seconddecimal
 	lw $ra,0($sp)		  # Getting return adress from stack
 	addi,$sp,4		  # Giving room to system
	move $v0,$s0		  # Return argument 1= returndecimal
	move $v1,$s1		  # Return argument 2= returnfloat
 	jr $ra			  # Return
   
subtract:
 lw $s4,0($sp)	# Getting Fifth argument / digit # of float
 addi $sp,-4	# Getting room for return adress
 sw $ra,0($sp)
 move $s0,$a0	# Getting First argument FirstDecimal
 move $s1,$a1	# Getting Second argument Firstfloat
 move $s2,$a2	# Getting Third argument SecondDecimal
 move $s3,$a3	# Getting Fourth argument Secondfloat
 bge $s0,$s2,sub1	# if(firstdecimal>=seconddecimal) jumb sub1
 bgt $s1,$s3,sub3	# if(first float>secondfloat) jumb s3
 sub $s0,$s0,$s2	# resultdecimal=firstdecimal-seconddecimal
 sub $s1,$s3,$s1	# resultfloat=secondfloat-firstfloat (subtraction rules)
 j endsub		# jump endsub
 sub1:	bgt $s3,$s1,sub2	# if(secondfloat>firstfloat) jump s2
	sub $s0,$s0,$s2		# resultdecimal=firstdecimal-seconddecimal
	sub $s1,$s1,$s3		# resultfloat=firstfloat-secondfloat
	j endsub		# jump endsub

 sub2: 	li $s5,1		# i=1
	li $s6,10		# j=10
	borc2:
		mult $s5,$s6
		mflo $s5	# i=i*j
		addi $s4,-1	# digit-=1
		bgt $s4,$zero,borc2	# if(digit>0) jump borc2
	add $s1,$s1,$s5	# firstfloat=borc+firstfloat
	sub $s1,$s1,$s3	# resultfloat=firstfloat-secondfloat
	addi $s0,-1	# firstdecimal-=1 /borc alindi
	sub $s0,$s0,$s2	# resultdecimal=firstdecimal-seconddecimal
	j endsub	# jump endsub

 sub3: li $s5,1		# i=1
       li $s6,10	# j=10
       borc3:
		mult $s5,$s6
		mflo $s5	# i=i*j
		addi $s4,-1	# digit-=1
		bgt $s4,$zero,borc3	#if(digit>0) jump borc3
       add $s3,$s3,$s5	# secondfloat=borc+secondfloat
       sub $s1,$s3,$s1	# resultfloat=secondfloat-firstfloat
       addi $s2,-1	# seconddecimal-=1 / borc alindi
       sub $s0,$s0,$s2	# resultdecimal= firstdecimal-seconddecimal
       j endsub

 endsub:
	lw $ra,0($sp)	# Getting return adress from stack
 	addi,$sp,4	# Giving room to system
	move $v0,$s0	# Return value is returndecimal
	move $v1,$s1	# Return value is returnfloat
 	jr $ra		# Return

multiply:
 lw $s4,0($sp)	# Getting Fifth argument / digit # of float
 addi $sp,-4	# Getting room for return adress
 sw $ra,0($sp)
 move $s0,$a0	# Getting First argument FirstDecimal
 move $s1,$a1	# Getting Second argument Firstfloat
 move $s2,$a2	# Getting Third argument SecondDecimal
 move $s3,$a3	# Getting Fourth argument Secondfloat
 li $s5,1		# shift=1
 li $s6,10		# j=10
 multiplyshift:		# Calculating shiftamount
 	addi $s4,-1	# s4-=1
	mult $s5,$s6	
	mflo $s5	# shift=shift*j
	bgt $s4,$zero,multiplyshift # if s4>0 j multiplyshift
 mult $s0,$s5	# Shift first decimal like 12->1200
 mflo $s6 
 mult $s2,$s5	# Shift second decimal like 1->100
 mflo $s7	
 addu $s6,$s6,$s1	# Combine firstdecimal and first float
 addu $s7,$s7,$s3	# Combine seconddecimal and secondfloat
 multu $s6,$s7		# Multiply them
 mflo $s6
 multu $s5,$s5		# Find reverse shift amount
 mflo $s5
 divu $s6,$s5		# Divide multiplation
 mflo $v0		# Return decimal
 mfhi $v1		# Return float
 lw $ra,0($sp)	# Getting return adress from stack
 addi,$sp,4	# Giving room to system
 jr $ra		# Return

digit:
 addi $sp,$sp,-12 # make room on stack for 3 registers
 sw $t0, 8($sp)
 sw $t1, 4($sp)
 sw $t2, 0($sp)
 li $t0, 1	  # i=1
 li $t1, 0	  # digit=0
 li $t2, 10	  # k=10
 loopdigit: mult $t0,$t2	
 	    mflo $t0	# i=i*k
 	    addi $t1,1	# digit+=1
 	    bge $a0,$t0, loopdigit	# argument>=i jump loopdigit
 move $v0,$t1				# Make return argument digit
 lw $t2, 0($sp)
 lw $t1, 4($sp)
 lw $t0, 8($sp)
 addi $sp,$sp,12 # give rooms to system
 jr $ra	# Return
 
print:
 li $v0, 1		# system call code for print_int
 move $a0, $t0   	# loading firstdecimal to system
 syscall		# print firstdecimal

 li $v0, 4		# system call code for print_str
 la $a0, dot  		# loading "." to system
 syscall		# print dot

 li $v0, 1		# system call code for print_int
 move $a0, $t1   	# loading firstfloat to system
 syscall		# print firstfloat

 li $v0, 4		# system call code for print_str
 move $a0, $t8 		# loading operator to system
 syscall		# print operator

 li $v0, 1		# system call code for print_int
 move $a0, $t2   	# loading seconddecimal to system
 syscall		# print seconddecimal

 li $v0, 4		# system call code for print_str
 la $a0, dot  		# loading "." to system
 syscall		# print dot

 li $v0, 1		# system call code for print_int
 move $a0, $t3   	# loading secondfloat to system
 syscall		# print secondfloat

 li $v0, 4		# system call code for print_str
 la $a0, equals  	# loading " = " to system
 syscall		# print equals

 li $v0, 1		# system call code for print_int
 move $a0, $t4   	# loading result of decimals to system
 syscall		# print result of decimals

 li $v0, 4		# system call code for print_str
 la $a0, dot  		# loading "." to system
 syscall		# print dot

 move $a0,$t5		# Putting argument as result float
 jal digit		# digit(resultfloat)
 move $t6,$v0		# t6=digit(resultfloat)
 bge $t6,$t9,moveon	# if(#digit of resultfloat>inputfloats) j moveon
 addzero:	li $v0, 4		# system call code for print_str
 		la $a0, zero  		# loading "." to system
 		syscall			# print dot
		addi $t6,1		# add digit to result float
		blt $t6,$t9,addzero	# if(#digit of returnfloat less than inputfloat) j addzero
 moveon:	li $v0, 1		# system call code for print_int
 		move $a0, $t5  # loading result of floats to system
 		syscall		# print result of floats
 		j exit

error:
 li $v0, 4
 la $a0, err
 syscall
 j exit

error2:
 li $v0, 4
 la $a0, err2
 syscall
 j exit

exit:
 li $v0, 4		# system call code for print_str
 la $a0, exitText	# loading exitText to system
 syscall		# print exitText
 li $v0, 10		# system call code for exit
 syscall		# exit

