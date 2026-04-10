{
	_drawbg = true;
	_bgwhite = false;
	_bgalp = 1;
	
	_allsounds = ds_map_create();
	
	_zoom = global._deathZoom;
	
	_init = false;
	
	global._died = true;
	
	x = global._playerX;
	y = global._playerY;
	
	_posTo = [x,y];
	_scaleTo = 1;
	
	_act = 0;
	_timer = 0;
	
	if(global._playerDir == "l"){
		image_xscale = -1;
	} else {
		image_xscale = 1;
	}
	image_yscale = 1;
	_snd = [false,false];
	
	_rep = "";
	_colorsinit = false;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}
