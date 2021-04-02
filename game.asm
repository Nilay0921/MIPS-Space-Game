# Bitmap display starter code#
# Bitmap Display Configuration:
# -Unit width in pixels: 8
# -Unit height in pixels: 8
# -Display width in pixels: 256
# -Display height in pixels: 256
# -Base Address for Display: 0x10008000 ($gp)

.eqv 	BASE_ADDRESS 0x10008000
.eqv	RED 0xff0000
.eqv	GREEN 0x00ff00
.eqv	BLUE 0x0000ff
.eqv	BLACK 0x00000000
.eqv 	PURPLE 0xff00ff
.eqv	W_KEY 119 
.eqv	A_KEY 97
.eqv	S_KEY 115
.eqv	D_KEY 100
.eqv	P_KEY 112
.eqv	WAIT_TIME 100
	
.data	
SHIP: .word 0:5
OBJECT: .word 0:3


.text
.globl main

main:	
	li $t0, BASE_ADDRESS #$t0 stores the base address for the display
	li $t1, RED #t1 sotres the red color code
	li $t2, GREEN #t2 stores the green color code
	li $t3, BLUE #t3 stores the blue color code
	la $t4, SHIP # Load address of ship location to $t4 
	
	
	sw $t2, 2056($t0) #Top of ship green
	sw $t1, 2180($t0) #edge of ship red
	sw $t2, 2184($t0) #Middle of ship green
	sw $t3, 2188($t0) #Front of ship blue
	sw $t2, 2312($t0) #Bottom of ship green
	
	# Initiail location of the ship
	li $t5, 2056
	sw $t5, 0($t4) # Store top of ship address into SHIP[0]
	li $t5, 2180
	sw $t5, 4($t4) # Store left edge of ship into SHIP[1]
	li $t5, 2184
	sw $t5, 8($t4) # Store middlw of ship into SHIP[2]
	li $t5, 2188
	sw $t5, 12($t4) # Store front of ship into SHIP[3]
	li $t5, 2312
	sw $t5, 16($t4) # Store bottom of ship into SHIP[4]
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 30 # Generate random number up until 31
	syscall
	li $t1, 128
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT
	add $t2, $t0, $t1 # Pixel address of right position of the object
	li $t3, PURPLE # Store color in $t3
	sw $t3, 0($t2) # Draw rightmost pixel of object on screen
	sub $t5, $t2, $t0
	sw $t5, 0($t4) # Store rightmost pixel of object into object array at OBJECT[0]
	addi $t2, $t2, -4
	sw $t3, 0($t2) # Draw middle pixel of object on screen
	sub $t5, $t2, $t0
	sw $t5, 4($t4) # Store middle pixel of object into object array at OBJECT[1]
	addi $t2, $t2, 128
	sw $t3, 0($t2) # Draw down pixel of object on screen
	sub $t5, $t2, $t0
	sw $t5, 8($t4) # Store down pixel of object into object array at OBJECT[2]
CHECK_KEY:	
	jal UPDATE_OBJ1
	li $t9, 0xffff0000 
	lw $t8, 0($t9)
	beq $t8, 1, KEY_PRESS #If key is pressed go check which key it is
	
	li $v0, 32
	li $a0, WAIT_TIME # Wait for the amount of time specified
	syscall
	j CHECK_KEY
	
KEY_PRESS:
	lw $t2, 4($t9)
	beq $t2, P_KEY, END
	beq $t2, W_KEY, UP_SHIP
	beq $t2, S_KEY, DOWN_SHIP
	beq $t2, D_KEY, RIGHT_SHIP
	beq $t2, A_KEY, LEFT_SHIP
	
	
