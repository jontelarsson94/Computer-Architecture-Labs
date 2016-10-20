# Task 1: Conditional jump
# Read two integers from the keyboard, then display the greater number on the screen.
# Hints: write and use two procedures Read_Int and Print_In
# The name of the file: Program10.s

.data
readInt: .asciiz "Enter an integer: "
Result: .asciiz "The bigger number is: "

.text

__start:

la $a0, readInt #print string for reading int
jal Print_String #jump to Print_String and link back
jal Read_Int #jump to Read_Int and link back
move $s0, $v0 #move read int to $t0
la $a0, readInt #print string for reading int
jal Print_String #jump to Print_String and link back
jal Read_Int #jump to Read_Int and link back
move $s1, $v0 #move read int to $t1

la $a0, Result
jal Print_String
bge    $s0, $s1, First_Bigger  # if  >=  then
j Second_Bigger

First_Bigger:
move $a0, $s0
jal    Print_Int        # jump to  and save position to $ra
j Exit

Second_Bigger:
move $a0, $s1
jal Print_Int
j Exit

Print_String:
li $v0, 4
syscall
jr $ra

Read_Int:
li $v0, 5
syscall
jr $ra

Print_Int:
li $v0, 1
syscall
jr $ra

Exit:
li $v0, 10
syscall
