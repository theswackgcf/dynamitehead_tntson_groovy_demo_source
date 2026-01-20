{
	if(_shadowsinit){
		if(ds_map_exists(global._gameshadows,_occupy_id)){
			_shadowmult[0] = clamp(0, _shadsize[0]-(_height/HEIGHT), _shadsize[0]);
			_shadowmult[1] = clamp(0, _shadsize[1]-(_height/HEIGHT), _shadsize[1]);
			global._gameshadows[? _occupy_id][? "draw"] = true;
			global._gameshadows[? _occupy_id][? "x"] = x;
			global._gameshadows[? _occupy_id][? "y"] = y+24;
			global._gameshadows[? _occupy_id][? "scalex"] = _shadsize[0]*_shadowmult[0];
			global._gameshadows[? _occupy_id][? "scaley"] = _shadsize[1]*_shadowmult[1];
		}
	}
	
	draw_sprite_ext(sprite_index,image_index,x+_dispoffset[0],y+_dispoffset[1]-_height,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}