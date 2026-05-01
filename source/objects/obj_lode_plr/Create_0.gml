{
	_lode_object = true;
	
	_allsounds = ds_map_create();
	
	_id = "";
	visible = false;
	
	x += sprite_width*0.5;
	y += sprite_height;
	
	#macro LODE_STATE_DEFAULT 0
	#macro LODE_STATE_LADDER 1
	#macro LODE_STATE_ROPE 2
	#macro LODE_STATE_DIG 3
	#macro LODE_STATE_CLIMB 4
	
	_input_digleft = "";
	_input_digright = "";
	
	_freeze = 0;
	
	_init_timer = 0;
	_init_voice = false;
	
	_plstate = LODE_STATE_DEFAULT;
	_store_plstate = _plstate;
	_state_storepos = [x,y];
	
	_offset = [0,0];
	_shakeamp = 0;
	
	_xscale = 1;
	
	_xspd = 0;
	_yspd = 0;
	
	_holdL = false;
	_holdR = false;
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_show = true;
	
	_curdir = DIR_R;
	_state_storedir = _curdir;
	_digdir = -1;
	
	_movespd_init = 1.8;
	_movespd = _movespd_init;
	_fallspd = 1.14;
	
	_move_mult = 1;
	
	_frac_x = 0;
	_frac_y = 0;
	
	_go_x = false;
	_go_y = false;
	
	_groundtimer = 0;
	_rope_cd = 0;
	_jump_power = 0;
	_jump_ptimer = 0;
	
	_ground_particle = true;
	_ground_particle_inactive = 0;
	
	_pushtimer = 0;
	
	_ladder_coyotetime = 0;
	_ladder_coyotetime_max = 5;
	
	_anim_transition = false;
	_anim_tr_anim = "";
	_anim = "idle";
	_anim_prev = _anim;
	_animspeed = 1;
	
	_imgspd_mult = 1;
	
	_depth = 9;
	
	_digtime = 0;
	_successdig = 0;
	
	_river_timer = 99;
	
	_init_timer = 0;
	_cangetdamage = false;
	_hurt_inst = noone;
	
	_death = false;
	_death_act = 0;
	_death_timer = 0;
	
	_win = false;
	_winpos = [x,y];
	_wintimer = 0;
	_winsnd = false;
	
	_backoff_init = false;
	_backoff = 0;
	_backoff_pos = [x,y];
	
	_tnt_activation = false;
	_tnt_activation_timer = 0;
	_tnt_blend_amnt = 0;
	
	_tnt_particle_timer = 0;
	_tnt_power = 0;
	_tnt_power_init = false;
	
	_tnt_snd = false;
	
	_blend = c_white;
	
	_got_key = false;
	
	_boss_init_timer = 0;
	_boss_warning = false;
	_boss_timer = 0;
	_boss_shakeamp = 0;
	
	if(!global._lode_editor){
		_digbox = instance_create_depth(x,y,0,obj_lode_digbox);
		_digbox._parentobj = self;
	
		_digbox_cur = instance_create_depth(x,y,0,obj_lode_digbox_current);
		_digbox_cur._parentobj = self;
	
		_hurtbox = instance_create_depth(x,y,0,obj_lode_plr_deathmask);
		_hurtbox._parentobj = self;
		
		_fire = instance_create_depth(x,y,0,obj_lode_plr_fire);
		_fire._parentobj = self;
	}
	
	#macro COL_X 0
	#macro COL_Y 1
	
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
		if(place_meeting(x+addval[0],y+addval[1],obj_lode_stalactite)){
			if(dir == COL_Y && addval[1] > 0){
				_go_x = trueval[0];
				_go_y = trueval[1];
			}
		}
		
		switch(_plstate){
			case LODE_STATE_DEFAULT:
				if(place_meeting(x+addval[0],y+addval[1],obj_lode_ladder)){
					var inst = instance_place(x+addval[0],y+addval[1],obj_lode_ladder);
					if(dir == COL_Y && addval[1] > 0 && instance_exists(inst) && inst._solid){
						_go_x = trueval[0];
						_go_y = trueval[1];
					}
				}
				
				//rope interaction
				if(_rope_cd <= 0 && place_meeting_array(x,y,global._lode_collide_rope,false,true)){
					var inst = place_meeting_array(x,y,global._lode_collide_rope, true,true);
					if(dir == COL_Y && addval[1] > 0 && instance_exists(inst)){
						y = inst.y+(sprite_height)-12;
						_yspd = 0;
						_frac_y = 0;
						_plstate = LODE_STATE_ROPE;
						
						sfx_play(snd_lode_rope);
					}
				}
			break;
			case LODE_STATE_LADDER:
				if(place_meeting_array(x,y+addval[1],global._lode_collide_solid)){
					if(dir == COL_Y && addval[1] > 0){
						_plstate = LODE_STATE_DEFAULT;
					}
				}
				if(!place_meeting(x,y,obj_lode_ladder)){
					_plstate = LODE_STATE_DEFAULT;
				}
			break;
			case LODE_STATE_ROPE:
				if(!place_meeting_array(x,y,global._lode_collide_rope)){
					_ground_particle_inactive = 4;
					_plstate = LODE_STATE_DEFAULT;
				}
			break;
		}
	}
	
	function do_dig() {
		if(_digbox != noone && instance_exists(_digbox)){
			_digbox._active = 2;
		}
		
		sfx_play(snd_lode_digswish);
		
		_curdir = _digdir;
		_digtime = 0;
		_shakeamp = 6;
		_state_storepos = [x,y];
		_state_storedir = _curdir;
		_store_plstate = _plstate;
		_plstate = LODE_STATE_DIG;
	}
	
	//key functions
	function keyhold(key){
		if(global._lode_howto){
			return false;
		}
		
		if(check_key(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keypress(key){
		if(global._lode_howto){
			return false;
		}
		
		if(check_keypress(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keyrelease(key){
		if(global._lode_howto){
			return false;
		}
		
		if(check_keyrelease(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
}