# Task 1: Conditional jump
# Read two integers from the keyboard, then display the greater number on the screen.
# Hints: write and use two procedures Read_Int and Print_In
# The name of the file: Program10.s

.data
  prompt: .asciiz "Enter an integer: "
  result: .asciiz "The larger integer is: "

.text
main:
  # Prompt 1st string
  la $a0, prompt
  jal Print_String
  # Read 1st integer
  jal Read_Int
  move $s1, $v0
  # Prompt 2nd string
  la $a0, prompt
  jal Print_String
  # read 2nd integer
  jal Read_Int
  move $s2, $v0
  # compare integers
  bge $s1, $s2, endif
   move $s1, $s2 # move larger integer into $s1
  endif:
  # print larger integer
  la $a0, result
  jal Print_String
  move $a0, $s1
  jal Print_Int
  jal end

Read_Int:
 li $v0, 5 # Set syscall to read_int
 syscall
 jr $ra

Print_Int:
  li $v0, 1 # Set syscall to print_int
  syscall
  jr $ra

Print_String:
 li $v0, 4 # Set syscall to print_string
 syscall
 jr $ra

end:
  li $v0, 10
  syscall
