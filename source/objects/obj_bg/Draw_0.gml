{
	if(!global._debugroom){
		_bgName = "lv"+string(global._location+1)+"_bg1";
		sprite_index = asset_get_index("spr_"+_bgName);
		if(global._tutorial){
			sprite_index = spr_tutr_bg;
		}
		if(sprite_index == spr_lv2_bg1 && global._buildver == HTML){
			sprite_index = spr_lv2_bg1_html;
		}
		
		gpu_set_texrepeat(true);
		
		shader_set(shd_wavy);
		shader_set_uniform_f(t, _timer);
		
		//default (tutorial)
		var shaderprops = {
			aX: 0.008,
			aY: 0,
			s: 0.04,
			fX: 120,
			fY: 0,
		}
		
		switch(global._location){
			case 0:
				//toxic trenches
				shaderprops = {
					aX: 0.015,
					aY: 0.015,
					s: 0.07,
					fX, 120,
					fY, 120,
				}
			break;
			case 1:
				//groovy graveyard
				shaderprops = {
					aX: 0.007,
					aY: 0.007,
					s: 0.2,
					fX, 90,
					fY, 90,
				}
			break;
		}
		
		shader_set_uniform_f(aX, shaderprops.aX);
		shader_set_uniform_f(aY, shaderprops.aY);
		shader_set_uniform_f(s, shaderprops.s);
		shader_set_uniform_f(fX, shaderprops.fX);
		shader_set_uniform_f(fY, shaderprops.fY);
		
		if(!global._pause){
			var spdarray = [0.14, 0.04];
			if(!global._tutorial){
				//locations
				_timer += spdarray[global._location];
			} else {
				//tutorial
				_timer += 0.08;
			}
		}
		
		for(var i = 0; i < image_number; i++){
			var scrollSpdH = room_width/(room_width*_scrollSpeed);
			var scrollSpdV = room_height/(room_height*_scrollSpeed);
			if(room_width > 9000){
				scrollSpdH = 0.98;
			}
			if(room_height > 9000){
				scrollSpdV = 0.98;
			}
			var drawX = ( (global._cameraX+(WIDTH/2)) + 128 ) * scrollSpdH;
			var drawY = ( (global._cameraY+(HEIGHT/2)) + 128 ) * scrollSpdV;
			
			switch(global._location){
				case 0:
					draw_sprite_ext(sprite_index, i, drawX, drawY, 1, 1, 0, #FFFFFF, 1);
				break;
				case 1:
					if(!global._pause){
						_lv2_bgangle[4] += _lv2_anglespeed;
						_lv2_bgangle[3] += _lv2_anglespeed/2;
						_lv2_bgangle[2] -= _lv2_anglespeed/3;
						_lv2_bgangle[1] -= _lv2_anglespeed/4;
					}
					
					draw_sprite_ext(sprite_index, i, drawX, drawY+_lv2_bgoffset[i], 1, 1, _lv2_bgangle[i], _lv2_tint, 1);
				break;
			}
		}
		
		shader_reset();
		gpu_set_texrepeat(false);
		
		if(_thunder){
			if(!global._pause){
				_thundertimer ++;
				if(_thundertimer >= 60){
					_thunderalp -= 0.03;
					if(_thunderalp <= 0){
						_thunder = false;
					}
				}
			}
			
			with(obj_lighting){
				_thunderalp = other._thunderalp;
			}
			
			draw_set_alpha(_thunderalp);
			draw_rectangle(global._cameraX-global._screenSideOffset,global._cameraY-global._screenSideOffset,global._cameraX+WIDTH+global._screenSideOffset,global._cameraY+HEIGHT+global._screenSideOffset, false);
			draw_set_alpha(1);
		} else {
			_thunderalp = 1;
			_thundertimer = 0;
		}
	}
}