StartProcessingSoundQueue:
	LDA #$FF
	STA rJOY2

	JSR ProcessNoiseQueue
	JSR ProcessDPCMQueue
	JSR Process2C33Queue
	JSR ProcessMusicQueue
	; Reset queues
	LDA #0
	STA iMusic1
	STA iMusic2
	STA iMusic3
	STA iFDSSFX
	STA iDPCMSFX
	STA iNoiseSFX
	RTS


ProcessNoiseQueue:
	LDA iNoiseSFX
	BNE ProcessNoiseQueue_Part2
	LDA iCurrentNoiseSFX
	BNE ProcessNoiseQueue_Part3
	RTS

ProcessNoiseQueue_Part2:
	STA iCurrentNoiseSFX
	LDY #0
	STY iSFXNoisePitch
	LDY #$ff

ProcessNoiseQueue_PointerLoop:
	INY
	LSR A
	BCC ProcessNoiseQueue_PointerLoop

	LDA NoiseDataLengths, Y
	ASL A
	STA iSFXNoiseOffset

ProcessNoiseQueue_Part3:
	LDA iSFXNoiseOffset
	CLC
	ADC #2
	BNE ProcessNoiseQueue_Sequenced

	LDA #iSFXNoisePitch
	BNE ProcessNoiseQueue_Exit

	LDA #$8A
	STA #iSFXNoisePitch
	BNE ProcessNoiseQueue_Update

ProcessNoiseQueue_Sequenced:
	LDA iSFXNoiseOffset
	LSR A
	TAY
	DEC iSFXNoiseOffset
	BCS ProcessNoiseQueue_Exit

	LDA SFXData_Lodge, Y
	BMI ProcessNoiseQueue_Exit
	STA iSFXNoisePitch
	BEQ ProcessNoiseQueue_Update

	LDA #$10
	STA rNOISE_VOL
	LDA #0
	STA rNOISE_LO
	STA rNOISE_HI
	RTS

ProcessNoiseQueue_Update:
	LDY #$1a
	STY rNOISE_VOL
	ORA #$80
	STA rNOISE_LO
	LDA #$08
	STA rNOISE_HI
	LDY #$01
	STY rNOISE_VOL

ProcessNoiseQueue_Exit:
	LDA rSND_CHN
	AND #$08
	BEQ ProcessNoiseQueue_Clear
	RTS

ProcessNoiseQueue_Clear:
	STA iCurrentNoiseSFX
	RTS

SFXData_Lodge:
	.db $80, $80, $0B, $09, $80, $80, $0A, $00, $09
SFXData_LodgeEnd:

NoiseDataLengths:
	.db $FF
	.db #SFXData_LodgeEnd - SFXData_Lodge


ProcessDPCMQueue:
	LDA iDPCMSFX
	BNE ProcessDPCMQueue_Part2

	LDA iCurrentDPCMSFX
	BEQ ProcessDPCMQueue_Exit

	LDA rSND_CHN
	AND #$10
	BNE ProcessDPCMQueue_Exit

	STA iCurrentDPCMSFX
	LDA #$0f
	STA rSND_CHN
	RTS

ProcessDPCMQueue_Part2:
	STA iCurrentDPCMSFX
	LDY #0

ProcessDPCMQueue_PointerLoop:
	INY
	LSR A
	BCC ProcessDPCMQueue_PointerLoop
	BCS ProcessDPCMQueue_PlaySound

ProcessDPCMQueue_Exit:
	RTS

ProcessDPCMQueue_PlaySound:
	LDA #$0f
	STA rSND_CHN
	LDA DPCM_Pitches, Y
	STA rDMC_FREQ
	LDA DPCM_Lengths, Y
	STA rDMC_LEN
	LDA DPCM_Addresses, Y
	STA rDMC_START
	LDA #$10
	STA rSND_CHN
	RTS


Process2C33Queue:
	LDA iFDSSFX
	BNE Process2C33Queue_Part2
	LDA iCurrentFDSSFX
	BNE Process2C33Queue_Part3
	RTS

Process2C33Queue_Part2:
	STA iCurrentFDSSFX
	LDY #$ff

Process2C33Queue_PointerLoop:
	INY
	LSR A
	BCC Process2C33Queue_PointerLoop

	STY iSFX2C33Offset
	STY iSFX2C33PointerOffset
	ASL iSFX2C33PointerOffset
	STA iSFX2C33DataOffset
	STA iFDSSFXPitch
	STA iFDSSFXPitch + 1
	LDA #$80
	STA rFDS_FREQ_HI

	LDY iSFX2C33PointerOffset
	LDA FDSSFXWavTables, Y
	STA zWavetablePointer
	LDA FDSSFXWavTables + 1, Y
	STA zWavetablePointer + 1
	LDY #0
	LDX #FDS_WAVETABLE_LENGTH

Process2C33Queue_WavLoop:
	LDA (zWavetablePointer), Y
	STA rFDS_WAV_RAM, Y
	INY
	DEX
	BNE Process2C33Queue_WavLoop

	LDY iSFX2C33PointerOffset
	LDA FDSSFXModTables, Y
	STA zModTablePointer
	LDA FDSSFXModTables + 1, Y
	STA zModTablePointer + 1
	LDY #0
	LDX #FDS_MODULATION_LENGTH

Process2C33Queue_ModLoop:
	LDA (zModTablePointer), Y
	STA rFDS_MOD_WRITE
	INY
	DEX
	BNE Process2C33Queue_ModLoop

	LDY iSFX2C33Offset
	LDA FDSSFXModDepths, Y
	STA rFDS_MOD_ENV
	LDA FDSSFXModRatesLo, Y
	STA rFDS_MOD_LO
	LDA FDSSFXModRatesHi, Y
	STA rFDS_MOD_HI

Process2C33Queue_Part3:
	LDY iSFX2C33PointerOffset
	LDA FDSSFXPointers, Y
	STA zFDSSFXPoitner
	LDA FDSSFXPointers + 1, Y
	STA zFDSSFXPoitner + 1
	LDY iSFX2C33DataOffset
	LDA (zFDSSFXPoitner), Y
	BMI Process2C33Queue_Volume
	INY
	AND #$0f
	STA rFDS_FREQ_HI
	LDA (zFDSSFXPoitner), Y
	INY
	STA rFDS_FREQ_LO
	STY iSFX2C33DataOffset
	RTS

Process2C33Queue_Volume:
	INY
	TAX
	INX
	BEQ Process2C33Queue_Ret
	INX
	BEQ Process2C33Queue_Loop
	CMP #$c0
	BCS Process2C33Queue_VolumePlusPitch
	STA rFDS_ENVELOPE
	STY iSFX2C33DataOffset
	RTS

Process2C33Queue_Ret:
	STX iCurrentFDSSFX
	JMP ClearFDS

Process2C33Queue_Loop:
	LDA iCurrentFDSSFX
	STA iFDSSFX
	STX iCurrentFDSSFX
	JMP Process2C33Queue

Process2C33Queue_VolumePlusPitch:
	AND #$BF
	STA rFDS_ENVELOPE
	LDA (zFDSSFXPoitner), Y
	INY
	AND #$0f
	STA rFDS_FREQ_HI
	LDA (zFDSSFXPoitner), Y
	INY
	STA rFDS_FREQ_LO
	STY iSFX2C33DataOffset
	RTS


