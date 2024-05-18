	.data
prompt:	.asciz "Enter string to remove numbers from:\n"
but: 	.space 100
okay:	.space 100
	.text
	.globl main
main:
	li a7, 4
	la a0, prompt
	ecall
	li a7, 8
	la a0, but
	li a1, 100
	ecall
	li t0, 0x30
	li t1, 0x39
	la t2, okay
	la t3, but
	lb t4, (t3)
	beqz t4, end
loop:
	blt t4, t0, add
	blt t1, t4, add
	j next
add:
	sb t4, (t2)
	addi t2, t2, 1
next:
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
	
end:
	li a7, 4
	la a0, okay
	ecall
	li a7, 10
	ecall