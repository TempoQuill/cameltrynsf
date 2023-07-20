; MUSIC
MACRO rest
	.db 0
ENDM

MACRO note pitch, octave
	.db octave << 4 | pitch
ENDM

MACRO tie
	.db NOTE_MASK
ENDM

MACRO note_length multiplier, shift
	.db NOTE_LENGTH_CMD | multiplier | shift
ENDM

MACRO drum_envelope id, multiplier, shift
	.db NOTE_LENGTH_CMD | id | multiplier | shift
ENDM

MACRO pitch_slide ammount, pitch, octave
	.db PITCH_BEND_CMD | ammount, octave << 4 | pitch
ENDM

MACRO instrument id
	.db INSTRUMENT_CMD | id
ENDM

MACRO volume_fade dir, ammount
	.db FADE_CTRL_CMD | dir | ammount
ENDM

MACRO volume_const
	.db FADE_CTRL_CMD + F_IN - 1
ENDM

MACRO sound_ret
	.db SOUND_RET_CMD
ENDM

MACRO drum_note pitch
	.db pitch
ENDM

MACRO dpcm_note id
	.db DPCM_ID_CMD + id
ENDM

; PATTERN DATA
MACRO sound_play address
	.dw address
ENDM

MACRO establish_loop
	.db 0, LOOP_CMD
ENDM

MACRO pitch_inc_switch
	.db 0, TUNING_CMD
ENDM

MACRO pat_ret
	.dw 0
ENDM
