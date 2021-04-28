/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "swap.s"
.section	.rodata

specifier:
	.string "%d\n"

.align 8

/* Data sections */
.data

value1:
	.long 3
value2:
	.long 4

.global swap
	.type swap, @function
.global swapAlt
	.type swapAlt, @function
.global main
	.type main, @function
.text

main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$value1, %rdi /* store the address of value1 in %rdi */
	movq	$value2, %rsi /* store the address of value2 in %rsi */
	
	call	swap

	movl	(%rdi), %esi /* dereference to get value */
   	movq	$specifier, %rdi
	movq	$0, %rax
	call	printf



	movq	$0, %rax
	leave
	ret
	.size main, .-main

swap:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, %rdx /* store the address of value1 in temp %rdx */
	movq	%rsi, %rdi /* %rdi contains the address of value2 */
	movq	%rdx, %rsi /* %rsi contains the address of temp */
	
	leave
	ret
	.size swap, .-swap
	
swapAlt:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rdi), %rdx 
	movq	(%rsi), %rcx 
	movq	%rcx, (%rdi) 
	movq	%rdx, (%rsi)
	
	leave
	ret
	.size swapAlt, .-swapAlt
