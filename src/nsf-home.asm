PLAY:
	TAX
	LDA NSFSongs, X
	LDY QueueOffsets, X
	STA iMusic1, Y
	RTS

NSFSongs:
	.db $01, $02, $04, $08, $10, $20, $40, $80 ; iMusic1
	.db $01, $02, $04, $08, $10, $20, $40, $80 ; iMusic2
	.db $01, $02, $04                          ; iMusic3
	.db $01, $02, $04, $08, $10, $20, $40      ; iFDSSFX
	.db $01, $02                               ; iDPCMSFX
	.db $01, $02                               ; iNoiseSFX

QueueOffsets:
	.db $00, $00, $00, $00, $00, $00, $00, $00
	.db $01, $01, $01, $01, $01, $01, $01, $01
	.db $02, $02, $02
	.db $03, $03, $03, $03, $03, $03, $03
	.db $04, $04
	.db $05, $05
