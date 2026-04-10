{
	if(global._seteffect > 0){
		switch(global._effect){
			case EFFECT_SEPIA:
				shader_set(shd_sepia);
				shader_set_uniform_f(shader_get_uniform(shd_sepia, "u_SepiaAmount"), 1);
			break;
		}
	}
	
	var camzoom = instance_find(obj_camera,0)._cameraZoom;
	if(camzoom <> 0){
		if(sprite_exists(sprite_index)){
			draw_sprite_ext(sprite_index, image_index, (x-(global._cameraX))/camzoom, (y-(global._cameraY))/camzoom, image_xscale/camzoom, image_yscale/camzoom, 0, #FFFFFF, 1);
		}
	}
	
	if(global._seteffect > 0){
		shader_reset();
	}
}