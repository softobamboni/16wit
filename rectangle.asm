.org $080D
.p816
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
.include "x16.inc"
width 	= $30
height 	= $32
xpoint	= $34
ypoint	= $36
xpoint2 = $2A
ypoint2 = $2C
nibble 	= $38	;8 bit
nibble2 = $39	;8 bit 
origin	= $24
xcalcd  = $26	
ycalcd  = $28
temp 	= $22

xnumber = 48
ynumber = 48

wnumber = 64
hnumber = 64

.include "init.asm"

instructions:
	.a16
	jsr calcy
	jsr calcx
	jsr calc_origin

	clc
	jsr width_draw
	clc
	jsr height_draw

	ldx nibble
	stx nibble2
	lda xpoint
	dec
	clc
	adc width
	sta xpoint
	jsr calcx
	lda ypoint
	dec
	clc
	adc height
	sta ypoint
	jsr calcy
	jsr calc_origin

	sec
	jsr width_draw
	sec
	jsr height_draw
	
; 	sec
;	jsr fill_screen
@end:
	bra @end
down:
	rep #$20
	lda ypoint2
	inc
	sta ypoint
	sta ypoint2
	lda xpoint2
	inc
	sta xpoint
	sta xpoint2
	bra instructions
left:
	rep #$20
	lda xpoint2
	dec
	sta xpoint
	lda ypoint2
	sta ypoint
	bra instructions
right:
	rep #$20
	lda xpoint2
	inc
	sta xpoint
	lda ypoint2
	sta ypoint
	brl instructions
calcy:						;make it a subroutine (the rts stuff)
	rep #$20
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
	rts
calcx:						;make it a subroutine too
;	rep #$20				;maybe calcx and calcy = same subroutine (calcorigin)
	.a16					;nibble at nibble
	lda xpoint
	and #$0007
	tax
	lda xpoint
	lsr
	lsr
	lsr
	sta xcalcd
	stx nibble
;	sep #$20
;	.a8
	rts
calc_origin:
	lda xcalcd
	clc
	adc ycalcd		;0+x+y = x+y
	sta origin
	rts
width_draw:			;subroutine (args = origin (memory), width (memory), carry (1 = reverse))
	.a16
	.i8
	ldy #1
	sty VERA_ctrl
	lda	origin
	sta VERA_addr_low
	stz VERA_ctrl
	sta VERA_addr_low
	lda #$0010
	bcc @skip
	ora #$0008
@skip:
	tax
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
	cpx #$18
	beq reverse
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
	rts
reverse:
	pha
	lda nibble
	inc
	and #7
	beq @skip
	tay
	lda p0,y
	ora VERA_data0
	sta VERA_data1
@skip:
	lda #$FF
	ply
	dey
@r_copy_8px:
	sta VERA_data0
	bit VERA_data1
	dey
	bne @r_copy_8px
@r_copy_last:
	ldy nibble2
	lda p1,y
	ora VERA_data0
	sta VERA_data1
@skip2:
	rts
height_draw:
	lda	origin
	ldy #1
	stz VERA_ctrl
	sta VERA_addr_low
	sty VERA_ctrl
	sta VERA_addr_low
	lda #$00C0
	tax	
	bcc @skip
	ora #$0008
	tax
	lda VERA_addr_low
;	clc
;	adc #$0050
;	sta VERA_addr_low
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
