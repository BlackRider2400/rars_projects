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
	li t3, 0x30 #wartosc '0'
	li t4, 0x39 #wartosc '9'
	la t1, buf #adress znaku w podanym stringu
	lb t2, (t1) #znak w podanym stringu
	beqz t2, end
	j loop
load:
	addi t1, t1, 1
	lb t2, (t1)
	beqz t2, end
loop:
	blt t2, t3, load
	bgt t2, t4, load
	sub t5, t4, t2 #odejmujemy od wartosci 9 aby wiedziec ile brakuje
	add t2, t3, t5 #dodajemy aby uzyskać dopełnienie, dodajemy oczywiscie od wartosci zero
	sb t2, (t1)
	j load
end:
	li a7, 4
	la a0, buf
	ecall
	li a7, 10
	ecall