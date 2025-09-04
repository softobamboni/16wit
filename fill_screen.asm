.org $080D
.p816
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
.include "x16.inc"
width 	= $30
height = $32
xpoint	= $34
ypoint	= $36
xpoint2 = $2A
ypoint2 = $2C
width2	= $38	;8 bit
nibble2 = $39	;8 bit
carry	= $24
xcalcd  = $26	
ycalcd  = $28
temp 	= $22

xnumber = 0		
ynumber = 0
wnumber = 640
hnumber = 480

.include "init.asm"

fill_screen:          ;fill screen
	stz carry
	bcc @skip
	lda #$FF
	sta carry
@skip:
	rep	#$20	;subroutine for filling rectangular part of the screen unprecisely
	.a16		;args - x and y position, width and height
    sep #$10	;and carry flag for filling in 1's or 0's
	.i8
	lda xpoint	;OG X, needs dividing by 8
	lsr
	lsr			;640x480
	lsr			
	sta xcalcd
	lda width 
	lsr			;80x480
	lsr			;i want 160x240 max; remember that
	lsr
	sta width2
	lda ypoint	;OG Y, needs multiplying by 80
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

	adc	xcalcd	;add x and y to create origin point
	
	sta VERA_addr_low		;storing origin into VERA]
	ldx #$10				;loop with width and height
	stx VERA_addr_bank
	lda #80					;making magic value
	sec						;80-width2
	sbc width2
	sta temp
	lda height
	lsr
	tay						;y is height/2
@yloop:	
	phy 
	ldy #2
@doitagain:
	sep #$20				;we need 2 index registers
	.a8						;x is width/8						
	lda carry				;we doing 2 horizontal runs y times because y is divided by 2
	ldx width2
@xloop:
	sta VERA_data0
	dex
	bne @xloop

	rep #$20
	.a16
	lda VERA_addr_low			;adding the magic value
	clc
	adc temp
	sta VERA_addr_low
	dey
	bne @doitagain				;16 bit accumulator is default; fun fact
	
	ply
	dey
	bne @yloop
	
	rts 