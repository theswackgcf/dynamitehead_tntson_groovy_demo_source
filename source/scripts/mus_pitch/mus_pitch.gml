///function mus_pitch(pitch)
function mus_pitch(pitch){
	if(global._cursong != -1){
		audio_sound_pitch(global._cursong, pitch);
	}
}