{
	//enemy specific variables
	_name = "Yolo-Bones";
	_codename = "st2_enm2";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 10;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_st2_enm2_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_st2_enm2_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 5;
	_movespd[? SPD_BACK] = 3;
	_movespd[? SPD_PANIC] = 8;
	_movespd[? SPD_FALL] = 8;
	_movespd[? SPD_GRABFALL] = 12;
	_spdmode = SPD_WALK;
	randomspd();
	
	_ailevel = 1.5;
	
	_dostepsound = true;
	
	_meleeanims = 0;
	_hurtanims = 3;
	
	_attackdist = 168;
	
	_standup_mult = 0.4;
	
	remove_trait(TRAIT_JABS);
	array_push(_enemytraits,
	TRAIT_KO, TRAIT_TAUNT, TRAIT_HOP, TRAIT_DODGE,
	TRAIT_STUN, TRAIT_FALLSTUN, TRAIT_BACKOFF, TRAIT_LOWKICK);
	
	_dodgezones = ["idle","air","upper","doublekick"];
	_dodgezones_start = _dodgezones;
	
	_block_endzones = [];
	_block_endzones_start = [];
	
	_playvoice.death = snd_yolo_death;
	_playvoice.flyout = snd_yolo_death2;
	_playvoice.slam = [snd_yolo_slam1,snd_yolo_slam2,snd_yolo_slam3];
	_playvoice.smackdown = snd_yolo_slam1;
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(208,122,17),make_color_rgb(197,29,24),make_color_rgb(125,96,202)];

	_animloop[? "slide"] = 2;
	_animloop[? "redcap"] = 7;

	_nockanim = "kick2";
	_nockframe = 0;

	//yolobones
	_yolob_kick = false;
	_yolob_timer = 0;
	_yolob_kickdir = 0;
	
	_milkthrow = false;
	
	_yolob_milk = false;
	_yolob_addtimer = false;
	_yolob_milktimer = 0;
	_yolob_milkact = 0;
	_yolob_heal = false;
	
	_yolob_kicked = false;
	_yolob_kicked_init = false;
	
	_yolob_sfx = [
		[4, snd_swish6, false], //frame, sfx, played
		[12, snd_glontch, false],
		[15, snd_glontch, false],
		[18, snd_glontch, false],
		[21, snd_glontch, false],
	];
	
	_yolob_subhp = false;
	_yolob_sol = noone;
	_yolob_hit = false;
	_yolob_pos = [x,y];
	
	#macro YOLOB_ATK_NONE 0
	#macro YOLOB_ATK_ALT1 1
	#macro YOLOB_ATK_ALT2 2
	
	_yolob_atkstate = YOLOB_ATK_NONE;
	
	_yolob_man_sfx = [false,false];
	_yolob_man_timer = 0;
	
	_yolob_man_groundpos = [x,y];
	_yolob_man_groundtimer = 0;
	_yolob_man_atktimer = 0;
	_yolob_man_hand = false;
	_yolob_man_handgone = false;
	_yolob_man_handobj = noone;
	
	_yolob_man_lowkick = false;
	_yolob_man_lowkick_end = false;
	
	_milksign = false;
	
	_yolob_parry = false;
	_yolob_milkstun = false;
	_yolob_milkstun_inactive = 0;
	_yolob_milkhits = 0;
	_yolob_atkcooldown = 0;
	_yolob_stopheal = false;
	
	_yolob_man_cd = 0;
}