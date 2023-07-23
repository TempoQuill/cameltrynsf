MusicData_Title_Pulse1:
	instrument 27
	volume_fade 1, 10
	note_length M1, S1
	note G_, 2

	volume_const
	note_length M1, S8
	note G_, 2
	note G_, 3
	note_length M1, S16
	note G_, 3
	note_length M1, S8
	note G_, 3
	note_length M1, S16
	note G_, 3
	instrument 10
	volume_fade 0, 5
	note_length M1, S8
	note C_, 3
	note_length M1, S2
	tie

	sound_ret

MusicData_Title_Pulse2:
	instrument 27
	volume_fade 1, 10
	note_length M1, S1
	note C_, 3

	volume_const
	note_length M1, S8
	note C_, 4
	note C_, 4
	note_length M1, S16
	note C_, 4
	note_length M1, S8
	note D_, 4
	note_length M1, S16
	note D#, 4
	instrument 10
	volume_fade 0, 5
	note_length M1, S8
	pitch_slide 10, C_, 5
	note G_, 4
	note_length M1, S2
	tie

	sound_ret

MusicData_Title_Hill:
	instrument 21
	note_length M1_5, S8
	note C_, 3
	note_length M1, S16
	note C_, 3
	note_length M1, S8
	note C_, 3
	note G_, 2
	note A#, 2
	note A#, 2
	note_length M1, S16
	note A#, 2
	note_length M1_5, S8
	note A#, 3

	note_length M1, S8
	note C_, 3
	note C_, 3
	note_length M1, S16
	note C_, 3
	note_length M1, S8
	note C_, 3
	note_length M1, S16
	note C_, 3
	instrument 0
	note_length M1, S8
	note C_, 2
	note_length M1, S4
	tie
	rest

	sound_ret

MusicData_Title_FDS:
	instrument 6
	volume_const
	note_length M1_5, S8
	note F_, 2
	instrument 0
	note_length M1, S32
	note A_, 4
	rest
	note_length M1, S8
	note A_, 4
	instrument 6
	note F_, 2
	instrument 0
	note A_, 4
	instrument 6
	note F_, 2
	instrument 0
	note_length M1, S16
	note A_, 4
	instrument 6
	note_length M1_5, S8
	note F_, 2

	instrument 0
	note_length M1, S16
	note A_, 4
	rest
	note A_, 4
	rest
	note_length M1, S4
	note A_, 4
	note_length M1, S2
	note F#, 4
	note_length M1, S8

	tie
	sound_ret
