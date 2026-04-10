function scr_lode_enm_create(){
	#macro LODE_ENM_CHASER 0
	#macro LODE_ENM_NEAR 1
	#macro LODE_ENM_RANDOM 2
	#macro LODE_ENM_MONYX 3
	
	_id = "";
	
	_allsounds = ds_map_create();
	
	_spawn_offsets = [
		(sprite_width*0.5)-4,
		(sprite_height)-8
	];
	
	_spawn_snd = false;
	
	x += _spawn_offsets[0];
	y += _spawn_offsets[1];
	
	_freeze = 0;
	
	_timer = 0;
	_init_timer = 0;
	_cangetdamage = false;
	
	_depth = 0;
	
	_target = noone;
	_target_timer = 999;
	_target_tileoffset = 0;
	
	_nearpoint = noone;
	_nearpoint_timer = 0;
	
	_state = LODE_STATE_DEFAULT;
	_remembermonyx = false;
	
	_go_x = false;
	_go_y = false;
	
	_storepos = [x,y];
	_storetimer = 0;
	_idletimer = 0;
	_idlefix = false;
	
	_walkpos = [x,y];
	_dir = "r";
	_xspd = 0;
	_yspd = 0;
	
	_fall_storepos = [x,y];
	
	_frac_x = 0;
	_frac_y = 0;
	
	_movespd_init = 0.96;
	_movespd = _movespd_init;
	
	_move_mult = 1;
	
	_fallspd = 0;
	
	_groundtimer = 0;
	_ladder_cd = 0;
	_rope_cd = 0;
	_collect_cd = 0;
	_ladder_invtime = 0;
	
	_order = 0;
	
	_pathinit = false;
	
	_pathfind_timer = 0;
	_path_step = false;
	_path_array = [];
	_curnode = -1;
	
	_ignore_pathfinding = 0;
	_force_path = 0;
	
	_is_stuck = false;
	_stuckcol = false;
	_stucktimer = 0;
	_offset = [0,0];
	
	_force_stuck = 0;
	
	_getup_timer = 0;
	_getup_index = 0;
	_getup = false;
	_getup_pos = [x,y];
	_getup_dir = DIR_R;
	_getup_same_y = false;
	
	_curdir = DIR_R;
	_dirval = 0;
	_moving = false;
	
	_enmwalk = 0;
	_enmwalk_y = y;
	_enmwalk_xspd = 0;
	
	_anim_transition = false;
	_anim_tr_anim = "";
	_anim = "idle";
	_anim_prev = _anim;
	_animspeed = 1;
	
	_codename = "";
	
	_disppos = [x,y];
	
	_collectable = false;
	_collectable_id = "";
	_sparklesoffset = [0,0];
	
	_river_timer = 99;
	
	_erase_init_tiles = false;
	_tiles_init = [_tilepos[0],_tilepos[1]];

	_project = true;
	_deadtimer = 0;

	_spawning = false;
	_spawntimer = 0;
	_spawnamp = 0.14;
	_spawnblend = c_black;
	_spawnblend_amnt = 1;
	
	_taunt = false;
	_tauntsnd = false;

	_snd = {
		taunt: -1,
		death: -1,
	}
	
	_spawnagain = false;
	_init_spawner = false;

	if(!global._lode_editor){
		_collectobj = instance_create_depth(x,y,0,obj_lode_follower_collect);
		_collectobj._parentobj = self;
		_collectobj._id = "collectable"+string(x+y)+string(irandom(99999));
	
		_hurtbox = instance_create_depth(x,y,0,obj_lode_chaser_deathmask);
		_hurtbox._parentobj = self;
	}
	
	function getcelldist(cell1,cell2){
		return sqrt_value(diff_abs(cell1[0],cell2[0]),diff_abs(cell1[1],cell2[1]));
	}
	
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
		}
		
		if(place_meeting(x+addval[0],y+addval[1],obj_lode_stalactite)){
			if(dir == COL_Y && addval[1] > 0){
				_go_x = trueval[0];
				_go_y = trueval[1];
			}
		}
		if((_state == LODE_STATE_DEFAULT && _groundtimer <= 0) || _state == LODE_STATE_ROPE || _state == LODE_STATE_LADDER){
			_go_x = true;
			_go_y = true;
		}
	}
	
	function spawn_collect(offs){
		if(_collectable){
			var offset = offs;
				
			collectpos = [_tilepos[0]+offset,_tilepos[1]];
			if(collectpos[0] != -1 && collectpos[1] != -1){
				if(global._stage_layout[1][collectpos[0]][collectpos[1]] == LTILE_AIR){
					global._stage_layout[0][collectpos[0]][collectpos[1]] = LTILE_COL;
					global._stage_layout[1][collectpos[0]][collectpos[1]] = LTILE_COL;
				}
			
				var inst = instance_create_depth(x,y,0,obj_lode_collect);
				inst.x = (collectpos[1]*global._lode_tilesize)+(global._lode_tilesize*0.5);
				inst.y = (collectpos[0]*global._lode_tilesize)+(global._lode_tilesize*0.5);
				inst._tilepos = [collectpos[0],collectpos[1]];
				inst._id = _collectable_id;
				inst._spawned = true;
				_collectable_id = "";
					
				_collect_cd = 90;
				_collectable = false;
			}
		}
	}
	
	function update_tilepos() {
		_tilepos[1] = round((x-(global._lode_tilesize*0.5))/global._lode_tilesize);
		_tilepos[0] = round((y-global._lode_tilesize)/global._lode_tilesize);
	}
}