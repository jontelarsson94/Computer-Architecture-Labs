.globl __start

.data

mem_value: .word 73

.text

__start:
	# Set the loop index to 3
	addi $s0, $zero, 3

loop:
	# Evaluate the branch condition
	beq $s0, $zero, exit

	# Update the global variable mem_value (in a quite inefficient way)
	lw $s1, mem_value
	addi $s2, $s1, 1
	addi $s1, $s2, 1
	sw $s1, mem_value

	# Update the loop index and jump to the beginning
	addi $s0, $s0, -1
	j loop

exit:
	syscall
