{
	_lode_object = true;
	
	_depth = 0;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_go_x = 0;
	_frac_x = 0;
	
	_movespd = 0.7;
	_dir = DIR_R;
	_xspd = 0;
	
	_turntimer = 0;
	
	x += sprite_width*0.5;
	y += sprite_height;
	y -= 4;
	
	visible = false;
	
	function checkcol(pixel){
		if(place_meeting_array(x+pixel,y,global._lode_collide_solid)){
			_go_x = false;
		}
	}
}