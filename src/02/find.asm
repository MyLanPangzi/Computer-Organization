.data
    string: .space 33
    char: .space 2

.macro print_str (%str)
    .data
        myLabel: .asciiz %str
    .text
        li $v0, 4
        la $a0, myLabel
        syscall
.end_macro

.macro print_buf (%buf)
        li $v0, 4
        la $a0, %buf
        syscall
.end_macro

.macro print_char (%buf)
        move $a0, %buf
        li $v0, 12
        syscall
.end_macro

.macro read_str (%buf, %len)
    la $a0, %buf
    li $a1, %len
    li $v0, 8
    syscall
.end_macro

.macro read_char(%buf)
    li $v0, 12
    syscall
    move %buf, $v0
.end_macro

print_str("enter a string(max 32 ): ")
read_str(string, 33)
print_buf(string)
print_str("enter a char: ")
read_char($t0)
print_char($t0)
print_str("enter a string(max 32 ): ")
