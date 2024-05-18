	.data
prompt:	.asciz "Enter string :\n"
but:	.space 100
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
	li t0, 'a'
	li t1, 'z'
	li t2, 0x20
	la t3, but
	lb t4, (t3)
	beqz t4, end
loop:
	blt t4, t0, next
	bgt t4, t1, next
	sub t4, t4, t2
	sb t4, (t3)
next:
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
end:
	li a7, 4
	la a0, but
	ecall
	li a7, 10
	ecall
