{
	if(_inview){
		if(global._buildver != HTML){
			shader_set(shd_glass);

			var sampler = shader_get_sampler_index(shd_glass, "overlayTex");
			texture_set_stage(sampler, sprite_get_texture(spr_st2_glass_overlay, 0));

			shader_set_uniform_f(shader_get_uniform(shd_glass, "overlayScale"), 3);
			shader_set_uniform_f(shader_get_uniform(shd_glass, "windowScale"), window_get_height());
		}

		draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1);

		if(global._buildver != HTML){
			shader_reset();
		}

		draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, image_blend, 1);
	}
}