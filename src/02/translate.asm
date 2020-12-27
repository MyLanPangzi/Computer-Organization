.data
    in: .space 4
    quit: .word 0x0a3f # ?
    a_z: .word 0x00000a61 0x00000a7a
    A_Z: .word 0x00000a41 0x00000a5a
    n0_9: .word 0x00000a30 0x00000a39

.macro print_str (%str)
    .data
        msg: .asciiz %str
    .text
        li $v0, 4
        la $a0, msg
        syscall
.end_macro

.macro read 
    li $v0, 8	
    la $a0, in	
    li $a1, 4	
    syscall
.end_macro


# 读入字符串 a
# 判断字符串在哪个范围内
# 根据范围，计算出偏移量
# 打印最终结果

li $t0,0
start:
print_str ("Enter a string (max 1 length, enter ? quit): ")

#读取字符串
li $v0, 8	
la $a0, in	
li $a1, 4	
syscall

#判断是否为?
lw $t0, quit
lw $t1, 0($a0)
beq $t0, $t1, exit

#加载边界范围
la $t0, a_z
lw $t1, 0($t0) #上界
lw $t2, 4($t0) #上界
lw $t3, 0($a0) #读入字符串

bge $t3, $t1, gtz # 判断大于a，大于则判断是否大于z
    j exit
gtz:
bgt $t3, $t2, exit #大于 z则退出
sub $t0, $t3, $t1 #算出偏移量
li $t2, 12 #偏移量单位12
mul $t0, $t2, $t0 #最终偏移量
la $t1, alpha #a基础地址
add $a0, $t1, $t0#单词地址

li $v0, 4
syscall
j start

exit:
    print_str("Bye")


.data
    alpha: .word 0x68706c61 0x20202061 0x0a
    bravo: .word 0x76617262 0x2020206f 0x0a
    china: .word 0x6e696863 0x20202061 0x0a
    delta: .word 0x746c6564 0x20202061 0x0a
    echo: .word 0x6f686365 0x20202020 0x0a
    foxtrot: .word 0x74786f66 0x20746f72 0x0a
    golf: .word 0x666c6f67 0x20202020 0x0a
    hotel: .word 0x65746f68 0x2020206c 0x0a
    india: .word 0x69646e69 0x20202061 0x0a
    juliet: .word 0x696c756a 0x20207465 0x0a
    kilo: .word 0x6f6c696b 0x20202020 0x0a
    lima: .word 0x616d696c 0x20202020 0x0a
    mary: .word 0x7972616d 0x20202020 0x0a
    november: .word 0x65766f6e 0x7265626d 0x0a
    oscar: .word 0x6163736f 0x20202072 0x0a
    paper: .word 0x65706170 0x20202072 0x0a
    quebec: .word 0x62657571 0x20206365 0x0a
    research: .word 0x65736572 0x68637261 0x0a
    sierra: .word 0x72656973 0x20206172 0x0a
    tango: .word 0x676e6174 0x2020206f 0x0a
    uniform: .word 0x66696e75 0x206d726f 0x0a
    victor: .word 0x74636976 0x2020726f 0x0a
    whisky: .word 0x73696877 0x2020796b 0x0a
    xray: .word 0x61722d78 0x20202079 0x0a
    yankee: .word 0x6b6e6179 0x20206565 0x0a
    zulu: .word 0x756c757a 0x20202020 0x0a

# 输入? 退出程序
# lw $t0, 0($a0)
# lw $t1, quit
# beq $t1, $t0, exit

# la $a0, alpha
# li $v0, 4
# syscall
# li $t0, 0 #循环起始变量
# li $t1, 3 #循环终止变量
# la $t2, a_z #上下界起始地址
# li $s0, 0 #判断是否打印了字符串
# li $s1, 8 # 上下界移动步长
# li $s2, 24 # 字符串移动步长

# for:
#     #计算上下界偏移量
#     mul $t3, $s1, $t0 
#     add $t2, $t2, $t3

#     #加载上下界，输入字符
#     lw $t4, 0($t2)
#     lw $t5, 4($t2)
#     lw $t6, 0($a0)
   
#    #判断是否在范围内
#     bge $t6, $t4, next
#         j inc
#     next:
#         bgt $t6, $t5, inc
#             #计算打印字符串偏移量=（输入字符串-上界字符串） * 字符串移动步长
#             sub $t8, $t6, $t4          
#             mul $t8, $t8, $s2
            
#             # 偏移量加起始字符串地址
#             la $a0, alpha
#             add $a0, $t8, $a0

#             #打印
#             li $v0,4
#             syscall
#             #退出循环
#             move $t0, $t1 
#             #打印标志置为0
#             li $s0, 1
#             j endfor
#     inc: 
#         addi $t0, $t0, 1
    
#  endfor: 
#     blt $t0, $t1, for

# li $t0, 0
# beq $t0, $s0, print_all
#     j start
# print_all:
#     print_str("*")
#     j start