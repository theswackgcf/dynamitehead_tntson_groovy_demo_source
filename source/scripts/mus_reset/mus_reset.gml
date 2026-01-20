///function mus_reset()
function mus_reset(){
	if(global._cursong != -1){
		global._looped = 0;
		audio_sound_set_track_position(global._cursong, 0);
	}
}