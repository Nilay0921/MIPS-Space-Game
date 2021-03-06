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
.eqv	ORANGE 0xffa500
.eqv	W_KEY 119 
.eqv	A_KEY 97
.eqv	S_KEY 115
.eqv	D_KEY 100
.eqv	P_KEY 112
.eqv	WAIT_TIME 100
.eqv	WAIT_TIME_C 100
	
.data	
SHIP: .word 0:5
OBJECT1: .word 0:3
OBJECT2: .word 0:3
OBJECT3: .word 0:3


.text
.globl main

main:	
	li $t0, BASE_ADDRESS #$t0 stores the base address for the display
	li $t1, RED #t1 sotres the red color code
	li $t2, GREEN #t2 stores the green color code
	li $t3, BLUE #t3 stores the blue color code
	la $t4, SHIP # Load address of ship location to $t4 
	li $s4, WAIT_TIME
	li $s5, 0
	
	jal CLEAR_SCREEN
	
CREATE_BOARDER:	
	# Create top border
	li $t5, 384
LOOP_B:	bge $t5, 512, DISPLAY_HEALTH
	add $t6, $t5, $t0
	sw $t3, 0($t6)
	addi $t5, $t5, 4
	j LOOP_B	
	
DISPLAY_HEALTH:
	# Show health
	sw $t2, 192($t0)
	sw $t2, 196($t0)
	sw $t2, 200($t0)
	sw $t2, 204($t0)
	sw $t2, 208($t0)
	sw $t2, 212($t0)
	sw $t2, 216($t0)
	sw $t2, 220($t0)
	sw $t2, 224($t0)
	sw $t2, 228($t0)
	
	li $s0, 10
	li $s1, 192


CREATE_BOARD:	
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
	
CREATE_OBJ1:	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 5 # Generate random number up until 31
	syscall
	li $t1, 128
	addi $a0, $a0, 5
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT1
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
	
CREATE_OBJ2:
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 10
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT2
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
	
CREATE_OBJ3:
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 20
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT3
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
	jal UPDATE_OBJ2
	jal UPDATE_OBJ3
	jal CHECK_COLLISION
	#li $t9, 0xffff0000 
	#lw $t8, 0($t9)
	#beq $t8, 1, KEY_PRESS #If key is pressed go check which key it is
	
	addi $s5, $s5, 1
	beq $s4, 10, NO_DEC
	bge $s5, 10, DEC
	j NO_DEC
DEC:
	addi $s4, $s4, -1
	li $s5, 0
NO_DEC:
	li $v0, 32
	add $a0, $zero, $s4
	#li $a0, WAIT_TIME Wait for the amount of time specified
	syscall
	
	li $t9, 0xffff0000 
	lw $t8, 0($t9)
	beq $t8, 1, KEY_PRESS #If key is pressed go check which key it is
	
	j CHECK_KEY
	
KEY_PRESS:
	lw $t2, 4($t9)
	beq $t2, P_KEY, main
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
	blt $t5, 640, CHECK_KEY # If current position of the top of ship is less than 128 we can't go higher
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
	
	#li $v0, 32
	#li $a0, WAIT_TIME # Wait for the amount of time specified
	#syscall
	
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
	
	#li $v0, 32
	#li $a0, WAIT_TIME # Wait for the amount of time specified
	#syscall
	
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
	
	#li $v0, 32
	#li $a0, WAIT_TIME # Wait for the amount of time specified
	#syscall
	
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
	
	#li $v0, 32
	#li $a0, WAIT_TIME # Wait for the amount of time specified
	#syscall
	
	j CHECK_KEY
	
UPDATE_OBJ1:
	li $t1, PURPLE
	li $t7, BLACK
	la $t2, OBJECT1
	
	#Middle pixel update
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	li $t8, 128
	div $t3, $t8
	mfhi $t8
	beq $t8, 0, CLEAR_OBJ1
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
	
UPDATE_OBJ2:
	li $t1, PURPLE
	li $t7, BLACK
	la $t2, OBJECT2
	
	#Middle pixel update
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	li $t8, 128
	div $t3, $t8
	mfhi $t8
	beq $t8, 0, CLEAR_OBJ2
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
	
