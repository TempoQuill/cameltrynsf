MusicData_GameOver_Pulse1:
	instrument 0
	volume_const
	note_length M1, S16
	note F_, 3
	note A_, 3
	note C_, 4
	note F_, 3
	note A_, 3
	note C#, 4
	note F_, 3
	note A_, 3
	note D_, 4
	note F_, 3
	note A_, 3
	note D#, 4
	note F_, 3
	note A_, 3
	note E_, 4
	note F_, 3
	note A_, 3
	note F_, 4
	note_length M3, S16
	tie
	pitch_slide 1, D#, 4
	tie
	sound_ret

MusicData_GameOver_Pulse2:
	instrument 21
	volume_const
	note_length M3, S32
	note C_, 3
	note C_, 3
	note_length M4_5, S32
	note C_, 3
	note_length M3, S64
	rest
	note_length M4_5, S32
	note C_, 3
	note_length M3, S64
	rest
	note_length M3, S32
	note C_, 3
	instrument 0
	note_length M3, S16
	note C_, 3
	note_length M3, S64
	tie
	rest
	note_length M3, S8
	note C_, 3
	note_length M4_5, S32
	tie
	note_length M3, S64
	rest
	sound_ret

MusicData_GameOver_Hill:
	instrument 21
	note_length M3, S32
	note F_, 2
	note F_, 3
	note_length M4_5, S32
	note F_, 2
	note_length M3, S64
	rest
	note_length M4_5, S32
	note F_, 2
	note_length M3, S64
	rest
	note_length M3, S32
	note F_, 2
	instrument 0
	note_length M3, S16
	note E_, 2
	note_length M3, S64
	tie
	rest
	note_length M3, S8
	note F_, 2
	note_length M4_5, S32
	tie
	note_length M3, S64
	rest
	sound_ret

MusicData_GameOver_Noise:
	drum_envelope DR3, M3, S16
	drum_note 14
	drum_note 14
	drum_note 14
	drum_note 14
	drum_note 14
	drum_envelope DR3, M1, S16
	drum_note 14
	drum_note 14
	drum_envelope DR3, M3, S8
	drum_note 14
	drum_envelope DR3, M1, S16
	rest
	sound_ret

MusicData_GameOver_FDS:
	instrument 6
	volume_const
	note_length M3, S16
	note F_, 2
	instrument 9
	note D#, 5
	note D#, 5
	note D#, 5
	note D#, 5
	note_length M1, S16
	note D#, 5
	note A#, 4
	note F_, 4
	note_length M3, S8
	tie
	sound_ret
