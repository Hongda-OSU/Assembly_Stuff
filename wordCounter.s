/* Name: Hongda Lin */
/* Date: 10/4/2021 */
.file "wordCounter.s"
.section	.rodata

str:
	.string "Hello world     AAA BBB CCC DDD     EEE FFF GGG HHH JJJ     KKK"
output:
	.string "The string is has %d words.\n"

.align 8

/* Data sections */
.data

.global wordCount
	.type wordCount, @function
.global main
	.type main, @function
.text
/********************************************************************************/
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$str, %rdi
	call	wordCount
	movl	%eax, %esi
	movq	$output, %rdi
	movq	$0, %rax
	call	printf
	
 
	leave
	ret
	.size main, .-main
/********************************************************************************/
wordCount:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %eax /* set num_word = 0 */
	movl	$0, %edx /* set isInWord = 0 */
loop:
	movb	(%rdi), %bl /* get the character */
	cmpl	$0, %ebx /* check the ASCII value of the character with string terminater */
	je	exit
	cmpl	$32, %ebx /* check if character is space */
	jne	inWordCheck
	movl	$0, %edx /* set isInWord = 0 */
	jmp	address

inWordCheck:
	cmpl	$0, %edx /* if isInWord == 0 */
	jne	address
	movl	$1, %edx /* set isInWord = 1 */
	incl	%eax /* num_word++ */
	
address:
	leaq	1(%rdi), %rdi /* str++, pointer now point at the next character */
	jmp	loop

exit:
	leave
	ret
	.size wordCount, .-wordCount
/********************************************************************************/


