{
	//enemy specific variables
	_name = "Gostlik";
	_codename = "st2_enm3";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 15;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_st2_enm3_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_st2_enm3_hurtbox);
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
	
	_backoffsound = false;
	
	_meleeanims = 3;
	_hurtanims = 2;
	
	_maxblockcount = 0;
	_block_endzones = ["upper","doublekick"];
	_block_endzones_start = _block_endzones;
	
	_dodgezones = ["air", "crouch"];
	_dodgezones_start = _dodgezones;
	
	array_push(_enemytraits,
	TRAIT_KO, TRAIT_TAUNT,
	TRAIT_BACKOFF, TRAIT_BLOCK, TRAIT_BLOCKKO, TRAIT_DODGE);
	
	_playvoice.death = snd_gostlik_die;
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(103,154,211),make_color_rgb(113,157,53),make_color_rgb(210,66,135)];

	_skullnum = 2;
	
	_animloop[? "block"] = 2;

	_nockanim = "blockko";
	_nockframe = 2;

	//gostlik
	_gl_passive_timer = 0;
	_gl_passive = false;
	_gl_spin = false;
	_gl_spinact = 0;
	_gl_timer = 0;
	
	_gl_sinetimer = 0;
	
	_gl_setskull = false;
	
	_gl_tongspin_act = 0;
	_gl_tongspin_timer = 0;
	_gl_tongspin_addtime = false;
	_gl_tongspin_amp = 0;
	
	_gl_particle = 0;
}