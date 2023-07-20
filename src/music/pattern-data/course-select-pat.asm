PD_CS_Pulse1:
	establish_loop
	sound_play MusicData_CourseSelect_Pulse1
	pat_ret

PD_CS_Pulse2:
	pitch_inc_switch
	establish_loop
	sound_play MusicData_CourseSelect_Pulse2
	pat_ret

PD_CS_Hill:
	establish_loop
	sound_play MusicData_CourseSelect_Hill
	pat_ret

PD_CS_Noise:
	establish_loop
	sound_play MusicData_CourseSelect_Noise
	pat_ret

PD_CS_FDS:
	establish_loop
	sound_play MusicData_CourseSelect_FDS_1
	sound_play MusicData_CourseSelect_FDS_1
	sound_play MusicData_CourseSelect_FDS_1
	sound_play MusicData_CourseSelect_FDS_2
	pat_ret
