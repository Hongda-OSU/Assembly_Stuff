/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "stringModify.s"
.section	.rodata
str1:
	.string "The string before modify is: %s\n"
str2:
	.string "The string after modify is: %s\n"
str3:
	.string "The number of character modifed is: %d\n"
.align 8

/* Data sections */
.data
/* cannot place in .rodata section because it should not be read only */
sample:
	.string "Hello world HAAAA"
ascii:
	.long 65

.global modify
	.type modify, @function

.global main
	.type main, @function
.text
/********************************************************************************/
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$str1, %rdi
	movq	$sample, %rsi
	movq	$0, %rax
	call	printf
	movq	$sample, %rdi
	call	modify
	movl	%eax, %ebx
	movq	$str2, %rdi
	movq	$sample, %rsi
	movq	$0, %rax
	call	printf
	movq	$str3, %rdi
	movl	%ebx, %esi
	movq	$0, %rax
	call	printf


	leave
	ret
	.size main, .-main

/********************************************************************************/
modify:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %eax /* set num_modify = 0 */
	movl	$0, %edx /*set counter = 0 */
	movl	ascii, %ebx /* %ebx store the ASCII value of the given charater, here is 'A' */
loop:
	movb	(%rdi, %rdx), %sil /* %sil store the first character in string */
	movzbl	%sil, %ecx /* %ecx is the ASCII value of %sil */
	cmpl	$0, %ecx /* check string terminater */
	je	exit
	cmpl	ascii, %ecx /* check if the current character need modify */
	jne	modification
	incl	%edx /* counter++ */
	jmp	loop

modification:
	movb	%bl, (%rdi, %rdx) /* replace the given character at position */
	incl	%edx /* counter++ */
	incl	%eax /* num_modify++ */
	jmp	loop
	
exit:
	leave
	ret
	.size modify, .-modify
/********************************************************************************/

