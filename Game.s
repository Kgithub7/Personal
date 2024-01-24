.data 0x10002000
static:
.ascii "\n  #?  ##"
.ascii "\n?    # *"
.ascii "\n   #   #"
.ascii "\n ?###?#?"
.ascii "\n#       "
.ascii "\n  ?## # "
.ascii "\n?     ? "
.ascii "\nS ## ## "
dynamic:
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "


.data 0x10002100
player:.byte 0x2B
start:.byte 0x53
exit:.byte 0x2A
empty:.byte 0x20
wall:.byte 0x23
monster:.byte 0x3F
choice:.byte 0
w:.byte 0x77
a:.byte 0x61
s:.byte 0x73
d:.byte 0x64
t:.byte 0x74
J:.byte 0x6A
task:.asciiz "\nMove to the Asterisk(*)." 
Move:.asciiz "\nClick W(Up), A(Left), S(Down), D(Right), or T(Terminate)?"
double_jump:.asciiz "\nClick J to Double Jump(Up)"
Monster:.asciiz "\nAvoid the Monsters (?)."
line:.asciiz "\n"
Dead:.asciiz "\nYou were killed by a monster :("
win:.asciiz "\nYou win! :)"
terminated:.asciiz "\nGame Terminated."
position:.byte 0
.data 0x10003000
terminate:.byte 0
spaces:
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "
.ascii "\n        "




.text
main:
initializer:
lb $s0, start
lb $s5, exit
la $t0, static
la $t1, dynamic
addu $t0, $t0, $t3
addu $t1, $t1, $t3
lb $s1, ($t0)
beq $s0, $s1, Start
beq $s5, $s1, Terminate
j Loop

Start:
lb $s2, player
sb $s2, ($t1)
sb $t3, position
j Loop

Terminate:
sb $t3, terminate

Loop:
#loop counter
addi $t3,$t3, 1
slti $t4, $t3, 71
bne $t4, $zero, initializer      #NOP

load:
lb $s0, empty
la $t0, dynamic
addu $t0, $t0, $t3
sb $s0, ($t0)


#loop counter
addi $t3,$t3, 1
slti $t4, $t3, 71
bne $t4, $zero, load      #NOP
addi $t3, $zero, 0

load2:
lb $s0, exit
lb $s1, wall
lb $s3, monster
la $t0, static
la $t1, dynamic
addu $t0, $t0, $t3
addu $t1, $t1, $t3
lb $s2, ($t0)
beq $s0, $s2, star
beq $s1, $s2, hash
beq $s3, $s2, q_mark
j loop

star:
sb $s0, ($t1)
j loop

hash:
sb $s1, ($t1)
j loop

q_mark:
sb $s3, ($t1)

loop:
#loop counter
addi $t3,$t3, 1
slti $t4, $t3, 71
bne $t4, $zero, load2      #NOP
addi $t3, $0, 0

Player:
lb $s0, player
lb $s1, position
la $t0, dynamic
addu $t0, $t0, $t3
addi $t3,$t3, 1
bne $t3, $s1, Player      #NOP
sb $s0, 1($t0)
addi $t3,$0, 0



print:
la $t0, dynamic
addu $t0, $t0, $t3


#syscall to print a character
ori $v0, $zero, 11                           
lb $a0, ($t0)       #NOP               
syscall

#loop counter
addi $t3,$t3,1
slti $t1, $t3, 72
bne $t1, $zero, print      #NOP

lb $s6, terminate
beq $s1, $s6, Exit


#syscall to print a string
ori $v0, $zero, 4                           
la $a0, spaces       #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, task       #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, Move       #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, double_jump       #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, Monster       #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, line       #NOP               
syscall

#syscall to read a character
ori $v0, $zero, 12                           
syscall

#store the character in memory
sb $v0, choice
#store the bytes into different memory addresses
lb $t0, choice 
lb $t1, w
lb $t2, a
lb $t3, s
lb $t4, d
lb $t5, t
lb $t6, empty
lb $t7, monster
lb $s4, J

#branch to the necessary label
beq  $t0, $t1, Up
beq  $t0, $t2, Left
beq  $t0, $t3, Down
beq  $t0, $t4, Right
beq  $t0, $t5, Terminated
beq  $t0, $s4, Double_Jump

Up:
la $t0, dynamic
addi $s1, $s1, -9
bge $s1, $zero, Up2
addi $s1, $s1, 9
j load

Up2:
addu $t0, $t0, $s1
lb $s0, ($t0)
beq $s0, $s5, Exit
beq $s0, $t7, dead
bne $s0, $t6, load
sb $s1, position
la $t0, dynamic
addi $s1, $s1, 9
addu $t0, $t0, $s1
sb $t6, ($t0)
j load 

Left:
la $t0, dynamic
addi $s1, $s1, -1
addu $t0, $t0, $s1
lb $s0, ($t0)
beq $s0, $s5, Exit
beq $s0, $t7, dead
bne $s0, $t6, load
sb $s1, position
la $t0, dynamic
addi $s1, $s1, 1
addu $t0, $t0, $s1
sb $t6, ($t0)
j load 

Down:
la $t0, dynamic
addi $s1, $s1, 9
addu $t0, $t0, $s1
lb $s0, ($t0)
beq $s0, $s5, Exit
beq $s0, $t7, dead
bne $s0, $t6, load
sb $s1, position
la $t0, dynamic
addi $s1, $s1, -9
addu $t0, $t0, $s1
sb $t6, ($t0)
j load  

Right:
la $t0, dynamic
addi $s1, $s1, 1
addu $t0, $t0, $s1
lb $s0, ($t0)
beq $s0, $s5, Exit
beq $s0, $t7, dead
bne $s0, $t6, load
sb $s1, position
la $t0, dynamic
addi $s1, $s1, -1
addu $t0, $t0, $s1
sb $t6, ($t0)
j load 

Double_Jump:
la $t0, dynamic
addi $s1, $s1, -18
bge $s1, $zero, Double_Jump2
addi $s1, $s1, 18
j load

Double_Jump2:
addu $t0, $t0, $s1
lb $s0, ($t0)
beq $s0, $s5, Exit
beq $s0, $t7, dead
bne $s0, $t6, load
sb $s1, position
la $t0, dynamic
addi $s1, $s1, 18
addu $t0, $t0, $s1
sb $t6, ($t0)
j load

dead:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, Dead       #NOP               
syscall

#syscall to terminate the program
ori $v0, $zero, 10               
syscall

Exit:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, win       #NOP               
syscall

#syscall to terminate the program
ori $v0, $zero, 10               
syscall

Terminated:
ori $v0, $zero, 4                           
la $a0, terminated       #NOP               
syscall

#syscall to terminate the program
ori $v0, $zero, 10               
syscall