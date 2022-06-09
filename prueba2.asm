.data
myarray: .space 20
arrayfinal: .space 20
mensaje: .asciiz "\n Ingresar valor entero: "

.text
.globl main

main:

    li $t0, 0
    la $t1, myarray

loop:
     #imprimimos nuestro mensaje
    la $a0, mensaje
    li $v0, 4
    syscall

    #leemos el entero
    li $v0, 5
    syscall
    move $t2, $v0 

    #guardamos nuestros valores en el array
    sw $t2, 0($t1)

    #++ en el arreglo (incrementar numero)
    addi $t1, $t1, 4
    #++ contador de ciclo
    addi $t0, $t0, 1
    blt $t0, 5, while

    li $t0, 0
    la $t1, myarray
    la $t8, arrayfinal

loop_even_numbers:
    lw $t2, 0($t1)
    
    addi $t1, $t1, 4
    andi $t9, $t2, 1
    addi $t0, $t0, 1
    beq $t9, $zero, insert_even
    blt $t0, 5, loop_even_numbers
    li $t0, 0
    la $t1, myarray
    j loop_odd_numbers

insert_even:
    sw $t2, 0($t8)
    addi $t8, $t8, 4
    j loop_even_numbers 

loop_odd_numbers:
    lw $t2, 0($t1)
    
    addi $t1, $t1, 4
    andi $t9, $t2, 1
    addi $t0, $t0, 1
    bne $t9, $zero, insert_odd
    blt $t0, 5, loop_odd_numbers
    li $t0, 0
    la $t1, arrayfinal
    j print_array
    
insert_odd:
    sw $t2, 0($t8)
    addi $t8, $t8, 4
    j loop_odd_numbers

print_array:


    lw $t2, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    move $a0, $t2
    li $v0, 1
    syscall
    blt $t0, 5, print_array

    li $v0, 10
    syscall