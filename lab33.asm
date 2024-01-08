.data
file_loc: .asciiz "test1.txt" 
buffer: .space 1024
new_line: .asciiz "\n" 

#error strings
readErrorMsg: .asciiz "\nError in reading file\n"
openErrorMsg: .asciiz "\nError in opening file\n"
info:    .asciiz "Student infromation :"
id:      .asciiz "\nID: "
name:    .asciiz "\nName: "
weight:  .asciiz "\nWeight: "
height:  .asciiz "\nHeight: "
medical: .asciiz "\nMedical history: "
.text
main:

openFile:

li $v0, 13          #syscall 13 - open file
la $a0, file_loc        #passing in file name
li $a1, 0               #set to read mode
li $a2, 0               #mode is ignored
syscall
move $s0, $v0           #else save the file descriptor

#Read input from file
li $v0, 14          #syscall 14 - read filea
move $a0, $s0           #sets $a0 to file descriptor
la $a1, buffer          
li $a2, 1024         
syscall             
move $s1, $v0


li   $v0, 16       # system call for close file
move $a0, $s0      # file descriptor to close
syscall            # close file

li $t0, 0 #counter
la $a1, buffer
setup:
	beq $t0, 0, ID
	beq $t0, 1, Name
	beq $t0, 2, Weight
	beq $t0, 3, Height
	beq $t0, 4, Medical
	j endProgram
	
loop:
	lb $t1, 0($a1)
	li $t2, 10
	beq $t1, $t2, endProgram
	beq $t1, $0, endProgram
	li $t2, 44
	beq $t1, $t2, addcounter
	move $a0, $t1
	li $v0, 11
	syscall
	addi $a1, $a1, 1
	j loop
	
addcounter:
	addi $t0,$t0,1
	j setup
	
Name:
	la $a0, name
	li $v0, 4
	syscall
	addi $a1, $a1, 1
	j loop
	
ID:
	la $a0, info
	li $v0, 4
	syscall
	la $a0,id
	li $v0,4
	syscall
	j loop
Weight:
	la $a0,weight
	li $v0,4
	syscall
	addi $a1,$a1,1
	j loop
	
Height:
	la $a0, height
	li $v0, 4
	syscall
	addi $a1, $a1, 1
	j loop
Medical:
	la $a0, medical
	li $v0, 4
	syscall
	addi $a1, $a1, 1
	j loop
	
endProgram:
li $v0, 10
syscall