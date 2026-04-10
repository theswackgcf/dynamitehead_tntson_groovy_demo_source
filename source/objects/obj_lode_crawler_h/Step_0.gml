{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = global._lode_spd;

		if(!global._lode_editor){
			if(_turntimer <= 0){
				sprite_index = spr_lode_crawler_h_walk;
			} else {
				_turntimer --;
				sprite_index = spr_lode_crawler_h_turn;
			}
			
			mask_index = spr_lode_crawler_h_walk;
			
			_xspd = _movespd*_dir;
		
			//collision and movement
			_frac_x = frac(_xspd*global._lode_spd);
		
			//x speed
			var amntx = _xspd*global._lode_spd;
			if(_xspd > 0){
				amntx = floor(_xspd*global._lode_spd);
			} else {
				amntx = ceil(_xspd*global._lode_spd);
			}
			repeat(abs(amntx)){
				_go_x = true;
				var pixel = sign(_xspd*global._lode_spd);
			
				checkcol(pixel);
			
				if(_go_x){
					x += pixel;
				} else {
					x -= pixel;
					_dir *= -1;
					_turntimer = 6;
				}
			}
		
			//x fraction
			if(_frac_x <> 0){
				_go_x = true;
				var pixel = _frac_x;
			
				checkcol(pixel);
			
				if(_go_x){
					x += pixel;
				} else {
					x -= pixel;
					_dir *= -1;
					_turntimer = 6;
				}
			}
			
			if(!place_meeting_array(x+((_xspd*global._lode_spd)*10),y+8,global._lode_collide_solid)){
				x -= _xspd*global._lode_spd;
				_dir *= -1;
				_turntimer = 6;
			}
		
			_frac_x = 0;
			
			//boulder logic
			if(place_meeting(x,y,obj_lode_boulder)){
				var boulder = instance_place(x,y,obj_lode_boulder);
				if(instance_exists(boulder) && boulder._project){
					boulder._project = false;
						
					with(boulder){
						global._lode_deletedStuff[? _id] = {
							xx: x,
							yy: y,
							_tilepos: _tilepos,
							delete_: true,
						}
					}
					
					var p = instance_create_depth(x+4,y-8,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
				}
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y+2],[image_xscale*_dir,image_yscale]);
	} else {
		image_speed = 0;
	}
}