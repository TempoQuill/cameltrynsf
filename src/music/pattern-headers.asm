MACRO ptrn_header square1, square2, hill, noise, dpcm, fds
	.dw square1, square2, hill, noise, dpcm, fds, 0, 0
ENDM

Music3_PatternHeaders:
	ptrn_header 0, 0, 0, 0, 0, PD_Countdown_FDS
	ptrn_header PD_NO_Match_Pulse1, PD_NO_Match_Pulse2, PD_NO_Match_Hill, 0, 0, PD_NO_Match_FDS
	ptrn_header PD_HurryUp_Pulse1, PD_HurryUp_Pulse2, PD_HurryUp_Hill, 0, 0, PD_HurryUp_FDS
	ptrn_header 0, 0, 0, 0, 0, 0
	ptrn_header 0, 0, 0, 0, 0, 0
	ptrn_header 0, 0, 0, 0, 0, 0
	ptrn_header 0, 0, 0, 0, 0, 0
	ptrn_header 0, 0, 0, 0, 0, 0

Music2_PatternHeaders:
	ptrn_header PD_CS_Pulse1, PD_CS_Pulse2, PD_CS_Hill, PD_CS_Noise, 0, PD_CS_FDS
	ptrn_header PD_Tutorial_Pulse1, PD_Tutorial_Pulse2, PD_Tutorial_Hill, PD_Tutorial_Noise, 0, PD_Tutorial_FDS
	ptrn_header PD_TAT_Pulse1, PD_TAT_Pulse2, PD_TAT_Hill, PD_TAT_Noise, PD_TAT_DPCM, PD_TAT_FDS
	ptrn_header PD_CJ_Pulse1, PD_CJ_Pulse2, PD_CJ_Hill, PD_CJ_Noise, 0, PD_CJ_FDS
	ptrn_header PD_SSB_Pulse1, PD_SSB_Pulse2, PD_SSB_Hill, PD_SSB_Noise, 0, PD_SSB_FDS
	ptrn_header PD_LS_Pulse1, PD_LS_Pulse2, PD_LS_Hill, PD_LS_Noise, 0, PD_LS_FDS
	ptrn_header PD_VC_Pulse1, PD_VC_Pulse2, PD_VC_Hill, PD_VC_Noise, 0, PD_VC_FDS
	ptrn_header PD_MR_Pulse1, PD_MR_Pulse2, 0, PD_MR_Noise, 0, PD_MR_FDS

Music1_PatternHeaders:
	ptrn_header PD_Title_Pulse1, PD_Title_Pulse2, PD_Title_Hill, 0, 0, PD_Title_FDS
	ptrn_header PD_Menu_Pulse1, PD_Menu_Pulse2, PD_Menu_Hill, 0, 0, PD_Menu_FDS
	ptrn_header PD_Goal_Pulse1, PD_Goal_Pulse2, PD_Goal_Hill, 0, 0, PD_Goal_FDS
	ptrn_header PD_NO_Miss_Pulse1, PD_NO_Miss_Pulse2, PD_NO_Miss_Hill, 0, 0, PD_NO_Miss_FDS
	ptrn_header PD_FinalTrial_Pulse1, PD_FinalTrial_Pulse2, 0, 0, 0, PD_FinalTrial_FDS
	ptrn_header PD_Congrats_Pulse1, PD_Congrats_Pulse2, PD_Congrats_Hill, PD_Congrats_Noise, PD_Congrats_DPCM, PD_Congrats_FDS
	ptrn_header PD_GameOver_Pulse1, PD_GameOver_Pulse2, PD_GameOver_Hill, PD_GameOver_Noise, 0, PD_GameOver_FDS
	ptrn_header PD_TWUIO_Pulse1, PD_TWUIO_Pulse2, PD_TWUIO_Hill, PD_TWUIO_Noise, 0, PD_TWUIO_FDS
