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
   movq  $0, -16(%rbp)        # stack space for current maximum


.loop_label:
   # prompt the user
   mov  $prompt_format, %rdi  # first printf argument, format string  
   xor  %rax, %rax            # zero out %rax  
   call  printf               # printf


   # read the value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -8(%rbp), %rsi        # second scanf argument, memory address
   xor  %rax, %rax            # zero out %rax
   call  scanf                # scanf


   # check loop condition
   cmp  $0, -8(%rbp)          # determine sign of current integer
   jl  .end_label             # exit loop if current value is negative

   
   # continue, determine current max
   mov  -8(%rbp), %rdi        # copy current value from stack to register for next instruction
   cmp  %rdi, -16(%rbp)       # compare maximum to current value
   jge  .print_label           # current value is not greater than current max, skip next instruction
   mov  %rdi, -16(%rbp)       # store new current max on stack 
   xor  %rax, %rax            # zero out %rax


# print to the screen   
.print_label:
   mov  $write_format, %rdi   # first printf argument, format string  
   mov -16(%rbp), %rsi        # second printf argument, the integer  
   xor  %rax, %rax            # zero out %rax  
   call  printf               # printf

   jmp  .loop_label           # unconditional jump to the beginning of loop 


.end_label:
   add  $16, %rsp             # release stack space
   pop  %rbp                  # restore old frame
   ret                        # return to C library to end


.data

read_format:
   .asciz  "%d"

prompt_format:
   .asciz  "Enter an integer (negative to quit) -> "

write_format:
   .asciz  "Current maximum is %d \n"


