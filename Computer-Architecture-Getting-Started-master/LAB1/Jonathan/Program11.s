.data
Result: .asciiz "The bigger number is: "
array: .word 20, 5, 17, 90, 92, -520

.text

__start:


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

#Increase counter and load from array to $t1
Loop:
sll $t0, $s0, 2   #shift left to get address i*4
add $t0, $t0, $s1 # get right address
lw $t1, 0($t0) #load value into array
blt $s3, $t1, Change_Value  #Check if new number is bigger and Change Value if it is
addi $s0, $s0, 1 #add 1 to i
jr $ra

Print_String:
li $v0, 4
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