UP_SHIP:
	li $t1, RED
	li $t2, GREEN
	li $t3, BLUE
	li $t7, BLACK
	la $t4, SHIP # Load address of ship into $t4
	
	# Top of ship
	lw $t5, 0($t4) # $t5 = SHIP[0] Top of ship
	blt $t5, 128, CHECK_KEY # If current position of the top of ship is less than 128 we can't go higher
	add $t6, $t0, $t5 # Adress of current pixel on board
	sw $t7, 0($t6) # Black out current pixel at SHIP[0]
	subi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[0] one space up
	sw $t5, 0($t4) # Store top of ship address updated into SHIP[0]
	
	# Red left edge
	lw $t5, 4($t4) # $t5 = SHIP[1] left edge of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[1]
	subi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t1, 0($t6) # Draw pixel at SHIP[1] one space up
	sw $t5, 4($t4) # Store left edge of ship address updated into SHIP[1]
	
	# Green middle of ship
	lw $t5, 8($t4) # $t5 = SHIP[2] middle of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[2]
	subi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[2] one space up
	sw $t5, 8($t4) # Store left edge of ship address updated into SHIP[2]
	
	# Blue front of ship
	lw $t5, 12($t4) # $t5 = SHIP[3] front of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[3]
	subi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t3, 0($t6) # Draw pixel at SHIP[3] one space up
	sw $t5, 12($t4) # Store left edge of ship address updated into SHIP[3]
	
	# Green bottom of ship
	lw $t5, 16($t4) # $t5 = SHIP[4] bottom of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[4]
	subi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[3] one space up
	sw $t5, 16($t4) # Store left edge of ship address updated into SHIP[4]
	
	li $v0, 32
	li $a0, WAIT_TIME # Wait for the amount of time specified
	syscall
	
	j CHECK_KEY
	
DOWN_SHIP:

	li $t1, RED
	li $t2, GREEN
	li $t3, BLUE
	li $t7, BLACK
	la $t4, SHIP # Load address of ship into $t4
	
	# Green bottom of ship
	lw $t5, 16($t4) # $t5 = SHIP[4] bottom of ship
	bgt $t5, 3968, CHECK_KEY
	add $t6, $t0, $t5 # address of current green bottom of ship 
	sw $t7, 0($t6) # Black out current pixel at SHIP[4]
	addi $t5, $t5, 128 # New address of green bottom after down move
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[4] one space up
	sw $t5, 16($t4) # Store left edge of ship address updated into SHIP[4]
	
	# Blue front of ship
	lw $t5, 12($t4) # $t5 = SHIP[3] front of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[3]
	addi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t3, 0($t6) # Draw pixel at SHIP[3] one space up
	sw $t5, 12($t4) # Store left edge of ship address updated into SHIP[3]
	
	# Green middle of ship
	lw $t5, 8($t4) # $t5 = SHIP[2] middle of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[2]
	addi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[2] one space up
	sw $t5, 8($t4) # Store left edge of ship address updated into SHIP[2]
	
	# Red left edge
	lw $t5, 4($t4) # $t5 = SHIP[1] left edge of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[1]
	addi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t1, 0($t6) # Draw pixel at SHIP[1] one space up
	sw $t5, 4($t4) # Store left edge of ship address updated into SHIP[1]
	
	# Top of ship
	lw $t5, 0($t4) # $t5 = SHIP[0] Top of ship
	add $t6, $t0, $t5 # Adress of current pixel on board
	sw $t7, 0($t6) # Black out current pixel at SHIP[0]
	addi $t5, $t5, 128
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[0] one space up
	sw $t5, 0($t4) # Store top of ship address updated into SHIP[0]
	
	li $v0, 32
	li $a0, WAIT_TIME # Wait for the amount of time specified
	syscall
	
	j CHECK_KEY
	
RIGHT_SHIP:

	li $t1, RED
	li $t2, GREEN
	li $t3, BLUE
	li $t7, BLACK
	la $t4, SHIP # Load address of ship into $t4
	
	# Blue front of ship
	lw $t5, 12($t4) # $t5 = SHIP[3] front of ship
	li $t8, 128
	subi $t9, $t5, 124
	div $t9, $t8
	mfhi $t8
	beq $t8, 0, CHECK_KEY
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[3]
	addi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t3, 0($t6) # Draw pixel at SHIP[3] one space up
	sw $t5, 12($t4) # Store left edge of ship address updated into SHIP[3]
	
	# Top of ship
	lw $t5, 0($t4) # $t5 = SHIP[0] Top of ship
	add $t6, $t0, $t5 # Adress of current pixel on board
	sw $t7, 0($t6) # Black out current pixel at SHIP[0]
	addi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[0] one space up
	sw $t5, 0($t4) # Store top of ship address updated into SHIP[0]
	
	# Green middle of ship
	lw $t5, 8($t4) # $t5 = SHIP[2] middle of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[2]
	addi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[2] one space up
	sw $t5, 8($t4) # Store left edge of ship address updated into SHIP[2]
	
	# Green bottom of ship
	lw $t5, 16($t4) # $t5 = SHIP[4] bottom of ship
	add $t6, $t0, $t5 # address of current green bottom of ship 
	sw $t7, 0($t6) # Black out current pixel at SHIP[4]
	addi $t5, $t5, 4 # New address of green bottom after down move
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[4] one space up
	sw $t5, 16($t4) # Store left edge of ship address updated into SHIP[4]
	
	# Red left edge
	lw $t5, 4($t4) # $t5 = SHIP[1] left edge of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[1]
	addi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t1, 0($t6) # Draw pixel at SHIP[1] one space up
	sw $t5, 4($t4) # Store left edge of ship address updated into SHIP[1]
	
	li $v0, 32
	li $a0, WAIT_TIME # Wait for the amount of time specified
	syscall
	
	j CHECK_KEY
	
