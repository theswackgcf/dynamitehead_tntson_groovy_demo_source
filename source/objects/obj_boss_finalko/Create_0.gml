{
	_codename = "boss"+string(global._location+1);
	_anim = "finalko";
	sprite_index = asset_get_index("spr_"+_codename+"_"+_anim);
	
	depth = -5001;
	
	_allsounds = ds_map_create();
	
	//smashing into screen, get off screen
	_boss_sounds = [
		[],
		[snd_lanky_tnthit1,snd_lanky_tnthit2,snd_lanky_tnthit3,snd_lanky_tnthit4],
	];
	
	_init = false;
	_spd = [0,0];
	_offset = [0,0];
	
	_drawself = true;
	
	_act = 0;
	_sintimer = 0;
	_timer = 0;
	
	_scale = 1;
	
	_amp = 0;
	_crack = false;
	_crackpos = 0;
	_crackalpha = 1;
	
	_skull = false;
	_skullpos = [0,0];
	_skullvel = [0,0];
	_skullangle = 0;
	
	_dh = false;
	
	_freeze = 0;
	
	_voiceclip = -1;
	
	_dir = DIR_R;
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	_centerpoint = global._cameraX+(WIDTH/2);
}