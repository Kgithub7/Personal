.data 0x10000000
prompt: .asciiz "\nDecode(D), Encode(E) or End(T): "
prompt2: .asciiz "\nEnter raw data: "
end: .asciiz "\nProgram Terminated"
p8:.asciiz "\nP8: "
p4:.asciiz "\nP4: "
p2:.asciiz "\nP2: "
p1:.asciiz "\nP1: "
p0:.asciiz "\nP0: "
P8:.byte 0
P4:.byte 0
P2:.byte 0
P1:.byte 0
P0:.byte 0
operation: .byte 0
i:.word 0
mask:.word 1
terminate:.byte 0x74
terminate2:.byte 0x54
encode:.byte 0x65
encode2:.byte 0x45
decode:.byte 0x64
decode2:.byte 0x44
.data 0x10000080
decoded:.word 0
.data 0x10000090
decoded2:.word 0
.data 0x100000a0
input:.word 0
.data 0x100000b0
encoded:.word 0
databits:.word 0
extended: .asciiz "\nExtended Hamming Codeword: "
unvalidated: .asciiz "\nUnvalidated Data Bits: "
syndrome: .asciiz "\nHamming Syndrome: "
pass: .asciiz "\nTotal parity - PASS "
fail: .asciiz "\nTotal parity - FAIL "
noError: .asciiz "\nThe encoded codeword is valid."
oneError: .asciiz "\nThe encoded codeword has 1 error"
twoErrors: .asciiz "\nThe encoded codeword has 2 errors"
validated: .asciiz "\nValidated Data Bits: "

.text
main:
#syscall to print a string
ori $v0, $zero, 4                           
lui $a0, 0x1000       #NOP               
syscall

#syscall to read a character
ori $v0, $zero, 12                           
syscall
#store the character in memory
sb $v0, operation
#store the characters into different memory addresses
lb $t0, operation 
lb $t1, terminate
lb $t2, terminate2
lb $t3, encode
lb $t4, encode2
lb $t5, decode
lb $t6, decode2
#branch to the necessary label
beq  $t0, $t1, Terminate
beq  $t0, $t2, Terminate
beq  $t0, $t3, Encode
beq  $t0, $t4, Encode
beq  $t0, $t5, Decode
beq  $t0, $t6, Decode
#Restart the program
j main

Encode:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, prompt2      #NOP               
syscall
#syscall to read a string
ori $v0, $zero, 8                          
la $a0, input      #NOP   
li $a1, 13      #NOP            
syscall
add $s1, $a0, $zero

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, extended      #NOP               
syscall
lb $t0, 0($s1)
sub $t0,$t0,48
lb $t1, 1($s1)
sub $t1,$t1,48
lb $t2, 2($s1)
sub $t2,$t2,48
lb $t3, 3($s1)
sub $t3,$t3,48
lb $t4, 4($s1)
sub $t4,$t4,48
lb $t5, 5($s1)
sub $t5,$t5,48
lb $t6, 6($s1)
sub $t6,$t6,48
lb $t7, 7($s1)
sub $t7,$t7,48
lb $t8, 8($s1)
sub $t8,$t8,48
lb $t9, 9($s1)
sub $t9,$t9,48
lb $s8, 10($s1)
sub $s8,$s8,48