UPDATE_OBJ3:
	li $t1, PURPLE
	li $t7, BLACK
	la $t2, OBJECT3
	
	#Middle pixel update
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	li $t8, 128
	div $t3, $t8
	mfhi $t8
	beq $t8, 0, CLEAR_OBJ3
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
	
	
CLEAR_OBJ1:
	li $t7, BLACK
	la $t2, OBJECT1
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	j CREATE_OBJECT1
	
CLEAR_OBJ2:
	li $t7, BLACK
	la $t2, OBJECT2
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	j CREATE_OBJECT2
	
CLEAR_OBJ3:
	li $t7, BLACK
	la $t2, OBJECT3
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	j CREATE_OBJECT3
	
CREATE_OBJECT1:
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 5 # Generate random number up until 10
	syscall
	li $t1, 128
	addi $a0, $a0, 5
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT1
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
	
	j CHECK_KEY
	
CREATE_OBJECT2:
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 10
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT2
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
	
	j CHECK_KEY
	
CREATE_OBJECT3:
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 20
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT3
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
	
	j CHECK_KEY
	
CHECK_COLLISION:
	la $t1, SHIP
	la $t2, OBJECT1
	la $t3, OBJECT2
	la $t4, OBJECT3
	
	# Check if ship collided with object1
	lw $t5, 0($t1) # $t5 = SHIP[0]
	lw $t6, 0($t2) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ1
	lw $t6, 4($t2) # OBJECT[1]
	beq $t5, $t6, C_OBJ1
	lw $t6, 8($t2) # OBJECT1[2]
	beq $t5, $t6, C_OBJ1
	
	lw $t5, 4($t1) # SHIP[1]
	lw $t6, 0($t2) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ1
	lw $t6, 4($t2) # OBJECT[1]
	beq $t5, $t6, C_OBJ1
	lw $t6, 8($t2) # OBJECT1[2]
	beq $t5, $t6, C_OBJ1
	
	lw $t5, 12($t1) # SHIP[3]
	lw $t6, 0($t2) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ1_HEAD
	lw $t6, 4($t2) # OBJECT[1]
	beq $t5, $t6, C_OBJ1_HEAD
	lw $t6, 8($t2) # OBJECT1[2]
	beq $t5, $t6, C_OBJ1_HEAD
	
	lw $t5, 16($t1) # SHIP[4]
	lw $t6, 0($t2) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ1
	lw $t6, 4($t2) # OBJECT[1]
	beq $t5, $t6, C_OBJ1
	lw $t6, 8($t2) # OBJECT1[2]
	beq $t5, $t6, C_OBJ1
	
	# Check if ship collided with object2
	lw $t5, 0($t1) # $t5 = SHIP[0]
	lw $t6, 0($t3) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ2
	lw $t6, 4($t3) # OBJECT[1]
	beq $t5, $t6, C_OBJ2
	lw $t6, 8($t3) # OBJECT1[2]
	beq $t5, $t6, C_OBJ2
	
	lw $t5, 4($t1) # SHIP[1]
	lw $t6, 0($t3) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ2
	lw $t6, 4($t3) # OBJECT[1]
	beq $t5, $t6, C_OBJ2
	lw $t6, 8($t3) # OBJECT1[2]
	beq $t5, $t6, C_OBJ2
	
	lw $t5, 12($t1) # SHIP[3]
	lw $t6, 0($t3) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ2_HEAD
	lw $t6, 4($t3) # OBJECT[1]
	beq $t5, $t6, C_OBJ2_HEAD
	lw $t6, 8($t3) # OBJECT1[2]
	beq $t5, $t6, C_OBJ2_HEAD
	
	lw $t5, 16($t1) # SHIP[4]
	lw $t6, 0($t3) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ2
	lw $t6, 4($t3) # OBJECT[1]
	beq $t5, $t6, C_OBJ2
	lw $t6, 8($t3) # OBJECT1[2]
	beq $t5, $t6, C_OBJ2
	
	# Check if ship collided with object3
	lw $t5, 0($t1) # $t5 = SHIP[0]
	lw $t6, 0($t4) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ3
	lw $t6, 4($t4) # OBJECT[1]
	beq $t5, $t6, C_OBJ3
	lw $t6, 8($t4) # OBJECT1[2]
	beq $t5, $t6, C_OBJ3
	
	lw $t5, 4($t1) # SHIP[1]
	lw $t6, 0($t4) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ3
	lw $t6, 4($t4) # OBJECT[1]
	beq $t5, $t6, C_OBJ3
	lw $t6, 8($t4) # OBJECT1[2]
	beq $t5, $t6, C_OBJ3
	
	lw $t5, 12($t1) # SHIP[3]
	lw $t6, 0($t4) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ3_HEAD
	lw $t6, 4($t4) # OBJECT[1]
	beq $t5, $t6, C_OBJ3_HEAD
	lw $t6, 8($t4) # OBJECT1[2]
	beq $t5, $t6, C_OBJ3_HEAD
	
	lw $t5, 16($t1) # SHIP[4]
	lw $t6, 0($t4) # $t6 = OBJECT1[0]
	beq $t5, $t6, C_OBJ3
	lw $t6, 4($t4) # OBJECT[1]
	beq $t5, $t6, C_OBJ3
	lw $t6, 8($t4) # OBJECT1[2]
	beq $t5, $t6, C_OBJ3
	
	j NO_COL
	
