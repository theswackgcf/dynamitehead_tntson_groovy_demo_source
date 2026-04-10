{
	_allsounds = ds_map_create();
	
	if(global._lightsout){
		sprite_index = spr_st2_enm2_ground_lights;
	}
	
	_snd = false;
	
	_dh = noone;
	
	_act = 0;
	_timer = 0;
	_out = false;
	_hand = false;
	
	_lerp_amnt = 0.09;
	
	_total_ailevel = 0;
	_increase_mult_amnt = 0;
	
	_parentobj = noone;
	_obj = noone;
	_spawnwarn = false;
	
	_showhand = false;
	
	_blocktimer = 0;
	
	_sptimer = 0;
	
	_freeze = 0;
	_dead = false;
	
	_alt_tutorial = false;
	
	_sort = true;
	
	_prompts = noone;
	_prompt_timer = 0;
	
	//colors
	_maxcolors = 4;
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}