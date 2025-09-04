VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25
VERA_ien          = $9F26
VERA_isr          = $9F27
VERA_irqline_l    = $9F28
VERA_dc_video     = $9F29 ; VERA_ctrl(1) (DCSEL) = 0
VERA_dc_hscale    = $9F2A ; VERA_ctrl(1) (DCSEL) = 0
VERA_dc_vscale    = $9F2B ; VERA_ctrl(1) (DCSEL) = 0
VERA_dc_border    = $9F2C ; VERA_ctrl(1) (DCSEL) = 0
VERA_dc_hstart    = $9F29 ; VERA_ctrl(1) (DCSEL) = 1
VERA_dc_hstop     = $9F2A ; VERA_ctrl(1) (DCSEL) = 1
VERA_dc_vsstart   = $9F2B ; VERA_ctrl(1) (DCSEL) = 1
VERA_dc_vstop     = $9F2C ; VERA_ctrl(1) (DCSEL) = 1
VERA_L0_config    = $9F2D
VERA_L0_mapbase   = $9F2E
VERA_L0_tilebase  = $9F2F
VERA_L0_hscroll_l = $9F30
VERA_L0_hscroll_h = $9F31
VERA_L0_vscroll_l = $9F32
VERA_L0_vscroll_h = $9F33
VERA_L1_config    = $9F34
VERA_L1_mapbase   = $9F35
VERA_L1_tilebase  = $9F36
VERA_L1_hscroll_l = $9F37
VERA_L1_hscroll_h = $9F38
VERA_L1_vscroll_l = $9F39
VERA_L1_vscroll_h = $9F3A

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

xnumber = 58
ynumber = 42

wnumber = 125
hnumber = 360