C_OBJ1:
	li $t7, RED
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	# Clear object
	li $t7, BLACK
	la $t2, OBJECT1
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Create object again
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 5 # Generate random number up until 10
	syscall
	li $t1, 128
	addi $a0, $a0, 5
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT1
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
C_OBJ1_HEAD:
	li $t7, ORANGE
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	# Decrease Health
	li $t7, RED
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	sw $t7, 4($s3)
	beq $s0, 2, END
	addi $s1, $s1, 8
	addi $s0, $s0, -2
	
	# Clear object
	li $t7, BLACK
	la $t2, OBJECT1
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Create object again
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 5 # Generate random number up until 10
	syscall
	li $t1, 128
	addi $a0, $a0, 5
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT1
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
C_OBJ2:
	li $t7, RED
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	# Clear object2
	li $t7, BLACK
	la $t2, OBJECT2
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Draw object2 again
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 10
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT2
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
C_OBJ2_HEAD:
	li $t7, ORANGE
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	# Decrease Health
	li $t7, RED
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	sw $t7, 4($s3)
	beq $s0, 2, END
	addi $s1, $s1, 8
	addi $s0, $s0, -2
	
	# Clear object2
	li $t7, BLACK
	la $t2, OBJECT2
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Draw object2 again
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 10
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT2
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
C_OBJ3:
	# make ship red
	li $t7, RED
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	# Update health
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	addi $s1, $s1, 4
	addi $s0, $s0, -1
	
	# Clear object3
	li $t7, BLACK
	la $t2, OBJECT3
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Re-spawn object3
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 20
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT3
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
C_OBJ3_HEAD:
	# make ship red
	li $t7, ORANGE
	
	# set colour of ship to red
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t7, 0($t5) # Change colour to red
	
	li $v0, 32
	li $a0, WAIT_TIME_C # Wait for the amount of time specified
	syscall
	
	# Decrease Health
	li $t7, RED
	add $s3, $s1, $t0
	sw $t7, 0($s3)
	beq $s0, 1, END
	sw $t7, 4($s3)
	beq $s0, 2, END
	addi $s1, $s1, 8
	addi $s0, $s0, -2
	
	# Clear object3
	li $t7, BLACK
	la $t2, OBJECT3
	
	lw $t3, 0($t2) # $t3 = OBJECT[0]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 4($t2) # $t3 = OBJECT[1]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	lw $t3, 8($t2) # $t3 = OBJECT[2]
	add $t4, $t0, $t3
	sw $t7, 0($t4) # Black out current pixel
	
	# Re-spawn object3
	
	# Generate random number
	li $v0, 42
	li $a0, 0
	li $a1, 10 # Generate random number up until 11-20
	syscall
	li $t1, 128
	addi $a0, $a0, 20
	mult $t1, $a0
	mflo $t1
	addi $t1, $t1, 124 # $t1 has the position of the object start position
	# Initialize object and draw on screen
	la $t4, OBJECT3
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
	
	# Draw ship again
	la $t1, SHIP
	li $t2, GREEN
	li $t3, RED
	li $t4, BLUE
	
	lw $t5, 0($t1) # SHIP[0]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 4($t1) # SHIP[1]
	add $t5, $t5, $t0
	sw $t3, 0($t5) # Change colour to red
	
	lw $t5, 8($t1) # SHIP[2]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	lw $t5, 12($t1) # SHIP[3]
	add $t5, $t5, $t0
	sw $t4, 0($t5) # Change colour to blue
	
	lw $t5, 16($t1) # SHIP[4]
	add $t5, $t5, $t0
	sw $t2, 0($t5) # Change colour to green
	
	j NO_COL
	
	
	
