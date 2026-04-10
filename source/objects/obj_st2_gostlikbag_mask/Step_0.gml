{
	depth = -2000;
	
	image_xscale = _scale*_xscale;
	image_yscale = _scale;
	
	if(_deathact < 2 && !_shadowsinit){
		//shadows
		global._gameshadows[? self.id] = ds_map_create();
		global._gameshadows[? self.id][? "draw"] = false;
		global._gameshadows[? self.id][? "x"] = x;
		global._gameshadows[? self.id][? "y"] = y+_shadoffset;
		global._gameshadows[? self.id][? "scalex"] = _defshadowsize;
		global._gameshadows[? self.id][? "scaley"] = _defshadowsize;
		
		_shadowsinit = true;
	}
	
	if(!global._pause){
		image_speed = 1;
		
		_height += _vspd;
		_vspd += 0.85;
		if(_height >= 0){
			if(!_bounce){
				_vspd = -14;
				_height = 4;
				_bounce = true;
			} else {
				_height = 0;
				_vspd = 0;
			}
		}
		
		if(!_death){
			_sintimer ++;
		}
		
		if(_amp > 4){
			_amp -= 0.7;
		} else {
			_amp = 4;
		}
		
		_angle = sin(_sintimer/9)*_amp;
		
		image_angle = _angle;
		
		//receiving hits
		if(!_death){
			if(_height <= 110 && place_meeting(x,y,obj_punchhitbox)){
				var p = instance_place(x,y,obj_punchhitbox);
				var parent = p._parentobj;
				if(instance_exists(p) && instance_exists(parent)){
					if(p._ptype == "pl" && p._damage == ATK_KO){
						var dist = parent.y-(y+_shadoffset);
						if(dist >= -96 && dist <= 6){
							if(parent._attacktype == "air"){
								//wrong attack type, telegraph that
								_sintimer = 0;
								_amp = 20;
								_height = -4;
								_vspd = -18;
								
								sfx_play_choose_proximity(global._swishsounds[2]);
								
								instance_destroy(p.id);
								return;
							} else if(parent._attacktype == "upper"){
								sfx_play(snd_finalko);
								sfx_play_choose(global._kdsounds);
								sfx_pitch(snd_finalko, 1.35);
								
								_height = 0;
								
								var p = instance_create_depth(x,y+_shadoffset-64,depth, obj_particle);
								p._type = "hit_final";
								global._contrasthit = global._contrasthit_max;
								
								if(instance_exists(parent._displayobj)){
									(parent._displayobj).image_index = 2;
								}
								
								global._hits += 1;
								global._hitmeter = 50;
								
								_curdir = parent._curdir;
								_death_inst = parent;
								_deathact = 0;
								_deathtimer = 0;
								
								global._pad_vibrate = 20;
								
								_death = true;
							}
						}
					}
				}
			}
		} else {
			_deathtimer ++;
			
			if(_deathact >= 2){
				depth = 9995;
			}
			
			switch(_deathact){
				case 0:
					image_angle = 0;
				
					with(obj_camera){
						_ampX = 14;
						_ampY = 14;
					}
				
					global._cameraZoom = 0.72;
					global._camZoomSpd = 0.06;
			
					if(_death_inst != noone && instance_exists(_death_inst)){
						_death_inst._freeze = 2;
					}
					
					with(obj_tipbox){
						if(_prompt == "upper"){
							global._deletedStuff[? self.id] = self.id;
							instance_destroy();
						}
					}
					
					global._gametips[? "upper"][1] = true;
					
					if(_deathtimer >= 32){
						_deathact = 1;
						_deathtimer = 0;
					}
				break;
				case 1:
					global._cameraZoom = global._defCamZoom;
					global._camZoomSpd = 0.5;
					
					image_angle += 3;
					if(_deathtimer >= 16){
						sprite_index = spr_st2_gostlikbag_out;
						_xscale = _curdir;
						x += 48*_curdir;
						y += 390;
						
						_xspd = 5*_curdir;
						_yspd = -12;
						
						sfx_play(snd_whistle);
						
						image_angle = 0;
						
						if(ds_map_exists(global._gameshadows, self.id)){
							ds_map_delete(global._gameshadows, self.id);
						}
						
						_shadowsinit = false;
						_deathact = 2;
						_deathtimer = 0;
					}
				break;
				case 2:
					x += _xspd;
					y += _yspd;
					_yspd += _grav;
					
					_scale -= 0.02;
					
					if(_scale <= 0.5){
						_dark_alpha += 0.05;
						if(_dark_alpha >= 1){
							_dark_alpha = 1;
						}
					}
					
					if(_scale <= 0){
						sfx_stop(snd_whistle);
						sfx_play(snd_ding);
						
						_scale = 0;
						
						_deathact = 3;
						_deathtimer = 0;
					}
				break;
				case 3:
					_starangle += 8;
					_starscale += 0.05;
					_staralpha -= 0.07;
					if(_staralpha <= 0){
						instance_destroy();
					}
				break;
			}
		}
	} else {
		image_speed = 0;
	}
}