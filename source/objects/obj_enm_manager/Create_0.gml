{	
	#macro SPD_WALK 0
	#macro SPD_BACK 1
	#macro SPD_PANIC 2
	#macro SPD_FALL 3
	#macro SPD_GRABFALL 4
	
	#macro STATE_IDLE 0
	#macro STATE_WALK 1
	#macro STATE_FOLLOW 2
	#macro STATE_ATTACK 3
	#macro STATE_OTHER 4
	#macro STATE_FALL 5
	#macro STATE_BLOCK 6
	#macro STATE_JUMP 7
	#macro STATE_SLIDE 8
	
	#macro ATK_NORM 100
	#macro ATK_MASH 101
	#macro ATK_KO 102
	#macro ATK_MASHKO 103
	
	#macro TRAIT_KO 200
	#macro TRAIT_TAUNT 201
	#macro TRAIT_BACKOFF 202
	#macro TRAIT_GRAB 203
	#macro TRAIT_HURT 204
	#macro TRAIT_HP 205
	#macro TRAIT_BLOCK 206
	#macro TRAIT_SPOT 207
	#macro TRAIT_BLOCKKO 208
	#macro TRAIT_CROUCHKO 209
	#macro TRAIT_DODGE 210
	#macro TRAIT_SLIDE 211
	#macro TRAIT_HOP 212
	#macro TRAIT_JABS 213
	#macro TRAIT_STUN 214
	#macro TRAIT_FALLSTUN 214
	#macro TRAIT_BLOCK_MASH 216
	#macro TRAIT_STUNLOCK_DODGE 217
	#macro TRAIT_MASHED 218
	#macro TRAIT_SLAM 219
	#macro TRAIT_PISSEDOFF 220
	
	#macro HOP_RANDOM_DH 0
	#macro HOP_BACK 1
	#macro HOP_SLIDE 2
	#macro HOP_NEAR 3
	#macro HOP_DH 4
	#macro HOP_RANDOM 5
	#macro HOP_CLOSE_DH 6
	
	#macro SPAWN_NORMAL 0
	#macro SPAWN_FALLPLANKS 1
	#macro SPAWN_CUTSCENE 2
	#macro SPAWN_HOP 3
	#macro SPAWN_PARACHUTE 4
	#macro SPAWN_CRUCIFIED 5
	
	global._enmtypes = ds_map_create();
	global._enmtypes[? "badhead"] = [["badhead","badhead",99],["badhead","badhead",99]];
	
	global._enmtypes[? "enm1"] = [["toxic","Toxicsaur",18],["hazard","Hazardsaur",20]];
	global._enmtypes[? "enm2"] = [["apple","Applethug",22],["rock","ROCKHARD",26]];
	global._enmtypes[? "enm3"] = [["cycliot","Cycliot",20],["crawler","Night crawler",24]];
	
	global._enmtypes[? "st2_enm1"] = [["ringmaster","Ringmaster",14],["grasshopper","Grasshopper",16]];
	global._enmtypes[? "st2_enm2"] = [["redcap","Red Cap",16],["milkman","Milkman",18]];
	global._enmtypes[? "st2_enm3"] = [["grinzy","Grinzy",17],["inty","Inty",20]];
	
	global._sequenceInfo = ds_map_create();
	global._sequenceLayers = ds_map_create();
	global._sequenceColors = ds_map_create();
	
	_codename = "";
	_enmtype = -1;
	
	global._skullrecolor = ["enm3","st2_enm2","st2_enm3"];
	
	global._sequenceOffset = ds_map_create();
	global._sequenceOffset[? "st2_enm1"] = [
		100,100,0,0 //l r u d
	];
	global._sequenceOffset[? "st2_enm3"] = [
		100,100,0,-200 //l r u d
	];
	
	global._sequenceInfo[? seq_st2_enm1_test] = {
		hop_frame: 68,
		hop_sprite: spr_st2_enm1_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: 0,
	}
	
	//henchie
	global._sequenceInfo[? seq_st2_enm1_entH] = {
		hop_frame: 44,
		hop_sprite: spr_st2_enm1_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -1000,
	}
	
	global._sequenceInfo[? seq_st2_enm1_entU] = {
		hop_frame: 44,
		hop_sprite: spr_st2_enm1_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -96,
	}
	
	global._sequenceInfo[? seq_st2_enm1_entC] = {
		anim_finish: true,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: 0,
	}
	
	global._sequenceInfo[? seq_st2_enm1_entD] = {
		hop_frame: 57,
		hop_sprite: spr_st2_enm1_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -1000,
	}
	
	//yolobones
	global._sequenceInfo[? seq_st2_enm2_entH] = {
		hop_frame: 136,
		hop_sprite: spr_st2_enm2_hop,
		walk_sprite: spr_st2_enm2_walk,
		do_arc: false,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,60],
		sdepth: -120,
	}
	
	global._sequenceInfo[? seq_st2_enm2_entC] = {
		hop_frame: 84,
		hop_sprite: spr_st2_enm2_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: 0,
	}
	
	//gostlik
	global._sequenceInfo[? seq_st2_enm3_entH] = {
		hop_frame: 58,
		hop_sprite: spr_st2_enm3_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -1000,
	}
	
	global._sequenceInfo[? seq_st2_enm3_entV] = {
		hop_frame: 58,
		hop_sprite: spr_st2_enm3_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -1000,
	}
	
	global._sequenceInfo[? seq_st2_enm3_entC] = {
		anim_finish: true,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -96,
	}
	
	//lanky larry
	global._sequenceInfo[? seq_boss2] = {
		hop_frame: 125,
		hop_sprite: spr_boss2_hop,
		do_arc: true,
		anim_finish: false,
		show_shadow: true,
		seqoffs: [0,0],
		sdepth: -1000,
	}
	
	global._curEnmCollide = [];
	global._enmCollideCooldown = 0;
}
