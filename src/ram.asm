; ZERO PAGE
.enum $0000
zMusicPatternPointers:
	.dsb 2 ; 0000
	.dsb 2
	.dsb 2 ; 0004
	.dsb 2
	.dsb 2 ; 0008
	.dsb 2
zMusicDataPointers:
	.dsb 2 ; 000c
	.dsb 2
	.dsb 2 ; 0010
	.dsb 2
	.dsb 2 ; 0014
	.dsb 2
zMusicLoopPointers:
	.dsb 2 ; 0018
	.dsb 2
	.dsb 2 ; 001c
	.dsb 2
	.dsb 2 ; 0020
	.dsb 2
zCurrentPitch:
	.dsb 2 ; 0024
	.dsb 2
	.dsb 2 ; 0028
zCurrent2C33Pitch:
	.dsb 2
zTargetPitch:
	.dsb 2 ; 002c
	.dsb 2
	.dsb 2 ; 0030
zTarget2C33Pitch:
	.dsb 2
zInstrumentPointer:
	.dsb 2 ; 0034
zVibratoPointer:
	.dsb 2
	.dsb 2 ; 0038
	.dsb 2
zPitchSlideAmmount:
	.dsb 2 ; 003c
zCurrentVibratoPointer:
zWavetablePointer:
zModTablePointer:
zFDSSFXPoitner:
	.dsb 2
	.dsb $c0
; STACK
iStack:
iStackBottom:
	.dsb $ff ; 0100
iStackTop:
	.dsb 1
; ABS
	.dsb $100
	.dsb $100
	.dsb $100
	.dsb $100
iMusic1:
	.dsb 1 ; 0600
iMusic2:
	.dsb 1
iMusic3:
	.dsb 1
iFDSSFX:
	.dsb 1
iDPCMSFX:
	.dsb 1 ; 0604
iNoiseSFX:
	.dsb 1
iCurrentMusic1:
	.dsb 1
iCurrentMusic2:
	.dsb 1
iCurrentMusic3:
	.dsb 1 ; 0608
iCurrentFDSSFX:
	.dsb 1
iCurrentDPCMSFX:
	.dsb 1
iCurrentNoiseSFX:
	.dsb 1
iMusicStack:
	.dsb 1 ; 060c
iCurrentChannel:
	.dsb 1
iMusicOffset:
	.dsb 1
iMusicTempo:
	.dsb 1
; note lengths
; +0: Actual length in frames
; +1: Subframes in units of 16, OR'd with high four bits
; Subframe mask: %11110000
; Hi Frame mask: %00001111
iMusicNoteLengths:
iMusicPulse1NoteLength:
	.dsb 2 ; 0610
iMusicPulse2NoteLength:
	.dsb 2
iMusicHillNoteLength:
	.dsb 2 ; 0614
iMusicNoiseNoteLength:
	.dsb 2
iDPCMNoteLengthCounter:
	.dsb 2 ; 0618
iMusic2C33NoteLength:
	.dsb 2
; 0: Pulse 1
; 1: Pulse 2
; 2: Hill
; 3: 2C33
iOctaves:
	.dsb 4 ; 061c
iEncodedNoteLengths:
	.dsb 1 ; 0620
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1 ; 0624
	.dsb 1
iNoteLengthRatios:
	.dsb 1
	.dsb 1
	.dsb 1 ; 0628
	.dsb 1
	.dsb 1
	.dsb 1
iSoundMathBuffer:
	.dsb 1 ; 062c
iCurrentNoisePitch:
	.dsb 1
iCurrentDPCMPitch:
	.dsb 1
iSFXNoiseOffset:
	.dsb 1
iSFXNoisePitch:
	.dsb 1 ; 0630
iSFX2C33Offset:
	.dsb 1
iSFX2C33PointerOffset:
	.dsb 1
iSFX2C33DataOffset:
	.dsb 1
iInstrument:
	.dsb 1 ; 0634
	.dsb 1
	.dsb 1
iFDSInstrument:
	.dsb 1
iInstrumentOffset:
	.dsb 1 ; 0638
	.dsb 1
