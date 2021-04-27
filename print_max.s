# @author Charlotte Fanning {@literal fanncg18@wfu.edu}
# @date May 3, 2021
# @assignment Lab 8
# @file print_max.s
# @course CSC 250
#
# This program reads a sequence of integers until a negative
# value is entered and displays the current maximum
#
# Compile and run (Linux)
#   gcc -no-pie print_max.s && ./a.out


.text
   .global main               # use main if using C library


main:
   push %rbp                  # save the old frame
   mov  %rsp, %rbp            # create a new frame  

   sub  $16, %rsp             # make some space on the stack (stack alignment)

   # prompt the user
   mov  $prompt_format, %rdi  # first printf argument, format string  
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   # read the value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -8(%rbp), %rsi        # second scanf argument, memory address
   xor  %rax, %rax            # zero out rax
   call scanf                 # scanf

   # print to the screen
   mov  $write_format, %rdi   # first printf argument, format string  
   mov -8(%rbp), %rsi         # second printf argument, the integer  
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   add  $16, %rsp             # release stack space
   pop  %rbp                  # restore old frame
   ret                        # return to C library to end


.data

read_format:
   .asciz  "%d"

prompt_format:
   .asciz  "Enter an integer -> "

write_format:
   .asciz  "You entered %d \n"


