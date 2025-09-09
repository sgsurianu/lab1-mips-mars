.data
    prompt_n:      .asciiz "Ingrese la cantidad de numeros a comparar (entre 3 y 5): "
    prompt_val:    .asciiz "Ingrese un numero: "
    result_msg:    .asciiz "El numero mayor es: "
    newline:       .asciiz "\n"

.text
.globl main
main:
    # Mostrar mensaje para cantidad de números
    li $v0, 4
    la $a0, prompt_n
    syscall

    # Leer cantidad de números
    li $v0, 5
    syscall
    move $t0, $v0      # $t0 ← cantidad de numeros (N)

    # Validar que N >= 3 y N <= 5
    li $t1, 3
    blt $t0, $t1, end   # Si N < 3, terminar
    li $t1, 5
    bgt $t0, $t1, end   # Si N > 5, terminar

    li $t2, 0           # $t2 ← contador (i = 0)
    li $t3, -2147483648 # $t3 ← mayor (inicializar con valor mínimo)

loop:
    # Mostrar mensaje para ingresar número
    li $v0, 4
    la $a0, prompt_val
    syscall

    # Leer número
    li $v0, 5
    syscall
    move $t4, $v0      # $t4 ← número actual

    # Comparar con el mayor actual ($t3)
    bgt $t4, $t3, update_max
    j skip_update

update_max:
    move $t3, $t4       # Actualizar mayor

skip_update:
    addi $t2, $t2, 1    # contador++

    # Si contador < N, repetir
    blt $t2, $t0, loop

    # Mostrar mensaje del resultado
    li $v0, 4
    la $a0, result_msg
    syscall

    # Imprimir el número mayor
    li $v0, 1
    move $a0, $t3
    syscall

    # Imprimir salto de línea
    li $v0, 4
    la $a0, newline
    syscall

end:
    li $v0, 10  # salir
    syscall
