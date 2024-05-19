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
	li t5, 8 #elipse_a
	li t6, 8 #elipse_b
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
	#now creating pixel array
	mv s9, s1
	addi s9, s9, 1
	mul s9, s9, s2
	mv a0, s9
	slli s9, s9, 1
	li a7, 9
	ecall
	mv s11, a0
	
	#end of data in header
	
	li t2, 0
	mv t3, s9
	mv t0, s11
begin:	
	beq t2, t3, end
	li t1, 0xFFFF
	sh t1, (t0)
	addi t2, t2, 1
	addi t0, t0, 2
	beq t2, t3, end
	li t1, 0x0000
	sh t1, (t0)
	addi t2, t2, 1
	addi t0, t0, 2
	j begin
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