FDSSFXModDepths:
	.db $84, $BF, $BF, $8B, $80, $BF, $80

FDSSFXModRatesLo:
	.db $FF, $FF, $FF, $2F, $00, $FF, $00

FDSSFXModRatesHi:
	.db $00, $0F, $0F, $00, $00, $0F, $00

FDSSFXModTables:
	.dw MT_SFX1, MT_SFX2, MT_SFX2, MT_SFX1, MT_SFX2, MT_SFX2, MT_SFX2

FDSSFXWavTables:
	.dw Wav_Snare2, Wav_Saw, Wav_Snare2, Wav_Saw, Wav_Saw, Wav_Saw, Wav_Saw

.include "src/music/fds-sfx-pointers.asm"
.include "src/music/sound-effects/1k-points.asm"
.include "src/music/sound-effects/concrete.asm"
.include "src/music/sound-effects/dir-force.asm"
.include "src/music/sound-effects/lucky.asm"
.include "src/music/sound-effects/ouch.asm"
.include "src/music/sound-effects/select.asm"
.include "src/music/sound-effects/stop.asm"


ProcessMusicQueue:
	LDA iMusic3
	BNE ProcessMusicQueue_Music3

	LDA iMusic1
	BNE ProcessMusicQueue_Music1

	LDA iMusic2
	BNE ProcessMusicQueue_Music2

	LDA iMusicStack
	BEQ StopMusic

	LDA iCurrentMusic1
	ORA iCurrentMusic2
	ORA iCurrentMusic3
	BNE ProcessMusicQueue_Update

	LDA iMusicStack
	STA iMusic2
	BEQ StopMusic

ProcessMusicQueue_Music2:
	JMP ProcessMusic2Queue

ProcessMusicQueue_Music3:
	JMP ProcessMusic3Queue

ProcessMusicQueue_Music1:
	JMP ProcessMusic1Queue

ProcessMusicQueue_Update:
	JMP ReadPatterns

StopMusic:
	LDA iCurrentFDSSFX
	BNE StopMusic_Skip2C33

	LDA #1
	STA rFDS_IO_ENABLE
	JSR ClearFDS

StopMusic_Skip2C33:
	LDA iCurrentDPCMSFX
	BNE StopMusic_SkipDPCM

	JSR ClearDPCM

StopMusic_SkipDPCM:
	LDA iCurrentNoiseSFX
	BNE StopMusic_SkipNoise

	JSR ClearNoise

StopMusic_SkipNoise:
	LDA #$10
	STA rSQ1_VOL
	STA rSQ2_VOL
	LDA #0
	STA iCurrentMusic3
	STA iCurrentMusic2
	STA iCurrentMusic1
	STA rSQ1_HI
	STA rSQ1_LO
	STA rSQ1_SWEEP
	STA rSQ2_HI
	STA rSQ2_LO
	STA rSQ2_SWEEP
	STA rTRI_LINEAR
	STA rTRI_HI
	STA rTRI_LO
	RTS

ClearFDS:
	LDA #$80
	STA rFDS_ENVELOPE
	STA rFDS_MOD_ENV
	STA rFDS_FREQ_HI
	LDA #0
	STA rFDS_MOD_LO
	STA rFDS_MOD_HI
	STA rFDS_FREQ_LO
	RTS

ClearDPCM:
	LDA #0
	STA rDMC_FREQ
	STA rDMC_LEN
	STA rDMC_START
	RTS

ClearNoise:
	LDA #$10
	STA rNOISE_VOL
	LDA #$80
	STA rNOISE_LO
	LDA #0
	STA rNOISE_HI
	RTS

;
; Specific music queue handlings
;
; This particular routine handles the jingles that bring the driver back to the
; previously playing song if from iCurrentMusic2.
;
ProcessMusic3Queue_StopMusic:
	; We land here when there's no music to play
	JMP StopMusic

ProcessMusic3Queue:
	; check for no music
	CMP #Music3_Stop
	BCS ProcessMusic3Queue_StopMusic
	; every song on this queue puts iCurrentMusic2 on the music stack
	STA iCurrentMusic3
	LDY iCurrentMusic2
	STY iMusicStack
	; iMusic3 is third in RAM
	LDY #$10
	STY iMusicOffset
	JSR ClearLoops
	STY iCurrentMusic2
	STY iCurrentMusic1
	JSR InitSong

ProcessMusic3Queue_CopyData:
	LDA Music3_PatternHeaders, Y
	STA zMusicPatternPointers, X
	INX
	INY
	; did RAM offset hit $c?
	CPX #12
	BCC ProcessMusic3Queue_CopyData
	JMP DefaultNoteLength


ProcessMusic2Queue:
	; iMusic2 is second in RAM
	LDY #$08
	STY iMusicOffset
	JSR ClearLoops
	STY iCurrentMusic1
	STY iCurrentMusic3
	JSR InitSong

ProcessMusic2Queue_CopyData:
	LDA Music2_PatternHeaders, Y
	STA zMusicPatternPointers, X
	INX
	INY
	; did RAM offset hit $c?
	CPX #12
	BCC ProcessMusic2Queue_CopyData
	JMP DefaultNoteLength


ProcessMusic1Queue:
	; iMusic1 is first in RAM
	JSR ClearLoops
	STY iMusicOffset
	STY iCurrentMusic2
	STY iCurrentMusic3
	JSR InitSong

ProcessMusic1Queue_CopyData:
	LDA Music1_PatternHeaders, Y
	STA zMusicPatternPointers, X
	INX
	INY
	; did RAM offset hit $c?
	CPX #12
	BCC ProcessMusic1Queue_CopyData
	JMP DefaultNoteLength


ClearLoops:
	LDY #0
	STY zMusicLoopPointers
	STY zMusicLoopPointers + 1
	STY zMusicLoopPointers + 2
	STY zMusicLoopPointers + 3
	STY zMusicLoopPointers + 4
	STY zMusicLoopPointers + 5
	STY zMusicLoopPointers + 6
	STY zMusicLoopPointers + 7
	STY zMusicLoopPointers + 8
	STY zMusicLoopPointers + 9
	STY zMusicLoopPointers + 10
	STY zMusicLoopPointers + 11
	RTS

InitSong:
	; fetch bit ID
	INY
	LSR A
	BCC InitSong
	DEY
	; add pointer offset
	TYA
	ORA iMusicOffset
	STA iMusicOffset
	TAX
	; iMusicOffset determines each song's tempo
	LDA MusicTempos, X
	STA iMusicTempo
	; each header is 16 bytes long for speed
	TYA
	ASL A ; x2
	ASL A ; x4
	ASL A ; x8
	ASL A ; x16
	TAY
	; initialize extra channel
	LDA #3
	STA rFDS_IO_ENABLE
	JSR ClearFDS
	; initialize RAM offset
	LDX #0
	RTS

DefaultNoteLength:
	; default note length
	LDA #0
	STA iMusicPulse1NoteLength
	STA iMusicPulse2NoteLength
	STA iMusicHillNoteLength
	STA iMusicNoiseNoteLength
	STA iDPCMNoteLengthCounter
	STA iMusic2C33NoteLength

ReadPatterns:
	LDY #0
	STY iCurrentChannel
	JSR ReadSquare1Pattern
	JSR ReadSquare2Pattern
	JSR ReadHillPattern
	JSR ReadNoisePattern
	JSR ReadDPCMPattern
	JMP Read2C33Pattern


