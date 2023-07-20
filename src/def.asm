FDS_Concrete = $01
FDS_Ouch     = $02
FDS_Lucky    = $04
FDS_Stop     = $08
FDS_Select   = $10
FDS_1KPoints = $20
FDS_DirForce = $40

DPCM_Bumper      = $01
DPCM_MarbleBreak = $02

Noise_Wood  = $01
Noise_Lodge = $02

Music1_Title           = $01
Music1_Menu            = $02
Music1_LevelClear      = $04
Music1_NumberMiss      = $08
Music1_FinalTrial      = $10
Music1_Congratulations = $20
Music1_GameOver        = $40
Music1_TheWarmUpIsOver = $80

Music2_CourseSelect    = $01
Music2_Tutorial        = $02
Music2_TurnAndTry      = $04
Music2_ConcreteJungle  = $08
Music2_SuperSonicBreak = $10
Music2_LuckySlot       = $20
Music2_VisionaryCastle = $40
Music2_MountainRoad    = $80

Music3_CountDown   = $01
Music3_NumberMatch = $02
Music3_HurryUp     = $04
Music3_Stop        = $08

C_ = 1
C# = 2
D_ = 3
D# = 4
E_ = 5
F_ = 6
F# = 7
G_ = 8
G# = 9
A_ = 10
A# = 11
B_ = 12
TIE_VALUE = 13
OCTAVE_MASK = %01110000
NOTE_MASK = %00001111
NES_TAIL_INSTRUMENTS = $15
NUM_FDS_ARP_SNARES = $06
FDS_TAIL_INSTRUMENTS = $12

NOTE_LENGTH_CMD = $80
PITCH_BEND_CMD  = $a0
INSTRUMENT_CMD  = $c0
FADE_CTRL_CMD   = $e0
SOUND_RET_CMD   = $ff

DPCM_ID_CMD = $a0

LOOP_CMD   = $e1
TUNING_CMD = $e2

DR0 = $00
DR1 = $20
DR2 = $40
DR3 = $60

M1   = $00
M1_5 = $08
M3   = $10
M4_5 = M1_5 | M3

S64 = $00
S32 = $01
S16 = $02
S8  = $03
S4  = $04
S2  = $05
S1  = $06
S0_5 = $07

F_OUT = $00
F_IN  = $10
