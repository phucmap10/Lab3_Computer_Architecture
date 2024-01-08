.data
counter_array: .space 400
data_array:   .space 100
comma:        .asciiz ", "
period:       .asciiz "."
result_str:   .asciiz ";"
input_str:    .asciiz "abhffeegghh"

.text
.globl main

main:
    la $t2, input_str
    la $s0, data_array
    la $s1, counter_array
    li $t1, 1
    lb $t3, 0($t2)
    sb $t3, 0($s0)
    sw $t1, 0($s1)
    addi $t2, $t2, 1
    li $t3, 1

main_loop:
    la $s0, data_array
    la $s1, counter_array
    lb $t4, 0($t2)
    li $t6, 0

check:
    beq $t4, $zero, print_result
    beq $t6, $t3, finish
    lb $s2, 0($s0)
    lw $s3, 0($s1)
    beq $t4, $s2, case1
    addi $s0, $s0, 1
    addi $s1, $s1, 4
    addi $t6, $t6, 1
    j check

case1:
    addi $s3, $s3, 1
    sw $s3, 0($s1)
    addi $t2, $t2, 1
    j main_loop

finish:
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    li $t6, 1
    sw $t6, 0($s1)
    sb $t4, 0($s0)
    j main_loop

print_result:
    la $s0, data_array
    la $s1, counter_array
    li $t1, 0
    li $t2, 0
    lb $t5, 0($s0)
    lw $t6, 0($s1)
    li $t4, -1

outer_loop:
    beq $t1, $t3, end_program
    li $t0, 0
    li $t2, 0
    la $s0, data_array
    la $s1, counter_array

inner_loop:
    beq $t2, $t3, print_char
    lb $t5, 0($s0)
    lw $t6, 0($s1)
    slt $t7, $t6, $zero
    bne $t7, $zero, case2
    beq $t0, $zero, start
    slt $t7, $t6, $s3
    bne $t7, $zero, swap
    beq $t6, $s3, compare_ascii

case2:
    addi $t2, $t2, 1
    addi $s0, $s0, 1
    addi $s1, $s1, 4
    j inner_loop

start:
    addi $t0, $t0, 1
    lb $s2, 0($s0)
    lw $s3, 0($s1)
    move $s4, $s1
    j case2

swap:
    move $s2, $t5
    move $s3, $t6
    move $s4, $s1
    j case2

compare_ascii:
    slt $t7, $s2, $t5
    bne $t7, $zero, case2
    j swap

print_char:
    addi $t1, $t1, 1
    li $v0, 11
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    beq $t1, $t3, outer_loop
    li $v0, 4
    la $a0, result_str
    syscall
    sw $t4, 0($s4)
    j outer_loop

end_program:
    li $v0, 4
    la $a0, period
    syscall
    li $v0, 10
    syscall