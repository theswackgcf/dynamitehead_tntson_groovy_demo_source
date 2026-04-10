{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = global._lode_spd;

		if(!global._lode_editor){
			if(_turntimer <= 0){
				sprite_index = spr_lode_crawler_v_walk;
			} else {
				_turntimer --;
				sprite_index = spr_lode_crawler_v_turn;
			}
			
			mask_index = spr_lode_crawler_v_walk;
			
			_yspd = _movespd*_dir;
		
			//collision and movement
			_frac_y = frac(_yspd*global._lode_spd);
		
			//y speed
			var amnty = _yspd*global._lode_spd;
			if(_yspd > 0){
				amnty = floor(_yspd*global._lode_spd);
			} else {
				amnty = ceil(_yspd*global._lode_spd);
			}
			repeat(abs(amnty)){
				_go_y = true;
				var pixel = sign(_yspd*global._lode_spd);
			
				checkcol(pixel);
			
				if(_go_y){
					y += pixel;
				} else {
					y -= pixel;
					_dir *= -1;
					_turntimer = 6;
				}
			}
			if(_turntimer <= 0 && y < sprite_height*0.5){
				y = sprite_height*0.5;
				_dir *= -1;
				_turntimer = 6;
			}
			if(_turntimer <= 0 && y > global._stage_dims[1]-(sprite_height*0.5)){
				y = global._stage_dims[1]-(sprite_height*0.5);
				_dir *= -1;
				_turntimer = 6;
			}
		
			//y fraction
			if(_frac_y <> 0){
				_go_y = true;
				var pixel = _frac_y;
			
				checkcol(pixel);
			
				if(_go_y){
					y += pixel;
				} else {
					y -= pixel;
					_dir *= -1;
					_turntimer = 6;
				}
			}
		
			_frac_y = 0;
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale*_dir]);
	} else {
		image_speed = 0;
	}
}