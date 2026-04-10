{
	_init = false;
	
	_silent = false;
	_compile_shaders = false;
	_drawbg = true;
	
	_shaders = false;
	_shader_array = [];
	
	_current_pass = 0;
	
	_load_spr = spr_load;
	
	_load_textures = [];
	_load_audio = [];
	
	_flush_textures = [];
	_flush_audio = [];
	
	_total_array = [];
	_total_count = 0;
	
	_flush = [false,false];
	
	_assetnum = 0;
	_curasset = 0;
	_curpage = 0;
	
	_spritearray = [];
	_cursprite = 0;
	_spritedraw = -1;
	
	_progress = 0;
	_total_progress = 0;
	
	_errorfix = 0;
	
	_loadbg = 0;
	
	_out = false;
	
	_loaded = false;
	
	function roomto(roomname){
		if(!_silent){
			if(!_out){
				with(obj_screen_tr){
					_show = true;
					_type = "out";
					_roomto = roomname;
				}
				_out = true;
			}
		} else {
			room_goto(roomname);
		}
	}
}