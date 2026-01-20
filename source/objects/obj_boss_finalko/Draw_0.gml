{
	if(_drawself){
		draw_sprite_ext(sprite_index, image_index, x+_offset[0], y+_offset[1], image_xscale+(sin(_sintimer/3)*0.04), image_yscale+(cos(_sintimer/3)*0.04), 0, #FFFFFF, 1);
	}
	if(_crack){
		draw_sprite_ext(spr_screencrack, 0, x, y, 2.5, 2.5, 0, c_white, clamp(0,_crackalpha,1));
	}
	if(_skull){
		draw_sprite_ext(asset_get_index("spr_"+_codename+"_skull"), 0, _skullpos[0], _skullpos[1], 1, 1, _skullangle, c_white, 1);
	}
}