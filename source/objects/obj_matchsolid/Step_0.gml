{
	if(global._debug){
		if(global._showHitbox){
			visible = true;
			if(_collidewith == "player"){
				image_blend = c_green;
			}
			if(_collidewith == "enemy"){
				image_blend = c_red;
			}
		} else {
			visible = false;
		}
	}
	
	if(!_deletestart){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
		}
		
		_deletestart = true;
	}
	
	//match objects for deleting
	if(!_matched && _delete_matchid != -1 && _delete_matchobj != noone){
		for(var i = 0; i < instance_number(_delete_matchobj); i++){
			var inst = instance_find(_delete_matchobj, i);
			if(instance_exists(inst) && inst._matchid == _delete_matchid){
				_matched = true;
				_delete_enemy = inst;
			}
		}
	}
	if(_delete_enemy != noone && instance_exists(_delete_enemy)){
		if(_delete_enemy._inactive){
			y = -HEIGHT;
			with(obj_st2_yolopass){
				_dissaptimer = 3;
			}
		} else {
			y = _starty;
		}
	}
	if(_delete_enemy != noone && !instance_exists(_delete_enemy)){
		with(obj_st2_yolopass){
			if(!_trigger){
				sfx_play_proximity(snd_secret);
				sfx_pitch(snd_secret,1.38);
				
				//particles
				for(var i = 0; i < irandom_range(12,24); i++){
					var p = instance_create_depth(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),-1000,obj_particle);
					p._type = "face";
					p._frameend = false;
					p._move = true;
					p._xspd = choose(random_range(-4,-9),random_range(4,9));
					p._yspd = choose(random_range(-3,-5),random_range(3,5));
					p._alpha = true;
					p._alpha_spd = 0.008;
					p._color = make_color_rgb(190, 130, 237);
				}
				
				_trigger = true;
			}
		}
		
		global._deletedStuff[? self.id] = 1;
		instance_destroy();
	}
}