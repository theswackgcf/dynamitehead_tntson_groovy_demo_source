{
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? _occupy_id] = ds_map_create();
		global._gameshadows[? _occupy_id][? "draw"] = false;
		global._gameshadows[? _occupy_id][? "x"] = x;
		global._gameshadows[? _occupy_id][? "y"] = y;
		global._gameshadows[? _occupy_id][? "scalex"] = 1;
		global._gameshadows[? _occupy_id][? "scaley"] = 1;
		
		_shadowsinit = true;
	}
	
	if(_init){
		//sine effect
		var offs = 0;
		if(!_hopping){
			offs = sin(_timer/18)*12;
		} else {
			offs = _hop_arc;
		}
		var shadowmult = clamp(0, 1-((offs)/64), 1);
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				global._gameshadows[? _occupy_id][? "draw"] = true;
				global._gameshadows[? _occupy_id][? "x"] = x;
				global._gameshadows[? _occupy_id][? "y"] = y+24;
				global._gameshadows[? _occupy_id][? "scalex"] = 0.25*shadowmult;
				global._gameshadows[? _occupy_id][? "scaley"] = 0.25*shadowmult;
			}
		}
		draw_sprite_ext(sprite_index, image_index, x, y+offs, 1, 1, 0, image_blend, 1);
	}
}