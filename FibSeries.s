/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "FibSeries.s"
.section	.rodata

str1:
	.string "Factorial of %d: %d\n"
str2:
	.string "Fibbonacci of %d: \n"

specifier:
	.string "%d "

.align 8

/* Data sections */
.data

value:
	.long 10

.global fibbonacci
	.type fibbonacci, @function
.global fatorial
	.type fatorial, @function
.global main
	.type main, @function
.text
/********************************************************************************/
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	value, %edi /* %edi contains value 10 */
	call	fatorial
	movl	%eax, %edx
	movq	$str1, %rdi
	movl	value, %esi
	movq	$0, %rax
	call	printf	
	movq	$str2, %rdi
	movl	value, %esi
	movq	$0, %rax
	call	printf
	movl	$0, %ebx
loop:
	cmpl	value, %ebx /* loop until %ebx = value */
	je	exitMain
	movl	%ebx, %edi /* %edi contains value in %edx */
	call	fibbonacci
	movq	$specifier, %rdi
	movl	%eax, %esi
	movq	$0, %rax
	call	printf
	incl	%ebx	
	jmp	loop

exitMain:	
	movq	$0, %rax
	leave
	ret
	.size main, .-main

/********************************************************************************/
fatorial:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx /* save callee svaed regsiter for recursion */
	cmpl	$0, %edi /* if %edi contains value 0, then return 1 */
	je	baseFa
	movl	%edi, %ebx /* %ebx contains value */
	decl	%edi /* value-- */
	call	fatorial /* recursive call fatorail, return value is %eax */
	imul	%ebx, %eax /* n * factorial(n-1) */
	jmp	exitFa

baseFa:
	movl	$1, %eax
	jmp	exitFa

exitFa:
	popq	%rbx
	leave
	ret
	.size fatorial, .-fatorial
/********************************************************************************/
fibbonacci:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r12
	pushq	%r13
	
	cmpl	$1, %edi /* if n<=1, then fib value = n */
	jle	baseFb

	decl	%edi /* get n-1 */
	movl	%edi, %r12d /* %r12d is n-1 */
	call	fibbonacci
	movl	%eax, %r13d /* store the return value of fib(n-1) in %r13d */
	decl	%r12d /* %r12d is n-2 */
	movl	%r12d, %edi
	call	fibbonacci
	addl	%r13d, %eax /* add the return value of fib(n-2) and %r13d */
	jmp	exitFb

baseFb:
	movl	%edi, %eax
	jmp	exitFb

exitFb:
	popq	%r13
	popq	%r12
	leave
	ret
	.size fatorial, .-fatorial







	
