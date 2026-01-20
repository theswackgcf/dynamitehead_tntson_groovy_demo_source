{
	depth = -10000;
	
	_starttimer = 0;
	_startval = 6;
	_drawnorm = false;
	_drawnorm_alp = 1;
	
	_allsounds = ds_map_create();
	
	_timer = 0;
	_act = 0;
	
	
	_ripped = false;
	
	_poster = true;
	
	_showbg = true;
	
	_posterframe = 0;
	_postertimer = 0;
	_postershow = true;
	_posterscale = 0.85;
	
	_handframe = 0;
	_handtimer = 0;
	_handshow = false;
	
	_dynamiteframe = 0;
	_dynamitetimer = 0;
	_dynamiteshow = false;
	
	_offset = 0;
	_xpos = _offset;
	_ypos = HEIGHT+_offset;
	
	_yvel = 0;
	_grav = 0.9;
	
	_scale = 3;
	
	_dhoffset = [-220,-48];
	_setdir = false;
	_dir = DIR_R;
	
	_end_anim = false;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_colorsinit = false;
	_rep = "";
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
	
	function draw_gui(){
		if(_showbg){
			draw_set_color(#000000);
			draw_rectangle(-global._screenSideOffset,-global._screenSideOffset,WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset, false);
			draw_set_color(#FFFFFF);
		}
	
		var offset = [WIDTH/2, HEIGHT/2];
	
		if(_act > 0 && _poster){
			if(!_ripped){
				draw_sprite_ext(spr_wanted, global._location, offset[0], offset[1],_posterscale,_posterscale,0,c_white,1);
			} else {
				draw_sprite_ext(spr_wanted_ripped, 0, offset[0], offset[1],_posterscale,_posterscale,0,c_white,1);
			}
		}
	
		if(_act == 1){
			if(_postershow){
				draw_sprite_ext(spr_wanted_appear, _posterframe, offset[0], offset[1],_posterscale,_posterscale,0,c_white,1);
			}
		}
	
		if(_colorsinit){		
			var _shdr = asset_get_index("shd_replace_col");
			if(global._buildver == HTML){
				_shdr = asset_get_index("shd_replace_col"+string(_maxcolors));
			}
				
			shader_set(_shdr);

			shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), _maxcolors);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _mult_colorinArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _mult_coloroutArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _mult_tolrArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _mult_blendArray);
		
			if(_act == 2){
				if(_handshow){
					draw_sprite(spr_wanted_dhhand, _handframe, 0, 0);
				}
			}
			if(_act == 3){
				if(_dynamiteshow && _setdir){
					if(!_end_anim){
						draw_sprite_ext(spr_dh_introflip, _dynamiteframe, _xpos, _ypos, _scale*_dir, _scale, 0, c_white, 1);
					} else {
						draw_sprite_ext(spr_dh_introflip_end, _dynamiteframe, _xpos, _ypos, _scale*_dir, _scale, 0, c_white, 1);
					}
				}
			}
	
			shader_reset();
		}
	}
}