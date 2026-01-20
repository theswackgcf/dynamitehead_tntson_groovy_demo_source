{
	_allsounds = ds_map_create();
	
	_scale = 1.12;
	image_xscale = global._scale*_scale;
	image_yscale = global._scale*_scale;
	_xscale = 1;
	
	_height = -HEIGHT;
	_vspd = 8;
	_bounce = false;
	
	_sintimer = 0;
	_amp = 32;
	
	_tntko = false;
	_object = true;
	_scrclearend = true;
	_freeze = 0;
	
	_codename = "st2_gostlikbag_mask";
	_enmtype = -1;
	
	_defshadowsize = 0.42;
	_shadoffset = 780;
	_shadowsinit = false;
	
	_death_inst = noone;
	_deathact = 0;
	_deathtimer = 0;
	_death = false;
	
	_curdir = DIR_R;
	
	_xspd = 0;
	_yspd = 0;
	_grav = 0.38;
	_dark_alpha = 0;
	
	_starscale = 0;
	_starangle = 0;
	_staralpha = 1;
	
	function tntko_kill() {
		if(!_tntko){
			_tntko = true;
			with(obj_fade){
				_fadeTo = 0;
				_fadeSpd = 0.04;
			}
			with(obj_dh_mask){
				_blowup_err = 0;
				_blowupenm ++;
			}
		}
	}
}