{
	_lode_object = true;
	
	y -= 2;
	
	_allsounds = ds_map_create();
	
	_depth = 0;
	
	_freeze = 0;
	
	_show = true;
	
	_id = "";
	
	_prevpos = [0,0];
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_movespd_init = 1.5;
	_movespd = _movespd_init;
	_fallspd = 1;
	
	_frac_x = 0;
	_frac_y = 0;
	
	_xspd = 0;
	_yspd = 0;
	
	_go_x = false;
	_go_y = false;
	
	_groundtimer = 0;
	_ground_particle = true;
	
	_forceboulder = 0;
	_bouldspd = 0;
	
	_particle_timer = 0;
	
	_collectable = false;
	_collectable_id = "";
	_collect_cd = 0;
	_plrxspd = 0;
	
	_project = true;
	_deadtimer = 0;
	
	_cantdig = 0;
	
	_checkdelete = false;
	
	_sparkles = noone;
	_sparklesoffset = [sprite_width*0.5,sprite_height];
	_disppos = [x,y];

	visible = false;
	
	function checkcol(pixel, dir){
		var addval = [0,0];
		var trueval = [true,true];
		if(dir == COL_X){
			//x collision
			addval = [pixel,0];
			trueval = [false,true];
			//can go x = false, can go y = true
		} else if(dir == COL_Y){
			//y collision
			addval = [0,pixel];
			trueval = [true,false];
			//can go x = true, can go y = false
		}
		
		if(place_meeting_array(x+addval[0],y+addval[1],global._lode_collide_solid)){
			_go_x = trueval[0];
			_go_y = trueval[1];
			if(dir == COL_Y && addval[1] < 0){
				_jump_power = 0;
			}
		}
		if(place_meeting(x+addval[0],y+addval[1],obj_lode_enmwall)){
			_go_x = trueval[0];
			_go_y = trueval[1];
		}
		if(place_meeting(x,y+1,obj_lode_enmwall)){
			var enmwall = instance_place(x,y+1,obj_lode_enmwall);
			if(instance_exists(enmwall) && enmwall._parentobj.id != self.id){
				if(y >= enmwall.y && y < enmwall.y+(sprite_height*0.5)){
					y = enmwall.y-1;
					_yspd = 0;
					_groundtimer = 2;
				}
			}
		}
	}
}