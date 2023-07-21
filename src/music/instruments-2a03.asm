InstrumentPointers:
	.dw Ins_Bass15
	.dw Ins_Bass5
	.dw Ins_Piano15
	.dw Ins_Piano10
	.dw Ins_Piano7
	.dw Ins_Piano5
	.dw Ins_Saw12
	.dw Ins_Saw11
	.dw Ins_Saw10
	.dw Ins_Saw9
	.dw Ins_Saw8
	.dw Ins_Saw7
	.dw Ins_Saw6
	.dw Ins_Saw5
	.dw Ins_Saw4
	.dw Ins_Saw3
	.dw Ins_Saw2
	.dw Ins_Saw1
	.dw Ins_Saw13
	.dw Ins_Saw7
	.dw Ins_Saw3
	.dw Ins_Bass15 ; From here on, tail rests
	.dw Ins_Bass5
	.dw Ins_Piano15
	.dw Ins_Piano10
	.dw Ins_Piano7
	.dw Ins_Piano5
	.dw Ins_Saw8
	.dw Ins_Saw7
	.dw Ins_BassTrem
	.dw Ins_Saw7

Ins_Bass15:
	.db $1B, $17, $57, $58
	.db $18, $18, $58, $59
	.db $19, $19, $59
	.db $FB

Ins_Bass5:
	.db $14, $12, $52, $53
	.db $13, $13, $53, $53
	.db $13, $13, $53
	.db $FB

Ins_Piano15:
	.db $9A, $17, $58, $57
	.db $95, $16, $57, $57
	.db $97, $17, $56, $56
	.db $96, $16, $55, $55
	.db $95, $15, $54, $54
	.db $94, $14, $53, $53
	.db $93, $13, $52, $52
	.db $92, $12, $51, $51
	.db $91, $11, $50
	.db $FE

Ins_Piano10:
	.db $97, $15, $55, $55
	.db $93, $14, $55, $55
	.db $95, $15, $54, $54
	.db $94, $14, $53, $53
	.db $93, $13, $53, $53
	.db $93, $13, $52, $52
	.db $92, $12, $51, $51
	.db $91, $11, $51, $51
	.db $91, $11, $50
	.db $FE

Ins_Piano7:
	.db $95, $13, $54, $53
	.db $92, $13, $53, $53
	.db $93, $13, $53, $53
	.db $93, $13, $52, $52
	.db $92, $12, $52, $52
	.db $92, $12, $51, $51
	.db $91, $11, $51, $51
	.db $91, $11, $50
	.db $FE

Ins_Piano5:
	.db $93, $12, $53, $52
	.db $92, $12, $52, $52
	.db $92, $12, $52, $52
	.db $92, $12, $52, $52
	.db $92, $12, $51, $51
	.db $91, $11, $51, $51
	.db $91, $11, $51, $51
	.db $91, $11, $50
	.db $FE

Ins_Saw13:
	.db $5D
	.db $FE

Ins_Saw12:
	.db $5C
	.db $FE

Ins_Saw11:
	.db $5B
	.db $FE

Ins_Saw10:
	.db $5A
	.db $FE

Ins_Saw9:
	.db $59
	.db $FE

Ins_Saw8:
	.db $58
	.db $FE

Ins_Saw7:
	.db $57
	.db $FE

Ins_Saw6:
	.db $56
	.db $FE

Ins_Saw5:
	.db $55
	.db $FE

Ins_Saw4:
	.db $54
	.db $FE

Ins_Saw3:
	.db $53
	.db $FE

Ins_Saw2:
	.db $52
	.db $FE

Ins_Saw1:
	.db $51
	.db $FE

Ins_BassTrem:
	.db $19, $12, $51, $52
	.db $13, $16, $58, $57
	.db $15, $12, $52, $53
	.db $15, $17, $55, $53
	.db $11, $11, $52, $54
	.db $17, $14, $52, $51
	.db $11, $11, $53, $56
	.db $15, $11, $51, $51
	.db $11, $11, $53, $53
	.db $11, $11, $51, $51
	.db $11, $12, $53, $51
	.db $11, $11, $51, $51
	.db $11, $12, $51, $51
	.db $11, $11, $51, $51
	.db $11, $11, $51, $51
	.db $11, $11, $51, $51
	.db $11, $11, $51, $51
	.db $11, $10
	.db $FE
