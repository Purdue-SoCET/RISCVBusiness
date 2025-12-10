	.file	"core_clk_gating_tb.c"
	.text
	.globl	wfi
	.type	wfi, @function
wfi:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 13 "core_clk_gating_tb.c" 1
	wfi
# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	wfi, .-wfi
	.globl	set_msip
	.type	set_msip, @function
set_msip:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$4294967280, %eax
	movl	$1, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	set_msip, .-set_msip
	.globl	clear_msip
	.type	clear_msip, @function
clear_msip:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$4294967280, %eax
	movl	$0, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	clear_msip, .-clear_msip
	.globl	do_some_work
	.type	do_some_work, @function
do_some_work:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L5
.L6:
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
.L5:
	cmpl	$999, -4(%rbp)
	jle	.L6
	movl	-8(%rbp), %eax
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	do_some_work, .-do_some_work
	.section	.rodata
	.align 8
.LC0:
	.string	"hart0: starting clock-gating sleep/wake test\n"
	.align 8
.LC1:
	.string	"hart0: waiting for hart1 to enter initial WFI\n"
	.align 8
.LC2:
	.string	"hart0: hart1 is sleeping; doing some work while it sleeps\n"
	.align 8
.LC3:
	.string	"hart0: raising MSIP to wake hart1\n"
	.align 8
.LC4:
	.string	"hart0: hart1 has woken up and done its work\n"
	.align 8
.LC5:
	.string	"hart0: requesting hart1 to sleep again and clearing MSIP\n"
	.align 8
.LC6:
	.string	"hart0: test complete, flag set to 1\n"
	.text
	.globl	hart0_main
	.type	hart0_main, @function
hart0_main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC0, %edi
	movl	$0, %eax
	call	print
	call	clear_msip
	movl	$.LC1, %edi
	movl	$0, %eax
	call	print
	nop
.L8:
	movl	hart1_ready_for_initial_sleep(%rip), %eax
	testl	%eax, %eax
	je	.L8
	movl	$.LC2, %edi
	movl	$0, %eax
	call	print
	movl	$0, %edi
	call	do_some_work
	movl	$.LC3, %edi
	movl	$0, %eax
	call	print
	call	set_msip
	nop
.L9:
	movl	hart1_awake_and_worked(%rip), %eax
	testl	%eax, %eax
	je	.L9
	movl	$.LC4, %edi
	movl	$0, %eax
	call	print
	movl	$.LC5, %edi
	movl	$0, %eax
	call	print
	movl	$1, hart1_sleep_again_request(%rip)
	call	clear_msip
	movl	$0, %edi
	call	do_some_work
	nop
.L10:
	movl	hart1_sleeping_again(%rip), %eax
	testl	%eax, %eax
	je	.L10
	movl	$1, flag(%rip)
	movl	$.LC6, %edi
	movl	$0, %eax
	call	print
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	hart0_main, .-hart0_main
	.section	.rodata
	.align 8
.LC7:
	.string	"hart1: starting, preparing for initial sleep\n"
	.align 8
.LC8:
	.string	"hart1: entering initial WFI (should gate clock)\n"
	.align 8
.LC9:
	.string	"hart1: woke up from WFI due to MSIP\n"
	.align 8
.LC10:
	.string	"hart1: doing some work after wake\n"
	.align 8
.LC11:
	.string	"hart1: waiting for hart0 to request second sleep\n"
	.align 8
.LC12:
	.string	"hart1: clearing MSIP and going back to WFI (second sleep)\n"
	.align 8
.LC13:
	.string	"hart1: went back to sleep; staying in low-power loop\n"
	.text
	.globl	hart1_main
	.type	hart1_main, @function
hart1_main:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC7, %edi
	movl	$0, %eax
	call	print
	call	clear_msip
	movl	$1, hart1_ready_for_initial_sleep(%rip)
	movl	$.LC8, %edi
	movl	$0, %eax
	call	print
	call	wfi
	movl	$.LC9, %edi
	movl	$0, %eax
	call	print
	call	clear_msip
	movl	$.LC10, %edi
	movl	$0, %eax
	call	print
	movl	$1, %edi
	call	do_some_work
	movl	$1, hart1_awake_and_worked(%rip)
	movl	$.LC11, %edi
	movl	$0, %eax
	call	print
	nop
.L13:
	movl	hart1_sleep_again_request(%rip), %eax
	testl	%eax, %eax
	je	.L13
	movl	$.LC12, %edi
	movl	$0, %eax
	call	print
	call	clear_msip
	call	wfi
	movl	$1, hart1_sleeping_again(%rip)
	movl	$.LC13, %edi
	movl	$0, %eax
	call	print
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	hart1_main, .-hart1_main
	.ident	"GCC: (GNU) 14.2.1 20250110 (Red Hat 14.2.1-10)"
	.section	.note.GNU-stack,"",@progbits
