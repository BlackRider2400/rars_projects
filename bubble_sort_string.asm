	.data
prompt:	.asciz	"Enter string:\n"
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
	la t0, but #adres początku but, nie zmieniamy
	la t1, but #adres pierwszego elementu
	li t5, 0x0A
	li t6, 1 #swapped zmienna
	lb t2, (t1) #wartosc pierwszego elementu
	beqz t2, end
	la t3, but #adres drugiego iteratora
	addi t3, t3, 1
	lb t4, (t3)  #wartosc kolejnego elementu
	beqz t4, end
	#t5 użyjemy jako temp do swappowania
loop:
	beqz t6, end
	li t6, 0
	blt t4, t2, swap
	j end
load:
	addi t1, t1, 1
	addi t3, t3, 1
	lb t2, (t1)
	lb t4, (t3)
	beqz t4, load_from_start
	beq t4, t5, load_from_start
	j loop
load_from_start:
	mv t1, t0
	lb t2, (t1)
	mv t3, t0
	addi t3, t3, 1
	lb t4, (t3)
	j loop
swap:
	sb t4, , (t1)
	sb t2, (t3)
	li t6, 1
	j load
end:
	li a7, 4
	la a0, but
	ecall
	li a7, 10
	ecall
