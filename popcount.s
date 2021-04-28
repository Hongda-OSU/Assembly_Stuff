/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "popcount.s"
.section	.rodata

str:
	.string "The number of '1' in 'value' is: %d.\n"

.align 8

/* Data sections */
.data

value:
	.long 255

.global popCount
	.type popCount, @function
.global main
	.type main, @function
.text
/********************************************************************************/
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	value, %edi
	call	popCount
	movl	%eax, %esi
	movq	$str, %rdi
	movq	$0, %rax
	call	printf


	leave
	ret
	.size main, .-main

/********************************************************************************/
popCount:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %eax
loop:
	cmpl	$0, %edi /* if value becomes 0, which means 0x0, then finish */
	je	exit
	movl	%edi, %ebx /* %ebx is the copy of %edi */
	andl	$1, %ebx /* bitwise and the last bit of %ebx, if is 1, then %ebx = 1, if is 0, then %ebx = 0 */
	addl	%ebx, %eax /* count how many '1's */
	shrl	$1, %edi /* unsigned right shift 1 position */
	jmp	loop
exit:
	leave
	ret
	.size popCount, .-popCount
/********************************************************************************/












