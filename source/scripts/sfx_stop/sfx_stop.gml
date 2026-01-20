///function sfx_stop(sound_index);
function sfx_stop(sfx){
	if(ds_map_exists(_allsounds, sfx)){
		global._curSongGain = 1;
		audio_stop_sound(_allsounds[? sfx]);
	}
}