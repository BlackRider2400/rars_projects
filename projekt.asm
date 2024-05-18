# Sample program that writes to a new file.
#   by Kenneth Vollmar and Pete Sanderson

        .data
fout:   .asciz "testout.bmp"      # filename for output
headerBuffer: .space 0x1A
buffer: .space 128
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
	
	la t0, headerBuffer #iterator on buffer address
	li t1, 'B'
	sb t1, (t0)
	addi t0, t0, 1
	li t1, 'M'
	sb t1, (t0)
	addi t0, t0, 1
	#size
	li t1, 0x9A
	sh t1, (t0)
	addi t0, t0, 2
	li t1, 0x00
	sh t1, (t0)
	addi t0, t0, 2
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
	li t1, 0x08
	sh t1, (t0)
	addi t0, t0, 2
	#height
	li t1, 0x08
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
	li t2, 0
	li t3, 64
	la t0, buffer
begin:	
	beq t2, t3, end
	li t1, 0xFFFFFFFF
	sh t1, (t0)
	addi t2, t2, 1
	addi t0, t0, 2
	beq t2, t3, end
	li t1, 0x00000000
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
	li   a2, 0xC0       # hardcoded buffer length
	ecall             # write to file
	li   a7, 64       # system call for write to file
	mv   a0, s6       # file descriptor
	la   a1, buffer # address of buffer from which to write
	li   a2, 128       # hardcoded buffer length
	ecall             # write to file
	###############################################################
	# Close the file
	li   a7, 57       # system call for close file
	mv   a0, s6       # file descriptor to close
	ecall             # close file
	###############################################################