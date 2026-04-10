{
	_allsounds = ds_map_create();
	
	_snd = {
		falling: false,
		tada: false,
	};
	_tntko = false;
	_object = true;
	_scrclearend = true;
	_freeze = 0;
	
	image_xscale = 1;
	image_yscale = 1;
	_height = HEIGHT;
	_act = 0;
	_picked = false;
	_defshadowsize = 0.6;
	_timr = 0;
	
	_amount = 500;
	
	_dh = noone;
	_lerptopos = [x,y];
	
	_codename = "moneypickup";
	_enmtype = -1;
	
	_sort = true;
	
	_rep = "";
	_colorsinit = false;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_shadowsinit = false;
	
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