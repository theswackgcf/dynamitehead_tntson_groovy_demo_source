{
	#macro LTILE_AIR 0  //nothing
	#macro LTILE_SOL 1  //solid block
	#macro LTILE_SOL2 2  //solid hard block
	#macro LTILE_PLR 3  //player
	#macro LTILE_EXT 4 //exit door
	#macro LTILE_LDR 5  //ladder
	#macro LTILE_ROP 6  //rope
	#macro LTILE_ROP2 7  //rope base
	#macro LTILE_COL 8  //monyx collectable
	#macro LTILE_SPR 9  //spring
	#macro LTILE_FLY 10  //fly block
	#macro LTILE_STAL 11  //stalactite
	#macro LTILE_RVR 12  //river
	#macro LTILE_BOL 13  //boulder
	
	#macro LTILE_ENM1 14 //enemy (chaser)
	#macro LTILE_ENM2 15 //enemy (chaser, near)
	#macro LTILE_ENM3 16 //enemy (monyx chaser)
	#macro LTILE_ENM4 17 //enemy (random walker)
	#macro LTILE_ENM5 18  //crawler horizontal
	#macro LTILE_ENM6 19  //crawler vertical
	
	#macro LTILE_KEY 20  //key
	#macro LTILE_SKL 21  //skull collectable
	#macro LTILE_1UP 22  //one up
	#macro LTILE_BGT 23  //bg tile
	
	#macro LTILE_BOS1 24  //soul boss
	#macro LTILE_SIGN 25  //sign block
	#macro LTILE_PTR 26 // pointer
	#macro LTILE_LDR2 27 // bone ladder
	#macro LTILE_SOL_DEL 28 // wall deleter
	#macro LTILE_WARN 29 // warning sign
	
	#macro LTILE_LOOP1 30 //loop 1 trigger
	#macro LTILE_LOOP2 31 //loop 2 trigger
	#macro LTILE_LOOP3 32 //loop 3 trigger
	#macro LTILE_LOOP4 33 //loop 4 trigger
	
	#macro LTILE_ENMCOL 99 //invisible enemy block
	
	_allsounds = ds_map_create();
	
	_stagesobj = instance_create_depth(0,0,0,obj_mg_lode_stages);
	
	if(global._lode_testmode){
		global._lode_editor = false;
	}
	global._lode_editor_layerarray = ds_map_create();
	_editor_dispoffset_init = [28,28];
	_editor_dispoffset = [_editor_dispoffset_init[0],_editor_dispoffset_init[1]];
	
	_editor_defsize = [17,10]; //tiles (w,h)
	_editor_curlayer = 1;
	_editor_mousepos = [0,0];
	_editor_mousetile = [0,0];
	
	global._lode_camera_pos = [0,0];
	
	global._lode_tilesize = 24;
	_offset = [0,0];
	_stage_offset = [0,0];
	_scr_shake_offset = [0,0];
	_scr_shake_x = 0;
	_scr_shake_y = 0;
	
	_editor_tiles = [];
	_editor_tile = 0;
	_editor_tilemenu = false;
	_editor_boxpos = [0,0];
	_editor_boxdims = [8*global._lode_tilesize,6*global._lode_tilesize];
	
	_editor_tilemenu_timer = 0;
	_editor_tilemenu_tile = -1;
	_editor_tilemenu_tile_preview = -1;
	
	_editor_place_cd = 0;
	
	_editor_cameradrag = false;
	_editor_cameradrag_offset = [0,0];
	
	_editor_tileselect = false;
	_editor_tileselect_pos = [0,0];
	_editor_tileselect_mousepos = [0,0];
	
	_editor_tileselect_dsmap = ds_map_create();
	_editor_tileset_gottiles = false;
	
	_editor_gottiles_drag = false;
	_editor_gottiles_drag_pos = [0,0];
	_editor_gottiles_drag_offset = [0,0];
	_editor_drag_prevoffset = [0,0];
	
	_editor_tileselect_size = [0,0];
	
	_dir = "lode_levels\\";
	_savepopup = false;
	_popuptimer = 0;
	
	_editor_help = false;
	
	_init = false;
	
	global._lode_textshadow_color = make_color_rgb(63, 22, 76);
	
	global._lode_collide_solid = [obj_lode_wall,obj_lode_spring,obj_lode_boulder];
	global._lode_collide_rope = [obj_lode_rope,obj_lode_flyblock];
	global._lode_collide_enemy = [obj_lode_chaser,obj_lode_chaser_monyx,obj_lode_chaser_near,obj_lode_chaser_random];
	
	global._stage_layout = [];
	global._stage_layout_bg = [];
	global._stage_hidetiles = [];
	global._stage_dims = [0,0]; //w h in pixels
	_editor_dims = [0,0];
	_editor_dims_tiles = [0,0];
	
	global._sign_layout = ds_map_create();
	
	_centerset = false;
	_stagedims_nooffset = [];
	
	global._lode_collect_cur = 0;
	global._lode_collect_max = 0;
	global._lode_collectblend = make_color_rgb(235, 204, 91);
	
	_lode_score_lerp = global._lode_score;
	_lode_score_string = "";
	
	global._lode_collect_combo = 1;
	global._lode_collect_combo_timer = 0;
	
	global._lode_score_add = {
		monyx: 5,
		enm: 60,
		skull: 100,
	};
	
	global._lode_score_sub = {
		death: 200,
	};
	
	global._lode_skulltimer = 600;
	
	_lode_monyx = global._minigame_monyx;
	_monyx_string = "";
	
	_tnt_lerp = global._lode_tnt;
	
	_ui_alphaTo = 1;
	_ui_alpha = _ui_alphaTo;
	
	global._lode_tnt_hold = 0;
	global._lode_tnt_hold_timer = 0;
	
	global._lode_tnt_blend = make_color_rgb(255, 151, 15);
	
	global._lode_tileframe = 0;
	
	global._lode_boss = false;
	
	global._lode_cullingbox = [0,0,0,0];
	global._lode_cullingoffset = [0,0];
	
	_tileinfo = ds_map_create();
	var curorder = 1;
	_tileinfo[? LTILE_BGT] = {
		obj: -1,
		project: false,
		editorspr: spr_lode_tiles,
		order: curorder,
		tile: true,
	};
	curorder ++;
	_tileinfo[? LTILE_SOL] = {
		obj: obj_lode_wall,
		project: false,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_SOL2] = {
		obj: obj_lode_wall_hard,
		project: false,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_SOL_DEL] = {
		obj: obj_lode_wall_delete,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_LDR] = {
		obj: obj_lode_ladder,
		project: false,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_LDR2] = {
		obj: obj_lode_bone_ladder,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ROP] = {
		obj: obj_lode_rope,
		project: false,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	
	_tileinfo[? LTILE_ROP2] = {
		obj: obj_lode_rope_base,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_PLR] = {
		obj: obj_lode_plr,
		project: true,
		editorspr: spr_lode_plr_idle,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_EXT] = {
		obj: obj_lode_exit,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_KEY] = {
		obj: obj_lode_key,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_PTR] = {
		obj: obj_lode_wall_pointer,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_COL] = {
		obj: obj_lode_collect,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_SKL] = {
		obj: obj_lode_skulls,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_1UP] = {
		obj: obj_lode_oneup,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_RVR] = {
		obj: obj_lode_river,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_SPR] = {
		obj: obj_lode_spring,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_FLY] = {
		obj: obj_lode_flyblock,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_SIGN] = {
		obj: obj_lode_signblock,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_STAL] = {
		obj: obj_lode_stalactite,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_BOL] = {
		obj: obj_lode_boulder,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	
	
	_tileinfo[? LTILE_ENM1] = {
		obj: obj_lode_chaser,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ENM2] = {
		obj: obj_lode_chaser_near,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ENM3] = {
		obj: obj_lode_chaser_monyx,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ENM4] = {
		obj: obj_lode_chaser_random,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ENM5] = {
		obj: obj_lode_crawler_h,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_ENM6] = {
		obj: obj_lode_crawler_v,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_BOS1] = {
		obj: obj_lode_soulboss,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_WARN] = {
		obj: obj_lode_warning,
		project: false,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	
	_tileinfo[? LTILE_LOOP1] = {
		obj: obj_lode_loop1trigger,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_LOOP2] = {
		obj: obj_lode_loop2trigger,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_LOOP3] = {
		obj: obj_lode_loop3trigger,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;
	_tileinfo[? LTILE_LOOP4] = {
		obj: obj_lode_loop4trigger,
		project: true,
		editorspr: -1,
		order: curorder,
	};
	curorder ++;

	_project = ds_map_create();

	_sprinfo = ds_map_create();
	
	_depthsort_timer = 99;
	_deptharray = [];

	_scrollobj = obj_lode_camera;
	_scrollinst = noone;

	_disp_dim = [426,240];
	global._lode_disp_dim = [_disp_dim[0],_disp_dim[1]];
	global._lode_proximity_dims = [_disp_dim[0],_disp_dim[1]];
	_display_bg = surface_create(_disp_dim[0],_disp_dim[1]);
	_display = surface_create(_disp_dim[0],_disp_dim[1]);
	
	_tr_draw = true;
	_tr_img = 0;
	_tr_type = "in";
	_tr_scale = [1,0];
	_tr_scale_spd = [0.01,0.01];
	_tr_alp = 0;
	_tr_done = false;
	
	_tr_exit_act = 0;
	_tr_exit_timer = 0;
	_tr_exit_scale_spd = 0;
	_tr_exit_scale = 0;
	
	_exit_trigger = false;
	_exit_spacing = 0;
	_exit_timer = 0;
	_exit_act = 0;
	_exit_bottomy = 0;
	_exit_bottomalp = 0;
	
	_exit_type = 0;
	
	global._sign_load_done = false;
	_textrender_force_texfilter = false;
	
	if(global._debug){
		instance_create_depth(0,0,-99,obj_mg_lode_debug);
	}
	
	_bgoffset = [[0,0],[0,0]];
	
	//game over
	_gameover = false;

	_mus_spd = 1;

	_over_time = 0;
	_over_act = 0;

	_lose_score = 0;
	_lose_score_prev = 0;
	_sndscore = false;

	_score_cd = 0;

	_wait = 0;
	_earned = 0;

	global._gameover_stopall = false;
	_over_exit = false;
	_exit_tr = false;
	
	_init_howto = false;
	global._lode_howto = false;
	
	_howto_bg_alp = 0;
	_howto_act = 0;
	_howto_timer = 0;
	_howto_size = [320,178];
	_howto_pos = [_disp_dim[0]*0.5,(_disp_dim[1]+(_howto_size[1]*0.5))+16];
	_howto_page = 0;
	
	_howto_text = ["Welcome to DIAL-RUNNER!/n/nUH-OH!! DynamiteHead's reckless surfing stunts resulted in him dropping ALL his hard earned Monyx. Now it's DIAL-M's job to get all that shiny stuff back./n/n/n/n/n/n/n","Find your way around various graveyard obstacles, collect all the Monyx and LEG IT OUT! It might seem simple at first, but takes quite the skill./n/n/n/n/n/n","Some Graveyard Gates will be locked behind a skull symbol. In that case, search around the stage for the GOLDEN GLOVE. You'll see it once you get there.../n/n/n/n/n/n/n/n",""];
	_howto_text_wrapped = [];
	
	_howto_bbox = [0,0,0,0];
	
	_bgtimer = 0;
	t = shader_get_uniform(shd_wavy, "timer");
	fX = shader_get_uniform(shd_wavy, "freqX");
	fY = shader_get_uniform(shd_wavy, "freqY");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");
	
	function draw_num(xx,yy,num,scale=1,align="left"){
		var drawx = xx;
		var num_str = num;
		var spacing = -4;
		if(!is_string(num)){
			num_str = string(num);
		}
		
		var charpoint = 1;
		
		if(align == "right"){
			drawx -= sprite_get_width(spr_lode_gui_num)*scale;
			charpoint = string_length(num_str);
		}
		
		for(var i = 0; i < string_length(num_str); i++){
			draw_sprite_ext(spr_lode_gui_num, real(string_char_at(num_str,charpoint)),drawx,yy,scale,scale,0,c_white,_ui_alpha);
			var valadd = (sprite_get_width(spr_lode_gui_num)*scale)+spacing;
			
			if(align == "left"){
				drawx += valadd;
				charpoint ++;
			} else if(align == "right"){
				drawx -= valadd;
				charpoint --;
			}
		}
	}
	
	function load_stage() {
		for(var i = 0; i < 2; i++){
			global._stage_layout[i] = [];
			global._stage_hidetiles[i] = [];
			for(var yy = 0; yy < array_length(global._lode_testlayout[i]); yy++){
				global._stage_layout[i][yy] = [];
				global._stage_layout_bg[yy] = [];
				global._stage_hidetiles[i][yy] = [];
				for(var xx = 0; xx < array_length(global._lode_testlayout[i][yy]); xx++){
					global._stage_layout[i][yy][xx] = global._lode_testlayout[i][yy][xx];
					global._stage_layout_bg[yy][xx] = global._lode_testlayout[0][yy][xx];
					global._stage_hidetiles[i][yy][xx] = false;
				}
			}
		}
					
		ds_map_copy(global._sign_layout,global._lode_testsigns);
		global._sign_load_done = true;
					
		update_dimensions(false,[true,true]);
	}
	
	function update_dimensions(update_dims_tiles,update_which = [false,false]) {
		if(!update_dims_tiles){
			if(update_which[0]){
				global._stage_dims[0] = (array_length(global._stage_layout[0][0])*global._lode_tilesize)+_editor_dispoffset[0];
				_editor_dims[0] = global._stage_dims[0];
				_editor_dims_tiles[0] = array_length(global._stage_layout[0][0]);
			}
			if(update_which[1]){
				global._stage_dims[1] = (array_length(global._stage_layout[0])*global._lode_tilesize)+_editor_dispoffset[1];
				_editor_dims[1] = global._stage_dims[1];
				_editor_dims_tiles[1] = array_length(global._stage_layout[0]);
			}
		} else {
			_editor_dims = [(_editor_dims_tiles[0]*global._lode_tilesize)+_editor_dispoffset[0],(_editor_dims_tiles[1]*global._lode_tilesize)+_editor_dispoffset[1]];
		}
	}
	
	function delete_objects(){
		with(all){
			if(variable_instance_exists(self.id,"_lode_object")){
				instance_destroy();
			}
		}
		_depthsort_timer = 99;
	}

	function place_objects() {
		for(var zz = 0; zz < array_length(global._stage_layout); zz++){
			for(var yy = 0; yy < _editor_dims_tiles[1]; yy++){
				for(var xx = 0; xx < _editor_dims_tiles[0]; xx++){
					var tile = global._stage_layout[zz][yy][xx];
					if(ds_map_exists(_tileinfo, tile)){
						if(!global._lode_editor){
							if(tile == LTILE_COL){
								global._lode_collect_max ++;
							}
						}
						if(_tileinfo[? tile].obj != -1){
							var inst = instance_create_depth(_editor_dispoffset[0]+xx*global._lode_tilesize,_editor_dispoffset[1]+yy*global._lode_tilesize,-1,_tileinfo[? tile].obj);
							if(_tileinfo[? tile].project){
								var idadd = "";
								random_set_seed(xx+yy);
								for(var i = 0; i < 8; i++){
									idadd += string(irandom(64));
								}
								randomize();
								inst._id = string(xx)+string(yy)+object_get_name(_tileinfo[? tile].obj)+idadd;
							} else {
								inst._curtile = tile;
							}
						
							if(inst._tilelayer == -1){
								inst._tilelayer = zz;
							}
						
							inst._tilepos = [yy,xx];
						}
					}
				}
			}	
		}
	}
}