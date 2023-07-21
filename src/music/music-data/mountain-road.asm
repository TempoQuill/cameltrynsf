MusicData_MountainRoad_Pulse1Pulse2:
	note_length M1, S1
	rest
	sound_ret

MusicData_MountainRoad_Pulse1:
	instrument 9
	volume_fade 1, 10
	note_length M1, S1
	pitch_slide 2, A_, 3
	note G_, 2
	volume_const
	note G_, 2
	sound_ret

MusicData_MountainRoad_Pulse2:
	instrument 0
	volume_const
	note_length M1_5, S16
	note A_, 1
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 1
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 2
	note_length M1, S32
	rest
	note_length M1, S16
	note G_, 2
	note_length M1, S4
	pitch_slide 8, A_, 2
	note G_, 2
	note_length M1, S32
	tie
	rest
	note_length M1_5, S16
	note A_, 2
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 2
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 1
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 1
	note_length M1, S32
	rest
	note_length M1_5, S16
	note A_, 2
	note_length M1, S32
	rest
	note_length M1, S16
	note G_, 2
	note_length M1, S4
	pitch_slide 8, A_, 2
	note G_, 2
	note_length M1, S32
	tie
	rest
	note_length M1_5, S16
	note G_, 2
	note_length M1, S32
	rest
	note_length M1, S16
	note F_, 2
	note D_, 2
	sound_ret

MusicData_MountainRoad_Noise_1:
	drum_envelope DR1, M1, S1
	rest
	sound_ret

MusicData_MountainRoad_Noise_2:
	drum_envelope DR1, M1, S8
	drum_note 3
	drum_note 3
	drum_note 3
	drum_envelope DR1, M1, S16
	drum_note 3
	drum_note 3
	rest
	drum_note 3
	drum_envelope DR1, M1, S8
	drum_note 3
	drum_note 3
	drum_note 3
	sound_ret

MusicData_MountainRoad_FDS_1:
	instrument 0
	volume_const
	note_length M1, S16
	note E_, 4
	note E_, 4
	tie
	note E_, 4
	note E_, 4
	tie
	note E_, 4
	note E_, 4
	tie
	note E_, 4
	note_length M1, S8
	note E_, 4
	note E_, 4
	note E_, 4
	sound_ret

MusicData_MountainRoad_FDS_2:
	instrument 6
	volume_const
	note_length M1, S8
	note F_, 2
	note F_, 2
	instrument 0
	note E_, 4
	instrument 6
	note_length M1, S16
	note F_, 2
	note F_, 2
	rest
	note F_, 2
	rest
	note F_, 2
	instrument 0
	note_length M1, S8
	note E_, 4
	note E_, 4
	instrument 6
	note_length M1, S8
	note F_, 2
	note F_, 2
	instrument 0
	note E_, 4
	instrument 6
	note_length M1, S16
	note F_, 2
	note F_, 2
	rest
	note F_, 2
	rest
	note F_, 2
	instrument 0
	note_length M1, S8
	note E_, 4
	instrument 6
	note F_, 2
	sound_ret

MusicData_MountainRoad_FDS_3:
	instrument 0
	volume_const
	note_length M1, S16
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	instrument 6
	note F_, 2
	note F_, 2
	rest
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	instrument 0
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	instrument 6
	note F_, 2
	tie
	note F_, 2
	note F_, 2
	rest
	note F_, 2
	note F_, 2
	tie
	sound_ret

