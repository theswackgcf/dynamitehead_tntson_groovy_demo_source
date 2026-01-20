{
	scr_enemyscript_display("draw");
	if(_parentobj != noone && instance_exists(_parentobj)){
		if(_parentobj._anim == "idle"){
			if(_parentobj._fr_crackstate > 0 && _parentobj._fr_crackstate < 4){
				draw_sprite_ext(asset_get_index("spr_fridge_idle_crack"+string(_parentobj._fr_crackstate)), image_index, x+60+_parentobj._dispoffset[0], y-225, image_xscale*0.8, image_yscale, image_angle, image_blend, image_alpha);
			}
		}
		if(global._debug && global._showHitbox){
			scr_textrender_type(x-96,y-256,_parentobj._fr_type);
		}
	}
}