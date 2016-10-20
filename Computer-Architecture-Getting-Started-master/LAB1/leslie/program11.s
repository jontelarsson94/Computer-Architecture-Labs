# Task 2: Loops and Arrays
# Implement a loop that finds the largest value in an array called purchases,
# which is allocated in the data segment and consisting of 6 elements.
# After finding the largest value, print it on the screen.
# The equivalent C code is:
# int max
# max = purchases[0]
# for(int i=1; i < 6 ; i++)
#   if(purchases[i] > max) max = purchases[i];
# print_int(max);

.data
  result: .asciiz "The larger integer is: "
  array: .word 450, 67, 3, -23, 1000, 765000

.text
main:
  # Loop through array checking for largest integer
  li $t1, 0 # i
  li $t2, 6 # 6
  la $t0, array # purchases
  lw $s0, 0($t0) # max = purchases[0]
  loop:
    lw $t3, 0($t0) # purchases[i]
    ble $t3, $s0, skip # if purchases[i] < max
    move   $s0, $t3    # max = purchases[i]
    skip:
    addi $t0, $t0, 4 # purchases++
    addi $t1, $t1, 1 # i++
    blt $t1, $t2, loop # while i < 6
  # Print results
  la $a0, result
  jal Print_String
  move $a0, $s0
  jal Print_Int
  jal end


Print_String:
 li $v0, 4 # Set syscall to print_string
 syscall
 jr $ra

Print_Int:
 li $v0, 1 # Set syscall to print_int
 syscall
 jr $ra

end:
  li $v0, 10
  syscall
