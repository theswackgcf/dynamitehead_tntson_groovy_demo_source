{
	if(_infoshow){
		gpu_set_texfilter(false);
		var draw_offsetX = -60;
		var draw_offsetY = 0;
		var drawX = floor(WIDTH/2)-120+draw_offsetX;
		var drawY = (floor(HEIGHT/2)-128)+draw_offsetY;
		var bosscolor = _bosscolor[_curboss];
		draw_sprite_ext(spr_wireframe_bossinfo, 1, drawX, drawY, 2, _infoscale*2, 0, make_color_rgb(bosscolor[0],bosscolor[1],bosscolor[2]), 1);
		draw_sprite_ext(spr_wireframe_bossinfo, 0, drawX, drawY, 2, _infoscale*2, 0, make_color_rgb(bosscolor[0],bosscolor[1],bosscolor[2]), 1);
	
		var textposy = [-28, 58];
		var bossoffsety = [-287,-122];
		var curpos;
		
		if(_infoscale > 1){
			curpos = 0;
		} else {
			curpos = 1;
		}
		
		var draw_info_x = 780+draw_offsetX;
		var drawcol = make_color_rgb(bosscolor[0],bosscolor[1],bosscolor[2]);
		var lines = ["name:", _bossinfo[? _curboss][0], "weight:", _bossinfo[? _curboss][1][0], "height:", _bossinfo[? _curboss][2][0], "bounty:", _bossinfo[? _curboss][3] + " monyx", "description:", _bossinfo[? _curboss][4]];
		
		if(global._metric){
			lines[3] = _bossinfo[? _curboss][1][1];
			lines[5] = _bossinfo[? _curboss][2][1];
		}
		
		scr_textrender_switchfont("dh_fontnes");
		var offsety = 0;
		
		scr_textrender_type(drawX-244, drawY-(99*(_infoscale*2))+(_text_hideoffset*0.2), "BOUNTYHEAD INFO:", false, drawcol, 1, 2, 2 * _infoscale);
		
		for(var i = 0; i < array_length(lines); i++){
			if((i % 2) == 0){
				drawcol = make_color_rgb(0, 0, 0);
			} else {
				drawcol = make_color_rgb(bosscolor[0],bosscolor[1],bosscolor[2]);
			}
			
			scr_textrender_type(draw_info_x, textposy[curpos] + offsety + draw_offsetY + _text_hideoffset, string_upper(lines[i]), false, drawcol, 1, 2, 2 * _infoscale);
			offsety += (24 * _infoscale);
		}
		
		scr_textrender_switchfont(global._defaultFont);
		
		if(surface_exists(_boss_surface)){
			surface_set_target(_boss_surface);
			
			//3d boss
			gpu_set_zwriteenable(true);
			gpu_set_ztestenable(true);
			gpu_set_texfilter(false);
			draw_clear_alpha(c_black, 0);
	
			var aspect = window_get_width() / window_get_height();
	
			camera_set_view_mat(_camera, matrix_build_lookat(_camx, _camy, _camz, 0, -_camy, _camz, 0, 0, 1));
			camera_set_proj_mat(_camera, matrix_build_projection_perspective_fov(-50, aspect, 1, 32000));
			camera_apply(_camera);
	
			var mat = matrix_build(0, 0, 0, 0, 0, _spin, 1, 1, 1);
			matrix_set(matrix_world, mat);
	
			shader_set(shd_wireframe);
			shader_set_uniform_f_array(shader_get_uniform(shd_wireframe, "wire_color"), _bosscolor[_curboss]);
	
			vertex_submit(_barycentric, pr_trianglelist, -1);
	
			matrix_set(matrix_world, matrix_build_identity());
	
			shader_reset();	
			
			gpu_set_zwriteenable(false);
			gpu_set_ztestenable(false);
			
			surface_reset_target();
		} else {
			_boss_surface = surface_create(_boss_surface_dim[0],_boss_surface_dim[1]);
		}
		
		if(surface_exists(_boss_surface_resize)){
			surface_set_target(_boss_surface_resize);
			draw_clear_alpha(c_black, 0);
			
			draw_surface_stretched(_boss_surface, 0, 0, _boss_surface_dim[0]/_surf_divby,_boss_surface_dim[1]/_surf_divby);
			
			surface_reset_target();
		} else {
			_boss_surface_resize = surface_create(_boss_surface_dim[0]/_surf_divby,_boss_surface_dim[0]/_surf_divby);
		}
		
		draw_surface_stretched(_boss_surface_resize, _bossoffset[0]+draw_offsetX, _bossoffset[1]+bossoffsety[curpos]+draw_offsetY+_boss_hideoffset, surface_get_width(_boss_surface_resize)*2,surface_get_height(_boss_surface_resize)*2*_infoscale);
		
		gpu_set_texfilter(global._texfilter);
	}
}