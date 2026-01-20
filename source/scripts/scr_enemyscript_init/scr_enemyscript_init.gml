function scr_enemyscript_init(type){
	if(type == "create"){
		_allsounds = ds_map_create();
		_allsoundstimer = 0;
		
		_mousedrag = false;
		_dragoffset = [0,0];
	
		_nameoverwrite = "";
	
		_init = false;
		_startTimer = 0;
		_sintimer = random(1000);
		
		_matchid = 0;
		
		_inactive = false;
		
		_nocrouchatk = false;
		
		_glass = false;
		
		_spawndir = "r";
		_spawnpos = [0,0];
		_offscreenpos = [0,0];
		
		_spawnedfromobject = false;
		_spawncutscene = false;
		
		_sequence = noone;
		_sequence_finished = true;
		_seq_yscale = 1;
		_sequence_act = 0;
		_sequence_id = 0;
		_sequence_obj = noone;
		_sequence_hop_obj = noone;
		_nohopobj = true;
		
		_seqhop_archeight = 870;
		_seqhop_spd = 0.04;
		
		_seq_forcehop = false;
		
		_seq_forcedepth = -1;
	
		_deleteid = 0;
	
		_hp = _maxhp;
		_storehp = _hp;
		_displayhp = _hp;
		_hplastframe = _hp;
		_showDmg = true;
		_dmgmultiplier = 1;
		
		_althp = false;
	
		_idiot = false;
		
		//boss enemy variables
		_start_setdir = false;
		_boss = false;
		_boss_active = true;
		_phase = 0;
		_finalhit = false;
		_flyout = false;
		_mashlosehp = 7;
		_tntlosehp = 16;
		_specialatk = 0;
		_aftermash = 0;
		
		_phaseend_act = 0;
		_phaseend_time = 0;
		_slideoffspd = 0;
		_phaseend_bounceval = 0;
		_phaseend_voice = false;
		_phaseend_voice_gain = 1;
		
		_boss_easeout = 0;
		_boss_easeout_prev = _boss_easeout;
		_boss_easeout_timer = 0;
		_ease_kd = 0;
		_ease_kd_timer = 0;
		_ease_kd_max = 1500;
	
		//set occupy id
		_occupy_id = "";
		_letr = global._occupyCharset;
		for(var i = 0; i < 7; i++){
			_occupy_id += string_char_at(_letr, round(random_range(1, string_length(_letr))));
		}
		
		_seqid = _codename+_occupy_id;
	
		_fallabove = false;
	
		_inview = false;
	
		//start fade
		_startFade = false;
		_fadeInit = false;
		_doFade = false;
		_fadeCol = [255,255,255];
		_fadeTo = [255,255,255];
	
		//pathfinding
		_initcol = false;
	
		_pathgridsize = [ceil(sprite_width/12),ceil(sprite_height/12)];
		_areasize = [WIDTH,HEIGHT];
		_defarea = [0,0,0,0];
		_pathgridarea = [0,0,0,0];
		_pathgrid = 0;
		
		_storeareapos = [x,y];
	
		_path = 0;
		
		_pathpoint = [x,y];
		_pointtime = 0;
	
		//movement
		_speed = 1;
	
		_standtimer = 0;
		_idletimer = 0;
		_movetimer = 0;
		_walktimer = 0;
		_badidletimer = 0;
		_posprev = [x,y];
	
		_movespd = ds_map_create();
		
		_movespd[? SPD_WALK] = 0;
		_movespd[? SPD_BACK] = 0;
		_movespd[? SPD_PANIC] = 0;
		_movespd[? SPD_FALL] = 0;
		_movespd[? SPD_GRABFALL] = 0;
		
		_spdmult = 1;
		_spdmult_timer = 0;
		
		_walkto = [x,y];
		_multdist = 1;
		
		_walksuccess = false;
		_walktopos = [x,y];
	
		_fixwall = false;
	
		_curspd = [0,0];
		_realspd = [0,0];
		
		_curdir = DIR_R;
		_curdir_prev = _curdir;
		
		_curdir_v = DIR_U;
		
		_tempdir = _curdir;
	
		_vdir = DIR_U;
		_vdir_prev = _vdir;
		
		_freedir = DIR_R;
		_freedir_v = DIR_U;
		
		_mashdir = DIR_R;
	
		_curstate = STATE_IDLE;
		_behaviortype = "";
		_state_cooldown = 0;
		
		_randoffset = [0,0];
		
		_freespd = false;
		
		_init_fallxspd = 0;
		_fallxspd = 0;
		_fallyspd = 0;
		
		random_set_seed(x+y);
		_fallxspd_offset = random_range(-1.6,1.2);
		randomise();
		
		_floatx = 0;
		_floaty = 0;
		_walltouch = 0;
		_walltouch_y = 0;
		
		_boundwall = {
			left: 0,
			right: 0,
			up: 0,
			down: 0,
		};
		
		_wallbonks = 0;
		
		_dmgcoold = 0;
		_dmgoffset = [0,0];
	
		_deffloortype = "dirt";
		_floortype = _deffloortype;
	
		//vertical
		_height = 0;
		_heightoffset = 0;
		_vspd = 0;
		_groundlevel = 0;
		_jump = false;
		_falling = false;
		_falls = 0;
		_fall_ko = false;
		_fallcd = 0;
		_addfallspd = 0;
		
		_parachute = false;
		_fallfloat = false;
		
		_kickeddown = false;
		
		random_set_seed(x+y);
		_fallfloat_spd = random_range(-4,-7);
		randomise();
		
		_fallfloat_offset = 0;
		
		_dmgfall = false;
		
		_jumptopos = [x,y];
		_jumpingdist = [500,260];
		_jumpingtimer = 0;
		
		_hop_arcstart = false;
		_hop_startpos = [x,y];
		_hop_base_y = y;
		_hop_time = 0;
		_hop_archeight_def = 950;
		_hop_archeight = _hop_archeight_def;
		_hop_spd_def = 0.03;
		_hop_spd = _hop_spd_def;
		_hop_arc = 0;
		_prev_hop_arc = 0;
		_hop_snd = false;
		
		_hop_quiet = 0;
		_hop_cooldownthing = 0;
		
		_hop_walk = false;
		_hop_walkspeed = 0;
		
		_dohop = false;
		_do_walk_hop = true;
		
		_afterhop = 0;
		
		_jumphit = [];
		
		_show_hits = false;
		_apply_hits = false;
		_ko_cooldown = 0;
		_ko_fall = false;
		
		_mashed = false;
		_mashedobj = noone;
		_mashedtimer = 0;
		_mashfling_spd = 0;
	
		_kotimer = 0;
		_standup = false;
	
		_death = false;
		_despawndeath = false;
		_slidepoints = 10;
		_nomovetime = 0;
		_deathoffset = [0,0];
		_downkill = false;
		_confirmkill = false;
		
		_forcedeath = false;
		
		_failsafedeath = 0;
		
		_spin = false;
		
		_skullnum = 1;
	
		_mashact = 0;
	
		//grab
		_grab_startpos = [0,0];
		_grab_lerppos = [0,0];
	
		_grabtr = false;
		_grabtr_offset = 0;
		_grabstart = false;
		_graboffset = [0,0];
		_grabbed = false;
		
		_grabDrawX = x;
		_grabDrawY = y;
		
		_storebgrab = [x,y];
		
		_grabresist = 0;
		_grabresist_curtimer = 0;
		_grabresist_timer = 200;
		_jumpoff_snd = false;
		
		_grabdodge = false;
		
		_grabhp = true;
		
		_slam = false;
		_phasehit_slam = false;
	
		_grabfall = false;
		_grabout = false;
	
		//collision
		_collide_solid = [];
		_collide_other = [];
		_collide_hurtbox = [];
		_collide_enemy = [];
		
		_checkenmcol = false;
		_checksolidcol = false;
	
		_followgridtimer = 0;
	
		//display
		visible = false;
		_haveshadow = true;
		_shadowsize = global._defShadowSize;
		_dispoffset = [0,0];
		_dispscale = [1,1];
		_drawifmoving = 0;
		_dispangle = 0;
		
		_shadowoffset = [0,0];
		
		_holdframe = [sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha];
		_holdframetimer = 0;
	
		//after image
		_afterim_active = 0;
		_afterim_timer = 0;
	
		//animation
		_anim = "idle";
		_animspeed = 1;
		_walk_animspeed = 0;
		
		_force_animspeed = 0;
		_force_animspeed_timer = 0;
		
		_anim_transition = false;
		_anim_tr_init = false;
		_anim_tr_anim = "";
		_anim_prev = "idle";
		
		_animloop = ds_map_create();
		
		_animloop[? "block"] = 0;
		_animloop[? "dead"] = 2;
		_animloop[? "dead_stun"] = 2;
		_animloop[? "standup"] = 2;
		_animloop[? "standup_stun"] = 2;
		_animloop[? "slide"] = 0;

		_setframe = false;

		_draw_display = true;

		//sounds
		_didtauntsound = false;
		_didnoticesound = false;
		_dostepsound = false;

		//interaction
		_dh = noone;
		_interest = 0;
		
		_panictimer = 0;
		_panicdist = 640;
		_panicspot = [x,y];
	
		_dh_atk = 0;
		_dh_atk_inst = noone;
		_dh_atk_dir = DIR_R;
		
		_dh_atk_taunt = 0;
		_dh_atk_taunt_inst = noone;
	
		_available = [false,false];
		
		_forceattack = 0;
		
		_atkallowed = [ATK_NORM,ATK_KO];
		_typeallowed = [];
		
		_didspot = false;
		_spottimer = 0;
		_spotwalk = false;
		
		_backoff = 0;
		_backofftime = 0;
		_backoffsound = true;
		
		_stuntimer = 0;
		_stunpunch = 0;
		_stun = false;
		_stunact = 0;
		_stunanim = false;
		_stunrange = [120,200];
		
		_slide = false;
		_slidetimer = 0;
		_slideact = 0;
		_slidedist = 560;
		_slidespd = 0;
		_slidespd_max = 25;
		_slidedecel_max = 0.16;
		_slidedir = 0;
		_slide_lookatdh = 0;
		_hopslide = false;
		_slidedecel = 0.1;
	
		//attack
		_attack = false;
		_attacktype = "";
		_atktimer = 0;
		_curatk = 0;
		_curatktimer = 0;
		_attackdist = 24;
		
		_nockatk = 0;
		_nockanim = "";
		_nockframe = 0;
		
		_breakpower = 0.32; //dh shield break power
		_successparry = 0;
		_parryframe = 0;
		
		_atkdelay = {
			meleeko: 0,
			blockko: 0
		};
		_atkhitb = {
			blockko: []
		};
		
		_attackhb = false;
	
		_did_ko = 0;
		_didko_timer = 0;
		_taunt = 0;
		_taunttime = 60;
		
		_jabstop = 0;
	
		_kotype = "";
		
		//block
		_blockcount = 0;
		_maxblockcount = 4;
		_blockcd = 0;
		_block = false;
		_blocktimer = 0;
		_block_endzones = [];
		_mashblock = 0;
		_blockfailcooldown = 0;
		
		_blockko_fx = false;
	
		//tnt quake
		_shockwave = false;
		_tntko = false;
		
		_scrclear = false;
		_scrcleartimer = 0;
		_scrclearend = false;
		_scrclear_happened = false;

		//getting damage / ko
		_hurttimer = 0;
		_dodgetimer = 0;
		_dodgezones = ["idle"];
		_blockroll = false;
		_downhurt = 0;
		
		_stunlock_hits = 0;
		_stunlock_hits_max = 3;
		_stunlock_timer = 0;
		_stunlock_formula = 0;
		
		_stunlock_dodge = false;
		_stunlock_after = 0;
		
		_stunlock_pose = 1;
		_stunlock_pose_max = 3;
		
		_freeze = 0;
		_hurtanim = 1;
		_mashhurt = 0;
		
		_mashhurt_max = 0;
		if(sprite_exists(asset_get_index("spr_"+_codename+"_mashhurt"))){
			_mashhurt_max = sprite_get_info(asset_get_index("spr_"+_codename+"_mashhurt")).num_subimages;
		}
		_mashhurt_pool = [];
	
		_hitadd = 0;
		_hitadd_time = 0;
	
		_hurt_combotime = 0;
		_hurts = 0;

		_battlezone = false;
		_bzstart = 0;
		_bzstart_offset = [0,0];
		_bzobj = noone;

		//enemy specific
		_enemytraits = [TRAIT_GRAB, TRAIT_SLAM, TRAIT_HURT, TRAIT_HP, TRAIT_JABS, TRAIT_MASHED, TRAIT_PISSEDOFF];
		
		_ailevel = 0;
		_aimode = 0;
		_forceai = -1;
		
		_ailevel_mult = 1;
		_pissedoff = 0;
		_pissedoff_int = -1;
		_pissedoff_offset = [-80, -145];
		_pissedoff_icontimer = 0;
		_pissedoff_hit = [1.7,2.5,3];
		
		_total_ailevel = 0;
		
		_koframe = 0;
	
		_grabweight = 1;
		
		_fatalko = false;
	
		_walkdist = [410, 370];
		_noticedist = 820;
		_dhdist = [_walkdist[0]/3,_walkdist[1]/3];
	
		_hpcolor = make_color_rgb(255, 0, 0);
	
		_voiceinit = false;
		_playvoice = {
			death: -1,
			flyout: -1,
			atk: -1,
			headshake: snd_headshake,
			slam: -1,
		};
		
		_voiceonce = false;
		_voicetimer = 0;
		
		_slampitch = [0.85,1.12];
	
		_meleeanims = 2;
		_hurtanims = 2;
	
		_shakeamp = 24;
		
		_docrouchkick = false;
		_crouchkicktime = 0;
		_crouchkicktime_max = 16;
		_ckick_cd = 0;
	
		_alt_attack = false;
	
		//create grab zone object
		_gzone = instance_create_depth(x, y, 0, obj_en_grabzone);
		_gzone._parentobj = self.id;
		_gzone.image_xscale = 5;
		_gzone.image_yscale = 2;
		_gzone._offset = [0,-10];
	
		_rep = "";
		_colorsinit = false;
		_difftype = false;
		_recolorstop = false;
		_docolors = false;
	
		//colors
		_maxcolors = global._maxcolors[? "dh"];
		
		_mult_colorinArray = [];
		_mult_coloroutArray = [];
		_mult_tolrArray = [];
		_mult_blendArray = [];
	
		_debugclick = false;
		_debugwalk = [x,y];
	
		_atk_timer = 0;
		_hits = 0;
		_hittimer = 0;
		
		//functions
		function randomspd() {
			var keys = ds_map_keys_to_array(_movespd);
			for(var i = 0; i < array_length(keys); i++){
				_movespd[? keys[i]] += random_range(-0.35,0.35);
				_movespd[? keys[i]] = clamp(_movespd[? keys[i]], 0.1, 255);
			}
			_hop_walkspeed = _movespd[? SPD_WALK];
		}
		
		function do_grid_collisions(){
			mp_grid_clear_all(_pathgrid);
			//add solids
			for(var i = 0; i < array_length(_collide_solid); i++){
				for(var j = 0; j < instance_number(_collide_solid[i]); j++){
					var inst = instance_find(_collide_solid[i], j);
					if(inst._collidewith == "all" || inst._collidewith == "enemy"){
						mp_grid_add_instances(_pathgrid, inst, false);
					}
				}
			}
				
			//add enemies
			/*for(var i = 0; i < array_length(_collide_enemy); i++){
				for(var j = 0; j < instance_number(_collide_enemy[i]); j++){
					var inst = instance_find(_collide_enemy[i], j);
					if(inst.id != self.id){
						mp_grid_add_instances(_pathgrid, inst, false);
					}
				}
			}*/     //garbajo
			
			//add direction collisions
			for(var i = 0; i < array_length(_collide_other); i++){
				for(var j = 0; j < instance_number(_collide_other[i]); j++){
					var inst = instance_find(_collide_other[i], j);
					if(inst._collidewith == "all" || inst._collidewith == "enemy"){
						switch(inst.object_index){
							case obj_battleborder:
								//only add battle border if direction aligns
								if(
								(inst._side == "l" && _realspd[0] >= 0) ||
								(inst._side == "r" && _realspd[0] <= 0) ||
								(inst._side == "u" && _realspd[1] >= 0) ||
								(inst._side == "d" && _realspd[1] <= 0)
								){
									mp_grid_add_instances(_pathgrid, inst, false);
								}
							break;
							
							//same here but for separate objects
							case obj_collideleft:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] >= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_collideright:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] <= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_collideup:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[1] >= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_collidedown:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[1] <= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_collideleftup:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] >= 0 && _realspd[1] >= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_collideleftdown:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] >= 0 && _realspd[1] <= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_colliderightup:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] <= 0 && _realspd[1] >= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
							case obj_colliderightdown:
								var ignore = false;
								if(_curstate == STATE_FOLLOW && place_meeting(x,y,inst)){
									ignore = inst._ignorefollow;
								}
								if(!ignore){
									if(_realspd[0] <= 0 && _realspd[1] <= 0){
										mp_grid_add_instances(_pathgrid, inst, false);
									}
								}
							break;
						}
					}
				}
			}
			
			//other
			var collide_special = [obj_slidespot];
			for(var i = 0; i < array_length(collide_special); i++){
				for(var j = 0; j < instance_number(collide_special[i]); j++){
					var inst = instance_find(collide_special[i], j);
					if(inst._collidewith == "all" || inst._collidewith == "enemy"){
						mp_grid_add_instances(_pathgrid, inst, false);
					}
				}
			}
		}
	
		function clearpath(){
			if(_path != 0){
				path_delete(_path);
				_path = 0;
				_pathtimer = 0;
			}
		}
	
		function check_occupy(){
			var dh = instance_nearest(x, y, obj_dh_mask);
		
			//empty from left
			if(dh._occupied_zone[0] == -1 || dh._occupied_zone[0] == _occupy_id){
				_available[0] = true;
			} else {
				_available[0] = false;
			}
		
			//empty from right
			if(dh._occupied_zone[1] == -1 || dh._occupied_zone[1] == _occupy_id){
				_available[1] = true;
			} else {
				_available[1] = false;
			}
		}
	
		function do_ko(setspd = 16){
			if(_hop_arc < 0){
				_height = -_hop_arc;
				_hop_arc = 0;
			}
			_hurttimer = 0;
			_jump = true;
			if(_dh_atk > 0 && _dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
				if(!_falling){
					_tempdir = _dh_atk_dir;
				}
				_dh_atk = 0;
			}
			
			_falling = true;
			_fall_ko = false;
			_standup = false;
			
			_fixwall = true;
			_falls = 0;
			_height += 4;
			
			_vspd = setspd;
			_dmgcoold = 0;
		}
		
		function doslide() {
			if(!(place_meeting_array(x-48, y, _collide_solid) && place_meeting_array(x+48, y, _collide_solid))){
				if(place_meeting_array(x-48, y, _collide_solid) && _curdir == DIR_L){
					_curdir = DIR_R;
				} else if(place_meeting_array(x+48, y, _collide_solid) && _curdir == DIR_R){
					_curdir = DIR_L;
				}
										
				_displayobj.image_index = 0;
				_anim_tr_anim = "crouch_in";
				_anim_tr_init = false;
				_anim_transition = true;
										
				_slide = true;
				_slidetimer = 0;
				_slideact = 0;
				
				_slide_lookatdh = 60;
			}
		}
	
		function tntko_kill() {
			if(!variable_instance_exists(self.id, "_object")){
				//real enemy
				if(variable_instance_exists(self.id, "_tntko")){
					if(!_tntko){
						_tntko = true;
						with(obj_fade){
							_fadeTo = 0;
							_fadeSpd = 0.04;
						}
						with(obj_dh_mask){
							_blowup_err = 0;
							_blowupenm ++;
						}
						_kotype = "tnt";
						if(!variable_instance_exists(self.id, "_begin")){
							if(_phaseend_act == 0){
								_curspd = [0,0];
								_vspd = 16;
								_jump = true;
								_falldir = choose(DIR_L,DIR_R);
								_falling = true;
								_fixwall = true;
							}
							if(!_boss){
								_hp = 0;
								_voicetimer = random_range(1, 14);
							} else {
								if(_phaseend_act == 0){
									_hp -= _tntlosehp;
									//play tnt kd voice
								}
							}
						} else {
							if(_begin){
								if(_phaseend_act == 0){
									_curspd = [0,0];
									_vspd = 16;
									_jump = true;
									_falldir = choose(DIR_L,DIR_R);
									_falling = true;
									_fixwall = true;
								}
								if(!_boss){
									_hp = 0;
									_voicetimer = random_range(1, 14);
								} else {
									if(_phaseend_act == 0){
										_hp -= _tntlosehp;
										//play tnt kd voice
									}
								}
							}
						}
					}
				}
			} else {
				//object
				if(variable_instance_exists(self.id, "_tntko")){
					if(!_tntko){
						_tntko = true;
						with(obj_fade){
							_fadeTo = 0;
							_fadeSpd = 0.04;
						}
						with(obj_dh_mask){
							_blowup_err = 0;
							_blowupenm ++;
						}
					}
				}
			}
		}
	
		function killself() {
			instance_destroy(_displayobj);
			instance_destroy(_hitobj);
			instance_destroy(_gzone);
			with(obj_punchhitbox){
				if(self.id == global._deadid){
					instance_destroy();
				}
			}
			global._deletedStuff[? _deleteid] = _deleteid;
			instance_destroy();
		}
	}
	
	if(type == "step"){
		//pathfinding
		_collide_solid = global._solidArray;
		_collide_other = global._solidOtherArray;
		_collide_hurtbox = global._hurtboxArray;
		_collide_enemy = global._enemyArray;

		_areasize = [WIDTH*5.8,HEIGHT*4.2];
		_defarea = [(_areasize[0]/2),(_areasize[1]/2),_areasize[0],_areasize[1]];

		_pathgridarea = [x-_defarea[0],y-_defarea[1],_defarea[2],_defarea[3]];
		if(_battlezone){
			if(place_meeting(x, y, obj_battlezone)){
				var bzone = instance_place(x,y, obj_battlezone);
				if(instance_exists(bzone)){
					var offs = [380,320];
					_areasize = [bzone.sprite_width+offs[0],bzone.sprite_height+offs[1]];
					
					_pathgridarea = [bzone.bbox_left-(offs[0]/2),bzone.bbox_top-(offs[1]/2),_areasize[0],_areasize[1]];
				}
			}
		}
		_pathgrid = mp_grid_create(_pathgridarea[0],_pathgridarea[1],_pathgridarea[2]/_pathgridsize[0],_pathgridarea[3]/_pathgridsize[1],_pathgridsize[0],_pathgridsize[1]);
		global._mpGridCount++;
			
		do_grid_collisions();
			
		_curstate = STATE_WALK;
			
		_aimode = 0;
		var modes = [5,10,15];
		for(var i = 0; i < 3; i++){
			if(_total_ailevel >= modes[i]){
				_aimode ++;
			}
		}
			
		_walktimer = 999;
			
		_init = true;
	}
}