.p816
.include "x16.inc"
init:
	.a16
	.i8
	clc
	xce
	sep #$10
	rep #$20
	lda #wnumber
	sta width 	
	lda #hnumber
	sta height	
	lda #xnumber
	sta xpoint	
	sta xpoint2
	lda #ynumber
	sta ypoint	
	sta ypoint2
	sep #$20
	.a8
	lda #%00000100
	sta VERA_L1_config
	lda #1
	sta VERA_L1_tilebase
	lda #$10
	sta VERA_addr_bank
	stz VERA_addr_low
	stz VERA_addr_high
	lda #$01
	ldy #155
clear_screen:			
	ldx #$FF
@loop:
	stz VERA_data0
	dex
	bne @loop
	dey
	bne clear_screen