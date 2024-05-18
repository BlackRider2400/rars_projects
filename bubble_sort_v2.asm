	.data
prompt:	.asciz "Enter string:\n"
buf:	.space 100
	.text
	.globl main
main:
	li a7, 4
	la a0, prompt
	ecall
	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	li t6, 1
load_start:
	beqz t6, end
	la t1, buf
	lb t2, (t1)
	beqz t2, end
	la t3, buf
	addi t3, t3, 1
	lb t4, (t3)
	beqz t4, end
	li t6, 0
loop:
	blt t4, t2, swap
load:
	addi t1, t1, 1
	addi t3, t3, 1
	lb t2, (t1)
	lb t4, (t3)
	beqz t4, load_start 
	j loop
swap:
	sb t4, (t1)
	sb t2, (t3)
	li t6, 1
	j load
end:
	li a7, 4
	la a0, buf
	ecall
	li a7, 10
	ecall
	