NO_COL:	
	jr $ra
	
	
CLEAR_SCREEN:
	li $t7, BLACK
	li $t5, 0
CLEAR_LOOP:
	bgt $t5, 4092, RETURN_BACK
	add $t6, $t5, $t0
	sw $t7, 0($t6)
	addi $t5, $t5, 4
	j CLEAR_LOOP
	
RETURN_BACK:
	jr $ra
	
	
	
END:	jal CLEAR_SCREEN
	
	# Display game over text
	li $t2, RED
	
	# Vertical part of E
	sw $t2, 1292($t0)
	sw $t2, 1420($t0)
	sw $t2, 1548($t0)
	sw $t2, 1676($t0)
	sw $t2, 1804($t0)
	sw $t2, 1932($t0)
	sw $t2, 2060($t0)
	#First line of E
	sw $t2, 1296($t0)
	sw $t2, 1300($t0)
	sw $t2, 1304($t0)
	# Second line of E
	sw $t2, 1680($t0)
	sw $t2, 1684($t0)
	sw $t2, 1688($t0)
	# Last ime of E
	sw $t2, 2064($t0)
	sw $t2, 2068($t0)
	sw $t2, 2072($t0)
	
	# First vertical of N
	sw $t2, 1312($t0)
	sw $t2, 1440($t0)
	sw $t2, 1568($t0)
	sw $t2, 1696($t0)
	sw $t2, 1824($t0)
	sw $t2, 1952($t0)
	sw $t2, 2080($t0)
	
	# 3 pixel top of N
	sw $t2, 1316($t0)
	sw $t2, 1320($t0)
	sw $t2, 1324($t0)
	
	# Middle of N
	sw $t2, 1452($t0)
	sw $t2, 1580($t0)
	sw $t2, 1708($t0)
	sw $t2, 1836($t0)
	sw $t2, 1964($t0)
	sw $t2, 2092($t0)
	
	# 3 pixel bottom of N
	sw $t2, 2096($t0)
	sw $t2, 2100($t0)
	sw $t2, 2104($t0)
	
	# Edge of N
	sw $t2, 1976($t0)
	sw $t2, 1848($t0)
	sw $t2, 1720($t0)
	sw $t2, 1592($t0)
	sw $t2, 1464($t0)
	sw $t2, 1336($t0)
	
	# Vertical of D
	sw $t2, 2112($t0)
	sw $t2, 1984($t0)
	sw $t2, 1856($t0)
	sw $t2, 1728($t0)
	sw $t2, 1600($t0)
	sw $t2, 1472($t0)
	sw $t2, 1344($t0)
	
	# Diagonal of D
	sw $t2, 1348($t0)
	sw $t2, 1480($t0) # Top diag
	sw $t2, 1612($t0) # Top diag
	sw $t2, 1992($t0) # Bottom diag
	sw $t2, 1868($t0) # Bottom diag
	sw $t2, 2116($t0)
	
	# Vertical of D 2
	sw $t2, 1740($t0)

CHECK_KEY_END:
	# Check for reset command
	li $t9, 0xffff0000 
	lw $t8, 0($t9)
	beq $t8, 1, KEY_PRESS_END #If key is pressed go check which key it is
	j CHECK_KEY_END

KEY_PRESS_END:
	lw $t2, 4($t9)
	beq $t2, P_KEY, main
	j CHECK_KEY_END

	li $v0, 10
	syscall