# Sample program that writes to a new file.
#   by Kenneth Vollmar and Pete Sanderson

        .data
fout:   .asciz "testout14.bmp"      # filename for output
headerBuffer: .space 0x1A
        .text 
        .globl main
main:
	#header:
	#rozszerzenie 2B 0x42 0x4D
	#rozmiar 4B 0x9F
	#reserved 4B 0x00
	#offset 4B 0x1A
	#wielkość headera 4B 0x10
	#width 2B 0x08
	#height 2B 0x08
	#planes 2B 0x01
	#bits per pixel 2B 0x08
	#czarny 2B 0x00 0x00
	#biały 2B 0xFF 0xFF
	li t5, 30 #elipse_a
	li t6, 20 #elipse_b
	#calculating width
	mv s1, t5
	slli s1, s1, 1
	addi s1, s1, 1
	#calculating height
	mv s2, t6
	slli s2, s2, 1
	addi s2, s2, 1
	#calculating size
	mv s10, s1
	mul s10, s10, s2
	slli s10, s10, 1
	add s10, s2, s10
	addi s10, s10, 0x1A
	
	
	la t0, headerBuffer #iterator on buffer address
	li t1, 'B'
	sb t1, (t0)
	addi t0, t0, 1
	li t1, 'M'
	sb t1, (t0)
	addi t0, t0, 1
	#size
	mv t1, s10
	sw t1, (t0)
	addi t0, t0, 4
	#reserved
	li t1, 0x00
	sh t1, (t0)
	addi t0, t0, 2
	li t1, 0x00
	sh t1, (t0)
	addi t0, t0, 2
	#offset
	li t1, 0x1A 
	sh t1, (t0)
	addi t0, t0, 2
	li t1, 0x00
	sh t1, (t0)
	addi t0, t0, 2
	#header size
	li t1, 0x0C
	sh t1, (t0)
	addi t0, t0, 2
	li t1, 0x00
	sh t1, (t0)
	addi t0, t0, 2
	#width
	mv t1, s1
	sh t1, (t0)
	addi t0, t0, 2
	#height
	mv t1, s2
	sh t1, (t0)
	addi t0, t0, 2
	#planes
	li t1, 0x01
	sh t1, (t0)
	addi t0, t0, 2
	#bpp
	li t1, 0x10
	sh t1, (t0)
	addi t0, t0, 2
	
	#end of data in header
	
	#now creating pixel array
	#s9 is pixel array size
	mv s9, s1
	addi s9, s9, 1
	mul s9, s9, s2
	mv a0, s9
	slli s9, s9, 1
	li a7, 9
	ecall
	mv s11, a0
	
	#setting for start
	#x
	li t0, 0
	#y
	mv t1, t6
	#a2
	mv s5, t5
	mul s5, s5, s5
	#b2
	mv s6, t6
	mul s6, s6, s6
	# fa2
	mv s7, s5
	slli s7, s7, 2
	# fb2
	mv s8, s6
	slli s8, s8, 2
	
	#d1 t2
	mul t3, t5, s5
	srai t2, s5, 2
	sub t2, t2, t3
	add t2, t2, s6
	
	#adding one to width
	addi s1, s1, 1
	
loop_1:
	mul s0, t0, s8
	mul s10, t1, s7
	bgt s0, s10, set_d2
	#write
	li s10, 0xFFFF	
	#1
	add s0, t1, t6
	mul s0, s0, s1
	add s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#2
	add s0, t1, t6
	mul s0, s0, s1
	sub s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#3
	sub s0, t6, t1
	mul s0, s0, s1
	add s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#4
	sub s0, t6, t1
	mul s0, s0, s1
	sub s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#end of write
	addi t0, t0, 1
	mul t3, t0, s8
	add t3, t3, s6
	bltz t2, post1
	addi, t1, t1, -1
	mul s0, t1, s7
	sub t3, t3, s0
post1:
	add t2, t2, t3
	j loop_1
set_d2:
	#d2 t2
	addi t3, t0, 1
	mul t2, t3, t3
	mul t2, t2, s6
	addi t3, t1, -1
	mul s0, t3, t3
	mul s0, s5, s0
	add t2, t2, s0
	mul s0, s5, s6
	add t2, t2, s0
loop_2:
	bltz t1, end
		#write
	li s10, 0xFFFF	
	#1
	add s0, t1, t6
	mul s0, s0, s1
	add s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#2
	add s0, t1, t6
	mul s0, s0, s1
	sub s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#3
	sub s0, t6, t1
	mul s0, s0, s1
	add s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#4
	sub s0, t6, t1
	mul s0, s0, s1
	sub s0, s0, t0
	add s0, s0, t5
	slli s0, s0, 1
	add s0, s0, s11
	sh s10, (s0)
	#end of write
	mul t3, s7, t1
	add t3, t3, s5
	addi t1, t1, -1
	bgtz t2, post_2
	addi t0, t0, 1
	mul s0, s8, t0
	add t3,t3, s0
post_2:
	add t2, t2, t3
	j loop_2
	
end:
	###############################################################
	#Just writing header
	# Open (for writing) a file that does not exist
	li   a7, 1024     # system call for open file
	la   a0, fout     # output file name
	li   a1, 1        # Open for writing (flags are 0: read, 1: write)
	ecall             # open a file (file descriptor returned in a0)
	mv   s6, a0       # save the file descriptor
	###############################################################
	# Write to file just opened
	li   a7, 64       # system call for write to file
	mv   a0, s6       # file descriptor
	la   a1, headerBuffer # address of buffer from which to write
	li   a2, 0x1A       # hardcoded buffer length
	ecall             # write to file
	li   a7, 64       # system call for write to file
	mv   a0, s6       # file descriptor
	mv   a1, s11 # address of buffer from which to write
	mv   a2, s9   # hardcoded buffer length
	ecall             # write to file
	###############################################################
	# Close the file
	li   a7, 57       # system call for close file
	mv   a0, s6       # file descriptor to close
	ecall             # close file
	###############################################################
