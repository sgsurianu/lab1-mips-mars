# GarciaSebastian_Menor.asm
# Lee N (3..5), luego N enteros y muestra el menor.

.data
    prompt_n:    .asciiz "Ingrese la cantidad de numeros a comparar (entre 3 y 5): "
    prompt_val:  .asciiz "Ingrese un numero: "
    msg_res:     .asciiz "El numero menor es: "
    nl:          .asciiz "\n"

.text
.globl main
main:
    # --- Pedir N ---
    li   $v0, 4                # syscall print_string
    la   $a0, prompt_n         # dir de texto "Ingrese la cantidad..."
    syscall

    li   $v0, 5                # syscall read_int
    syscall
    move $t0, $v0              # $t0 <- N

    # --- Validar N en [3,5] ---
    li   $t1, 3
    blt  $t0, $t1, end         # si N < 3 -> terminar
    li   $t1, 5
    bgt  $t0, $t1, end         # si N > 5 -> terminar

    # --- Inicializar ---
    li   $t2, 0                # $t2 <- contador i = 0
    li   $t3, 2147483647       # $t3 <- menor (valor max int como inicio)

loop:
    # --- Pedir valor ---
    li   $v0, 4
    la   $a0, prompt_val
    syscall

    li   $v0, 5                # leer entero
    syscall
    move $t4, $v0              # $t4 <- numero actual

    # --- Si numero actual < menor, actualizar ---
    blt  $t4, $t3, update_min
    j    skip

update_min:
    move $t3, $t4              # menor <- actual

skip:
    addi $t2, $t2, 1           # i++
    blt  $t2, $t0, loop        # repetir mientras i < N

    # --- Imprimir resultado ---
    li   $v0, 4
    la   $a0, msg_res
    syscall

    li   $v0, 1                # print_int
    move $a0, $t3              # menor
    syscall

    li   $v0, 4                # salto de linea
    la   $a0, nl
    syscall

end:
    li   $v0, 10               # exit
    syscall
