{
	//speakers
	var speakerposL = [x-256,y+_offsety.speakerL];
	var speakerposR = [x+256,y+_offsety.speakerR];
	if(!_beat){
		draw_sprite_ext(spr_boss2_bg_spL, _speakerframe, speakerposL[0], speakerposL[1],1,1,0,image_blend,image_alpha);
		draw_sprite_ext(spr_boss2_bg_spR, _speakerframe, speakerposR[0], speakerposR[1],1,1,0,image_blend,image_alpha);
	} else {
		draw_sprite_ext(spr_boss2_bg_spL_beat, _speakerframe, speakerposL[0], speakerposL[1],1,1,0,image_blend,image_alpha);
		draw_sprite_ext(spr_boss2_bg_spR_beat, _speakerframe, speakerposR[0], speakerposR[1],1,1,0,image_blend,image_alpha);
	}
	
	_lankfsprite = -1;
	_lankfframe = 0;
	
	//lanky larry
	if(_larry){
		var curframe = _lankframe%_deframes;
		switch(_state){
			case "intro":
				draw_sprite_ext(spr_boss2_bg_intro, curframe, x+_lank_offsetx, y-164+_offsety.set,_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
				draw_sprite_ext(spr_boss2_bg_intro_light, curframe, x+_lank_offsetx+(_switchoffset[0]*_lankscale[0]), y-164+_offsety.set+(_switchoffset[1]*_lankscale[1]),_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
				if(!global._pause){
					_eyesframe += 0.15;
					if(_eyesframe >= 11){
						_eyesframe = 9;
					}
				}
				curframe = _eyesframe;
				var offset = [28*_lankscale[0],-217*_lankscale[1]];
				draw_sprite_ext(spr_boss2_bg_intro_eyes, curframe, x+_lank_offsetx+offset[0], y-164+_offsety.set+offset[1],_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
			case "default":
				if(_curmine_show){
					draw_sprite_ext(spr_boss2_mine_air,0,_curminepos[0],_curminepos[1],0.5,0.5,0,image_blend,image_alpha);
				}
			
				var sprite;
				if(_larryact_tr <= 0){
					sprite = asset_get_index("spr_boss2_bg_"+string(_larryact));
					_lankfsprite = asset_get_index("spr_boss2_bg_"+string(_larryact)+"_front");
				} else {
					sprite = spr_boss2_bg_0;
				}
				if(_minethrow){
					_larryact = 4;
					sprite = spr_boss2_bg_4;
				}
				if(_seethe){
					sprite = spr_boss2_bg_seethe;
				}
				if(ds_map_exists(_lankframes, sprite)){
					curframe = _lankframe%_lankframes[? sprite];
				}
				if(!_seethe && _larryact_tr <= 0 && _larryact <> 4){
					if(_beat){
						curframe = _lankframe_onbeat;
					} else {
						curframe = 0;
					}
				}
				_lankfframe = curframe;
				draw_sprite_ext(sprite, curframe, x+_lank_offsetx, y-164+_offsety.set,_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
			case "leave":
				draw_sprite_ext(spr_boss2_bg_leave, 0, x+_lank_offsetx, y-164+_offsety.set,_spawndir*_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
			case "enter":
				draw_sprite_ext(spr_boss2_bg_enter, 0, x, y-164+_offsety.set+_lank_offsety,_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
			case "spin":
				var sprite = spr_boss2_bg_0;
				if(ds_map_exists(_lankframes, sprite)){
					curframe = _lankframe%_lankframes[? sprite];
				}
				draw_sprite_ext(sprite, curframe, x, y-164+_offsety.set,_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
			case "seethe":
				var offset = [0,0];
				if(_larryact_tr <= 0){
					sprite = spr_boss2_bg_seethe;
					offset[0] = random_range(-4,4);
					offset[1] = random_range(-2,2);
				} else {
					sprite = spr_boss2_bg_0;
				}
				if(global._pause){
					offset = [0,0];
				}
				draw_sprite_ext(sprite, curframe, x+_lank_offsetx+offset[0], y-164+_offsety.set+offset[1],_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			break;
		}
		
		//display intro PROPER
		if(_bossintro != noone && instance_exists(_bossintro)){
			var sprite = -1;
			var curframe = 0;
			var offset = [96,-180];
			switch(_bossintro.sprite_index){
				case spr_boss2_intro1:
					sprite = spr_boss2_intro1_back;
				break;
				case spr_boss2_intro2:
					sprite = spr_boss2_intro2_back;
				break;
			}
			curframe = _bossintro.image_index;
			var draw = true;
			if((curframe >= 4 && sprite == spr_boss2_intro1_back) || (curframe <= 3 && sprite == spr_boss2_intro2_back)){
				draw = false;
			}
			if(draw && sprite != -1){
				draw_sprite_ext(sprite, curframe, _bossintro.x+offset[0], _bossintro.y+offset[1],_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
			}
		}
	}
	//dj set
	draw_sprite_ext(spr_boss2_bg_set, 0, x, y+_offsety.set,1,1,0,image_blend,image_alpha);
	if(_lankfsprite != -1){
		if(sprite_exists(_lankfsprite)){
			var offset = [0,0];
			if(ds_map_exists(_lankf_offsets, _lankfsprite)){
				offset = [_lankf_offsets[? _lankfsprite][0]*_lankscale[0],_lankf_offsets[? _lankfsprite][1]*_lankscale[1]];
			}
			draw_sprite_ext(_lankfsprite, _lankfframe, x+_lank_offsetx+offset[0], y-164+_offsety.set+offset[1],_lankscale[0],_lankscale[1],0,image_blend,image_alpha);
		}
	}
}