bitmap:
	rep #$20
	.a16
	ldx #$10				;copy memory to the framebuffer
	lda #$1FF
	stz VERA_ctrl
	stx VERA_addr_bank		;arguments: x, y, width, height
	sta VERA_addr_low
; 	stz VERA_addr_high
	sep #$30
	.i8
	.a8
	ldx #32
@loop:
	phx
	ldx #3
	ldy temp
@loop2:
	lda data,y
	sta VERA_data0
	iny
	dex
	bne @loop2

	sty temp
	rep #$20
	.a16
	lda VERA_addr_low
	clc
	adc #80-3
	sta VERA_addr_low
	sep #$20
	.a8
	plx
	dex
	bne @loop
@end:
	rts
