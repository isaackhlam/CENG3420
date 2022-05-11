.globl _start

.data
# Step 1
var1: 15
var2: 19
newline: .asciz "\n"

.text
_start:

# Step 2
# Load var1 and print
li a7,1
la a0,var1
ecall
# Print newline
jal ra,printnewline
# Load var2 and print
li a7,1
la a0,var2
ecall
# Print newline
jal ra,printnewline

# Step 3
# Add var1 by 1
lb t1,var1
addi t2,t1,1
la t3,var1
sb t2,(t3)
# multiply var2 by 4
lb t1,var2
addi t2,zero,4
mul t3,t1,t2
la t4,var2
sb t3,(t4)

# Step 4
# Print var1
li a7,1
lb a0,var1
ecall
# Print newline
jal ra,printnewline
# Print var2
li a7,1
lb a0,var2
ecall
# Print newline
jal ra,printnewline

# Step 5
# Swap var1 and var 2
lb t1,var1
lb t2,var2
la t3,var1
la t4,var2
sb t1,(t4)
sb t2,(t3)
# Print var1
li a7,1
lb a0,var1
ecall
# Print newline
jal ra,printnewline
# Print var2
li a7,1
lb a0,var2
ecall
# Print newline
jal ra,printnewline
# End program
li a0,0
li a7,93
ecall

printnewline: li a7,4
la a0,newline
ecall
jr ra