ReadSquare1Pattern:
	JSR ReadPatternData
	BCS ReadSquare1Pattern_UpdateSilent
	JSR ReadMusicData
	BCS ReadSquare1Pattern_Dec
	JSR InterpretPulseMusicData
	BCS ReadSquare1Pattern
	LDA iRestingTail
	BMI ReadSquare1Pattern_UpdateSilent
	JSR InterpretPulseInstrument
	JMP ReadSquare1Pattern_Update

ReadSquare1Pattern_Dec:
	INC iInstrumentOffset
	DEC iMusicPulse1NoteLength

ReadSquare1Pattern_Update:
	JSR ApplyVibrato
	JSR ApplyPitchSlide
	JSR ApplyFade
	LDA iRestingTail
	AND #$01
	CMP iMusicPulse1NoteLength
	BEQ ReadSquare1Pattern_UpdateSilent
	JSR CheckPulseFade
	LDY iInstrumentOffset
	LDA (zInstrumentPointer), Y
	CLC
	ADC iSoundMathBuffer
	ADC iFadeOffset
	STA rSQ1_VOL
	LDA #0
	STA rSQ1_SWEEP
	LDA zCurrentPitch
	STA rSQ1_LO
	LDA zCurrentPitch + 1
	ORA #$08
	STA rSQ1_HI
	RTS

ReadSquare1Pattern_UpdateSilent:
	LDA #$10
	STA rSQ1_VOL
	LDA #0
	STA rSQ1_SWEEP
	STA rSQ1_LO
	STA rSQ1_HI
	RTS

ReadSquare2Pattern:
	INC iCurrentChannel
ReadSquare2Pattern_Restart:
	LDY iCurrentChannel
	JSR ReadPatternData
	BCS ReadSquare2Pattern_UpdateSilent
	JSR ReadMusicData
	BCS ReadSquare2Pattern_Dec
	JSR InterpretPulseMusicData
	BCS ReadSquare2Pattern_Restart
	LDA iRestingTail + 1
	BMI ReadSquare2Pattern_UpdateSilent
	JSR InterpretPulseInstrument
	JMP ReadSquare2Pattern_Update

ReadSquare2Pattern_Dec:
	INC iInstrumentOffset + 1
	DEC iMusicPulse2NoteLength

ReadSquare2Pattern_Update:
	JSR ApplyVibrato
	JSR ApplyPitchSlide
	JSR ApplyFade
	LDA iRestingTail + 1
	AND #$01
	CMP iMusicPulse2NoteLength
	BEQ ReadSquare2Pattern_UpdateSilent
	JSR CheckPulseFade
	LDY iInstrumentOffset + 1
	LDA (zInstrumentPointer), Y
	CLC
	ADC iSoundMathBuffer
	ADC iFadeOffset + 1
	STA rSQ2_VOL
	LDA #0
	STA rSQ2_SWEEP
	LDA zCurrentPitch + 2
	STA rSQ2_LO
	LDA zCurrentPitch + 3
	ORA #$08
	STA rSQ2_HI
	RTS

ReadSquare2Pattern_UpdateSilent:
	LDA #$10
	STA rSQ2_VOL
	LDA #0
	STA rSQ2_SWEEP
	STA rSQ2_LO
	STA rSQ2_HI
	RTS


ReadHillPattern:
	INC iCurrentChannel
ReadHillPattern_Restart:
	LDY iCurrentChannel
	JSR ReadPatternData
	BCS ReadHillPattern_UpdateSilent
	JSR ReadMusicData
	BCS ReadHillPattern_Dec
	JSR InterpretHillMusicData
	BCS ReadHillPattern_Restart
	LDA iRestingTail + 2
	BMI ReadHillPattern_UpdateSilent
	JSR InterpretHillInstrument
	JMP ReadHillPattern_Update

ReadHillPattern_Dec:
	DEC iMusicHillNoteLength

ReadHillPattern_Update:
	JSR ApplyVibrato
	JSR ApplyPitchSlide
	LDA iRestingTail + 2
	AND #$01
	CMP iMusicHillNoteLength
	BEQ ReadHillPattern_UpdateSilent
	LDA #$81
	STA rTRI_LINEAR
	LDA zCurrentPitch + 4
	STA rTRI_LO
	LDA zCurrentPitch + 5
	STA rTRI_HI
	RTS

ReadHillPattern_UpdateSilent:
	LDA #0
	STA rTRI_LINEAR
	STA rTRI_LO
	STA rTRI_HI
	RTS

ReadNoisePattern:
	INC iCurrentChannel

ReadNoisePattern_Restart:
	LDY iCurrentChannel
	JSR ReadPatternData
	BCS ReadNoisePattern_UpdateSilent
	JSR ReadMusicData
	BCS ReadNoisePattern_Dec
	JSR InterpretNoiseMusicData
	BCC ReadNoisePattern_Update
	BCS ReadNoisePattern_Restart

ReadNoisePattern_Dec:
	DEC iMusicNoiseNoteLength
	RTS

ReadNoisePattern_Update:
	LDA iCurrentNoiseSFX
	BNE ReadNoisePattern_End
	LDA iCurrentNoisePitch
	BEQ ReadNoisePattern_UpdateSilent
	LDX iNoiseID
	LDA NoiseVolumes, X
	STA rNOISE_VOL
	LDA iCurrentNoisePitch
	ORA #$80 ; always periodic noise
	STA rNOISE_LO
	LDA #$08
	STA rNOISE_HI
	LDA NoiseSweeps, X
	STA rNOISE_VOL
ReadNoisePattern_End
	RTS

ReadNoisePattern_UpdateSilent:
	LDA iCurrentNoiseSFX
	BNE ReadNoisePattern_End
	LDA #$10
	STA rNOISE_VOL
	LDA #$80 ; always periodic noise
	STA rNOISE_LO
	LDA #0
	STA rNOISE_HI
	RTS

ReadDPCMPattern:
	INC iCurrentChannel
ReadDPCMPattern_Restart:
	LDY iCurrentChannel
	JSR ReadPatternData
	BCS ReadDPCMPattern_UpdateSilent
	JSR ReadMusicData
	BCS ReadDPCMPattern_Dec
	JSR InterpretDPCMMusicData
	BCC ReadDPCMPattern_Update
	BCS ReadDPCMPattern_Restart

ReadDPCMPattern_Dec:
	DEC iDPCMNoteLengthCounter
	RTS

ReadDPCMPattern_Update:
	LDY iCurrentDPCMSFX
	BNE ReadDPCMPattern_End
	LDY iCurrentDPCMPitch
	INY
	BEQ ReadDPCMPattern_UpdateSilent
	LDA #$0f
	STA rSND_CHN
	DEY
	LDA DPCM_Pitches, Y
	STA rDMC_FREQ
	LDA DPCM_Lengths, Y
	STA rDMC_LEN
	LDA DPCM_Addresses, Y
	STA rDMC_START
	LDA #$1f
	STA rSND_CHN
ReadDPCMPattern_End:
	RTS

ReadDPCMPattern_UpdateSilent:
	LDY iCurrentDPCMSFX
	BNE ReadDPCMPattern_End
	LDA #0
	STA rDMC_FREQ
	STA rDMC_LEN
	STA rDMC_START
	RTS

Read2C33Pattern:
	INC iCurrentChannel

