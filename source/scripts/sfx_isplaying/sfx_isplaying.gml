///sfx_isplaying(sound_index)
function sfx_isplaying(sfx){
	if(!ds_map_exists(_allsounds, sfx)){
		return false;
	} else {
		if(audio_is_playing(_allsounds[? sfx])){
			return true;
		} else {
			return false;
		}
	}
}