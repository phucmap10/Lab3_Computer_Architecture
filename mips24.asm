.data
InputArray:     .space 40
UniqueArray:    .space 40
OccurrenceArray:.space 40
separator:      .asciiz ", "
userPrompt:     .asciiz "Enter an element: "
uniqueLabel:    .asciiz "Unique values: "
duplicateLabel: .asciiz "Duplicated values: "
repeatLabel:    .asciiz "repeated "
timesLabel:     .asciiz " times"
semicolonLabel: .asciiz "; "
periodLabel:    .asciiz ". "
.text
.globl main
main:
    li $t0, 10               # Set array size
    li $t1, 0                # Initialize user input loop counter
    la $t2, InputArray       # Set pointer to InputArray
    li $t3, 0                # Initialize counter for copying unique elements to UniqueArray
    li $t7, 0                # Initialize counter for printing unique values
    li $t5, 1                # Constant 1 for loop control

    # Input loop
inputLoop:
    beq $t1, $t0, startProcessing
    li $v0, 4
    la $a0, userPrompt
    syscall
    li $v0, 5
    syscall
    sw $v0, 0($t2)
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    j inputLoop

startProcessing:
    la $t2, InputArray
    li $t1, 1
    la $s0, UniqueArray
    la $s1, OccurrenceArray
    li $t3, 1
    lw $t4, 0($t2)
    sw $t4, 0($s0)
    addi $s0, $s0, 4
    sw $t3, 0($s1)
    addi $s1, $s1, 4
    addi $t2, $t2, 4

mainLoop:
    beq $t1, $t0, endProgram
    la $s0, UniqueArray
    la $s1, OccurrenceArray
    lw $t4, 0($t2)
    li $t6, 0

checkDuplicates:
    beq $t6, $t3, doneChecking
    lw $s2, 0($s0)
    lw $s3, 0($s1)
    beq $t4, $s2, foundDuplicate
    addi $s0, $s0, 4
    addi $s1, $s1, 4
    addi $t6, $t6, 1
    j checkDuplicates

foundDuplicate:
    addi $s3, $s3, 1
    sw $s3, 0($s1)
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    j mainLoop

doneChecking:
    addi $t3, $t3, 1
    li $t6, 1
    sw $t4, 0($s0)
    sw $t6, 0($s1)
    addi $t1, $t1, 1
    addi $t2, $t2, 4
    j mainLoop

endProgram:
    la $s0, UniqueArray
    la $s1, OccurrenceArray
    li $t5, 1
    li $t7, 0
    li $t1, 0
    la $v0, 4
    la $a0, uniqueLabel
    syscall
printUniqueValues:
    beq $t1, $t3, printDuplicateValues
    lw $s2, 0($s0)
    lw $s3, 0($s1)
    addi $s0, $s0, 4
    addi $s1, $s1, 4
    addi $t1, $t1, 1
    bne $s3, $t5, printUniqueValues
    addi $t7, $t7, 1
    beq $t7, $t5, printRemainingUniqueValues
    li $v0, 4
    la $a0, separator
    syscall

printRemainingUniqueValues:
    li $v0, 1
    move $a0, $s2
    syscall
    j printUniqueValues

printDuplicateValues:
    li $v0, 4
    la $a0, periodLabel
    syscall
    la $a0, duplicateLabel
    syscall
    la $s0, UniqueArray
    la $s1, OccurrenceArray
    li $t7, 0
    li $t1, 0

printDuplicatesLoop:
    beq $t1, $t3, endPrintingDuplicates
    lw $s2, 0($s0)
    lw $s3, 0($s1)
    addi $s0, $s0, 4
    addi $s1, $s1, 4
    addi $t1, $t1, 1
    beq $s3, $t5, printDuplicatesLoop
    addi $t7, $t7, 1
    beq $t7, $t5, printRemainingDuplicates

    la $a0, separator
    syscall

printRemainingDuplicates:
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, separator
    syscall
    la $a0, repeatLabel
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    li $v0, 4
    la $a0, timesLabel
    syscall
    j printDuplicatesLoop

endPrintingDuplicates:
    li $v0, 4
    la $a0, periodLabel
    syscall

    li $v0, 10
    syscall