{
	scr_textrender_switchfont("dh_fontnes");
	if(global._showHitbox){
		var mglode = instance_find(obj_mg_lode,0);
		if(instance_exists(mglode)){
			for(var zz = 0; zz < array_length(global._stage_layout); zz++){
				for(var yy = 0; yy < array_length(global._stage_layout[zz]); yy++){
					for(var xx = 0; xx < array_length(global._stage_layout[zz][yy]); xx++){
						scr_textrender_type(mglode._editor_dispoffset[0]+(xx*global._lode_tilesize),mglode._editor_dispoffset[1]+((yy*global._lode_tilesize)+(zz*8)), string(global._stage_layout[zz][yy][xx]));
					}
				}
			}
		}
	}
	scr_textrender_switchfont(global._defaultFont);
}