lb $s0, 0($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 1($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 2($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 3($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 4($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 5($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 6($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

#Calculate P8
xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t6
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP                 
syscall
sb $s0, P8
move $s3, $s0

lb $s0, 7($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 8($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

lb $s0, 9($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

#Calculate P4
xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$t9
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP                
syscall
sb $s0, P4
move $s4, $s0

lb $s0, 10($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0      #NOP               
syscall

#Calculate P2
xor $s0, $t0,$t1
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$s8
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0                
syscall
sb $s0, P2
move $s5, $s0

#Calculate P1
xor $s0, $t0,$t2
xor $s0, $s0,$t4
xor $s0, $s0,$t6
xor $s0, $s0,$t7
xor $s0, $s0,$t9
xor $s0, $s0,$s8
or $s2,$s0,$s2 
sll $s2,$s2,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0               
syscall
sb $s0, P1
move $s6, $s0

#Calculate P0
xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t6
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$t9
xor $s0, $s0,$s8
xor $s0, $s0,$s3
xor $s0, $s0,$s4
xor $s0, $s0,$s5
xor $s0, $s0,$s6
or $s2,$s0,$s2 

#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0                    
syscall
sb $s0, P0
move $s7, $s0
sw $s2, encoded


#syscall to print a string
ori $v0, $zero, 4                           
la $a0, p8      #NOP               
syscall
#syscall to print an integer
ori $v0, $zero, 1                        
move $a0, $s3     #NOP               
syscall
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, p4     #NOP               
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s4    #NOP               
syscall
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, p2    #NOP               
syscall
#syscall to print an integer
ori $v0, $zero, 1                         
move $a0, $s5   #NOP               
syscall
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, p1     #NOP               
syscall
#syscall to print an integer
ori $v0, $zero, 1                         
move $a0, $s6    #NOP               
syscall
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, p0     #NOP               
syscall
#syscall to print an integer
ori $v0, $zero, 1                        
move $a0, $s7    #NOP               
syscall
j main


Decode:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, prompt2      #NOP               
syscall
#syscall to read a string
ori $v0, $zero, 8                          
la $a0, input      #NOP   
li $a1, 18      #NOP            
syscall
add $s1, $a0, $zero

#Convert user's input
lb $t0, 0($s1)
sub $t0,$t0,48
lb $t1, 1($s1)
sub $t1,$t1,48
lb $t2, 2($s1)
sub $t2,$t2,48
lb $t3, 3($s1)
sub $t3,$t3,48
lb $t4, 4($s1)
sub $t4,$t4,48
lb $t5, 5($s1)
sub $t5,$t5,48
lb $t6, 6($s1)
sub $t6,$t6,48
lb $s3, 7($s1)
sub $s3,$s3,48
lb $t7, 8($s1)
sub $t7,$t7,48
lb $t8, 9($s1)
sub $t8,$t8,48
lb $t9, 10($s1)
sub $t9,$t9,48
lb $s4, 11($s1)
sub $s4,$s4,48
lb $s8, 12($s1)
sub $s8,$s8,48
lb $s5, 13($s1)
sub $s5,$s5,48
lb $s6, 14($s1)
sub $s6,$s6,48
lb $s7, 15($s1)
sub $s7,$s7,48

lb $s0, 0($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 1($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 2($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 3($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 4($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 5($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 6($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 7($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 8($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 9($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 10($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 11($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 12($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 13($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 14($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sll $s2,$s2,1
lb $s0, 15($s1)
sub $s0,$s0,48
or $s2,$s0,$s2 
sw $s2, decoded

lw $s0,i
or $s0,$t0,$s0
sll $s0,$s0,1
or $s0,$t1,$s0
sll $s0,$s0,1
or $s0,$t2,$s0
sll $s0,$s0,1
or $s0,$t3,$s0
sll $s0,$s0,1
or $s0,$t4,$s0
sll $s0,$s0,1
or $s0,$t5,$s0
sll $s0,$s0,1
or $s0,$t6,$s0
sll $s0,$s0,1
or $s0,$t7,$s0
sll $s0,$s0,1
or $s0,$t8,$s0
sll $s0,$s0,1
or $s0,$t9,$s0
sll $s0,$s0,1
or $s0,$s8,$s0
sw $s0,databits
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, unvalidated      #NOP               
syscall

#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t0                   
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t1                    
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t2                 
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t3                
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t4                
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t5                  
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t6                
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t7                 
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t8                  
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $t9                  
syscall
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s8     #NOP               
syscall

#syscall to print a string
ori $v0, $zero, 4                           
la $a0, syndrome       #NOP               
syscall

#Calculate Hamming Syndrome 
add $a3,$0,$0
xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t6
xor $s0, $s0,$s3
or $a3,$s0,$a3 
sll $a3,$a3,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0     #NOP               
syscall

xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$t9
xor $s0, $s0,$s4
or $a3,$s0,$a3 
sll $a3,$a3,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0     #NOP               
syscall

xor $s0, $t0,$t1
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$s8
xor $s0, $s0,$s5
or $a3,$s0,$a3 
sll $a3,$a3,1
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0     #NOP               
syscall

xor $s0, $t0,$t2
xor $s0, $s0,$t4
xor $s0, $s0,$t6
xor $s0, $s0,$t7
xor $s0, $s0,$t9
xor $s0, $s0,$s8
xor $s0, $s0,$s6
or $a3,$s0,$a3 
#syscall to print an integer
ori $v0, $zero, 1                          
move $a0, $s0     #NOP               
syscall

xor $s0, $t0,$t1
xor $s0, $s0,$t2
xor $s0, $s0,$t3
xor $s0, $s0,$t4
xor $s0, $s0,$t5
xor $s0, $s0,$t6
xor $s0, $s0,$s3
xor $s0, $s0,$t7
xor $s0, $s0,$t8
xor $s0, $s0,$t9
xor $s0, $s0,$s4
xor $s0, $s0,$s8
xor $s0, $s0,$s5
xor $s0, $s0,$s6
xor $s0, $s0,$s7
add $v1, $zero,$zero
bne $s0,$v1,Fail
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, pass       #NOP               
syscall
j Decode2

Fail:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, fail       #NOP               
syscall

Decode2:
beq $s0,$v1,Decode3
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, oneError       #NOP               
syscall
add $k0,$zero,$0
lw $v1,mask

loop:
sll $v1,$v1,1
#loop counter
addi $k0,$k0,1
slt $k1, $k0, $a3
bne $k1, $zero, loop      #NOP
xor $s2, $v1,$s2

sw $s2, input
la $s1,input
#Convert user's input
lb $t0, 0($s1)
sub $t0,$t0,48
lb $t1, 1($s1)
sub $t1,$t1,48
lb $t2, 2($s1)
sub $t2,$t2,48
lb $t3, 3($s1)
sub $t3,$t3,48
lb $t4, 4($s1)
sub $t4,$t4,48
lb $t5, 5($s1)
sub $t5,$t5,48
lb $t6, 6($s1)
sub $t6,$t6,48
lb $s3, 7($s1)
sub $s3,$s3,48
lb $t7, 8($s1)
sub $t7,$t7,48
lb $t8, 9($s1)
sub $t8,$t8,48
lb $t9, 10($s1)
sub $t9,$t9,48
lb $s4, 11($s1)
sub $s4,$s4,48
lb $s8, 12($s1)
sub $s8,$s8,48
lb $s5, 13($s1)
sub $s5,$s5,48
lb $s6, 14($s1)
sub $s6,$s6,48
lb $s7, 15($s1)
sub $s7,$s7,48

lw $s0,i
or $s0,$t0,$s0
sll $s0,$s0,1
or $s0,$t1,$s0
sll $s0,$s0,1
or $s0,$t2,$s0
sll $s0,$s0,1
or $s0,$t3,$s0
sll $s0,$s0,1
or $s0,$t4,$s0
sll $s0,$s0,1
or $s0,$t5,$s0
sll $s0,$s0,1
or $s0,$t6,$s0
sll $s0,$s0,1
or $s0,$t7,$s0
sll $s0,$s0,1
or $s0,$t8,$s0
sll $s0,$s0,1
or $s0,$t9,$s0
sll $s0,$s0,1
or $s0,$s8,$s0
sw $s0,decoded2
j main

Decode3:
beq $a3,$zero,Decode4
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, twoErrors       #NOP               
syscall
li $s0,-1
li $s2,0xFFFFFFFF
j main

Decode4:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, noError       #NOP               
syscall
lw $s0, databits
j main

Terminate:
#syscall to print a string
ori $v0, $zero, 4                           
la $a0, end       #NOP               
syscall
#syscall to terminate the program
li $v0, 10
syscall