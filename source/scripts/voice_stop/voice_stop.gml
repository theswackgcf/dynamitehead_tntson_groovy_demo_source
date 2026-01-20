function voice_stop(voice){
	if(audio_is_playing(voice)){
		audio_stop_sound(voice);
	}
}