Read2C33Pattern_Restart:
	LDY iCurrentChannel
	JSR ReadPatternData
	BCS Read2C33Pattern_UpdateSilent
	JSR ReadMusicData
	BCS Read2C33Pattern_Dec
	PHA
	LDA #0
	STA iFDSArpPitch
	STA iFDSArpPitch + 1
	PLA
	JSR InterpretFDSMusicData
	BCS Read2C33Pattern_Restart
	LDA iRestingTail + 3
	BMI Read2C33Pattern_UpdateSilent
	JSR InterpretFDSInsturment
	JMP Read2C33Pattern_Update

Read2C33Pattern_Dec:
	DEC iMusic2C33NoteLength

Read2C33Pattern_Update:
	JSR ApplyPitchSlide
	JSR ApplyFade
	JSR ApplyFDSArp
	LDA iCurrentFDSSFX
	BNE Read2C33Pattern_End

	LDA iRestingTail + 3
	AND #$01
	CMP iMusic2C33NoteLength
	BEQ Read2C33Pattern_UpdateSilent

	LDY iFDSInstrumentOffset
	LDA (zInstrumentPointer), Y
	CLC
	ADC iSoundMathBuffer
	ADC iFDSFadeOffset
	STA rFDS_ENVELOPE
	LDA iFDSModDepth
	STA rFDS_MOD_ENV
	LDA iFDSModRate
	STA rFDS_MOD_LO
	LDA #0
	STA rFDS_MOD_HI
	LDA zCurrent2C33Pitch
	STA rFDS_FREQ_LO
	LDA zCurrent2C33Pitch + 1
	AND #$0f
	STA rFDS_FREQ_HI
Read2C33Pattern_End:
	RTS

Read2C33Pattern_UpdateSilent:
	LDA iCurrentFDSSFX
	BNE Read2C33Pattern_End
	JMP ClearFDS

NoiseVolumes:
	.db $12, $15, $1A, $1F

NoiseSweeps:
	.db $09, $03, $01, $01

DPCM_Pitches:
	.db $00, $0A, $0D, $0F, $0F, $0F

DPCM_Lengths:
	.db $01, $4D, $47, $48, $4C, $D3

DPCM_Addresses:
	.db $6D, $5A, $6E, $00, $12, $25


StoreNoteLength:
	; %100xyzzz
	; x - x3 flag
	; y - x1.5 flag
	; z - shift id
	AND #$1f
	STA iEncodedNoteLengths, Y
	RTS


StorePitchBend:
	; %101xxxx 0yyyzzzz
	; x - incrementation
	; y - octave
	; z - pitch
	CPY #3
	BCC StorePitchBend_NotFDS
	LDY #3
StorePitchBend_NotFDS:
	AND #$1f
	STA iPitchSlideIncrementation, Y
	LDA zTargetPitch, X
	STA zCurrentPitch, X
	LDA zTargetPitch + 1, X
	STA zCurrentPitch + 1, X
	LDY iCurrentChannel
	JSR ReadMusicData
	PHA
	AND #OCTAVE_MASK
	CPY #3
	BCS StorePitchBend_FDSOctave
	STA iOctaves, Y
	BCC StorePitchBend_DoLoNybble
StorePitchBend_FDSOctave:
	STA iOctaves + 3
StorePitchBend_DoLoNybble:
	PLA
	AND #NOTE_MASK
	CMP #TIE_VALUE
	BCS StorePitchBend_Exit
	ASL A
	TAX
	JSR GetPitch
	LDA #$80
	ORA iTargetPitch + 1, X
	STA iTargetPitch + 1, X
StorePitchBend_Exit:
	RTS


StoreInstrument:
	; 110xxxxx
	; x - instrument ID
	; NOTE: ID is doubled for use as a pointer offset
	AND #$1f
	ASL A
	CPY #3
	BCS StoreInstrument_FDS
	STA iInstrument, Y
	RTS
StoreInstrument_FDS:
	STA iFDSInstrument
	RTS

StoreFade:
	; %111xyyyy
	; x - direction
	; y - timer
	AND #$1f
	CPY #2
	BCS StoreFade_FDS
	STA iInstrumentFade, Y
	LDA #0
	STA iFadeCounter, Y
	STA iFadeOffset, Y
	RTS

StoreFade_FDS:
	STA iFDSInstrumentFade
	LDA #0
	STA iFDSFadeCounter
	STA iFDSFadeOffset
	RTS


;
; Pattern reading routine
;
; In Cameltry (FDS/FC), pattern data is read in words due to the 6502
; addressing endianness.  High byte is read first to determine the read data.
;
; (FDS) $60-$DF - Establish music data pointer
; (FC)  $80-$DF - Establish music data pointer
; $E1/$E2/$E4/$E8/$F0 - Commands with possible parameters
;
; WARNING: Pattern data is only accessed when a music data pointer is cleared
;
ReadPatternData_Increment:
	INC zMusicPatternPointers, X
	BNE ReadPatternData_NoInc
	INC zMusicPatternPointers + 1, X
ReadPatternData_NoInc:
	RTS

ReadPatternData_Decrement:
	LDA zMusicPatternPointers, X
	BNE ReadPatternData_NoDec
	DEC zMusicPatternPointers + 1, X
ReadPatternData_NoDec:
	DEC zMusicPatternPointers, X
	RTS


ReadPatternData:
	; load channel offset into X
	LDA iCurrentChannel
	ASL A
	TAX
	; 00 00 = nothing to see here, bail
	LDA zMusicPatternPointers + 1, X
	BEQ ReadPatternData_Bail
	; non-zero = note still playing, bail
	LDA iMusicNoteLengths, X
	BNE ReadPatternData_End
	; non-zero = reading music data, bail
	LDA zMusicDataPointers + 1, X
	BNE ReadPatternData_End

ReadPatternData_Shortcut:
	JSR ReadPatternData_Increment
	LDA (zMusicPatternPointers, X)
	CMP #$60 ; FDS RAM space start
	BCS ReadPatternData_PointerOrMasterCMD
	LDA (zMusicPatternPointers, X)
	BNE ReadPatternData_NextWord
	; 00 = End / Loop
	LDA zMusicLoopPointers + 1, X
	BEQ ReadPatternData_Bail

	LDA zMusicLoopPointers, X
	STA zMusicPatternPointers, X
	LDA zMusicLoopPointers + 1, X
	STA zMusicPatternPointers + 1, X
	BNE ReadPatternData_Shortcut

ReadPatternData_End:
	; music playing
	CLC
	RTS

ReadPatternData_Bail:
	; pattern pointer is empty
	SEC
	RTS

	; 01-5f = invalid, move to the next word
ReadPatternData_NextWord:
	JSR ReadPatternData_Decrement
	LDA #2
	ADC zMusicPatternPointers, X
	STA zMusicPatternPointers, X
	LDA #0
	INX
	ADC zMusicPatternPointers, X
	STA zMusicPatternPointers, X
	LDA iCurrentChannel
	ASL A
	TAX
	JMP ReadPatternData_Shortcut

ReadPatternData_PointerOrMasterCMD:
	CMP #$e0 ; FDS BIOS start
	BCC ReadPatternData_Pointer
	JMP ReadPatternData_MasterCMD

ReadPatternData_Pointer:
	JSR ReadPatternData_Decrement
	; then pull from pointer
	LDA (zMusicPatternPointers, X)
	STA zMusicDataPointers, X
	JSR ReadPatternData_Increment
	LDA (zMusicPatternPointers, X)
	STA zMusicDataPointers, X
	JSR ReadPatternData_Increment
	CLC
	RTS

