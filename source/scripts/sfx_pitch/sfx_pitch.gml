///function sfx_pitch(sfx, pitch)
function sfx_pitch(sfx, pitch){
	if(ds_map_exists(_allsounds, sfx)){
		audio_sound_pitch(_allsounds[? sfx], pitch);
	}
}