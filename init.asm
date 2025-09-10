.org $080D
.p816
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
.include "x16.inc"
	bra init
														;0=black, .=white
p0: .byte $00, $80, $C0, $E0, $F0, $F8, $FC, $FE		;........ 0....... 00...... 000..... 0000.... 00000... 000000.. 0000000.
p1:	.byte $FF, $7F, $3F, $1F, $0F, $07, $03, $01		;00000000 .0000000 ..000000 ...00000 ....0000 .....000 ......00 .......0
p2:	.byte $80, $40, $20, $10, $08, $04, $02, $01 		;0....... .0...... ..0..... ...0.... ....0... .....0.. ......0. .......0
														;i like monospace
data: .incbin "test.bin"

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
	sta ypoint2
	sta xpoint
	sta xpoint2
	lda #ynumber
	sta ypoint
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

	jsr bitmap
	jsr rectangle
e:	bra e
.include "rectangle.asm"
.include "bitmap.asm"
.include "calc_origin.asm"
