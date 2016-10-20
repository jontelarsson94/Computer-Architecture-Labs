__start:
	addi $s0, $zero, 5

loop:
	beq $s0, $zero, end

	addi $s0, $s0, -1
	beq $zero, $zero, loop
end:
	syscall