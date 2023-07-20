.base 0
	.db "NESM", $1a, $01
	.db 30 ; total sounds
	.db 1  ; track offset
	.dw StartProcessingSoundQueue
	.dw PLAY
	.dw StartProcessingSoundQueue
	.db "Cameltry (FDS)"
.pad $2e, $00
	.db "Pinch Punch"
.pad $4e, $00
	.db "'89-'91 Taito, 2023 Tempo Quill"
.pad $6e, $00
	.dw $411a                                  ; NTSC
	.db $00, $00, $00, $00, $00, $00, $00, $00 ; Banks
	.dw 0                                      ; PAL
	.db 0                                      ; TV option: NTSC
	.db %00000100                              ; FDS Audio
.pad $80, $00