{
	visible = false;
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			x = _parentobj.x;
			y = _parentobj.y;
			
			if(!global._freeRoam){
				if(_parentobj._tnt_power > 0){
					if(place_meeting(x,y,obj_lode_wall)){
						_parentobj._tnt_power = 0;
						_hurttimer = 2;
					}
				}
			
				if(!_parentobj._win && !_parentobj._death && _parentobj._cangetdamage){
					if(_parentobj._tnt_activation || _parentobj._tnt_power > 0) return;
					if(_hurttimer > 0) return;
				
					if(place_meeting(x,y,obj_lode_wall)){
						_hurttimer = 2;
					}
					var enm = [
						obj_lode_chaser_deathmask,
						obj_lode_crawler_h,
						obj_lode_crawler_v,
						obj_lode_boulder,
						obj_lode_stalactite_hitbox,
					];
					if(place_meeting_array(x,y,enm,false,true)){
						var dohurt = false;
						var spawninginst = false;
						var inst = place_meeting_array(x,y,enm,true,true);
						if(instance_exists(inst)){
							if(variable_instance_exists(inst.id, "_freeze")){
								_parentobj._hurt_inst = inst;
							}
							if(variable_instance_exists(inst.id, "_parentobj")){
								_parentobj._hurt_inst = inst._parentobj;
								var h_inst = inst._parentobj;
								if(variable_instance_exists(h_inst.id, "_taunt")){
									h_inst._taunt = true;
								}
								if(variable_instance_exists(h_inst.id, "_spawning")){
									if(h_inst._spawning){
										h_inst._taunt = false;
										h_inst = noone;
										spawninginst = true;
										dohurt = false;
									}
								}
							}
						
							if(inst.object_index != obj_lode_boulder){
								if(!spawninginst){
									dohurt = true;
								}
								if(variable_instance_exists(inst.id, "_getup_timer")){
									if(inst._getup_timer > 0){
										dohurt = false;
									}
								}
							} else {
								//boulder
								if(y > inst.y+inst.sprite_height){
									dohurt = true;
								}
							}
						}
						if(dohurt){
							_hurttimer = 2;
						}
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
		}
		
		if(_hurttimer > 0){
			_hurttimer --;
		}
	}
}