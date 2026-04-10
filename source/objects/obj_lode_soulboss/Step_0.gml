{
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		x = _startx+_offsetx;
		y = _starty;

		/*if(global._cursong == -1){
			audio_stop_sound(mus_minigame_lode);
			with(obj_music){
				_musicinit = false;
			}
		}*/

		if(!_init){
			//global._cursong = -1;
			
			audio_stop_sound(snd_lode_ghosts);
			
			var num = 0;
			for(var i = 0; i < irandom_range(16,20); i++){
				var xx = random_range(0,_surf_dim[0]*0.8);
				var yy = random_range(0,_surf_dim[1]);
				_surf_sprites[? num] = {
					init_x: xx,
					init_y: yy,
					xx: xx,
					yy: yy,
					spr: choose(spr_lode_soulboss_1,spr_lode_soulboss_2,spr_lode_soulboss_3),
					img: random(25),
					col: make_color_rgb(13, 36, 166),
				}
				num ++;
			}
			for(var i = 0; i < irandom_range(20,24); i++){
				var xx = random_range(0,_surf_dim[0]*0.8);
				var yy = random_range(0,_surf_dim[1]);
				_surf_sprites[? num] = {
					init_x: xx,
					init_y: yy,
					xx: xx,
					yy: yy,
					spr: choose(spr_lode_soulboss_1,spr_lode_soulboss_2,spr_lode_soulboss_3),
					img: random(25),
					col: c_white,
				}
				num ++;
			}
			
			_init = true;
		} else {
			if(_timer % 3 == 0){
				var dskeys = ds_map_keys_to_array(_surf_sprites);
				for(var i = 0; i < array_length(dskeys); i++){
					var curkey = i;
					if(ds_map_exists(_surf_sprites,curkey)){
						var curspr = _surf_sprites[? curkey];
						curspr.img += 0.21*global._lode_spd;
						curspr.xx = round(curspr.init_x + (sin(curspr.img/1.5)*24));
						curspr.yy = round(curspr.init_y + (cos(curspr.img/1.5)*24));
					}
				}
			
				if(global._buildver != HTML){
					_particle_timer += global._lode_spd;
					if(_particle_timer >= irandom_range(7,16)){
						var p_array = [];
						for(var i = 0; i < irandom_range(6,14); i++){
							p_array[i] = instance_create_depth(random_range(x,x+_surf_dim[0]),random_range(y,y+_surf_dim[1]),0,obj_particle);
							p_array[i]._lode_particle = true;
							p_array[i]._type = "lode_soulboss_particle";
							p_array[i]._move = true;
							p_array[i]._xspd = random_range(0.2,0.7);
							p_array[i]._yspd = random_range(0.2,0.7)*choose(-1,1);
						}
						_particle_timer = 0;
					}
				}
			}
			
			_grad_timer += global._lode_spd;
			_grad_x = sin(_grad_timer/64)*28;
		}

		if(!global._lode_editor){
			_timer ++;
			if(_timer >= 65){
				_offsetx += _spd*global._lode_spd;
			}
			if(_stop){
				_spd = lerp(_spd,0,0.16);
			}
			
			if(_allsounds != undefined && _allsounds != -1){
				if(!_stopsnd){
					if(!sfx_isplaying(snd_lode_ghosts)){
						sfx_play(snd_lode_ghosts,_vol);
					} else {
						sfx_volume(snd_lode_ghosts,_vol);
					}
				} else {
					if(sfx_isplaying(snd_lode_ghosts)){
						sfx_stop(snd_lode_ghosts);
					}
				}
			}
		}
		
		scr_lode_overtile();
	} else {
		image_speed = 0;
	}
}