LEFT_SHIP:

	li $t1, RED
	li $t2, GREEN
	li $t3, BLUE
	li $t7, BLACK
	la $t4, SHIP # Load address of ship into $t4
	
	# Red left edge
	lw $t5, 4($t4) # $t5 = SHIP[1] left edge of ship
	li $t8, 128
	div $t5, $t8
	mfhi $t8
	beq $t8, 0, CHECK_KEY
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[1]
	subi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t1, 0($t6) # Draw pixel at SHIP[1] one space up
	sw $t5, 4($t4) # Store left edge of ship address updated into SHIP[1]
	
	# Green bottom of ship
	lw $t5, 16($t4) # $t5 = SHIP[4] bottom of ship
	add $t6, $t0, $t5 # address of current green bottom of ship 
	sw $t7, 0($t6) # Black out current pixel at SHIP[4]
	subi $t5, $t5, 4 # New address of green bottom after down move
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[4] one space up
	sw $t5, 16($t4) # Store left edge of ship address updated into SHIP[4]
	
	# Green middle of ship
	lw $t5, 8($t4) # $t5 = SHIP[2] middle of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[2]
	subi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[2] one space up
	sw $t5, 8($t4) # Store left edge of ship address updated into SHIP[2]
	
	# Top of ship
	lw $t5, 0($t4) # $t5 = SHIP[0] Top of ship
	add $t6, $t0, $t5 # Adress of current pixel on board
	sw $t7, 0($t6) # Black out current pixel at SHIP[0]
	subi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t2, 0($t6) # Draw pixel at SHIP[0] one space up
	sw $t5, 0($t4) # Store top of ship address updated into SHIP[0]
	
	# Blue front of ship
	lw $t5, 12($t4) # $t5 = SHIP[3] front of ship
	add $t6, $t0, $t5
	sw $t7, 0($t6) # Black out current pixel at SHIP[3]
	subi $t5, $t5, 4
	add $t6, $t0, $t5
	sw $t3, 0($t6) # Draw pixel at SHIP[3] one space up
	sw $t5, 12($t4) # Store left edge of ship address updated into SHIP[3]
	
	li $v0, 32
	li $a0, WAIT_TIME # Wait for the amount of time specified
	syscall
	
	j CHECK_KEY
	
UPDATE_OBJ1:
	li $t1, PURPLE
	li $t7, BLACK
	la $t2, OBJECT
	
	#Middle pixel update
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel at OBJECT[1]
	addi $t3, $t3, -4
	add $t4, $t0, $t3
	sw $t1, 0($t4) # Draw pixel at OBJECT[1] one space to the left
	sw $t3, 4($t2) # Store new location of pixel
	
	#Bottom pixel update
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel at OBJECT[2]
	addi $t3, $t3, -4
	add $t4, $t0, $t3
	sw $t1, 0($t4) # Draw pixel at OBJECT[2] one space to the left
	sw $t3, 8($t2) # Store new location of pixel
	
	#Bottom pixel update
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel at OBJECT[0]
	addi $t3, $t3, -4
	add $t4, $t0, $t3
	sw $t1, 0($t4) # Draw pixel at OBJECT[0] one space to the left
	sw $t3, 0($t2) # Store new location of pixel
	
	jr $ra
	
	
END:	li $v0, 10
	syscall