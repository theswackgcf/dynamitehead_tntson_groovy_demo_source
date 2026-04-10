{
	if(_init){
		scr_textrender_switchfont("dh_fontnes_lode");
		gpu_set_texfilter(false);
		if(surface_exists(_drawsurface)){
			surface_set_target(_drawsurface);
			
			draw_clear_alpha(c_black,0);
			var drawalp = 1;
			if(!global._lode_editor){
				var plr = instance_nearest(x,y,obj_lode_plr);
				if(instance_exists(plr)){
					drawalp = clamp(0.08+(1-(diff_abs(plr.y,y)/global._lode_disp_dim[1])),0,1);
				}
			}

			var init_drawx = floor(_surf_dim[0]/2);
			var init_drawy = floor(_surf_dim[1]/2);

			var drawx = floor(init_drawx);
			var drawy = floor(init_drawy+(sin(_signimg/24)*4));

			var twidth = (scr_textrender_width(_text_wrapped)+32)*_textscale;
			var theight = (scr_textrender_height(_text_wrapped)+32)*_textscale;

			draw_sprite_ext(spr_lode_signblock,_signimg,drawx,drawy+floor(theight/2),1,1,0,c_white,1);
			
			if(_drawdeletetext){
				draw_sprite_ext(spr_lode_signblock,_signimg,drawx,drawy+floor(theight/2),1,1,0,make_color_rgb(255,85,85),1);
				scr_nesfont_shadow(drawx+24,drawy+floor(theight/2)+24,"R: Change text",false,c_white,global._lode_textshadow_color,1);
			}
			
			if(_readtimer > 0){
				scr_textrender_halign("center");
				scr_nesfont_shadow(drawx,drawy+floor(theight/2)-16,string_upper(key_to_string(global._input[global._inptype][? "confirm"]))+": Read",false,c_white,global._lode_textshadow_color,1);
				scr_textrender_halign("left");
			}
			if(_showtext){
				draw_set_alpha(0.8);
				draw_set_color(c_black);
				draw_rectangle(drawx-floor(twidth/2),drawy-floor(theight/2),drawx+floor(twidth/2),drawy+floor(theight/2),false);
				draw_set_color(c_white);
				draw_set_alpha(1);
			
				scr_textrender_halign("center");
				scr_textrender_valign("middle");
				scr_nesfont_shadow(drawx,drawy,_text_wrapped,false,c_white,global._lode_textshadow_color,1,_textscale,_textscale);
				scr_textrender_halign("left");
				scr_textrender_valign("top");
			}
			
			surface_reset_target();
		
			scr_lode_project_surface(_drawsurface,(x-init_drawx)+sprite_xoffset,((y+8)-init_drawy-floor(theight/2))+sprite_yoffset);
		} else {
			_drawsurface = surface_create(_surf_dim[0],_surf_dim[1]);
		}
		gpu_set_texfilter(global._texfilter);
		scr_textrender_switchfont(global._defaultFont);
	}
}