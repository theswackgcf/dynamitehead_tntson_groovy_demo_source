{
	visible = false;
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			x = _parentobj.x;
			y = _parentobj.y;
			
			if(_parentobj._cangetdamage){
				if(_parentobj._getup || _parentobj._getup_timer > 0) return;
				if(_parentobj._taunt) return;
				if(_hurttimer > 0) return;
				if(_parentobj._ladder_invtime > 0) return;
				if(place_meeting(x-_parentobj._movespd,y+16,obj_lode_ladder)){
					return;
				};
				
				if(place_meeting(x,y,obj_lode_wall)){
					with(_parentobj){
						spawn_collect(-1);
					}
					
					_hurttimer = 2;
				}
				if(place_meeting(x,y,obj_lode_plr)){
					var plr = instance_place(x,y,obj_lode_plr);
					if(instance_exists(plr) && plr._tnt_power > 0){
						with(_parentobj){
							sfx_play(snd_mg_flame);
						}
						_hurttimer = 2;
					}
				}
				if(place_meeting(x,y-8,obj_lode_boulder)){
					var boulder = instance_place(x,y-8,obj_lode_boulder);
					if(instance_exists(boulder) && boulder._project){
						boulder._project = false;
						
						if(boulder._collectable){
							var collectpos = [boulder._tilepos[0],boulder._tilepos[1]];
							global._stage_layout[0][collectpos[0]][collectpos[1]] = LTILE_COL;
							global._stage_layout[1][collectpos[0]][collectpos[1]] = LTILE_COL;
					
							var inst = instance_create_depth(boulder.x,boulder.y,0,obj_lode_collect);
							inst.x = (collectpos[1]*global._lode_tilesize)+(global._lode_tilesize*0.5);
							inst.y = (collectpos[0]*global._lode_tilesize)+(global._lode_tilesize*0.5);
							inst._spawned = true;
							inst._tilepos = [collectpos[0],collectpos[1]];
							inst._id = boulder._collectable_id;
							boulder._collectable_id = "";
						}
						
						with(boulder){
							global._lode_deletedStuff[? _id] = {
								xx: x,
								yy: y,
								_tilepos: _tilepos,
								delete_: true,
							}
						}
						
						var p = instance_create_depth(x+4,y+2,0,obj_particle);
						p._lode_particle = true;
						p._type = "lode_block";
					}
					_hurttimer = 2;
				}
				if(place_meeting(x,y,obj_lode_stalactite_hitbox)){
					_hurttimer = 2;
				}
				
				var lode = instance_find(obj_mg_lode,0);
				if(instance_exists(lode)){
					var checky = global._stage_dims[1]+diff_abs(global._stage_dims[1],lode._disp_dim[1]);
					if(global._stage_dims[1] >= lode._disp_dim[1]){
						checky = global._stage_dims[1]+global._lode_tilesize;
					}
					if(y >= checky){
						_hurttimer = 2;
					}
				}
			}
		}
		
		if(_hurttimer > 0){
			_hurttimer --;
		}
	}
}