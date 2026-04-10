{
	//enemy specific variables
	_name = "Lanky \"HIT IT!\" Larry";
	_codename = "boss2";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 99;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_boss2_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_boss2_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	_begin = false;
	
	_boss = true;
	_phasehp = [_maxhp*0.66,_maxhp*0.28,5];
	
	_attackdist = 0;
	_maxblockcount = 7;
	
	_nockanim = "blockko";
	_nockframe = 5;
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 7;
	_movespd[? SPD_BACK] = 9;
	_movespd[? SPD_PANIC] = 12;
	_movespd[? SPD_FALL] = 0;
	_movespd[? SPD_GRABFALL] = 10;
	_spdmode = SPD_WALK;
	randomspd();
	
	_dostepsound = true;
	
	_meleeanims = 1;
	_hurtanims = 3;
	
	_pissedoff_offset = [-125,-220];
	
	_taunttime = 70;
	
	_mashfling_spd = 12;
	
	array_push(_enemytraits,
	TRAIT_KO, TRAIT_TAUNT,
	TRAIT_BACKOFF, TRAIT_BLOCK,
	TRAIT_STUN,
	TRAIT_BLOCKKO, TRAIT_STUNLOCK_DODGE);
	remove_trait([TRAIT_JABS]);
	
	_block_endzones = ["air","crouch","slide","upper","doublekick"];
	_jumphit = ["upper"];
	
	_playvoice.death = snd_lanky_defeated;
	_playvoice.headshake = -1;
	_playvoice.slam = [snd_lanky_grunt1,snd_lanky_grunt2,snd_lanky_grunt3];
	
	_animloop[? "block"] = 2;
	_animloop[? "hop"] = 2;
	_animloop[? "lightgag"] = 11;
	_animloop[? "spin1"] = 7;
	_animloop[? "dizzy"] = 3;
	_animloop[? "hench1"] = 3;
	_animloop[? "hench2"] = 3;
	_animloop[? "phaseend2"] = 4;
	_animloop[? "phaseend3"] = 1;
	
	_atkdelay.blockko = 6;
	
	_maxcolors = 3;
	
	_hpcolor = [make_color_rgb(242,164,45),make_color_rgb(242,164,45)];

	//enemy specific
	_showlight = 0;
	_lightsource = noone;
	_lightoffset = [0,0];
	_light_scalex = 1.4;
	_light_alpha = 0;
	_lighttimer = 0;
	_dialogue = false;
	_storex = x;
	
	_skid = false;
	
	_phasehit = 0;
	_phasehit_anim = "";
	_phasehit_frame = 0;
	_finalko = false;
	
	_animerrtimer = 0;
	
	_ll_looppoint = 114.42;
	_ll_phaseloopset = false;
	
	_ll_badatk = 0;
	_ll_stuckfix = false;
	
	_ll_yellfix = false;
	_ll_yelltime = 0;
	
	_ll_dizzyfix = false;
	_ll_dizzytime = 0;
	
	_ll_spawndir = DIR_R;
	_ll_spawnleft = [x,y];
	_ll_spawnright = [x,y];
	
	_ll_seqpos = [x,y];
	_ll_spawnpos = [_spawnpos[0],_spawnpos[1]];
	_ll_offscreenpos = [x,y];
	
	_ll_atk_prepare = 0;
	_ll_atk_dusttimer = 0;
	_ll_atk = false;
	_ll_atktimer = 0;
	_ll_atkmin = 20;
	_ll_mashtimer = 0;
	_ll_mashblock = 0;
	
	_ll_taunt = false;
	_ll_tauntamp = 0;
	
	_ll_atknum = 0;
	
	_ll_atk_addtimer = false;
	_ll_atk_timer = 0;
	
	_ll_crouchhit = false;
	
	_ll_atkactive = false;
	
	_ll_tntvoice = false;
	
	_ll_atk1_attack = false;
	_ll_atk1_atkact = 0;
	_ll_atk1_hop = false;
	_ll_atk1_hopstart = false;
	_ll_atk1_multjump = false;
	_ll_atk1_jumpamnt = 0;
	_ll_atk1_maxjump = 5;
	_ll_atk1_jumpcd = 0;
	_ll_atk1_shake = 0;
	_ll_atk1_afterim = 0;
	
	_ll_atk2_attack = false;
	_ll_atk2_timer = 0;
	_ll_atk2_xspd = 0;
	_ll_atk2_xspd_init = -2;
	_ll_atk2_xspd_modify = 0.3;
	_ll_atk2_spawn = 0;
	
	_ll_atk3_act = 0;
	_ll_atk3_curclaps = 0;
	_ll_atk3_claps = 0;
	_ll_atk3_claptimer = 0;
	_ll_atk3_offscreen = false;
	_ll_atk3_curpos = [x,y];
	_ll_atk3_clappos = [x,y];
	_ll_atk3_gotopos = [x,y];
	_ll_atk3_quickflash = false;
	_ll_atk3_after = 0;
	
	_ll_lightgag = 0;
	_ll_lightgagsfx = [false,false];
	_ll_lightgagdone = false;
	
	_ll_atk4_act = 0;
	_ll_atk4_timer = 0;
	_ll_atk4_poses = 0;
	_ll_atk4_maxposes = 7;
	_ll_atk4_dopose = false;
	_ll_atk4_posetype = 1;
	_ll_atk4_maxframes = 3;
	_ll_atk4_afterattack = false;
	_ll_atk4_offset = 256;
	
	_ll_atk4_lighttype = -1;
	_ll_atk4_lightdelay = 0;
	
	_ll_atk5_act = 0;
	_ll_atk5_spinamp = 0;
	_ll_atk5_spintimer = 0;
	_ll_atk5_endspin = 0;
	
	_ll_henchspawn = noone;
	
	_ll_atk6_act = 0;
	_ll_atk6_timer = 0;
	
	_ll_phaseend_offset = 0;
	
	_ll_killskull = false;
	_ll_disappear = false;
	
	_ll_dogshit = 0;
	
	_ll_storepos = 0;
}