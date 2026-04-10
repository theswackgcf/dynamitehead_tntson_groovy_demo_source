{
	_musicstart = true;
	_musicinit = false;
	
	_ef_muffled = audio_effect_create(AudioEffectType.LPF2);
	_ef_bitcrush = audio_effect_create(AudioEffectType.Bitcrusher);
	
	_resumepos = false;
	
	_musindex = -1;
	_musnotplaying = 0;
	
	global._musicPos = ds_map_create();
	
	global._musFade = 1;
	global._musFadeLerp = global._musFade;
	
	global._storeEffect = undefined;
	global._storeMashed = undefined;
	
	global._loops = ds_map_create();
	//global._loops[? "mus_theme1"] = 8.755;
	//global._loops[? "mus_boss1"] = 12.656;
	global._loops[? "mus_menu"] = 1.360;
	global._loops[? "mus_theme2"] = 4.56;
	global._loops[? "mus_boss2"] = 13.95;
	global._loops[? "mus_win"] = 3.013;
	global._loops[? "mus_gameover"] = 0.740;
	global._loops[? "mus_briefing"] = 5.08;
	global._loops[? "mus_tutorial"] = 12.37;
	
	global._bossgains = [1,1];
	
	global._forceStopMusic = false;
	
	global._weirdmusic = 0;
	global._weirdmusic_lerp = 1;
	global._weirdmusic_lerpto = 1;
	global._weirdmusic_pause = false;
}