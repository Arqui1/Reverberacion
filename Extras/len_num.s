.global _start
_start:
	
	mov r1, #50
	mov r2, #25
	
	mov r9, #0 @contador operando 1 = r2
	mov r10, #0 @contador operando 2 = r3
operando1:
	cmp r1, #0
	beq operando2
	
	lsr r1, #1
	add r9, r9, #1
	b operando1
	
operando2:
	cmp r2, #0
	beq devolverse
	
	lsr r2, #1
	add r10, r10, #1
	b operando2
	
devolverse:
	add r11, r9, r10
	lsr r11, #1 @aqui se obtiene lo que iria en ""lsr #6""
	

