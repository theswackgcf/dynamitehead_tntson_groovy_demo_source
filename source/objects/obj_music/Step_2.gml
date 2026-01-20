{
	//set volume of all sounds in the game
	var fadems = 100;
	if(global._unfocusedmute){
		if(!window_has_focus()){
			audio_group_set_gain(audiogroup_sfx, 0, fadems);
			audio_group_set_gain(audiogroup_music, 0, fadems);
			audio_group_set_gain(audiogroup_voices, 0, fadems);
		} else {
			audio_group_set_gain(audiogroup_sfx, global._sfxVolume*global._masterVolume, fadems);
			audio_group_set_gain(audiogroup_music, global._curSongGain*global._musFadeLerp*global._musVolume*global._masterVolume, fadems);
			audio_group_set_gain(audiogroup_voices, global._voiceVolume*global._masterVolume, fadems);
		}
	} else {
		audio_group_set_gain(audiogroup_sfx, global._sfxVolume*global._masterVolume, fadems);
		audio_group_set_gain(audiogroup_music, global._curSongGain*global._musFadeLerp*global._musVolume*global._masterVolume, fadems);
		audio_group_set_gain(audiogroup_voices, global._voiceVolume*global._masterVolume, fadems);
	}
}