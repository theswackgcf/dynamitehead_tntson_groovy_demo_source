{
	visible = false;
	
	_codename = "dh";
	
	_speed = 1;
	_freeze = 0;
	
	_init = false;
	
	_allsounds = ds_map_create();
	_allsoundstimer = 0;
	
	_idleguitimer = 0;
	_idleguithreshold = 30;
	
	//sfx
	_sfx = ds_map_create();
	_sfx[? snd_tnt_pull] = false;
	_sfx[? snd_tnt_push] = false;
	_sfx[? snd_money2] = false;
	
	_deffloortype = "dirt";
	_floortype = _deffloortype;
	
	_begin = false;
	_beginact = 0;
	_begintimer = 0;
	_beginspd = 0;
	_beginstar = false;
	
	_pickup = false;
	_lastpickuphprestore = 0;
	
	_moneypickup = false;
	_moneypickup_inst = noone;
	
	_hptimer = 0;
	_maxhp = 60;
	_hp = _maxhp;
	_hplastframe = _hp;
	_displayhp = _hp;
	
	_lowhp = false;
	
	_startx = x;
	_starty = y;
	
	_initspeed = 9;
	totalspd = [0,0];
	_spd = [0,0];
	_maxspd = [0,0];
	_float = [0,0];
	_preservespd = 0;
	_stopspd = false;
	_accel = 1;
	_decel = 0;
	_diagspeed = 0;
	
	_jump = false;
	_jump_enmhit = false;
	_nojump = 0;
	_nojump_end = false;
	_rolljump = false;
	_roll_bounceoff = 0;
	
	_height = 0;
	_vspd = 0;
	_vaccel = 0;
	
	_stopwalk = 0;
	
	_groundlevel = 0;
	_mingroundko = 140;
	
	_walking = false;
	
	_walltouch = [0,0];
	_slidetouch = 0;
	
	_slide_cooldown = 0;
	
	_koenemy = noone;
	
	_state = "begin";
	_prevstate = _state;
	
	_fastcrouch = 0;
	
	_candospecial = true;
	
	_mashtime = 0;
	_mashact = 0;
	_mashattack = 0;
	_mashko = false;
	_mashenemy = 0;
	_mashobj = noone;
	_mashfreeze = false;
	_mashpress = false;
	_mashsuccess = false;
	_mashpenalty = 0;
	_mashpenalty_max = 3;
	
	_mashsounds = [
		[snd_mashbg, 0, false, 0], //snd_index frame occured snd_to_stop
		[snd_mashko_swing, 21, false, snd_mashbg],
		[snd_mashko, 23, false, snd_mashko_swing],
	];
	_mashparticle = [
		["mash", 0, 10, false], //particle image_angle frame occured
		["mash", 45, 14, false],
	];
	
	_forcemash = false;
	_forcetnt = false;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_dh_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_dh_hurtbox);
	_hitobj._parentobj = self.id;
	
	//create occupy zone
	_zoneobj_l = instance_create_depth(x, y, 0, obj_dh_occupyzone);
	_zoneobj_l._parentobj = self.id;
	_zoneobj_l._type = "l";
	
	_zoneobj_r = instance_create_depth(x, y, 0, obj_dh_occupyzone);
	_zoneobj_r._parentobj = self.id;
	_zoneobj_r._type = "r";
	
	_occupied_zone = [-1,-1];
	_occupdist = 180;
	
	_occupycenter = 0;
	
	instance_create_depth(0, 0, 0, obj_enemyzone);
	
	_anim = "idle";
	
	_curdir = DIR_R;
	_curdir_prev = _curdir;
	_tempdir = _curdir;
	
	_anim_transition = false;
	_anim_tr_init = false;
	_anim_tr_anim = "";
	_anim_prev = "";
	
	_animloop = ds_map_create();
	
	_animloop[? "tnt"] = 0;
	_animloop[? "dead"] = 2;
	_animloop[? "standup"] = 2;
	_animloop[? "dive"] = 3;
	_animloop[? "taunt"] = 3;
	_animloop[? "tauntside"] = 3;
	_animloop[? "tauntdown"] = 5;
	_animloop[? "tauntup"] = 6;
	_animloop[? "tauntmoney"] = 4;
	_animloop[? "finalko"] = 2;
	
	_dispoffset = [0,0];
	
	_bigpunch_amp = 0;
	_punch_lerpx = x;
	
	//crouch / sliding
	_crouch = false;
	_slide = false;
	_runslide = false;
	_slidespd = 0;
	_slidetimer = 0;
	_slidedecel = 1;
	_slidedecel_max = 2.5;
	_slide_sfx = false;
	_slide_collidewall = false;
	_noslidecd = 0;
	
	//melee attacks
	_attack = false;
	_attacktype = "";
	_attackcooldown = 0;
	_attackvar = 0;
	_attackhb = false;
	_upper = false;
	_doublekick = false;
	_downattack = 0;
	
	//doublekick checks
	//r
	_doublekickcheck[0][0] = [80, -64];
	_doublekickcheck[0][1] = [256, 64];
	
	//l
	_doublekickcheck[1][0] = [-80, -64];
	_doublekickcheck[1][1] = [-256, 64];
	
	_doublekickbools[0] = false;
	_doublekickbools[1] = false;
	
	//melee attacks continue
	_onecombo = 0;
	_onecombocd = 0;
	_ocombotimer = 0;
	_finalcombo = false;
	
	_hurtTimer = 0;
	_damageTimer = 0;
	_damage = 0;
	_noAtkTimer = 0;
	_hurtbox = noone;
	_push = false;
	
	_combo = 0;
	_combotimer = 0;
	_combomax = 4;
	
	_dmgcoold = 0;
	
	_punchtimer = 0;
	_atk_timer = 0;
	_hits = 0;
	_totalhits = 0;
	_hittimer = 0;
	
	_falling = false;
	_falls = 0;
	_dead = false;
	_deadtimer = 0;
	_jumpback = false;
	
	_jumpjuice = 0;
	_maxjumpjuice = 14;
	_jumpreach = 0;
	
	_occupied = [noone, noone];
	_itemanim = 0;
	_iteminst = noone;
	
	//delete later
	_grabid = noone;
	
	_grab = false;
	_enemygrab = false;
	_grabinst = noone;
	_grabtimer = 0;
	_grabcooldown = 0;
	_grabdist = 240;
	_grabdown = false;
	
	_grabweight = 1;
	
	_grabfail = false;
	_grabfailact = 0;
	_grabfailtime = 0;
	_grabfailshake = false;
	
	_graboffset = [[
		//grabstart
		[200,0],[180,0],[60,0],[60,0],[60,0],
	],[
		//idle
		[0,0],[12,8],[12,8],[12,12],[12,12],[6,4],[6,4],[0,0],[-4,-12],[-4,-12],[0,0],[0,0],
	],[
		//walk
		[0,0],[0,-10],[0,-12],[0,-12],[0,-8],[0,-8],[0,12],[0,0],[0,-10],[0,-12],[0,-12],[0,-8],[0,-8],[0,12],
	],[
		//grab fail
		[0,-96],[0,-96],[0,-96],[0,-96],[0,-96],[0,-96],[0,0],[0,200],[0,200],[0,200],[0,200],[0,200],[0,200],[0,200],[0,200],[0,200],[0,200]
	],[
		//slam
		[234,54],[234,54],[234,40],[234,40],[197,-263],[0,-303],[-18,-304],[-18,-304],[-28,-304],[-28,-304],[-28,-304],[-235,64],[-235,64],[-235,40],[-235,40],[-198,-263],[0,-304],[17,-304],[17,-304],[27,-304],[27,-304],[27,-304]
	],[
		//grabdown
		[0,96],[0,96],[0,96],[0,96],[0,-260],[0,-300],[0,-290],
	]];
	
	_graboffsetsimple = [];
	
	_slam = false;
	_slamdir = DIR_R;
	_slam_init = false;
	_slamcooldown = 0;
	_slamcount = 0;
	_slamsounds = [
		[[snd_slambong1,snd_slambong2,snd_slambong3,snd_slambong4,snd_slambong5,snd_slambong6,snd_slambong7], "slam", 1, false, DIR_R],	//index, type, frame, occured, dir
		[[snd_slamswish1,snd_slamswish2,snd_slamswish3], "", 4, false, DIR_R],
		[[snd_slambong1,snd_slambong2,snd_slambong3,snd_slambong4,snd_slambong5,snd_slambong6,snd_slambong7], "slam", 12, false, DIR_L],
		[[snd_slamswish1,snd_slamswish2,snd_slamswish3], "", 15, false, DIR_L]
	];
	_slamspd = 1;
	_canslam = true;
	
	_throw = false;
	
	_blowup = false;
	_blowuptimer = 0;
	_explosiontimer = 0;
	_blowupexpl = false;
	_blowup_countperfect = 0;
	_blowup_err = 0;
	_blowup_errmax = 120;
	
	global._blowup_kill = 0;
	
	//shield and parrying
	_shield = false;
	_shieldpower = 1;
	_shieldgain = [-0.0022,0.0018];
	_shieldcd = 0;
	
	_parrytimer = 0;
	_maxparry = 9;
	_parryenmx = -999;
	
	_successparry = 0;
	
	_parryzoom = global._defCamZoom;
	
	_parryframe = 0;
	_parryframe_max = sprite_get_info(asset_get_index("spr_"+_codename+"_parry")).num_subimages;
	
	_parryspot = false;
	
	//stunlocked
	_stunnedtimer = 0;
	_shakeoff = false;
	_minstun = 50;
	_maxstun = 200;
	
	_wintimer = 0;
	_firstindex = false;
	_star = false;
	_winanim = false;
	_winzoom = 1;
	
	//running
	_running = false;
	_runkeys = [];
	_runs = 0;
	_runtimer = 0;
	_rundist = 0;
	_skidtimer = 0;
	_runparticle = 0;
	_skidparticle = 0;
	_skidsound = false;
	
	_blowupenmmax = 0;
	_blowupenm = 0;
	
	//run roll
	_runroll = false;
	_rollspd = 0;
	_runroll_bump = false;
	_runroll_dive = false;
	_runroll_slide = false;
	
	//arrays
	_collidesolid = [];
	
	_shockwave = 0;
	_zaptime = 0;
	
	_doWin = false;
	_winvoice = false;
	_wintimeroffset = 0;
	
	_idletimer = 0;
	_idleanim = [false,false];
	_idles = 0;
	
	_taunt = false;
	_taunt_type = "";
	_tauntloops = 0;
	
	_invmax = 160;
	_invframe = 0;
	_invalpha = 1;
	
	_prompts = instance_create_depth(x,y,0,obj_dh_prompts);
	_prompts._parentobj = self;
	
	_showlight = false;
	_lightsource = noone;
	_light_scalex = 1.4;
	
	_phasehit = 0;
	_phasehit_anim = "";
	_phasehit_frame = 0;
	_kickass_obj = noone;
	
	_input_keypress = [];
	_input_keyrelease = [];
	_buffertimer_press = 0;
	_buffertimer_release = 0;
	
	_buffer_deletepress = "";
	_buffer_deleterelease = "";
	
	_checkallkills = false;
	
	function setinput() {
		_inptype = global._inptype; //inptype is the input method (keyboard, gamepad)
		_input = [ds_map_create(),ds_map_create()];
		_tempinputs = ["left","right","up","down", "jump", "punch", "tnt", "crouch", "slide", "grab", "shield", "taunt"];
		for(var j = 0; j < array_length(global._input); j++){
			for(var i = 0; i < array_length(_tempinputs); i++){
				if(is_string(global._input[j][? _tempinputs[i]])){
					_input[j][? _tempinputs[i]] = global._input[j][? _tempinputs[i]];
				} else {
					_input[j][? _tempinputs[i]] = floor(global._input[j][? _tempinputs[i]]); //"floor" this is dumb
				}
			}
		}
	}
	
	//this is here so the function is easier to type out
	function keyhold(key){
		if(check_key(_input[_inptype][? key], _inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keypress(key){
		if(check_keypress(_input[_inptype][? key], _inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	function keyrelease(key){
		if(check_keyrelease(_input[_inptype][? key], _inptype)){
			return true;
		} else {
			return false;
		}
	}
	
	//buffered inputs
	function buffercheck_press(key){
		if(array_length(_input_keypress) == 0){
			return false;
		} else {
			if(_input_keypress[array_length(_input_keypress)-1] == key){
				_buffer_deletepress = key;
				return true;
			} else {
				return false;
			}
		}
	}
	function buffercheck_release(key){
		if(array_length(_input_keyrelease) == 0){
			return false;
		} else {
			if(_input_keyrelease[array_length(_input_keyrelease)-1] == key){
				_buffer_deleterelease = key;
				return true;
			} else {
				return false;
			}
		}
	}
	
	function throw_enemy(){
		//throwing enemies
		if(_slam){
			_curdir = _tempdir;
			global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]];
		}
		
		_slam = false;
		_displayobj.image_speed = 1;
		_slam_init = false;
		
		if(instance_exists(_grabinst)){
			if(variable_instance_exists(_grabinst, "_grabbed")){
				_grabinst._dh = noone;
				_grabinst._height += 190;
				_grabinst._vspd = 16;
				_grabinst._tempdir = _curdir;
				_grabinst._slam = false;
					
				_grabinst._falling = true;
				_grabinst._fall_ko = false;
				_grabinst._falls = 0;
					
				_grabinst._jump = true;
				_grabinst._grabfall = true;
				_grabinst._stunlock_timer = _grabinst._stunlock_formula;
				_grabinst._stunlock_hits += 1;
							
				_grabinst._grabstart = false;
				_grabinst._grabbed = false;
				_grabinst._curstate = STATE_FALL;
				_grabinst._fixwall = true;
				_grabinst._dmgoffset = [0,0];
						
				if(_grabinst._hp > 0){
					_grabinst._deathoffset = [0,0];
				}
						
				with(_grabinst){
					do_grid_collisions();
				}
			}
		}
		
		_grabinst = noone;
		_enemygrab = false;
		_throw = true;
							
		sfx_play_choose(global._swishsounds[2]);
	}

	function force_throw_enemy(){
		_throw = false;
		
		_slam = false;
		_displayobj.image_speed = 1;
		_slam_init = false;
		
		if(instance_exists(_grabinst)){
			if(variable_instance_exists(_grabinst, "_grabbed")){
				if(_grabinst._dh != noone){
					_grabinst._dh = noone;
				}
			
				if(!_grabinst._phasehit_slam){
					if(!_grabinst._grabdodge){
						_grabinst._height += 190;
						_grabinst._vspd = 8;
					} else {
						/*_grabinst.x = _grabinst._storebgrab[0];
						_grabinst.y = _grabinst._storebgrab[1];
						_grabinst._grabDrawX = _grabinst.x;
						_grabinst._grabDrawY = _grabinst.y;*/
			
						_grabinst._height += 8;
						_grabinst._vspd = 16;
					}
				}
			
				_grabinst._tempdir = _curdir;
				_grabinst._slam = false;
			
				_grabinst._grabout = true;
		
				_grabinst._falling = true;
				_grabinst._fall_ko = false;
				_grabinst._jump = true;
				_grabinst._falls = 0;
							
				_grabinst._grabbed = false;
				_grabinst._grabstart = false;
		
				_grabinst._curstate = STATE_FALL;
		
				_grabinst._fixwall = true;
				_grabinst._dmgoffset = [0,0];
							
				with(_grabinst){
					do_grid_collisions();
				}
			}
		}
		
		_grabinst = noone;
							
		_enemygrab = false;
	}
}