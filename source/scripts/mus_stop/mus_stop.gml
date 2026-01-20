///function mus_stop()
function mus_stop(){
	if(global._cursong != -1){
		audio_stop_sound(global._cursong);
		global._cursong = -1;
	}
}