ReadPatternData_EstLoop:
	JSR ReadPatternData_Decrement
	; $e1 = Establish loop point
	LDA #2
	ADC zMusicPatternPointers, X
	STA zMusicPatternPointers, X
	STA zMusicLoopPointers, X
	LDA #0
	INX
	ADC zMusicPatternPointers, X
	STA zMusicPatternPointers, X
	STA zMusicLoopPointers, X
	JMP ReadPatternData_Shortcut

ReadPatternData_MasterCMD:
	AND #$1f
	LSR A ; $e1
	BCS ReadPatternData_EstLoop
	LSR A ; $e2
	BCS ReadPatternData_Tuning
	JMP ReadPatternData_NextWord

ReadPatternData_Tuning:
	; $e2 = Detune Note
	; Noise/DPCM don't have tuning
	CPY #3
	BEQ ReadPatternData_BailTuning
	CPY #4
	BEQ ReadPatternData_BailTuning
	BCS ReadPatternData_FDSTuning

	LDA iTuning, Y
	EOR #1
	STA iTuning, Y
	BCC ReadPatternData_BailTuning

ReadPatternData_FDSTuning:
	LDA iFDSTuning
	EOR #1
	STA iFDSTuning

ReadPatternData_BailTuning:
	JMP ReadPatternData_NextWord


;
; Music Data Reading Routine
;
; Check for active note length, bail
; Read a byte, determine what to do from there
;
ReadMusicData:
	LDA iMusicNoteLengths, X
	BNE ReadMusicData_Bail
	LDA (zMusicDataPointers, X)
	INC zMusicDataPointers, X
	BNE ReadMusicData_Exit
	INC zMusicDataPointers + 1, X
ReadMusicData_Exit:
	CLC
	RTS

ReadMusicData_Bail:
	SEC
	RTS


ClearDataPointer:
	LDA #0
	STA zMusicDataPointers, X
	STA zMusicDataPointers + 1, X
	SEC
	RTS


;
; Note Disection Routine
;
; 01-7f expresses a note the engine analyzes to figure out what to do with it
; in byte xy, x = octave, y = note
;
DisectNote:
	PHA
	AND #OCTAVE_MASK
	CPY #3
	BCS DisectNote_FDSOctave
	STA iOctaves, Y
	BCC DisectNote_DoLoNybble
DisectNote_FDSOctave:
	EOR #$70
	STA iOctaves + 3
DisectNote_DoLoNybble:
	PLA
	AND #NOTE_MASK
	BEQ DisectNote_Rest
	CMP #TIE_VALUE
	BCS DisectNote_Tie
	ASL A
	TAX
	JSR GetPitch
	TYA
	ASL A
	TAX
	CPY #3
	BCS DisectNote_FDSPitch

	SEC
	LDA zTargetPitch, X
	SBC iTuning, Y
	STA zTargetPitch, X
	STA zCurrentPitch, X
	LDA zTargetPitch + 1, X
	SBC #0
	STA zTargetPitch + 1, X
	STA zCurrentPitch + 1, X
	BCS DisectNote_Tie

DisectNote_FDSPitch:
	CLC
	LDA zTarget2C33Pitch
	ADC iFDSTuning
	STA zTarget2C33Pitch
	STA zCurrent2C33Pitch
	LDA zTarget2C33Pitch + 1
	ADC #0
	STA zTarget2C33Pitch + 1
	STA zCurrent2C33Pitch + 1
	BCS DisectNote_Tie

DisectNote_Rest:
	CPY #3
	BCC DisectNote_Rest2A03

	LDY #3

DisectNote_Rest2A03:
	LDA iRestingTail, Y
	ORA #$80
	STA iRestingTail, Y
	LDY iCurrentChannel

DisectNote_Tie:
	RTS


;
; Calculate Note Length
;
; where 'iEncodedNoteLengths' = %000xyzzz
; x - Triple Time
; y - Time and a Half
; z - Shift offset - Default = %100
;
CalculateNoteLength:
	TYA
	ASL A
	TAX
	LDA iMusicTempo
	STA iMusicNoteLengths, X
	LDA iMusicNoteLengths + 1, X
	AND #$f0
	; stash old buffer
	PHA
	LDA #0
	STA iSoundMathBuffer
	STA iMusicNoteLengths + 1, X
	LDA iEncodedNoteLengths, Y
	AND #$18
	BEQ CalculateNoteLength_SkipNoteLengthMath
	CMP #$10
	BEQ CalculateNoteLength_TripleTime
	BCC CalculateNoteLength_TimeAndAHalf

	; Quadruple Time and a Half
	LDA iMusicNoteLengths, X
	; m/2
	LSR iMusicNoteLengths, X
	ROL iMusicNoteLengths + 1, X
	; 4a
	ASL A
	ROL iSoundMathBuffer
	ASL A
	ROL iSoundMathBuffer
	; a + m
	ADC iMusicNoteLengths, X
	STA iMusicNoteLengths, X
	LDA #0
	ADC iSoundMathBuffer
	STA iSoundMathBuffer
	BCC CalculateNoteLength_SkipNoteLengthMath

CalculateNoteLength_TripleTime:
	LDA iMusicNoteLengths, X
	; 2a
	ASL A
	ROL iSoundMathBuffer
	; a + m
	ADC iMusicNoteLengths, X
	; M'=3M
	STA iMusicNoteLengths, X
	LDA #0
	ADC iSoundMathBuffer
	STA iSoundMathBuffer
	BCC CalculateNoteLength_SkipNoteLengthMath

CalculateNoteLength_TimeAndAHalf:
	LDA iMusicNoteLengths, X
	; a/2
	LSR A
	ROR iMusicNoteLengths + 1, X
	; a + m
	ADC iMusicNoteLengths, X
	STA iMusicNoteLengths, X
	LDA #0
	ADC iSoundMathBuffer
	STA iSoundMathBuffer

CalculateNoteLength_SkipNoteLengthMath:
	LDA iSoundMathBuffer
	ORA iMusicNoteLengths + 1, X
	LDA iEncodedNoteLengths, Y
	AND #$07
	CMP #4
	BCS CalculateNoteLength_RollUp

	ORA #$fc
	TAY

CalculateNoteLength_RollDownLoop:
	ROL iMusicNoteLengths, X
	ROL iMusicNoteLengths + 1, X
	LDA #0
	ADC iMusicNoteLengths, X
	STA iMusicNoteLengths, X
	INY
	CLC
	BNE CalculateNoteLength_RollDownLoop
	BEQ CalculateNoteLength_Exit

CalculateNoteLength_RollUp:
	CLC
	AND #$03
	TAY
	BEQ CalculateNoteLength_Exit

CalculateNoteLength_RollUpLoop:
	ROR iMusicNoteLengths, X
	ROR iMusicNoteLengths + 1, X
	LDA #0
	ADC iMusicNoteLengths, X
	STA iMusicNoteLengths, X
	DEY
	CLC
	BNE CalculateNoteLength_RollUpLoop

CalculateNoteLength_Exit:
	PLA
	ADC iMusicNoteLengths + 1, X
	STA iMusicNoteLengths + 1, X
	LDA #0
	ADC iMusicNoteLengths, X
	STA iMusicNoteLengths, X
	CLC
	RTS

