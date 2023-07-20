; SFX DATA FORMAT
;	.db $xx, $HI, $LO
;	x - volume, $80-$BF for consective bytes, $C0-FE for pitch next byte
;	if x = $FF, end
;	HI - bits 8-15 of pitch
;	LO - bits 0-7 of pitch
FDSSFXPointers:
	.dw SoundEffectData_Concrete
	.dw SoundEffectData_Ouch
	.dw SoundEffectData_Lucky
	.dw SoundEffectData_Stop
	.dw SoundEffectData_Select
	.dw SoundEffectData_1KPoints
	.dw SoundEffectData_DirForce