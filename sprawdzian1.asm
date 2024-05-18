	.data
prompt1:	.asciz "Enter string1:\n"
prompt2:	.asciz "Enter string2:\n"
prompt3:	.asciz "Answer string:\n"
buf1:	.space 100
buf2:	.space 100
	.text
	.globl main
main:
	li a7, 4
	la a0, prompt1
	ecall
	li a7, 8
	la a0, buf1
	li a1, 100
	ecall
	li a7, 4
	la a0, prompt2
	ecall
	li a7, 8
	la a0, buf2
	ecall
	
	la t0, buf1
	lb t1, (t0) #znak w głównym stringu
	beqz t1, end
	la t6, buf1
	la t2, buf2
	j loop
load_next:
	addi t0, t0, 1
	lb t1, (t0)
	beqz t1, end
	la t2, buf2
loop:
	lb t3, (t2) #znak w drugim stringu
	beqz t3, is_ok
	beq t3, t1, load_next
	addi t2, t2, 1
	j loop
is_ok:
	sb t1, (t6)
	addi t6, t6, 1
	lb t5, (t6)
	beqz t5, end
	j load_next
end:
	li t5, 0
	sb t5, (t6)
	li a7, 4
	la a0, prompt3
	ecall
	la a0, buf1
	ecall
	li a7, 10
	ecall