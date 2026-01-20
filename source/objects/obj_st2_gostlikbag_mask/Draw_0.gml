{
	if(_shadowsinit){
		_shadowmult = clamp(0, _defshadowsize-(-_height/HEIGHT), _defshadowsize);
		if(ds_map_exists(global._gameshadows,self.id)){
			global._gameshadows[? self.id][? "draw"] = true;
			global._gameshadows[? self.id][? "x"] = x+(sin(_sintimer/9)*_amp*14);
			global._gameshadows[? self.id][? "y"] = y+_shadoffset;
			global._gameshadows[? self.id][? "scalex"] = _defshadowsize*_shadowmult;
			global._gameshadows[? self.id][? "scaley"] = _defshadowsize*_shadowmult;
		}
	}
	
	draw_sprite_ext(sprite_index,image_index,x,y+_height,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	if(_dark_alpha > 0){
		draw_sprite_ext(sprite_index,image_index,x,y+_height,image_xscale,image_yscale,image_angle,c_black,_dark_alpha);
	}
	if(_starscale > 0){
		draw_sprite_ext(spr_starwhite, 0, x, y, _starscale, _starscale, _starangle, c_white, _staralpha);
	}
}