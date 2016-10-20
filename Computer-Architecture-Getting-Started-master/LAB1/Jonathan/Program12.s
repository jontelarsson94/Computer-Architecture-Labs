.data
array: .space 24
readInt: .asciiz "Enter an integer: "
Result: .asciiz "The bigger number is: "

.text

__start:

li $s0, 0 #first index, (i)
li $s2, 6 # max index
la $s1, array #get address start of array
la $a0, readInt


Program:
blt $s0, $s2, Loop_Read  #Loop through array

li $s0, 0 #first index, (i)
li $s2, 6 # max index
la $s1, array # purchases
lw $s3, 0($s1) #save biggest number

jal    Loop        # jump to Loop and save position to $ra

bge $s0, $s2, Print_Int_Exit  # gone through whole array

j Loop  #else jump to Loop


jal    Print_Int_Exit        # jump to Print_Int and save position to $ra

#Change value in biggest number register
Change_Value:
move $s3, $t1
addi $s0, $s0, 1 #add 1 to i
jr $ra

#Loop through indexes and read int from user
Loop_Read:
sll $t0, $s0, 2   #shift left to get address i*4
add $t0, $t0, $s1 # get right address
la $a0, readInt
jal Print_String
jal Read_Int
move $t1, $v0
sw $t1, 0($t0) #save value to array
addi $s0, $s0, 1 #add 1 to i
j Program

#Increase counter and load from array to $t1
Loop:
sll $t0, $s0, 2   #shift left to get address i*4
add $t0, $t0, $s1 # get right address
lw $t1, 0($t0) #load value into $t1
blt $s3, $t1, Change_Value  #Check if new number is bigger and Change Value if it is
addi $s0, $s0, 1 #add 1 to i
jr $ra

Print_Int:
li $v0, 1
syscall
jr $ra

Print_String:
li $v0, 4
syscall
jr $ra

Read_Int:
li $v0, 5
syscall
jr $ra

Print_Int_Exit:
la $a0, Result
jal Print_String
li $v0, 1
move $a0, $s3
syscall
j Exit


Exit:
li $v0, 10
syscall
