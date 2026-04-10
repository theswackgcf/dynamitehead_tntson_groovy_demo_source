{
	_lode_object = true;
	
	_depth = 0;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_go_y = 0;
	_frac_y = 0;
	
	_movespd = 0.7;
	_dir = DIR_R;
	_yspd = 0;
	
	_turntimer = 0;
	
	x += sprite_width*0.5;
	y += sprite_height*0.5;
	
	visible = false;
	
	function checkcol(pixel){
		if(place_meeting_array(x,y+pixel,global._lode_collide_solid)){
			_go_y = false;
		}
		if(place_meeting(x,y+pixel,obj_lode_wallgone)){
			_go_y = false;
		}
	}
}