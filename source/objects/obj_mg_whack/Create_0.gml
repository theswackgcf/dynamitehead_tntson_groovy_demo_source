{
	#macro WHACK_ACT_APPEAR 0
	#macro WHACK_ACT_APPEAR_BOSS 1
	#macro WHACK_ACT_PRESENT 2
	#macro WHACK_ACT_BONKED 3
	#macro WHACK_ACT_OUT 4
	
	#macro WHACK_RESTORE_CORN 20
	#macro WHACK_RESTORE_TOMATO 40
	#macro WHACK_RESTORE_CHOCO 12
	
	#macro WHACK_INPUT_MOUSE 0
	#macro WHACK_INPUT_KEY 1
	
	_inptype = WHACK_INPUT_MOUSE;
	_inptype = WHACK_INPUT_MOUSE;
	
	_cursorframe = 0;
	
	_curspot = [2,1];
	_curspot_coords = [0,0];
	
	_allsounds = ds_map_create();
	
	_spots = [
		[false,false,false,false,false],
		[false,true,true,true,false],
		[false,false,false,false,false],
	];
	_spots_scale = [];
	_spots_particle = [];
	
	_enemystate = ds_map_create();
	
	_skyframe = 0;
	
	_enmtimer = 45;
	_enmscale = 0.65;
	
	_firstbonked = false;
	_spawnfirst = false;
	
	_dialm = false;
	
	_bonked = 0;
	_difficulty = 0;
	_diffc_mode = 0;
	_bonkmultipl_start = 0.85;
	_bonkmultipl = _bonkmultipl_start;
	
	_juice = 0;
	_hp = 60;
	
	_hp_max = _hp;
	_juice_max = 100;
	_juice_atk = 30;
	
	_hp_display = _hp;
	_juice_display = _juice;
	
	_hp_ui_amp = [0,0];
	_hp_ui_offs = [0,0];
	
	_juice_ui_amp = [0,0];
	_juice_ui_offs = [0,0];
	
	_hurt_alp = 0;
	
	_fireframe = 0;
	
	_flames_init = false;
	
	_flames_active = false;
	_flames_rows = [];
	_flames_x = [0,0];
	_flames_y = 0;
	_flames_row = 0;
	_flames = ds_map_create();
	_flames_timer = 99;
	_flames_started = false;
	
	_holdc = 0;
	
	_tnt_offset = 0;
	_tnt_amp = 0;
	_tnt_active = false;
	_tnt_active_juice = 0;
	
	_preboss_bonks = 0;
	
	_boss = false;
	_bossphase = 0;
	_boss_bonks = 0;
	_boss_timer = 0;
	_boss_act = 0;
	_boss_shake = false;
	_boss_spot = "2 1";
	_boss_maxhp = 5;
	_boss_hp = _boss_maxhp;
	_boss_itemrefill = 0;
	_boss_itemrefill_timer = 0;
	_boss_itemrefill_force = -1;
	
	_boss_bombtimer = 0;
	_boss_rememberblock = -1;
	
	_thunder_alp = 0;
	
	_bonuscol = make_color_rgb(255, 204, 51);
	
	_bonus_scoremult = 0;
	_bonus_damageless = 0;
	
	_score = 0;
	_score_display = 0;
	_score_string = "";
	
	_score_multiplier = 1;
	
	_score_add = {
		bonk: 15,
		fry: 25,
		item: 50,
		boss_defeat: 500,
	}
	_score_sub = {
		enm_miss: 25,
		bomb_miss: 40,
		dialm_hit: 100,
	}
	
	_monyx = global._minigame_monyx;
	_monyx_string = "";
	
	_lose_score = 0;
	_lose_score_string = "";
	_lose_score_prev = 0;
	
	_score_cd = 0;
	_sndscore = false;
	
	_earned = 0;
	
	_mus_spd = 1;
	_mus_spdup = false;
	
	_gameover = false;
	global._gameover_stopall = false;
	_over_time = 0;
	_over_act = 0;
	_over_exit = false;
	_wait = 0;
	
	_howto = !global._whack_help;
	_howto_intro = false;
	_howto_timer = 0;
	_howto_startval = 24;
	
	_howto_page = 0;
	_howto_length = sprite_get_info(spr_whack_howto_help).num_subimages;
	
	_howto_yspd = 0;
	_howto_offs = 0;
	_howto_scale = 0;
	_howto_alpha = 0;
	_howto_out = false;
	
	_handright_on = 0;
	_handleft_on = 0;
	_closebtn_on = 0;
	
	_howto_showright = true;
	_howto_showleft = true;
	_howto_showclose = true;
	
	_howto_surface = surface_create(WIDTH, HEIGHT);
	
	_howto_text = [
		[
			["Whack these guys:",[0,-156],1.24],
		],
		[
			["Don't whack DIAL-M!",[0,-164],1.24],
		],
		[
			["Snack pickups:",[0,-160],1.24],
			["KOOL KOB/n/g+20HP/w",[-200,155],1.24],
			["TASTY\nTOMATO\n/g+40HP/w",[0,155],1.24],
			["CRAZY\nCHOCO\n/y+12TNT/w",[200,155],1.24],
		],
		[
			["Once enough time has passed,\n/yKOOL KOB/w becomes\n/rTASTY TOMATO/w.",[0,125],1.24],
		],
		[
			["Bonus pickups:",[0,-160],1.24],
			["Grant score and health upgrades.\nAppear when low on HP.",[0,155],1.12],
		],
		[],
	];
	
	_init = false;
	
	function drawscore(str, strx, stry, backwards, color = c_white) {
		var curx = strx;
		var cury = stry;
		var scale = [1,1];
		var curstr = "";
		if(!backwards){
			curstr = str;
		} else {
			for(var i = 0; i < string_length(str); i++){
				curstr = curstr + string_copy(str, string_length(str)-i, 1);
			}
		}
		for(var s = 0; s < string_length(curstr); s++){
			draw_sprite_ext(spr_whack_dispnum, real(string_char_at(curstr, s+1)), curx, cury+(sin(s*0.6)*-10), scale[0], scale[1], 0, color, 1);
			var val = (sprite_get_width(spr_whack_dispnum)-12)*scale[0];
			if(!backwards){
				curx += val;
			} else {
				curx -= val;
			}
			scale[0] -= 0.06;
			scale[1] -= 0.1;
		}
	}
	
	//key functions
	function keyhold(key){
		if(check_key(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keypress(key){
		if(check_keypress(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keyrelease(key){
		if(check_keyrelease(global._input[global._inptype][? key], global._inptype)){
			return true;
		} else {
			return false;
		}
	}
}