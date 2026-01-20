///function sfx_volume(sound_index, volume, [time])
function sfx_volume(sfx, gain, time = 0){
	if(ds_map_exists(_allsounds, sfx)){
		audio_sound_gain(_allsounds[? sfx], gain, time);
	}
}