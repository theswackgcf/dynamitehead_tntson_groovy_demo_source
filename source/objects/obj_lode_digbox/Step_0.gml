{
	if(global._debug){
		visible = global._showHitbox;
		image_blend = c_black;
		if(_active > 0){
			image_blend = c_white;
		}
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			scr_lode_digbox_offset();
	
			if(_active > 0){
				var collide_wall_hard = false;
				var collide_wall = false;
				var collide_boulder = false;
			
				if(instance_number(obj_lode_wall_hard) > 0){
					if(!place_meeting(x,y,obj_lode_wall_hard)){
						collide_wall_hard = true;
					}
				} else {
					collide_wall_hard = true;
				}
				if(instance_number(obj_lode_wall) > 0){
					if(place_meeting(x,y,obj_lode_wall)){
						collide_wall = true;
					}
				} else {
					collide_wall = true;
				}
				if(instance_number(obj_lode_boulder) > 0){
					if(place_meeting(x,y,obj_lode_boulder)){
						collide_boulder = true;
					}
				} else {
					collide_boulder = true;
				}
			
				if(collide_wall_hard && (collide_wall || collide_boulder)){
					var dobreak = true;
				
					var checkobjs = [
						obj_lode_wall,
						obj_lode_ladder,
						obj_lode_stalactite,
						obj_lode_boulder,
						obj_lode_chaser,
						obj_lode_chaser_near,
						obj_lode_chaser_monyx,
						obj_lode_chaser_random,
						obj_lode_crawler_h,
						obj_lode_exit,
					];
				
					for(var i = 0; i < array_length(checkobjs); i++){
						if(place_meeting(x,y-global._lode_tilesize,checkobjs[i])){
							dobreak = false;
						}
					}
				
					if(instance_number(obj_lode_boulder) <= 0){
						collide_boulder = false;
					}
					if(collide_boulder){
						dobreak = true;
					}
					if(dobreak){
						var wall = instance_place(x,y,obj_lode_wall);
						if(instance_exists(wall)){
							global._stage_layout[1][wall._tilepos[0]][wall._tilepos[1]] = LTILE_AIR;
						
							for(var i = 0; i < 4; i++){
								var p = instance_create_depth(wall.x+random_range(0,global._lode_tilesize),wall.y+random_range(0,global._lode_tilesize),0,obj_particle);
								p._type = "lode_break";
								p._lode_particle = true;
								p._move = true;
								p._do_grav = true;
								p._grav_val = 0.24;
								p._xspd = random_range(0.9,2)*choose(1,-1);
								p._yspd = -random_range(1.8,2.24);
								p._color = make_color_rgb(137, 56, 235);
								if(wall._collectable_timer > 0){
									p._color = global._lode_collectblend;
								}
							}
						
							var wnew = instance_create_depth(wall.x,wall.y,wall.depth,obj_lode_wallgone);
							wnew._tilepos = [wall._tilepos[0],wall._tilepos[1]];
						
							_parentobj._successdig = 12;
							_active = 0;
						
							sfx_play(snd_lode_dig);
						
							instance_destroy(wall.id);
						}
						var boulder = instance_place(x,y,obj_lode_boulder);
						if(instance_exists(boulder) && boulder._cantdig <= 0){
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
							global._stage_layout[1][boulder._tilepos[0]][boulder._tilepos[1]] = LTILE_AIR;
						
							_active = 0;
						
							for(var i = 0; i < 4; i++){
								var p = instance_create_depth(boulder.x+random_range(0,global._lode_tilesize),boulder.y+random_range(0,global._lode_tilesize),0,obj_particle);
								p._type = "lode_break";
								p._lode_particle = true;
								p._move = true;
								p._do_grav = true;
								p._grav_val = 0.24;
								p._xspd = random_range(0.9,2)*choose(1,-1);
								p._yspd = -random_range(1.8,2.24);
								p._color = make_color_rgb(185, 148, 247);
								if(boulder._collectable){
									p._color = global._lode_collectblend;
								}
							}
						
							sfx_play(snd_lode_dig);
							sfx_pitch(snd_lode_dig,0.76);
						
							instance_destroy(boulder.id);
						}
					} else {
						_parentobj._digtime = 12;
					}
				}
				_active --;
			}
		}
	}
}