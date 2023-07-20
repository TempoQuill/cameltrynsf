FDSInstrumentPointers:
	; TRITONE ARPEGGIATED
	.dw Snare1_1 ; COMMON
	.dw Snare1_2 ; GOAL
	.dw Snare1_3 ; UNFORTUNATE
	.dw Snare3   ; UNFORTUNATE
	.dw Snare4   ; VC
	.dw Snare5   ; WARMUP OVER
	; NORMAL
	.dw Kick1_1  ; COMMON
	.dw Kick1_2  ; SSB, VC
	.dw Kick2    ; MENU
	.dw Snare2_1 ; TUTORIAL, SSB, VC
	.dw Snare2_2 ; FORTUNATE
	.dw Snare2_3 ; FORTUNATE
	.dw Snare2_4 ; FORTUNATE
	.dw Snare2_5 ; FORTUNATE
	.dw Saw1     ; COUNTDOWN
	.dw Saw2     ; CONGRATS
	.dw Saw1     ; FINAL TRIAL
	.dw Saw1     ; FINAL TRIAL

Kick1_1:
	.db $A0, $98, $8F, $8B, $88, $86, $85, $85, $84, $84, $84, $83
	.db $83, $82, $82, $82, $82, $82, $81, $81, $81, $81, $81, $80, $FF

Kick1_2:
	.db $A0, $98, $8F, $80, $FF

Kick2:
	.db $9E, $90, $8B, $87, $85, $84, $83
	.db $82, $82, $82, $81, $81, $81, $80, $FF

Snare1_1:
	.db $A0, $9B, $97, $94, $93, $90, $8E, $8D, $8D, $8D, $8C
	.db $8B, $8A, $89, $88, $86, $85, $84, $82, $81, $80, $FF

Snare1_2:
	.db $96, $93, $90, $8E, $8D, $8B, $8A, $89, $89, $89, $88
	.db $88, $87, $86, $86, $84, $83, $83, $81, $81, $80, $FF

Snare1_3:
	.db $9A, $96, $93, $90, $8F, $FF

Snare2_1:
	.db $9F, $92, $8C, $80, $FF

Snare2_2:
	.db $9D, $91, $8B, $80, $FF

Snare2_3:
	.db $9B, $90, $8B, $80, $FF

Snare2_4:
	.db $99, $8F, $8A, $80, $FF

Snare2_5:
	.db $97, $8E, $89, $80, $FF

Snare3:
	.db $A0, $97, $91, $92, $93, $8E, $8B, $8C, $8D, $8C, $88
	.db $89, $8A, $88, $83, $84, $85, $84, $82, $81, $80, $FF

Snare4:
	.db $A0, $9B, $97, $94, $93, $90, $8E, $80, $FF

Snare5:
	.db $A0, $9B, $97, $94, $80, $FF

Saw1:
	.db $92, $FE

Saw2:
	.db $90, $FE
