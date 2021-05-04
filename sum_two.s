# @author Charlotte Fanning {@literal fanncg18@wfu.edu}
# @date May 3, 2021
# @assignment Lab 8
# @file sum_two.s
# @course CSC 250
#
# This program reads two integers and displays the sum
#
# Compile and run (Linux)
#   gcc -no-pie sum_two.s && ./a.out


.text
   .global main               # use main if using C library


main:
   push  %rbp                 # save the old frame
   mov  %rsp, %rbp            # create a new frame  

   sub  $16, %rsp             # make some space on the stack (stack alignment)

   # prompt the user
   mov  $prompt_format, %rdi  # first printf argument, format string  
   xor  %rax, %rax            # zero out rax  
   call  printf               # printf

   # read first value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -8(%rbp), %rsi        # second scanf argument, memory address
   xor  %rax, %rax            # zero out rax
   call  scanf                # scanf

   # read second value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -16(%rbp), %rsi       # second scanf argument, memory address
   xor  %rax, %rax            # zero out %rax
   call  scanf                # scanf

   # add integers in function
   mov  -16(%rbp), %rsi       # second sum argument, the second integer
   mov  -8(%rbp), %rdi        # first sum argument, the first integer  
   call  sum                  # sum of integers, result stored in %rax

   # print to screen
   mov  %rax, %rcx            # fourth printf argument, the sum
   mov  -16(%rbp), %rdx       # third printf argument, the second integer
   mov  -8(%rbp), %rsi        # second printf argument, the first integer
   mov  $write_format, %rdi   # first printf argument, format string  
   xor  %rax, %rax            # zero out rax  
   call  printf               # printf

   add  $16, %rsp             # release stack space
   pop  %rbp                  # restore old frame
   ret                        # return to C library to end


.data

read_format:
   .asciz  "%d"

prompt_format:
   .asciz  "Enter two integers -> "

write_format:
   .asciz  "%d + %d = %d \n"

sum:
   lea  (%rdi, %rsi), %eax
   ret


