	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Sum 1: %lld and Q: %d\n"
.LC1:
	.string	"Sum 2: %lld and Q: %d\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Sample %d - First Approach completed in %d clock cycles.\n"
	.align 8
.LC3:
	.string	"Sample %d - Second Approach completed in %d clock cycles.\n\n"
	.section	.rodata.str1.1
.LC4:
	.string	"Average of %ld clock cycles.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%edi, %edi
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	40000+A(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	-40000(%r14), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	time@PLT
	movq	%rax, %rdi
	call	srand@PLT
	movl	$0, Q(%rip)
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	cltd
	shrl	$22, %edx
	addl	%edx, %eax
	andl	$1023, %eax
	subl	%edx, %eax
	leal	-512(%rax), %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	movl	%edx, 0(%rbp)
	cmpl	$512, %eax
	je	.L2
	addl	%edx, Q(%rip)
.L2:
	addq	$4, %rbp
	cmpq	%r14, %rbp
	jne	.L3
	leaq	cycles_second(%rip), %r15
	leaq	A(%rip), %rax
	movq	%r15, %rbp
	leaq	cycles_first(%rip), %r12
	leaq	39984(%rax), %r13
.L6:
#APP
# 51 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	movl	%esi, start_time(%rip)
	leaq	A(%rip), %rax
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L4:
	movslq	(%rax), %rcx
	addq	$4, %rax
	addq	%rcx, %rdx
	cmpq	%r14, %rax
	jne	.L4
	movl	Q(%rip), %ecx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
#APP
# 65 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	movl	%esi, end_time(%rip)
	subl	start_time(%rip), %esi
	movl	%esi, (%r12)
#APP
# 78 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	movl	%esi, start_time(%rip)
	leaq	A(%rip), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L5:
	movl	4(%rcx), %eax
	addl	(%rcx), %eax
	addq	$28, %rcx
	addl	-20(%rcx), %eax
	addl	-16(%rcx), %eax
	addl	-12(%rcx), %eax
	addl	-8(%rcx), %eax
	addl	-4(%rcx), %eax
	cltq
	addq	%rax, %rdx
	cmpq	%rcx, %r13
	jne	.L5
	movl	Q(%rip), %ecx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
#APP
# 92 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	movl	%esi, end_time(%rip)
	subl	start_time(%rip), %esi
	addq	$4, %rbp
	addq	$4, %r12
	leaq	20+cycles_second(%rip), %rax
	movl	%esi, -4(%rbp)
	cmpq	%rax, %rbp
	jne	.L6
	movq	$0, total_first(%rip)
	movl	$1, %ebp
	leaq	.LC2(%rip), %r12
	movq	$0, total_second(%rip)
.L7:
	leaq	cycles_first(%rip), %rbx
	movl	%ebp, %edx
	movq	%r12, %rsi
	xorl	%eax, %eax
	movl	(%rbx,%rbp,4), %ecx
	movl	$1, %edi
	call	__printf_chk@PLT
	movl	(%r15,%rbp,4), %ecx
	movl	%ebp, %edx
	movl	$1, %edi
	leaq	.LC3(%rip), %rsi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movslq	(%rbx,%rbp,4), %rcx
	movslq	(%r15,%rbp,4), %rax
	addq	$1, %rbp
	addq	total_first(%rip), %rcx
	addq	%rax, total_second(%rip)
	movq	%rcx, total_first(%rip)
	cmpq	$5, %rbp
	jne	.L7
	movq	%rcx, %rax
	sarq	$63, %rcx
	movl	$1, %edi
	movabsq	$7378697629483820647, %rbp
	imulq	%rbp
	leaq	.LC4(%rip), %rsi
	xorl	%eax, %eax
	sarq	%rdx
	subq	%rcx, %rdx
	call	__printf_chk@PLT
	movq	total_second(%rip), %rcx
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	leaq	.LC4(%rip), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	movl	$1, %edi
	movq	%rcx, %rax
	sarq	$63, %rcx
	imulq	%rbp
	popq	%rbp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	sarq	%rdx
	subq	%rcx, %rdx
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.globl	end_time
	.data
	.align 4
	.type	end_time, @object
	.size	end_time, 4
end_time:
	.long	125
	.globl	start_time
	.align 4
	.type	start_time, @object
	.size	start_time, 4
start_time:
	.long	150
	.comm	total_second,8,8
	.comm	total_first,8,8
	.comm	cycles_second,20,16
	.comm	cycles_first,20,16
	.comm	Q,4,4
	.comm	P,4,4
	.comm	A,40000,32
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
