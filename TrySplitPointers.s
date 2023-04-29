	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 11, 1
	.globl	_main
	.p2align	4, 0x90
_main:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r13
	subq	$776, %rsp
	.cfi_offset %r13, -24
	movq	_$sSfN@GOTPCREL(%rip), %rax
	movl	%edi, -204(%rbp)
	movq	%rax, %rdi
	movq	%rsi, -216(%rbp)
	callq	_$sS2ayxGycfC
	movq	_$sSfN@GOTPCREL(%rip), %rdi
	movq	%rax, _$s8Contents2raSaySfGvp(%rip)
	callq	_$sS2ayxGycfC
	leaq	_$s8Contents2raSaySfGvp(%rip), %rcx
	xorl	%edx, %edx
	movl	%edx, %esi
	movq	%rax, _$s8Contents2iaSaySfGvp(%rip)
	movq	%rcx, %rdi
	leaq	-32(%rbp), %rax
	movq	%rsi, -224(%rbp)
	movq	%rax, %rsi
	movl	$33, %edx
	movq	-224(%rbp), %rcx
	callq	_swift_beginAccess
	leaq	_$sSaySfGMD(%rip), %rdi
	callq	___swift_instantiateConcreteTypeFromMangledName
	xorl	%r8d, %r8d
	movl	%r8d, %edi
	movq	%rax, %rsi
	leaq	_$s8Contents2raSaySfGvp(%rip), %r13
	movq	%rax, -232(%rbp)
	callq	_$sSa15reserveCapacityyySiF
	movq	_$s8Contents2raSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -240(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-240(%rbp), %rdi
	movq	%rax, -248(%rbp)
	callq	_$sSa24_baseAddressIfContiguousSpyxGSgvg
	movq	-240(%rbp), %rdi
	movq	%rax, -256(%rbp)
	callq	_swift_bridgeObjectRelease
	movq	-256(%rbp), %rax
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	je	LBB0_3
	movb	$1, %al
	movb	%al, -257(%rbp)
	jmp	LBB0_4
LBB0_3:
	xorl	%eax, %eax
	movb	%al, -257(%rbp)
LBB0_4:
	movb	-257(%rbp), %al
	testb	$1, %al
	jne	LBB0_5
	jmp	LBB0_6
LBB0_5:
	movb	$1, %al
	movb	%al, -258(%rbp)
	jmp	LBB0_7
LBB0_6:
	movq	_$s8Contents2raSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -272(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	-272(%rbp), %rcx
	movq	%rcx, -48(%rbp)
	movq	-48(%rbp), %rdx
	movq	%rdx, -56(%rbp)
	movq	%rax, -280(%rbp)
	callq	_$sSaySfGSayxGSlsWl
	leaq	-56(%rbp), %rcx
	movq	-232(%rbp), %rdi
	movq	%rax, %rsi
	movq	%rcx, %r13
	callq	_$sSlsE7isEmptySbvg
	movq	-272(%rbp), %rdi
	movb	%al, -281(%rbp)
	callq	_swift_bridgeObjectRelease
	movb	-281(%rbp), %al
	movb	%al, -258(%rbp)
LBB0_7:
	movb	-258(%rbp), %al
	xorb	$-1, %al
	testb	$1, %al
	jne	LBB0_8
	jmp	LBB0_9
LBB0_8:
	jmp	LBB0_10
LBB0_9:
	jmp	LBB0_12
LBB0_10:
	jmp	LBB0_11
LBB0_11:
	leaq	L___unnamed_1(%rip), %rax
	movq	%rsp, %rcx
	movq	%rax, (%rcx)
	movl	$1, 32(%rcx)
	movq	$14175, 24(%rcx)
	movl	$2, 16(%rcx)
	movq	$39, 8(%rcx)
	leaq	L___unnamed_2(%rip), %rdi
	leaq	L___unnamed_3(%rip), %rcx
	xorl	%edx, %edx
	movl	%edx, %r8d
	movl	$11, %esi
	movl	$2, %edx
	movl	%edx, -288(%rbp)
	movl	-288(%rbp), %r9d
	callq	_$ss18_fatalErrorMessage__4file4line5flagss5NeverOs12StaticStringV_A2HSus6UInt32VtF
	ud2
LBB0_12:
	movq	_$s8Contents2raSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -296(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-296(%rbp), %rdi
	movq	%rax, -304(%rbp)
	callq	_$sSa24_baseAddressIfContiguousSpyxGSgvg
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	movq	%rax, -312(%rbp)
	je	LBB0_14
	movb	$1, %al
	movb	%al, -313(%rbp)
	jmp	LBB0_15
LBB0_14:
	xorl	%eax, %eax
	movb	%al, -313(%rbp)
LBB0_15:
	movb	-313(%rbp), %al
	testb	$1, %al
	jne	LBB0_16
	jmp	LBB0_17
LBB0_16:
	movb	$1, %al
	movb	%al, -314(%rbp)
	jmp	LBB0_18
LBB0_17:
	movq	-296(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rcx
	movq	%rcx, -80(%rbp)
	callq	_$sSaySfGSayxGSlsWl
	leaq	-80(%rbp), %rcx
	movq	-232(%rbp), %rdi
	movq	%rax, %rsi
	movq	%rcx, %r13
	callq	_$sSlsE7isEmptySbvg
	movb	%al, -314(%rbp)
LBB0_18:
	movb	-314(%rbp), %al
	testb	$1, %al
	jne	LBB0_19
	jmp	LBB0_21
LBB0_19:
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-296(%rbp), %rdi
	callq	_$sSa6_owneryXlSgvg
	movq	-312(%rbp), %rcx
	cmpq	$0, %rcx
	movq	%rax, -328(%rbp)
	je	LBB0_23
	movq	-312(%rbp), %rax
	movq	%rax, -336(%rbp)
	jmp	LBB0_22
LBB0_21:
	movq	-296(%rbp), %rdi
	callq	_swift_bridgeObjectRetain
	movq	-296(%rbp), %rcx
	movq	%rcx, -88(%rbp)
	leaq	-88(%rbp), %rdx
	leaq	_$ss12_ArrayBufferVySfGMD(%rip), %rdi
	movq	%rax, -344(%rbp)
	movq	%rdx, -352(%rbp)
	callq	___swift_instantiateConcreteTypeFromMangledName
	movq	%rax, -360(%rbp)
	callq	_$ss12_ArrayBufferVySfGAByxGSTsWl
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-352(%rbp), %rdi
	movq	-360(%rbp), %rdx
	movq	%rax, %rcx
	callq	_$ss15ContiguousArrayVyAByxGqd__c7ElementQyd__RszSTRd__lufC
	movq	%rax, %rcx
	movq	%rcx, %rdi
	movq	%rax, -368(%rbp)
	callq	_swift_retain
	movq	-368(%rbp), %rdi
	movq	%rax, -376(%rbp)
	callq	_swift_release
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-368(%rbp), %rdi
	callq	_$ss22_ContiguousArrayBufferV5owneryXlvg
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-368(%rbp), %rdi
	movq	%rax, -384(%rbp)
	callq	_$ss22_ContiguousArrayBufferV19firstElementAddressSpyxGvg
	movq	-368(%rbp), %rdi
	movq	%rax, -392(%rbp)
	callq	_swift_release
	movq	-384(%rbp), %rax
	movq	-392(%rbp), %rcx
	movq	%rax, -400(%rbp)
	movq	%rcx, -408(%rbp)
	jmp	LBB0_25
LBB0_22:
	movq	-336(%rbp), %rax
	movq	%rax, -416(%rbp)
	jmp	LBB0_24
LBB0_23:
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rcx, -416(%rbp)
	jmp	LBB0_24
LBB0_24:
	movq	-416(%rbp), %rax
	movq	-328(%rbp), %rcx
	movq	%rcx, -400(%rbp)
	movq	%rax, -408(%rbp)
LBB0_25:
	movq	-408(%rbp), %rax
	movq	-400(%rbp), %rcx
	cmpq	$0, %rax
	movq	%rax, -424(%rbp)
	movq	%rcx, -432(%rbp)
	je	LBB0_28
	movq	-424(%rbp), %rax
	movq	%rax, -440(%rbp)
	movq	-440(%rbp), %rax
	movq	%rax, -96(%rbp)
	jmp	LBB0_30
LBB0_28:
	movl	$4, %eax
	decq	%rax
	seto	%cl
	testb	$1, %cl
	movq	%rax, -448(%rbp)
	jne	LBB0_79
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	-448(%rbp), %rdx
	subq	%rdx, %rcx
	seto	%sil
	decq	%rcx
	seto	%dil
	cmpq	$0, %rcx
	movq	%rcx, -456(%rbp)
	je	LBB0_31
	jmp	LBB0_32
LBB0_30:
	movq	-96(%rbp), %rax
	movq	-296(%rbp), %rdi
	movq	%rax, -464(%rbp)
	callq	_swift_bridgeObjectRelease
	leaq	_$s8Contents2iaSaySfGvp(%rip), %rax
	xorl	%ecx, %ecx
	movq	%rax, %rdi
	leaq	-128(%rbp), %rsi
	movl	$33, %edx
	callq	_swift_beginAccess
	xorl	%r8d, %r8d
	movl	%r8d, %edi
	movq	-232(%rbp), %rsi
	leaq	_$s8Contents2iaSaySfGvp(%rip), %r13
	callq	_$sSa15reserveCapacityyySiF
	jmp	LBB0_40
LBB0_31:
	movq	$0, -104(%rbp)
	jmp	LBB0_33
LBB0_32:
	movq	-456(%rbp), %rax
	movq	%rax, -104(%rbp)
LBB0_33:
	movq	-104(%rbp), %rax
	cmpq	$0, %rax
	movq	%rax, -472(%rbp)
	je	LBB0_36
	movq	-472(%rbp), %rax
	movq	%rax, -480(%rbp)
	movq	-480(%rbp), %rax
	movq	%rax, -96(%rbp)
	jmp	LBB0_30
LBB0_36:
	jmp	LBB0_37
LBB0_37:
	jmp	LBB0_38
LBB0_38:
	jmp	LBB0_39
LBB0_39:
	leaq	L___unnamed_1(%rip), %rax
	movq	%rsp, %rcx
	movq	%rax, (%rcx)
	movl	$1, 32(%rcx)
	movq	$14164, 24(%rcx)
	movl	$2, 16(%rcx)
	movq	$39, 8(%rcx)
	leaq	L___unnamed_2(%rip), %rdi
	leaq	L___unnamed_4(%rip), %rcx
	movl	$11, %esi
	movl	$57, %r8d
	movl	$2, %edx
	movl	%edx, -484(%rbp)
	movl	-484(%rbp), %r9d
	callq	_$ss17_assertionFailure__4file4line5flagss5NeverOs12StaticStringV_A2HSus6UInt32VtF
	ud2
LBB0_40:
	movq	_$s8Contents2iaSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -496(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-496(%rbp), %rdi
	movq	%rax, -504(%rbp)
	callq	_$sSa24_baseAddressIfContiguousSpyxGSgvg
	movq	-496(%rbp), %rdi
	movq	%rax, -512(%rbp)
	callq	_swift_bridgeObjectRelease
	movq	-512(%rbp), %rax
	movq	%rax, -136(%rbp)
	cmpq	$0, -136(%rbp)
	je	LBB0_42
	movb	$1, %al
	movb	%al, -513(%rbp)
	jmp	LBB0_43
LBB0_42:
	xorl	%eax, %eax
	movb	%al, -513(%rbp)
LBB0_43:
	movb	-513(%rbp), %al
	testb	$1, %al
	jne	LBB0_44
	jmp	LBB0_45
LBB0_44:
	movb	$1, %al
	movb	%al, -514(%rbp)
	jmp	LBB0_46
LBB0_45:
	movq	_$s8Contents2iaSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -528(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	-528(%rbp), %rcx
	movq	%rcx, -144(%rbp)
	movq	-144(%rbp), %rdx
	movq	%rdx, -152(%rbp)
	movq	%rax, -536(%rbp)
	callq	_$sSaySfGSayxGSlsWl
	leaq	-152(%rbp), %rcx
	movq	-232(%rbp), %rdi
	movq	%rax, %rsi
	movq	%rcx, %r13
	callq	_$sSlsE7isEmptySbvg
	movq	-528(%rbp), %rdi
	movb	%al, -537(%rbp)
	callq	_swift_bridgeObjectRelease
	movb	-537(%rbp), %al
	movb	%al, -514(%rbp)
LBB0_46:
	movb	-514(%rbp), %al
	xorb	$-1, %al
	testb	$1, %al
	jne	LBB0_47
	jmp	LBB0_48
LBB0_47:
	jmp	LBB0_49
LBB0_48:
	jmp	LBB0_51
LBB0_49:
	jmp	LBB0_50
LBB0_50:
	leaq	L___unnamed_1(%rip), %rax
	movq	%rsp, %rcx
	movq	%rax, (%rcx)
	movl	$1, 32(%rcx)
	movq	$14175, 24(%rcx)
	movl	$2, 16(%rcx)
	movq	$39, 8(%rcx)
	leaq	L___unnamed_2(%rip), %rdi
	leaq	L___unnamed_3(%rip), %rcx
	xorl	%edx, %edx
	movl	%edx, %r8d
	movl	$11, %esi
	movl	$2, %edx
	movl	%edx, -544(%rbp)
	movl	-544(%rbp), %r9d
	callq	_$ss18_fatalErrorMessage__4file4line5flagss5NeverOs12StaticStringV_A2HSus6UInt32VtF
	ud2
LBB0_51:
	movq	_$s8Contents2iaSaySfGvp(%rip), %rax
	movq	%rax, %rdi
	movq	%rax, -552(%rbp)
	callq	_swift_bridgeObjectRetain
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-552(%rbp), %rdi
	movq	%rax, -560(%rbp)
	callq	_$sSa24_baseAddressIfContiguousSpyxGSgvg
	movq	%rax, -160(%rbp)
	cmpq	$0, -160(%rbp)
	movq	%rax, -568(%rbp)
	je	LBB0_53
	movb	$1, %al
	movb	%al, -569(%rbp)
	jmp	LBB0_54
LBB0_53:
	xorl	%eax, %eax
	movb	%al, -569(%rbp)
LBB0_54:
	movb	-569(%rbp), %al
	testb	$1, %al
	jne	LBB0_55
	jmp	LBB0_56
LBB0_55:
	movb	$1, %al
	movb	%al, -570(%rbp)
	jmp	LBB0_57
LBB0_56:
	movq	-552(%rbp), %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rcx
	movq	%rcx, -176(%rbp)
	callq	_$sSaySfGSayxGSlsWl
	leaq	-176(%rbp), %rcx
	movq	-232(%rbp), %rdi
	movq	%rax, %rsi
	movq	%rcx, %r13
	callq	_$sSlsE7isEmptySbvg
	movb	%al, -570(%rbp)
LBB0_57:
	movb	-570(%rbp), %al
	testb	$1, %al
	jne	LBB0_58
	jmp	LBB0_60
LBB0_58:
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-552(%rbp), %rdi
	callq	_$sSa6_owneryXlSgvg
	movq	-568(%rbp), %rcx
	cmpq	$0, %rcx
	movq	%rax, -584(%rbp)
	je	LBB0_62
	movq	-568(%rbp), %rax
	movq	%rax, -592(%rbp)
	jmp	LBB0_61
LBB0_60:
	movq	-552(%rbp), %rdi
	callq	_swift_bridgeObjectRetain
	movq	-552(%rbp), %rcx
	movq	%rcx, -184(%rbp)
	leaq	-184(%rbp), %rdx
	leaq	_$ss12_ArrayBufferVySfGMD(%rip), %rdi
	movq	%rax, -600(%rbp)
	movq	%rdx, -608(%rbp)
	callq	___swift_instantiateConcreteTypeFromMangledName
	movq	%rax, -616(%rbp)
	callq	_$ss12_ArrayBufferVySfGAByxGSTsWl
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-608(%rbp), %rdi
	movq	-616(%rbp), %rdx
	movq	%rax, %rcx
	callq	_$ss15ContiguousArrayVyAByxGqd__c7ElementQyd__RszSTRd__lufC
	movq	%rax, %rcx
	movq	%rcx, %rdi
	movq	%rax, -624(%rbp)
	callq	_swift_retain
	movq	-624(%rbp), %rdi
	movq	%rax, -632(%rbp)
	callq	_swift_release
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-624(%rbp), %rdi
	callq	_$ss22_ContiguousArrayBufferV5owneryXlvg
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	-624(%rbp), %rdi
	movq	%rax, -640(%rbp)
	callq	_$ss22_ContiguousArrayBufferV19firstElementAddressSpyxGvg
	movq	-624(%rbp), %rdi
	movq	%rax, -648(%rbp)
	callq	_swift_release
	movq	-640(%rbp), %rax
	movq	-648(%rbp), %rcx
	movq	%rax, -656(%rbp)
	movq	%rcx, -664(%rbp)
	jmp	LBB0_64
LBB0_61:
	movq	-592(%rbp), %rax
	movq	%rax, -672(%rbp)
	jmp	LBB0_63
LBB0_62:
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rcx, -672(%rbp)
	jmp	LBB0_63
LBB0_63:
	movq	-672(%rbp), %rax
	movq	-584(%rbp), %rcx
	movq	%rcx, -656(%rbp)
	movq	%rax, -664(%rbp)
LBB0_64:
	movq	-664(%rbp), %rax
	movq	-656(%rbp), %rcx
	cmpq	$0, %rax
	movq	%rax, -680(%rbp)
	movq	%rcx, -688(%rbp)
	je	LBB0_67
	movq	-680(%rbp), %rax
	movq	%rax, -696(%rbp)
	movq	-696(%rbp), %rax
	movq	%rax, -192(%rbp)
	jmp	LBB0_69
LBB0_67:
	movl	$4, %eax
	decq	%rax
	seto	%cl
	testb	$1, %cl
	movq	%rax, -704(%rbp)
	jne	LBB0_80
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	-704(%rbp), %rdx
	subq	%rdx, %rcx
	seto	%sil
	decq	%rcx
	seto	%dil
	cmpq	$0, %rcx
	movq	%rcx, -712(%rbp)
	je	LBB0_70
	jmp	LBB0_71
LBB0_69:
	movq	-192(%rbp), %rax
	movq	-552(%rbp), %rdi
	movq	%rax, -720(%rbp)
	callq	_swift_bridgeObjectRelease
	leaq	-128(%rbp), %rdi
	callq	_swift_endAccess
	leaq	-32(%rbp), %rdi
	callq	_swift_endAccess
	movq	-688(%rbp), %rdi
	callq	_swift_unknownObjectRelease
	movq	-432(%rbp), %rdi
	callq	_swift_unknownObjectRelease
	movq	_$sSfN@GOTPCREL(%rip), %rdi
	movq	-464(%rbp), %rax
	movq	%rax, _$s8Contents3sa1So15DSPSplitComplexVvp(%rip)
	movq	-720(%rbp), %rcx
	movq	%rcx, _$s8Contents3sa1So15DSPSplitComplexVvp+8(%rip)
	callq	_$ss15ContiguousArrayVAByxGycfC
	movq	_$sSfN@GOTPCREL(%rip), %rdi
	movq	%rax, _$s8Contents3rcas15ContiguousArrayVySfGvp(%rip)
	callq	_$ss15ContiguousArrayVAByxGycfC
	xorl	%edx, %edx
	movq	%rax, _$s8Contents3icas15ContiguousArrayVySfGvp(%rip)
	movl	%edx, %eax
	addq	$776, %rsp
	popq	%r13
	popq	%rbp
	retq
LBB0_70:
	movq	$0, -200(%rbp)
	jmp	LBB0_72
LBB0_71:
	movq	-712(%rbp), %rax
	movq	%rax, -200(%rbp)
LBB0_72:
	movq	-200(%rbp), %rax
	cmpq	$0, %rax
	movq	%rax, -728(%rbp)
	je	LBB0_75
	movq	-728(%rbp), %rax
	movq	%rax, -736(%rbp)
	movq	-736(%rbp), %rax
	movq	%rax, -192(%rbp)
	jmp	LBB0_69
LBB0_75:
	jmp	LBB0_76
LBB0_76:
	jmp	LBB0_77
LBB0_77:
	jmp	LBB0_78
LBB0_78:
	leaq	L___unnamed_1(%rip), %rax
	movq	%rsp, %rcx
	movq	%rax, (%rcx)
	movl	$1, 32(%rcx)
	movq	$14164, 24(%rcx)
	movl	$2, 16(%rcx)
	movq	$39, 8(%rcx)
	leaq	L___unnamed_2(%rip), %rdi
	leaq	L___unnamed_4(%rip), %rcx
	movl	$11, %esi
	movl	$57, %r8d
	movl	$2, %edx
	movl	%edx, -740(%rbp)
	movl	-740(%rbp), %r9d
	callq	_$ss17_assertionFailure__4file4line5flagss5NeverOs12StaticStringV_A2HSus6UInt32VtF
	ud2
LBB0_79:
	ud2
LBB0_80:
	ud2
	.cfi_endproc

	.private_extern	___swift_instantiateConcreteTypeFromMangledName
	.globl	___swift_instantiateConcreteTypeFromMangledName
	.weak_definition	___swift_instantiateConcreteTypeFromMangledName
	.p2align	4, 0x90
___swift_instantiateConcreteTypeFromMangledName:
	subq	$40, %rsp
	movq	%rdi, %rax
	movq	(%rdi), %rcx
	cmpq	$0, %rcx
	setl	%dl
	testb	$1, %dl
	movq	%rcx, %rsi
	movq	%rdi, 32(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rsi, 8(%rsp)
	jne	LBB1_2
LBB1_1:
	movq	8(%rsp), %rax
	addq	$40, %rsp
	retq
LBB1_2:
	movq	16(%rsp), %rax
	sarq	$32, %rax
	negq	%rax
	movq	16(%rsp), %rcx
	movl	%ecx, %edx
	movslq	%edx, %rsi
	movq	32(%rsp), %rdi
	addq	%rsi, %rdi
	xorl	%edx, %edx
	movl	%edx, %esi
	movq	%rsi, (%rsp)
	movq	%rax, %rsi
	movq	(%rsp), %rdx
	movq	(%rsp), %rcx
	callq	_swift_getTypeByMangledNameInContext
	movq	%rax, %rcx
	movq	24(%rsp), %rdx
	movq	%rax, (%rdx)
	movq	%rcx, 8(%rsp)
	jmp	LBB1_1

	.private_extern	_$sSaySfGSayxGSlsWl
	.globl	_$sSaySfGSayxGSlsWl
	.weak_definition	_$sSaySfGSayxGSlsWl
	.p2align	4, 0x90
_$sSaySfGSayxGSlsWl:
	subq	$24, %rsp
	movq	_$sSaySfGSayxGSlsWL(%rip), %rax
	cmpq	$0, %rax
	movq	%rax, 16(%rsp)
	jne	LBB2_2
	movl	$255, %edi
	callq	_$sSaySfGMa
	movq	_$sSayxGSlsMc@GOTPCREL(%rip), %rdi
	movq	%rax, %rsi
	movq	%rdx, 8(%rsp)
	movq	%rax, %rdx
	callq	_swift_getWitnessTable
	movq	%rax, %rcx
	movq	%rax, _$sSaySfGSayxGSlsWL(%rip)
	movq	%rcx, 16(%rsp)
LBB2_2:
	movq	16(%rsp), %rax
	addq	$24, %rsp
	retq

	.private_extern	_$sSaySfGMa
	.globl	_$sSaySfGMa
	.weak_definition	_$sSaySfGMa
	.p2align	4, 0x90
_$sSaySfGMa:
	subq	$40, %rsp
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	_$sSaySfGML(%rip), %rdx
	cmpq	$0, %rdx
	movq	%rdi, 32(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rcx, 16(%rsp)
	jne	LBB3_3
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	32(%rsp), %rdi
	callq	_$sSaMa
	cmpq	$0, %rdx
	movq	%rax, %rcx
	movq	%rax, 8(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rdx, 16(%rsp)
	jne	LBB3_3
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	8(%rsp), %rdx
	movq	%rdx, _$sSaySfGML(%rip)
	movq	%rdx, 24(%rsp)
	movq	%rcx, 16(%rsp)
LBB3_3:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rax, (%rsp)
	movq	%rcx, %rax
	movq	(%rsp), %rdx
	addq	$40, %rsp
	retq

	.private_extern	_$ss12_ArrayBufferVySfGAByxGSTsWl
	.globl	_$ss12_ArrayBufferVySfGAByxGSTsWl
	.weak_definition	_$ss12_ArrayBufferVySfGAByxGSTsWl
	.p2align	4, 0x90
_$ss12_ArrayBufferVySfGAByxGSTsWl:
	subq	$24, %rsp
	movq	_$ss12_ArrayBufferVySfGAByxGSTsWL(%rip), %rax
	cmpq	$0, %rax
	movq	%rax, 16(%rsp)
	jne	LBB4_2
	movl	$255, %edi
	callq	_$ss12_ArrayBufferVySfGMa
	movq	_$ss12_ArrayBufferVyxGSTsMc@GOTPCREL(%rip), %rdi
	movq	%rax, %rsi
	movq	%rdx, 8(%rsp)
	movq	%rax, %rdx
	callq	_swift_getWitnessTable
	movq	%rax, %rcx
	movq	%rax, _$ss12_ArrayBufferVySfGAByxGSTsWL(%rip)
	movq	%rcx, 16(%rsp)
LBB4_2:
	movq	16(%rsp), %rax
	addq	$24, %rsp
	retq

	.private_extern	_$ss12_ArrayBufferVySfGMa
	.globl	_$ss12_ArrayBufferVySfGMa
	.weak_definition	_$ss12_ArrayBufferVySfGMa
	.p2align	4, 0x90
_$ss12_ArrayBufferVySfGMa:
	subq	$40, %rsp
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	_$ss12_ArrayBufferVySfGML(%rip), %rdx
	cmpq	$0, %rdx
	movq	%rdi, 32(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rcx, 16(%rsp)
	jne	LBB5_3
	movq	_$sSfN@GOTPCREL(%rip), %rsi
	movq	32(%rsp), %rdi
	callq	_$ss12_ArrayBufferVMa
	cmpq	$0, %rdx
	movq	%rax, %rcx
	movq	%rax, 8(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rdx, 16(%rsp)
	jne	LBB5_3
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	8(%rsp), %rdx
	movq	%rdx, _$ss12_ArrayBufferVySfGML(%rip)
	movq	%rdx, 24(%rsp)
	movq	%rcx, 16(%rsp)
LBB5_3:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rax, (%rsp)
	movq	%rcx, %rax
	movq	(%rsp), %rdx
	addq	$40, %rsp
	retq

	.private_extern	_$s8Contents2raSaySfGvp
	.globl	_$s8Contents2raSaySfGvp
.zerofill __DATA,__common,_$s8Contents2raSaySfGvp,8,3
	.private_extern	_$s8Contents2iaSaySfGvp
	.globl	_$s8Contents2iaSaySfGvp
.zerofill __DATA,__common,_$s8Contents2iaSaySfGvp,8,3
	.private_extern	_$s8Contents3sa1So15DSPSplitComplexVvp
	.globl	_$s8Contents3sa1So15DSPSplitComplexVvp
.zerofill __DATA,__common,_$s8Contents3sa1So15DSPSplitComplexVvp,16,3
	.private_extern	_$s8Contents3rcas15ContiguousArrayVySfGvp
	.globl	_$s8Contents3rcas15ContiguousArrayVySfGvp
.zerofill __DATA,__common,_$s8Contents3rcas15ContiguousArrayVySfGvp,8,3
	.private_extern	_$s8Contents3icas15ContiguousArrayVySfGvp
	.globl	_$s8Contents3icas15ContiguousArrayVySfGvp
.zerofill __DATA,__common,_$s8Contents3icas15ContiguousArrayVySfGvp,8,3
	.private_extern	"_symbolic SaySfG"
	.section	__TEXT,__swift5_typeref,regular,no_dead_strip
	.globl	"_symbolic SaySfG"
	.weak_definition	"_symbolic SaySfG"
	.p2align	1
"_symbolic SaySfG":
	.ascii	"SaySfG"
	.byte	0

	.private_extern	_$sSaySfGMD
	.section	__DATA,__data
	.globl	_$sSaySfGMD
	.weak_definition	_$sSaySfGMD
	.p2align	3
_$sSaySfGMD:
	.long	"_symbolic SaySfG"-_$sSaySfGMD
	.long	4294967290

	.section	__TEXT,__cstring,cstring_literals
	.p2align	4
L___unnamed_1:
	.asciz	"Swift/x86_64-apple-macos.swiftinterface"

L___unnamed_3:
	.space	1

	.private_extern	_$sSaySfGSayxGSlsWL
	.section	__DATA,__data
	.globl	_$sSaySfGSayxGSlsWL
	.weak_definition	_$sSaySfGSayxGSlsWL
	.p2align	3
_$sSaySfGSayxGSlsWL:
	.quad	0

	.private_extern	_$sSaySfGML
	.globl	_$sSaySfGML
	.weak_definition	_$sSaySfGML
	.p2align	3
_$sSaySfGML:
	.quad	0

	.private_extern	"_symbolic _____ySfG s12_ArrayBufferV"
	.section	__TEXT,__swift5_typeref,regular,no_dead_strip
	.globl	"_symbolic _____ySfG s12_ArrayBufferV"
	.weak_definition	"_symbolic _____ySfG s12_ArrayBufferV"
	.p2align	1
"_symbolic _____ySfG s12_ArrayBufferV":
	.byte	2
	.long	_$ss12_ArrayBufferVMn@GOTPCREL+4
	.ascii	"ySfG"
	.byte	0

	.private_extern	_$ss12_ArrayBufferVySfGMD
	.section	__DATA,__data
	.globl	_$ss12_ArrayBufferVySfGMD
	.weak_definition	_$ss12_ArrayBufferVySfGMD
	.p2align	3
_$ss12_ArrayBufferVySfGMD:
	.long	"_symbolic _____ySfG s12_ArrayBufferV"-_$ss12_ArrayBufferVySfGMD
	.long	4294967287

	.private_extern	_$ss12_ArrayBufferVySfGAByxGSTsWL
	.globl	_$ss12_ArrayBufferVySfGAByxGSTsWL
	.weak_definition	_$ss12_ArrayBufferVySfGAByxGSTsWL
	.p2align	3
_$ss12_ArrayBufferVySfGAByxGSTsWL:
	.quad	0

	.private_extern	_$ss12_ArrayBufferVySfGML
	.globl	_$ss12_ArrayBufferVySfGML
	.weak_definition	_$ss12_ArrayBufferVySfGML
	.p2align	3
_$ss12_ArrayBufferVySfGML:
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
	.p2align	4
L___unnamed_4:
	.asciz	"Unexpectedly found nil while unwrapping an Optional value"

L___unnamed_2:
	.asciz	"Fatal error"

	.section	__TEXT,__swift5_entry,regular,no_dead_strip
	.p2align	2
l_entry_point:
	.long	_main-l_entry_point

	.private_extern	__swift_FORCE_LOAD_$_swiftAccelerate_$_Contents
	.section	__DATA,__const
	.globl	__swift_FORCE_LOAD_$_swiftAccelerate_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftAccelerate_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftAccelerate_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftAccelerate

	.private_extern	__swift_FORCE_LOAD_$_swiftMetal_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftMetal_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftMetal_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftMetal_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftMetal

	.private_extern	__swift_FORCE_LOAD_$_swiftDarwin_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftDarwin_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftDarwin_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftDarwin_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftDarwin

	.private_extern	__swift_FORCE_LOAD_$_swiftFoundation_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftFoundation_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftFoundation_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftFoundation_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftFoundation

	.private_extern	__swift_FORCE_LOAD_$_swiftObjectiveC_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftObjectiveC_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftObjectiveC_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftObjectiveC_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftObjectiveC

	.private_extern	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftCoreFoundation_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftCoreFoundation

	.private_extern	__swift_FORCE_LOAD_$_swiftDispatch_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftDispatch_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftDispatch_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftDispatch_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftDispatch

	.private_extern	__swift_FORCE_LOAD_$_swiftCoreGraphics_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftCoreGraphics_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftCoreGraphics_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftCoreGraphics_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftCoreGraphics

	.private_extern	__swift_FORCE_LOAD_$_swiftIOKit_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftIOKit_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftIOKit_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftIOKit_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftIOKit

	.private_extern	__swift_FORCE_LOAD_$_swiftXPC_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftXPC_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftXPC_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftXPC_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftXPC

	.private_extern	__swift_FORCE_LOAD_$_swiftos_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftos_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftos_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftos_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftos

	.private_extern	__swift_FORCE_LOAD_$_swiftCompatibility51_$_Contents
	.globl	__swift_FORCE_LOAD_$_swiftCompatibility51_$_Contents
	.weak_definition	__swift_FORCE_LOAD_$_swiftCompatibility51_$_Contents
	.p2align	3
__swift_FORCE_LOAD_$_swiftCompatibility51_$_Contents:
	.quad	__swift_FORCE_LOAD_$_swiftCompatibility51

	.private_extern	___swift_reflection_version
	.section	__TEXT,__const
	.globl	___swift_reflection_version
	.weak_definition	___swift_reflection_version
	.p2align	1
___swift_reflection_version:
	.short	3

	.no_dead_strip	_main
	.no_dead_strip	l_entry_point
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftAccelerate_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftMetal_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftDarwin_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftFoundation_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftObjectiveC_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftCoreFoundation_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftDispatch_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftCoreGraphics_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftIOKit_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftXPC_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftos_$_Contents
	.no_dead_strip	__swift_FORCE_LOAD_$_swiftCompatibility51_$_Contents
	.no_dead_strip	___swift_reflection_version
	.linker_option "-lswiftAccelerate"
	.linker_option "-lswiftCore"
	.linker_option "-framework", "Accelerate"
	.linker_option "-framework", "CoreVideo"
	.linker_option "-lswiftMetal"
	.linker_option "-framework", "Metal"
	.linker_option "-lswiftDarwin"
	.linker_option "-lswiftFoundation"
	.linker_option "-lswiftObjectiveC"
	.linker_option "-framework", "Foundation"
	.linker_option "-lswiftCoreFoundation"
	.linker_option "-framework", "CoreFoundation"
	.linker_option "-lswiftDispatch"
	.linker_option "-framework", "Combine"
	.linker_option "-framework", "ApplicationServices"
	.linker_option "-lswiftCoreGraphics"
	.linker_option "-framework", "CoreGraphics"
	.linker_option "-lswiftIOKit"
	.linker_option "-framework", "IOKit"
	.linker_option "-framework", "ColorSync"
	.linker_option "-framework", "ImageIO"
	.linker_option "-framework", "CoreServices"
	.linker_option "-framework", "Security"
	.linker_option "-lswiftXPC"
	.linker_option "-framework", "CFNetwork"
	.linker_option "-framework", "DiskArbitration"
	.linker_option "-framework", "CoreText"
	.linker_option "-framework", "IOSurface"
	.linker_option "-framework", "OpenGL"
	.linker_option "-lswiftos"
	.linker_option "-lswiftSwiftOnoneSupport"
	.linker_option "-lobjc"
	.linker_option "-lswiftCompatibility51"
	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	84084544

	.weak_reference __swift_FORCE_LOAD_$_swiftAccelerate
	.weak_reference __swift_FORCE_LOAD_$_swiftMetal
	.weak_reference __swift_FORCE_LOAD_$_swiftDarwin
	.weak_reference __swift_FORCE_LOAD_$_swiftFoundation
	.weak_reference __swift_FORCE_LOAD_$_swiftObjectiveC
	.weak_reference __swift_FORCE_LOAD_$_swiftCoreFoundation
	.weak_reference __swift_FORCE_LOAD_$_swiftDispatch
	.weak_reference __swift_FORCE_LOAD_$_swiftCoreGraphics
	.weak_reference __swift_FORCE_LOAD_$_swiftIOKit
	.weak_reference __swift_FORCE_LOAD_$_swiftXPC
	.weak_reference __swift_FORCE_LOAD_$_swiftos
	.weak_reference __swift_FORCE_LOAD_$_swiftCompatibility51
.subsections_via_symbols
