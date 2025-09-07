
rectangle:					;draw a rectangle
 	.a16					;arguments: x ($34), y ($36), width ($30), height ($32), color (carry flag)
	.i8
	jsr calc_origin

	sep #$10
	jsr width_draw
	jsr height_draw

;	ldx nibble
;	stx nibble2
;	lda xpoint
;	dec
;	clc
;	adc width
;	sta xpoint
	lda ypoint
	pha
	dec
	clc
	adc height
	sta ypoint
	jsr calc_origin

	clc
	jsr width_draw

	pla
	sta ypoint

	lda xpoint
	dec
	clc
	adc width
	sta xpoint
	jsr calc_origin

	clc
	jsr height_draw
@end:
	bra @end

fill_area:					;arguments: x ($34), y ($36), width ($30), height ($32), color (carry flag)
	jsr calc_origin

	lda height
	pha
@loop:
	clc
	jsr width_draw			;do width_draw height times
	rep #$20
	pla						;fucking inefficient but straightforward
	dec
	beq @end
	pha
	lda #80
	clc
	adc origin
	sta origin
	bra @loop
@end:
 	bra @end

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
width_draw:			;subroutine (args = origin (memory), width (memory), carry (1 = change color))
	.a16
	.i8
	ldy #1
	sty VERA_ctrl
	lda	origin
	sta VERA_addr_low
	stz VERA_ctrl
	sta VERA_addr_low
	ldx #$10
	stx VERA_addr_bank
	sty VERA_ctrl
	stx VERA_addr_bank
	lda width
	clc 
	adc nibble
	and #$07
	sta temp
	lda width
	lsr
	lsr
	lsr
	sep #$20
	.a8
@copy_first:
	tax	
	ldy nibble
	lda p1,y		
	ora VERA_data0
	sta VERA_data1
@skip2:
	lda #$FF
	dex
@copy_8px:
	sta VERA_data0
	bit VERA_data1
	dex
	bne @copy_8px
@copy_last:
	ldy temp
	beq @skip3
	lda p0,y
	ora VERA_data0
	sta VERA_data1
@skip3:
	rep #$20
	rts
height_draw:
	.a16
	.i8
	lda	origin
	ldy #1
	stz VERA_ctrl
	sta VERA_addr_low
	sty VERA_ctrl
	sta VERA_addr_low
	lda #$00C0
	tax	
@skip:
	stz VERA_ctrl
	stx VERA_addr_bank
	sty VERA_ctrl
	stx VERA_addr_bank
	sep #$20
	.a8
	ldy nibble
;	cpx #$B8
;	bne @skip2
;	tya
;	eor #$07
;	tay
@skip2:
	lda p2, y
	rep #$10
	.i16
	ldx height
	dex
	bit VERA_data0
	bit VERA_data1
@draw:
	ora VERA_data0
	sta VERA_data1
	dex
	bne @draw
	sep #$10
	rep #$20
	stz VERA_ctrl
	.a16
	.i8
	rts