;
; Calculate pitch
;
; Pull an entry from one of two tables and store it in RAM
; INPUT: X / 2 = Pitch ID
; CONDITION: Y =< 2 (pulses, hill), OR, Y = 5 (FDS)
;
GetPitch:
	CPY #3 ; NOISE, DPCM, FDS
	BCS GetPitch_NotPulseOrHill

	TYA
	ASL A
	TAY

	SEC
	LDA zTargetPitch, Y
	STA iTargetPitch, Y
	LDA zTargetPitch + 1, Y
	STA iTargetPitch + 1, Y

	LDA Notes_2A03, X
	STA zTargetPitch, Y
	LDA Notes_2A03 + 1, X
	STA zTargetPitch + 1, Y

	LDX iCurrentChannel
	LDA iOctaves, X
	SEC
	SBC #$10
	BCS GetPitch_Quit

	PHA
	TYA
	TAX
	PLA

GetPitch_Division:
	LSR zTargetPitch + 1, X
	ROR zTargetPitch, X
	SEC
	SBC #$10
	BCC GetPitch_Division
	LDY iCurrentChannel
	RTS

GetPitch_NotPulseOrHill:
	TXA
	CPY #4
	BEQ GetPitch_DPCM
	BCS GetPitch_2C33
	; NOISE
	RTS

GetPitch_DPCM:
GetPitch_Quit:
	; DPCM
	LDY iCurrentChannel
	RTS

GetPitch_2C33:
	; FDS
	LDA zTarget2C33Pitch
	STA iTarget2C33Pitch
	LDA zTarget2C33Pitch + 1
	STA iTarget2C33Pitch + 1

	LDA Notes_2C33, X
	STA zTarget2C33Pitch
	LDA Notes_2C33 + 1, X
	STA zTarget2C33Pitch + 1

	LDX iCurrentChannel
	LDA iOctaves, X
	SEC
	SBC #$10
	BCS GetPitch_Quit

GetPitch_2C33Division:
	LSR zTarget2C33Pitch + 1
	ROR zTarget2C33Pitch
	SEC
	SBC #$10
	BCC GetPitch_2C33Division
	LDY iCurrentChannel
	RTS



;
; Interpretation routines
;
; For interpreting music data, there are two ways to exit these subroutines:
; ClearDataPointer    - if byte = $ff  - Sets carry so each routine can restart
; CalculateNoteLength - if byte = Note - Clears carry to allow routine updates
;
; For interpreting instruments, we only return directly if we're pitch bending:
; For pitch bend, HI(zTargetPitch) + APP(iCurrentChannel)*2 >= $8000
; If pitch bend is off, use vibrato instead.
;
InterpretPulseMusicData:
	PHA
	CLC
	ADC #1
	BNE InterpretPulseMusicData_DetermineByte
	PLA
	JMP ClearDataPointer

InterpretPulseMusicData_DetermineByte:
	PLA
	BMI InterpretPulseMusicData_Command
	JSR DisectNote
	JMP CalculateNoteLength

InterpretPulseMusicData_Command:
	CMP #PITCH_BEND_CMD
	BCC InterpretPulseMusicData_NoteLength
	CMP #INSTRUMENT_CMD
	BCC InterpretPulseMusicData_PitchBend
	CMP #FADE_CTRL_CMD
	BCC InterpretPulseMusicData_Instrument
	JSR StoreFade
	JSR ReadMusicData
	JMP InterpretPulseMusicData

InterpretPulseMusicData_NoteLength:
	JSR StoreNoteLength
	JSR ReadMusicData
	JMP InterpretPulseMusicData

InterpretPulseMusicData_PitchBend:
	JSR StorePitchBend
	JSR ReadMusicData
	JMP InterpretPulseMusicData

InterpretPulseMusicData_Instrument:
	JSR StoreInstrument
	JSR ReadMusicData
	JMP InterpretPulseMusicData


InterpretPulseInstrument:
	LDA #0
	STA iInstrumentOffset, Y
	LDA iRestingTail, Y
	AND #$80
	STA iRestingTail, Y
	LDX iInstrument, Y
	CPX #NES_TAIL_INSTRUMENTS * 2
	BCC InterpretPulseInstrument_NoTail

	LDA #0
	STA iRestingTail, Y

InterpretPulseInstrument_NoTail:
	LDA InstrumentPointers, X
	STA zInstrumentPointer
	LDA InstrumentPointers + 1, X
	STA zInstrumentPointer + 1
	TYA
	ASL A
	TAX
	LDA iTargetPitch + 1, X
	BMI InterpretPulseInstrument_Exit

	JMP DoInstrumentVibrato

InterpretPulseInstrument_Exit:
	LDA #0
	STA zVibratoPointer, X
	STA zVibratoPointer + 1, X
	STA iVibratoOffset, Y
	RTS


InterpretHillMusicData:
	PHA
	CLC
	ADC #1
	BCC InterpretHillMusicData_DetermineByte
	PLA
	JMP ClearDataPointer

InterpretHillMusicData_DetermineByte:
	PLA
	BMI InterpretHillMusicData_Command
	JSR DisectNote
	JMP CalculateNoteLength

InterpretHillMusicData_Command:
	CMP #PITCH_BEND_CMD
	BCC InterpretHillMusicData_NoteLength
	CMP #INSTRUMENT_CMD
	BCC InterpretHillMusicData_PitchBend
	AND #$1f
	JSR StoreInstrument
	JSR ReadMusicData
	JMP InterpretHillMusicData

InterpretHillMusicData_NoteLength:
	JSR StoreNoteLength
	JSR ReadMusicData
	JMP InterpretHillMusicData

InterpretHillMusicData_PitchBend:
	JSR StorePitchBend
	JSR ReadMusicData
	BMI InterpretHillMusicData


InterpretHillInstrument:
	LDA iRestingTail + 2
	AND #$80
	STA iRestingTail + 2
	LDA iInstrument + 2
	CMP #NES_TAIL_INSTRUMENTS * 2
	BCC InterpretHillInstrument_NoTail

	INC iRestingTail + 2

InterpretHillInstrument_NoTail:
	TYA
	ASL A
	TAX
	LDA iTargetPitch + 5
	BMI InterpretHillInstrument_Exit

	JMP DoInstrumentVibrato

InterpretHillInstrument_Exit:
	LDA #0
	STA zVibratoPointer + 4
	STA zVibratoPointer + 5
	STA iVibratoOffset + 2
	RTS


InterpretNoiseMusicData:
	PHA
	CLC
	ADC #1
	BCC InterpretNoiseMusicData_DetermineByte
	PLA
	JMP ClearDataPointer

InterpretNoiseMusicData_DetermineByte:
	PLA
	BMI InterpretNoiseMusicData_NoteLength
	AND #$0f
	STA iCurrentNoisePitch
	JMP CalculateNoteLength

InterpretNoiseMusicData_NoteLength:
	PHA
	AND #$60
	ROL A
	ROL A
	ROL A
	ROL A
	STA iNoiseID
	PLA
	JSR StoreNoteLength
	JSR ReadMusicData
	JMP InterpretNoiseMusicData


InterpretDPCMMusicData:
	PHA
	CLC
	ADC #1
	BCC InterpretDPCMMusicData_DetermineByte
	PLA
	JMP ClearDataPointer

