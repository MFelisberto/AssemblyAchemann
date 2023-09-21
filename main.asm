.text
	.global main
main:
	la $a0, nPrograma    # $a0 <- "Programa Ackermann\n"
    li $v0, 4		     # Imprime nPrograma
	syscall
	la  $a0, integrantes # $a0 <-"Componentes: <Arthur, Marcelo e Mateus\n"
    li  $v0, 4           # Imprime integrantes
    syscall
   
loop: # la�o para o programa seguir rodando enquanto o usuario não digitar um numero negativo..

    la  $a0, msgInicial  # $a0 <-"\nDigite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução:\n"
    li  $v0, 4           # Imprime msgInicial
    syscall
   
    li $v0, 5		    # Ler o 'm' do teclado
	syscall
	bltz $v0, fim		# Se o 'm' for negativo encerra o programa
	move $t0, $v0		# $t0 será nosso registrador para o 'm'
	
	li $v0, 5		    # Ler o 'n' do teclado
	syscall
	bltz $v0, fim		# Se o 'n' for negativo encerra o programa
	move $t1, $v0		# $t1 será nosso registrador para o 'n'

	subi $sp, $sp, 12	# cria pilha de 3 espaços(12 bytes)
	sw $t0, 0($sp)		# $t0 <- no incio da fila('m') sw = save word
	sw $t1, 4($sp)		# $t1 <- no meio da fila('n')  sw = save word
	sw $ra, 8($sp)		# $ra <- no final da fila      sw = save word
	
	jal ackermann		# vai para a função
	
    lw $ra, 8($sp)		# $ra <- 8($sp)
	addiu $sp, $sp, 12  # exclui
	
    la $a0, string0	    # $a0 <- "A(" 
	li $v0, 4
	syscall
	
    move $a0, $t0       # 'm'
    li $v0, 1
	syscall
	
    la $a0, string1     # $a0 <- ","
	li $v0, 4
	syscall
	
	move $a0, $t1       # 'n'
	li $v0, 1
	syscall
	
	la $a0, string2     # $a0 <- ")= " 
	li $v0, 4
	syscall
	
	move $a0, $a1		# $a0 <- $a1(resutado)
	li $v0, 1		
	syscall

	j loop

# dividi as comparações em mais passos para facilitar
ackermann: 
	lw $a0, 0($sp)		    # $a0 <- $t0('m')  lw = load word
	lw $a1, 4($sp)		    # $a1 <- $t1('n')  lw = load word
	beqz $a0, m_equals_zero # se 'm'= 0 vai para m_equals_zero:
    bgtz $a0,m_bigger_zero	# se 'm'> 0 vai para m_bigger_zero
	jr $ra			        # retorno
	
m_equals_zero:	
	addi $a1, $a1, 1	# 'n' + 1
	jr $ra			    # retorno
	
m_bigger_zero:
	bgtz $a1, n_bigger_zero	# se 'n'> 0 vai para n_bigger_zero
	
    subi $a0, $a0, 1	    # $a0 <- 'm' - 1
	addi $a1, $a1, 1	    # $a1 <- 'n' = 1
	subi $sp, $sp, 12	    # cria pilha de 3 espaços(12 bytes)
	
    sw $a0, 0($sp)		    # 0($sp) <- 'm' ~posição 0
	sw $a1, 4($sp)		    # 4($sp) <- 'n' ~posição 1
	sw $ra, 8($sp)		    # 8($sp) <- $ra ~posição 2
	
    jal ackermann		    # volta para a ackermann com novos valores 'm' e 'n'
	
    lw $ra, 8($sp)		    # $ra = pilha[2]
	addiu  $sp, $sp, 12     # exclui
	
    jr $ra			        # retorno
	
n_bigger_zero:
	subi $a1, $a1, 1	# $a1 <- 'n'-1
	subi $sp, $sp, 16	# cria pilha de 4(16 bytes)
	
    sw $a0, 0($sp)		# 0($sp) <- 'm' ~posição 0
	sw $a1, 4($sp)		# 4($sp) <- 'n' ~posição 1
	sw $ra, 8($sp)		# 8($sp) <- $ra ~posição 2
	
    subi $a0, $a0, 1	# $a0 <- 'm' - 1
	sw $a0, 12($sp)		# 12($sp) <- 'm'-1 ~posição 3
	
    jal ackermann		# volta para a ackermann com novo valores
	
    lw $a0, 12($sp)		# $a0 <- 12($sp) ~usando lw e sw para salvar na pilha, fica facil de trabalhar com os valores usando poucos registradores
	sw $a0, 0($sp)		# 0($sp) <- 'm'
	sw $a1, 4($sp)		# 4($sp) <- 'n'
	
    jal ackermann		# volta para a ackermann com novos valores 
	
    lw $ra, 8($sp)		# $ra <- 8($sp) 
	addiu $sp, $sp, 16	# exclui
	jr $ra			    # retorno
	
fim:
	li $v0, 10		    # encerra o programa
	syscall
		
	
.data
	nPrograma:    .asciiz "Programa Ackermann\n"
    integrantes:  .asciiz "Componentes: <Arthur, Marcelo e Mateus\n"
	msgInicial:   .asciiz "\nDigite os parametros m e n para calcular A(m, n) ou -1 para abortar a execução:\n"
    string0:      .asciiz "A(" 
	string1:      .asciiz ","
	string2:      .asciiz ")= "
	
	m:      .space 0
	n:      .space 0
	result: .space 4	