iFDSInstrumentOffset:
	.dsb 1
iVibratoOffset:
	.dsb 1
	.dsb 1 ; 063c
	.dsb 1
iInstrumentFade:
	.dsb 1
	.dsb 1
iFDSInstrumentFade:
	.dsb 1 ; 0640
iFadeCounter:
	.dsb 1
	.dsb 1
iFDSFadeCounter:
	.dsb 1
iPitchSlideIncrementation:
	.dsb 1 ; 0644
	.dsb 1
	.dsb 1
	.dsb 1
iRestingTail: ; MUST BE ZERO FOR TIES TO WORK PROPERLY
	.dsb 1 ; 0648
	.dsb 1
	.dsb 1
	.dsb 1
iFadeOffset:
	.dsb 1 ; 064c
	.dsb 1
iFDSFadeOffset:
	.dsb 1
iNoiseID:
	.dsb 1
iFDSModRate:
	.dsb 1 ; 0650
iFDSModDepth:
	.dsb 1
iFDSArpPitch:
iFDSSFXPitch:
	.dsb 2
iTargetPitch:
	.dsb 2 ; 0654
	.dsb 2
	.dsb 2 ; 0658
iTarget2C33Pitch:
	.dsb 2
iTuning:
	.dsb 3 ; 065c
iFDSTuning:
	.dsb 1
	.dsb $a0
	.dsb $100
.ende

;
; PPU registers
; $2000-$2007
;
.enum $2000
rPPUCTRL:
	.dsb 1
rPPUMASK:
	.dsb 1
rPPUSTATUS:
	.dsb 1
rOAMADDR:
	.dsb 1
rOAMDATA:
	.dsb 1
rPPUSCROLL:
	.dsb 1
rPPUADDR:
	.dsb 1
rPPUDATA:
	.dsb 1
.ende

;
; APU registers and joypad registers
;  $4000-$4015	 $4016-$4017
;
.enum $4000
rSQ1_VOL:
	.dsb 1 ; 4000
rSQ1_SWEEP:
	.dsb 1
rSQ1_LO:
	.dsb 1
rSQ1_HI:
	.dsb 1

rSQ2_VOL:
	.dsb 1 ; 4004
rSQ2_SWEEP:
	.dsb 1
rSQ2_LO:
	.dsb 1
rSQ2_HI:
	.dsb 1

rTRI_LINEAR:
	.dsb 1 ; 4008
	.dsb 1
rTRI_LO:
	.dsb 1
rTRI_HI:
	.dsb 1

rNOISE_VOL:
	.dsb 1 ; 400c
	.dsb 1
rNOISE_LO:
	.dsb 1
rNOISE_HI:
	.dsb 1

rDMC_FREQ:
	.dsb 1 ; 4010
rDMC_RAW:
	.dsb 1
rDMC_START:
	.dsb 1
rDMC_LEN:
	.dsb 1

rOAM_DMA:
	.dsb 1 ; 4014

rSND_CHN:
	.dsb 1

rJOY1:
	.dsb 1
rJOY2:
	.dsb 1

FDS_WAVETABLE_LENGTH = $40
FDS_MODULATION_LENGTH = $20

rFDS_IO_ENABLE  = $4023
rFDS_WAV_RAM    = $4040
rFDS_ENVELOPE   = $4080
rFDS_FREQ_LO    = $4082
rFDS_FREQ_HI    = $4083
rFDS_MOD_ENV    = $4084
rFDS_MOD_COUNT  = $4085
rFDS_MOD_LO     = $4086
rFDS_MOD_HI     = $4087
rFDS_MOD_WRITE  = $4088
rFDS_WAV_MASTER = $4089
rFDS_ENV_SPEED  = $408A
rFDS_VOL_GAIN   = $4090
rFDS_WAV_ACC    = $4091
rFDS_MOD_GAIN   = $4092
rFDS_MOD_ACC    = $4093
rFDS_MOD_MULTI  = $4094
rFDS_MOD_INC    = $4095
rFDS_WAV_VALUE  = $4096
rFDS_MOD_VALUE  = $4097

.ende