calc_origin:				;calculate origin
	rep #$20				;needed for every draw subroutine internally
	.a16
	lda ypoint
	asl
	asl
	asl
	asl
	asl
	asl
	sta temp
	lda ypoint
	asl
	asl
	asl
	asl
	clc
	adc temp
	sta ycalcd
	lda xpoint
	and #$0007
	tax
	lda xpoint
	lsr
	lsr
	lsr
	sta xcalcd
	stx nibble
	lda xcalcd
	clc
	adc ycalcd		;0+x+y = x+y
	sta origin
	rts