InterpretDPCMMusicData_DetermineByte:
	PLA
	BMI InterpretDPCMMusicData_NotRest
	LDA #$ff
	STA iCurrentDPCMPitch
	JMP CalculateNoteLength

InterpretDPCMMusicData_NotRest:
	CMP #DPCM_ID_CMD
	BCS InterpretDPCMMusicData_Note

	JSR StoreNoteLength
	JSR ReadMusicData
	JMP InterpretDPCMMusicData

InterpretDPCMMusicData_Note:
	SEC
	SBC #DPCM_ID_CMD
	STA iCurrentDPCMPitch
	JMP CalculateNoteLength


InterpretFDSMusicData:
	PHA
	CLC
	ADC #1
	BNE InterpretFDSMusicData_DetermineByte
	PLA
	JMP ClearDataPointer

InterpretFDSMusicData_DetermineByte:
	PLA
	BMI InterpretFDSMusicData_Command
	JSR DisectNote
	JMP CalculateNoteLength

InterpretFDSMusicData_Command:
	CMP #PITCH_BEND_CMD
	BCC InterpretFDSMusicData_NoteLength
	CMP #INSTRUMENT_CMD
	BCC InterpretFDSMusicData_PitchBend
	CMP #FADE_CTRL_CMD
	BCC InterpretFDSMusicData_Instrument
	JSR StoreFade
	JSR ReadMusicData
	JMP InterpretFDSMusicData

InterpretFDSMusicData_NoteLength:
	JSR StoreNoteLength
	JSR ReadMusicData
	JMP InterpretFDSMusicData

InterpretFDSMusicData_PitchBend:
	JSR StorePitchBend
	JSR ReadMusicData
	JMP InterpretFDSMusicData

InterpretFDSMusicData_Instrument:
	JSR StoreInstrument
	JSR ReadMusicData
	JMP InterpretFDSMusicData


InterpretFDSInsturment:
	LDA #0
	STA iFDSInstrumentOffset
	LDA iRestingTail + 3
	AND #$80
	STA iRestingTail + 3
	LDX iFDSInstrument
	CPX #NUM_FDS_ARP_SNARES * 2
	BCC InterpretFDSInsturment_NotArpd

	LDA #2
	ORA iRestingTail + 3
	STA iRestingTail + 3
	BCS InterpretFDSInsturment_NoTail

InterpretFDSInsturment_NotArpd:
	CPX #FDS_TAIL_INSTRUMENTS * 2
	BCC InterpretFDSInsturment_NoTail

	INC iRestingTail + 3

InterpretFDSInsturment_NoTail:
	LDA FDSInstrumentPointers, X
	STA zInstrumentPointer
	LDA FDSInstrumentPointers + 1, X
	STA zInstrumentPointer + 1
	LDA WavPointers, X
	STA zWavetablePointer
	LDA WavPointers + 1, X
	STA zWavetablePointer + 1
	LDA #$80
	STA rFDS_WAV_MASTER
	LDY #0
	LDX #FDS_WAVETABLE_LENGTH

InterpretFDSInsturment_Wav:
	LDA (zWavetablePointer), Y
	STA rFDS_WAV_RAM, Y
	INY
	DEX
	BNE InterpretFDSInsturment_Wav

	LDX iFDSInstrument
	LDA ModTablePointers, X
	STA zModTablePointer
	LDA ModTablePointers + 1, X
	STA zModTablePointer + 1
	LDY #0
	LDX #FDS_MODULATION_LENGTH

InterpretFDSInsturment_Mod:
	LDA (zModTablePointer), Y
	STA rFDS_MOD_WRITE
	INY
	DEX
	BNE InterpretFDSInsturment_Mod

	LDA iFDSInstrument
	LSR A
	TAX
	LDA Mod_Depths, X
	STA iFDSModDepth
	LDA Mod_Rates, X
	STA iFDSModRate
	RTS

DoInstrumentVibrato:
	LDA iInstrument, Y
	LSR A
	TAX
	LDA InstrumentVibratos, X
	ASL A
	TAX
	LDA Vibrato, X
	PHA
	LDA Vibrato + 1, X
	PHA
	TYA
	ASL A
	TAX
	PLA
	STA zVibratoPointer + 1, X
	PLA
	STA zVibratoPointer, X
	LDA #0
	STA iVibratoOffset, Y
	RTS


ApplyVibrato:
	LDA zVibratoPointer, X
	STA zCurrentVibratoPointer
	LDA zVibratoPointer + 1, X
	STA zCurrentVibratoPointer + 1
	BEQ ApplyVibrato_Exit
	LDA iVibratoOffset, Y
	TAY
	LDA (zCurrentVibratoPointer), Y
	BEQ ApplyVibrato_Zero
ApplyVibrato_NonZero:
	TAX
	DEX
	BEQ ApplyVibrato_Down

ApplyVibrato_Up:
	; Vib = $ff
	PHA
	LDA iCurrentChannel
	ASL A
	TAX
	PLA
	CLC
	ADC zTargetPitch, X
	BCC ApplyVibrato_UpExit
	STA zCurrentPitch, X
ApplyVibrato_UpExit:
	TYA
	LDY iCurrentChannel
	STA iVibratoOffset, Y
	RTS

ApplyVibrato_Down:
	; Vib = $01
	PHA
	LDA iCurrentChannel
	ASL A
	TAX
	PLA
	CLC
	ADC zTargetPitch, X
	BCS ApplyVibrato_DownExit
	STA zCurrentPitch, X
ApplyVibrato_DownExit:
	TYA
	LDY iCurrentChannel
	STA iVibratoOffset, Y
	RTS

ApplyVibrato_Zero:
	LDA zCurrentPitch
	CMP zTargetPitch
	BEQ ApplyVibrato_Exit

ApplyVibrato_Rewind:
	; encountered the next label
	DEY
	LDA (zCurrentVibratoPointer), Y
	BNE ApplyVibrato_Rewind
	INY
	LDA (zCurrentVibratoPointer), Y
	BNE ApplyVibrato_NonZero

ApplyVibrato_Exit:
	; haven't reached vibrato yet
	TYA
	LDY iCurrentChannel
	STA iVibratoOffset, Y
	RTS


ApplyPitchSlide:
	LDA #2
	CMP iCurrentChannel
	BCS ApplyPitchSlide_NotFDS

	TAY
	INY
	LDX #6

ApplyPitchSlide_NotFDS:
	LDA iTargetPitch + 1, X
	BPL ApplyPitchSlide_Quit
	SEC
	LDA iTargetPitch, X
	SBC zCurrentPitch, X
	STA zPitchSlideAmmount
	LDA iTargetPitch + 1, X
	SBC zCurrentPitch + 1, X
	STA zPitchSlideAmmount + 1
	BMI ApplyPitchSlide_Down
	JMP ApplyPitchSlide_Up

ApplyPitchSlide_Quit:
	RTS

ApplyPitchSlide_Down:
	; iTargetPitch > zCurrentPitch
	; $F800 - $FFFF
	CLC
	LDA iPitchSlideIncrementation, Y
	ADC zCurrentPitch, X
	STA zCurrentPitch, X
	LDA #0
	ADC zCurrentPitch + 1, X
	STA zCurrentPitch + 1, X
	LDA iPitchSlideIncrementation, Y
	ADC zPitchSlideAmmount
	STA zPitchSlideAmmount
	LDA #0
	ADC zPitchSlideAmmount + 1
	STA zPitchSlideAmmount + 1
	BEQ ApplyPitchSlide_Done

	LDY iCurrentChannel
	RTS

