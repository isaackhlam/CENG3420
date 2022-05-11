.globl _start

.data
a: .word -1 22 8 35 5 4 11 2 1 78

.text
_start:
la a0,a  # get the array address
li t4,10 # int i = 0; i<10
li t6,0  
sort:addi t5,t6,-1 # int j = i - 1
ble t6,t4,loop     # i < 10, loop

# End program
li a0,0
li a7,93
ecall

# for(i = 0; i < n; i++)
loop:bgez t5,loop2 # j >=0, loop2
addi t6,t6,1       # i++
j sort             # continue

# for(j = i - 1; i >= 0; j--) //v[j]>v[j+1] at line 33
loop2:mv a1,t5     # a1 = j
slli t1, a1, 2 # get the offset of v[k] relative to v[0]
add t1, a0, t1 # get the address of v[k]
lw t0, 0(t1) # load the v[k] to t0
lw t2, 4(t1) # load the v[k + 1] to t2
bgt t0,t2,swap # if v[k] > v[k+1], swap
addi t5,t5,-1 # j--
j loop # continue

# swap(j+1,j)
swap: 
sw t2, 0(t1) # store t2 to the v[k]
sw t0, 4(t1) # store t0 to the v[k + 1]
addi t5,t5,-1 # j--
j loop # continue
