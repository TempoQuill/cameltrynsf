;
; Vibrato
;
; Instruments operate with vibrato
;
Vibrato:
	.dw Piano
	.dw Bass

Piano:
	.db $00, $00, $00, $00
	.db $00, $00, $00, $00
	.db $00, $00, $00, $00
	.db $00, $00, $00, $00
	.db $00
	.db $01, $01, $01, $01
	.db $FF, $FF, $FF, $FF
	.db $00

Bass:
	.db $00, $00, $00
	.db $00, $00, $00
	.db $00, $00
	.db $01, $01, $01
	.db $FF, $FF, $FF
	.db $00

InstrumentVibratos:
	.db $01, $01, $00, $00
	.db $00, $00, $01, $01
	.db $01, $01, $01, $01
	.db $01, $01, $01, $01
	.db $01, $01, $00, $00
	.db $00
	.db $01, $01, $00, $00
	.db $00, $00, $01, $00
	.db $01, $01