ApplyPitchSlide_Up:
	; iTargetPitch < zCurrentPitch
	; $0000 - $07FF
	SEC
	LDA iPitchSlideIncrementation, Y
	SBC zCurrentPitch, X
	STA zCurrentPitch, X
	LDA zCurrentPitch + 1, X
	SBC #0
	STA zCurrentPitch, X
	LDA iPitchSlideIncrementation, Y
	SBC zPitchSlideAmmount
	STA zPitchSlideAmmount
	LDA zPitchSlideAmmount + 1
	SBC #0
	STA zPitchSlideAmmount + 1
	BCC ApplyPitchSlide_Done

	LDY iCurrentChannel
	RTS

ApplyPitchSlide_Done:
	LDA iTargetPitch + 1, X
	EOR #$80
	STA iTargetPitch + 1, X
	STA zCurrentPitch + 1, X
	LDA iTargetPitch, X
	STA zCurrentPitch, X
	LDA #0
	STA iPitchSlideIncrementation, Y
	STA zPitchSlideAmmount
	STA zPitchSlideAmmount + 1
	LDY iCurrentChannel
	RTS


ApplyFade:
	; are we in the FDS channel?
	CPY #2
	BCS ApplyFade_FDS
	TYA
	TAX
	; in or out?
	LDA iInstrumentFade, Y
	CMP #$0f
	BEQ ApplyFade_None
	BCS ApplyFade_In
	; pulse channel
	; if iFadeCounter stays non zero, fallthrough
	DEC iFadeCounter, X
	BNE ApplyFade_None
	; reset counter
	LDA iInstrumentFade, Y
	AND #$0f
	ADC #1
	STA iFadeCounter, Y

	; if volume alone is non-zero, fallthrough
	LDA iInstrumentOffset, Y
	TAY
	LDA (zInstrumentPointer), Y
	LDY iCurrentChannel
	AND #$0f
	ADC iFadeOffset, Y
	BEQ ApplyFade_None

	DEC iFadeOffset, X
	RTS

ApplyFade_FDS:
	; 2C33 channel
	; in or out?
	LDA iFDSInstrumentFade
	CMP #$0f
	BEQ ApplyFade_FDSNone
	BCS ApplyFade_FDSIn
	; if iFDSFadeCounter stays non-zero, fallthrough
	DEC iFDSFadeCounter
	BNE ApplyFade_FDSNone
	; reset counter
	LDA iFDSInstrumentFade
	AND #$0f
	ADC #1
	STA iFDSFadeCounter

	; if volume alone is non-zero, fallthrough
	LDA iFDSInstrumentOffset
	TAY
	LDA (zInstrumentPointer), Y
	LDY iCurrentChannel
	ADC iFDSFadeOffset
	BEQ ApplyFade_FDSNone

	DEC iFDSFadeOffset

ApplyFade_None:
ApplyFade_FDSNone:
	RTS

ApplyFade_In:
	; if iFadeCounter stays non zero, fallthrough
	DEC iFadeCounter, X
	BNE ApplyFade_None
	; reset counter
	LDA iInstrumentFade, Y
	AND #$0f
	ADC #0
	STA iFadeCounter, Y
	; get volume
	LDA iInstrumentOffset, Y
	TAY
	LDA (zInstrumentPointer), Y
	LDY iCurrentChannel
	AND #$0f
	; 2's complement + 1
	EOR #$ff
	CLC
	ADC #2
	STA iFadeOffset, Y
	RTS

ApplyFade_FDSIn:
	; if iFDSFadeCounter stays non-zero, fallthrough
	DEC iFDSFadeCounter
	BNE ApplyFade_FDSNone
	; reset counter
	LDA iFDSInstrumentFade
	AND #$0f
	ADC #0
	STA iFDSFadeCounter
	; get volume
	LDA iFDSInstrumentOffset
	TAY
	LDA (zInstrumentPointer), Y
	LDY iCurrentChannel
	AND #$1f
	; 2's complement
	EOR #$ff
	CLC
	ADC #1
	STA iFDSFadeOffset
	RTS


CheckPulseFade:
	LDA #0
	STA iSoundMathBuffer
	LDA iInstrumentOffset, Y
	TAY
	LDA (zInstrumentPointer), Y
	AND #$0f
	CLC
	ADC iFadeOffset
	BEQ CheckPulseFade_FixOffset
	BCC CheckPulseFade_FixOffset
	RTS

CheckPulseFade_FixOffset:
	INC iSoundMathBuffer
	LDA (zInstrumentPointer), Y
	AND #$0f
	CLC
	ADC iSoundMathBuffer
	ADC iFadeOffset
	BEQ CheckPulseFade_FixOffset
	BCC CheckPulseFade_FixOffset
	RTS


;
; Arpeggio application
;
; Before western composers get excited, keep in mind this is used for the power
; snare instruments, which are grouped by hardcoding the point where
; arpeggiation stops in the instrument pointer offset.
;
; In other words arp'd chords are impossible.  Power snares alternate pitch by
; a tritone to make convincing noise.
;
ApplyFDSArp:
	LDA iRestingTail
	CMP #$02
	BNE ApplyFDSArp_Quit

	LDA iFDSArpPitch
	ORA iFDSArpPitch + 1
	BEQ ApplyFDSArp_Begin

	LDA zCurrent2C33Pitch
	CMP zTarget2C33Pitch
	BEQ ApplyFDSArp_Set
	BNE ApplyFDSArp_Reset

ApplyFDSArp_Quit:
	RTS

ApplyFDSArp_Reset:
	LDA zTarget2C33Pitch
	STA zCurrent2C33Pitch
	LDA zTarget2C33Pitch + 1
	STA zCurrent2C33Pitch + 1
	RTS

ApplyFDSArp_Set:
	LDA iFDSArpPitch
	STA zCurrent2C33Pitch
	LDA iFDSArpPitch + 1
	STA zCurrent2C33Pitch + 1

ApplyFDSArp_Begin:
	LDA iCurrentChannel
	ASL A
	TAX
	LDA zMusicDataPointers, X
	BNE ApplyFDSArp_NoCarry1

	DEC zMusicDataPointers + 1, X
ApplyFDSArp_NoCarry1:
	DEC zMusicDataPointers, X
	JSR ReadMusicData
	PHA
	AND #OCTAVE_MASK
	STA iOctaves + 3
	PLA
	AND #NOTE_MASK
	BEQ ApplyFDSArp_Bail
	CMP #TIE_VALUE
	BCS ApplyFDSArp_Bail
	ADC #6
	ASL A
	TAX
	LDA Notes_2C33, X
	STA iFDSArpPitch
	LDA Notes_2C33 + 1, X
	STA iFDSArpPitch + 1
ApplyFDSArp_Bail:
	RTS

.include "src/music/instruments-2a03.asm"
.include "src/music/instruments-2c33.asm"
.include "src/music/mod-tables.asm"
.include "src/music/modulation-data.asm"
.include "src/music/notes.asm"
.include "src/music/tempos.asm"
.include "src/music/vibrato.asm"
.include "src/music/wav-tables.asm"
.include "src/music/pattern-headers.asm"
.include "src/music/pattern-data.asm"
.include "src/music/music-data.asm"