/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "getBinary.s"
.section	.rodata
str:
	.string "The binary form of %c is: "
specifier:
	.string "%d"

.align 8

/* Data sections */
.data

value:
	.word 'A'

.global convert
	.type convert, @function
.global main
	.type main, @function
.text
/********************************************************************************/
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$str, %rdi
	movb	value, %sil
	movq	$0, %rax
	call	printf
	movb	value, %dl
	call	convert
	
	
 
	leave
	ret
	.size main, .-main
/********************************************************************************/
convert:
	pushq	%rbp
	movq	%rsp, %rbp
	movzbl	%dl, %ebx
	movl	$8, %r13d
loop:
	cmpl	$0, %r13d
	je	exit
	movl	%r13d, %ecx
	decl	%ecx
	movl	%ebx, %r12d
	shrl	%cl, %ebx
	andl	$1, %ebx
	movq	$specifier, %rdi
	movl	%ebx, %esi
	movq	$0, %rax
	call	printf
	movl	%r12d, %ebx
	
	decl	%r13d
	jmp	loop
	
exit:
	 
	leave
	ret
	.size convert, .-convert
/********************************************************************************/



