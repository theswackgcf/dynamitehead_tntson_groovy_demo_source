{
	if(_fromlank){
		depth = 5000;
	} else {
		if(!_warn){
			var warn = instance_create_depth(x, (global._cameraY+(WIDTH/2))-350, -5000, obj_boss2_mine_warning);
			warn._parentobj = self;
			_warn = true;
		}
		_sort = true;
	}
	if(!global._pause){
		if(_active){
			image_speed = 1;
		
			if(y-_height >= global._cameraY+32 && !_snd){
				if(_allsounds != -1){
					sfx_play_proximity(snd_mine_throw,0.5);
				}
				_snd = true;
			}
		
			if(_height > _groundlevel){
				sprite_index = spr_boss2_mine_air;
				x += _xspd;
				y += _yspd;
				_height -= 28;
			} else {
				if(place_meeting(x,y,obj_dh_mask)){
					var dh = instance_place(x,y,obj_dh_mask);
					if(instance_exists(dh) && dh._mashact > 0 || dh._blowup){
						var p = instance_create_depth(x-32,y,depth-4,obj_particle);
						p._type = "vanish";
					
						instance_destroy();
					}
				}
			
				if(global._finalhit > 0){
					var p = instance_create_depth(x-32,y,depth-4,obj_particle);
					p._type = "vanish";
					
					instance_destroy();
				}
			
				_timer ++;
				if(!_snd2){
					if(_allsounds != -1){
						sfx_play_proximity(snd_mine_land, 0.6);
						_snd2 = true;
					}
				}
				if(!_popoff){
					sprite_index = spr_boss2_mine;
					if(_timer >= _popofftimer){
						_timer = 0;
						_popoff = true;
					}
				} else {
					sprite_index = spr_boss2_mine_popoff;
					if(_timer >= 30){
						var pj = instance_create_depth(x,y-32,depth,obj_projectile);
						pj._cangetdamage = false;
						pj._visible = false;
						pj._temp = true;
						pj._deathtimer = 8;
						pj._scale2 = [2.5, 2];
						pj._damage = ATK_KO;
					
						var p = instance_create_depth(x-32,y,depth-4,obj_particle);
						p._type = "smile";
					
						if(_allsounds != -1){
							sfx_play_proximity(snd_explosion_smile, 0.72);
						}
					
						with(obj_camera){
							_ampX = 7;
							_ampY = 12;
						}
					
						_active = false;
					}
				}
			
				_height = _groundlevel;
			}
		} else {
			_deadtimer ++;
			if(!sfx_isplaying(snd_explosion_smile) || _deadtimer >= 140){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}