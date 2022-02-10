.globl _start

.data
a: .word -1 22 8 35 5 4 11 2 1 78

.text
_start:
# s0 = *a[], s1 = left, s2 = right, s11 = 4
la s0, a 
li s1, 0
li s2, 9
li s11, 4
jal quicksort
addi a7,zero,93
add a0,zero,zero
ecall

swap: # *a[i]=t1 a[i]=a1 
addi t3,t3,1 #j++
mul t5, t3, s11 # t5 = j*4
add t5, t5, s0 # t5 = *a[j]
lw t6, (t5) # t6 = a[j]
sw t6, (t1) 
sw a1, (t5)
addi t4, t4, 1
j beforeloop

partition: 
mul t2,s2,s11 #set t2 = right
add t2,t2,s0  #t2 = *a[right] 
lw a2,(t2) # a2 = a[right] = pivot
addi t3, s1, -1 # j = t3 = left - 1
mv t4, s1 # i = t4 = left
beforeloop:
blt t4, s2, loop # go loop if t4(i) < s2(right)
addi t3,t3,1 #j+1
mul t5, t3, s11 #t5 = j*4
add t5, t5, s0  #t5 = *a[j+1]
lw t6, (t5)      #t6 = a[j+1]
sw t6, (t2)      #a[right] = a[j+1]
sw a2, (t5)      #a[j+1] = a[right]
mv a0, t3  # return j+1
jr ra

loop:
mul t1,t4,s11 # set t1 = i*4
add t1,t1,s0  # t1 = *a[i]
lw a1,(t1)    # a1 = a[i]
ble a1, a2, swap     # a1(a[i}) <= a2 (pivot)
addi t4, t4, 1 # i++
j beforeloop

quicksort:
addi, sp, sp, -12
sw ra, 0(sp)
sw s1, 4(sp)
sw s2, 8(sp)
bge s1, s2, done # left >= right(left < right) quicksort done  
jal partition #Otherwise do
addi s2, a0, -1
jal quicksort
lw s2, 8(sp)
addi s1, a0, 1
jal quicksort
done:
lw s1, 4(sp)
lw ra, 0(sp)
addi sp, sp, 12
jr ra
