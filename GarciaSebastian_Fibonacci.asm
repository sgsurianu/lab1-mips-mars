# GarciaSebastian_Fibonacci.asm
# Pide k, imprime los k primeros terminos de Fibonacci (0,1,1,2,3,...) y
# muestra la suma total de los terminos impresos.

.data
    prompt_k:     .asciiz "Cuantos terminos de la serie Fibonacci desea generar? "
    msg_series:   .asciiz "Serie Fibonacci: "
    msg_sum:      .asciiz "Suma de la serie: "
    comma_sp:     .asciiz ", "
    nl:           .asciiz "\n"

.text
.globl main
main:
    # --- Preguntar k ---
    li   $v0, 4              # print_string
    la   $a0, prompt_k
    syscall

    li   $v0, 5              # read_int
    syscall
    move $t6, $v0            # $t6 <- k (cantidad de terminos)

    # --- Validar k >= 1 (si no, salir) ---
    li   $t7, 1
    blt  $t6, $t7, end       # si k < 1 -> terminar

    # --- Inicializar serie ---
    li   $t0, 0              # $t0 <- a (F(0))
    li   $t1, 1              # $t1 <- b (F(1))
    li   $t2, 0              # $t2 <- i (contador)
    li   $t5, 0              # $t5 <- suma acumulada

    # --- Encabezado de la serie ---
    li   $v0, 4
    la   $a0, msg_series
    syscall

fib_loop:
    # Imprimir separador ", " si i > 0
    bgtz $t2, print_sep
    j    print_term

print_sep:
    li   $v0, 4
    la   $a0, comma_sp
    syscall

print_term:
    # Imprimir termino actual: a
    li   $v0, 1              # print_int
    move $a0, $t0
    syscall

    # suma += a
    addu $t5, $t5, $t0

    # siguiente = a + b
    addu $t3, $t0, $t1

    # rotar: a <- b ; b <- siguiente
    move $t0, $t1
    move $t1, $t3

    # i++
    addi $t2, $t2, 1

    # mientras i < k, repetir
    blt  $t2, $t6, fib_loop

    # Salto de linea
    li   $v0, 4
    la   $a0, nl
    syscall

    # Imprimir "Suma de la serie: "
    li   $v0, 4
    la   $a0, msg_sum
    syscall

    # Imprimir suma
    li   $v0, 1
    move $a0, $t5
    syscall

    # Salto de linea final
    li   $v0, 4
    la   $a0, nl
    syscall

end:
    li   $v0, 10             # exit
    syscall
