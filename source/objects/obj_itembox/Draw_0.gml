{
	if(_active){
		_shadowmult = clamp(0, 1-(_height_draw/HEIGHT), 1);
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,self.id)){
				global._gameshadows[? self.id][? "draw"] = true;
				global._gameshadows[? self.id][? "scalex"] = 0.3*_shadowmult;
				global._gameshadows[? self.id][? "scaley"] = 0.3*_shadowmult;
			}
		}
	
		draw_set_color(c_white);
		if(_showself){
			draw_sprite_ext(sprite_index, image_index, x, y-_height_draw, image_xscale, image_yscale, 0, image_blend, 1);
		}
		if(!_showself && _nukeactive){
			draw_sprite_ext(spr_itembox_expbottom,floor(_nukeframe),x,y-_height_draw,image_xscale*2,image_yscale*2,0,image_blend,1);
		}
	} else {
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,self.id)){
				global._gameshadows[? self.id][? "draw"] = false;
			}
		}
	}
}