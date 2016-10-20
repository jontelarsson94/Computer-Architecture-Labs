# Task 3: Fill the array from the Keyboard
# In the second task, the array was already allocated on the data memory.
# Now we need to improve Task 2 to be more practical.
# Rather than entering the values of the purchases in the
# compile time, we need to enter all the purchases in the
# run time (when the program is executed).
# The equivalent C code would look something like this:
# //read the inputs from the keyboard
# int i, max, purchases[6];
# for (i = 0; i <6; i++)
#             purchases[i] = read_int();
# //Finding the largest value in the array
# max = arr [0];
# for (i = 1; i <6; i++)
#             if (purchases[i]> max)
#                         max = arr [i];
# //Print the largest number
#  print_int(max);

.data
  prompt: .asciiz "Enter an integer: "
  result: .asciiz "The larger integer is: "
  array: .word 0:24

.text
main:
  # Loop through array reading input
  li $t1, 0 # i
  li $t2, 6 # 6
  la $t0, array # purchases
  read_loop:
    la $a0, prompt
    jal Print_String
    jal Read_Int
    sw $v0, 0($t0) # purchases[i] = read_int
    addi $t0, $t0, 4 # purchases++
    addi $t1, $t1, 1 # i++
    blt $t1, $t2, read_loop # while i < 6
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

Read_Int:
  li $v0, 5 # Set syscall to read_int
  syscall
  jr $ra

Print_Int:
  li $v0, 1 # Set syscall to print_int
  syscall
  jr $ra

end:
  li $v0, 10
  syscall
