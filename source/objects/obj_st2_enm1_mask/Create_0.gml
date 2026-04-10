{
	//enemy specific variables
	_name = "Henchie";
	_codename = "st2_enm1";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 10;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_st2_enm1_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_st2_enm1_hurtbox);
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
	
	_meleeanims = 2;
	_hurtanims = 3;
	
	_pissedoff_offset = [-60,-235];
	
	array_push(_enemytraits,
	TRAIT_KO, TRAIT_TAUNT, TRAIT_DODGE,
	TRAIT_BACKOFF, TRAIT_BLOCK,
	TRAIT_SPOT, TRAIT_BLOCKKO,
	TRAIT_CROUCHKO);
	
	_block_endzones = ["air","crouch","slide","upper","doublekick"];
	_dodgezones = ["crouch"];
	_dodgezones_start = _dodgezones;
	_jumphit = ["upper"];
	
	_playvoice.death = snd_henchie_die;
	_playvoice.atk = snd_henchie_notice;
	_playvoice.slam = [snd_henchie_slam1,snd_henchie_slam2,snd_henchie_slam3];
	_playvoice.smackdown = snd_henchie_slam1;
	_slampitch = [1.2,1.45];
	
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(198,55,102),make_color_rgb(255,204,51),make_color_rgb(83,132,66)];

	_atkdelay.blockko = 4;
	_atkdelay.meleeko = 4;
	
	_atkhitb.blockko = [[12,4],[150,-100]];
	
	_animloop[? "block"] = 2;
	_animloop[? "jump"] = 1;
	_animloop[? "jumpko"] = 3;
	_animloop[? "ringmaster"] = 6;

	_nockanim = "crouchkick";
	_nockframe = 0;

	//enemy specific
	_hn_crucified = false;
	_hn_c_trigger = false;
	_hn_c_timer = 0;
	_hn_c_shakes = 0;
	_hn_c_amp = 0;
	_hn_c_snd = false;
	
	_hn_timer = 0;
	_hn_forceattack = false;
	_hn_attack = false;
	_hn_atkact = 0;
	_hn_atktimer = 0;
	_hn_hop = false;
	_hn_hopstart = false;
	_hn_hopsnd = false;
	_hn_addtimer = false;
	_hn_multjump = false;
	_hn_jumpamnt = 0;
	_hn_jumpcd = 0;
	_hn_shake = 0;
	_hn_slamdown = 0;
	_hn_endinit = false;
	_hn_afterim = 0;
	_hn_crouchhit = false;
	_hn_cooldown = 0;
	
	_hn_slamdown_timer = 0;
	_hn_slamdownsnd = false;
	
	_hn_shocktimer = 0;
	_hn_shocks = 0;
	
	_hn_bosstimer = 0;
	
	#macro HENCHIE_ATK_NONE 0
	#macro HENCHIE_ATK_ALT1 1
	
	_hn_atkstate = HENCHIE_ATK_NONE;
	_hn_atk_storepos = [x,y];
	
	_hn_ring_hurt = true;
	
	_hn_setrounds = false;
	_hn_rounds = 1;
	_hn_dmgadd = 3;
	_hn_ring_ground = false;
	_hn_ring_time = 0;
	_hn_ring_fake = false;
	_hn_ring_fake_snd = 0;
	
	_hn_wait = 0;
	_hn_num = 0;
	_hn_prepkill = 0;
	_hn_prepkill_timer = 0;
	
	_hn_idle3_timer = 0;
	
	_hn_ring_afttimer = 0;
	
	function spawn_fakevanish() {
		for(var j = 0; j < 3; j++){
			var p = instance_create_depth(x-76, y-76, _displayobj.depth+12, obj_particle);
			p._type = "fakevanish"+string(choose(1,2));
			p._alpha = true;
			p._alpha_spd = 0.03;
			p._move = true;
			p._xspd = irandom_range(2,3)*choose(1,-1);
			p._yspd = irandom_range(1,2)*choose(1,-1);
			p._changescale = true;
			p._changescale_spd = 0.01;
			p._frameend = false;
		}
		for(var j = 0; j < 4; j++){
			var p = instance_create_depth(x-76+random_range(-42,42), y-76+random_range(-42,42), _displayobj.depth+12, obj_particle);
			p._type = "fakevanish"+string(choose(3,5));
			p._alpha = true;
			p._alpha_spd = 0.02;
			p._move = true;
			p._xspd = irandom_range(4,7)*choose(1,-1);
			p._yspd = irandom_range(3,6)*choose(1,-1);
			p._changescale = true;
			p._changescale_spd = 0.01;
			p._frameend = false;
		}
		for(var j = 0; j < 14; j++){
			var p = instance_create_depth(x-76+random_range(-42,42), y-76+random_range(-42,42), _displayobj.depth+12, obj_particle);
			p._type = "fakevanish6";
			p._alpha = true;
			p._alpha_spd = 0.01;
			p._move = true;
			p._xspd = irandom_range(8,10)*choose(1,-1);
			p._yspd = irandom_range(7,10)*choose(1,-1);
			p._changescale = true;
			p._changescale_spd = 0.01;
			p._frameend = false;
		}
	}
}