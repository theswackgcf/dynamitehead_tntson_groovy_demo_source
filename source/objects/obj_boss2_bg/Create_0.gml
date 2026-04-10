{
	_allsounds = ds_map_create();
	
	_codename = "boss2";
	
	_intro = true;
	_freeze = 0;
	
	_bossheadpos = 0;
	
	_phase = 1;
	
	_spawndir = choose(DIR_L,DIR_R);
	
	_act = 0;
	_acttimer = 0;
	
	_timer = 0;
	_lankframe = 0;
	_lankframe_onbeat = 0;
	_lankfsprite = -1;
	_lankfframe = 0;
	_larry = true;
	_larryact = 1;
	_larryact_timer = 0;
	_larryact_prev = _larryact;
	_larryact_tr = 0;
	
	_lankscale = [0.88,0.88];
	
	_lankf_offsets = ds_map_create();
	_lankf_offsets[? spr_boss2_bg_1_front] = [9,44];
	_lankf_offsets[? spr_boss2_bg_2_front] = [34,27];
	_lankf_offsets[? spr_boss2_bg_3_front] = [-42,26];
	_lankf_offsets[? spr_boss2_bg_7_front] = [-120,-25];
	_lankf_offsets[? spr_boss2_bg_8_front] = [145,-27];
	
	_deframes = 3;
	_lankframes = ds_map_create();
	_lankframes[? spr_boss2_bg_0] = 2;
	_lankframes[? spr_boss2_bg_4] = 4;
	_lankframes[? spr_boss2_bg_9] = 4;
	
	_songplaying = false;
	_bpm = 103.5;
	
	_failsafe_timer = 0;
	_beat = false;
	_speakertimer = 0;
	_speakerframe = 0;
	
	_lank_offsetx = 0;
	_lank_offsety = 0;
	
	_seethe = false;
	
	_state = "default";
	
	_offsety = {
		speakerL: 0,
		set: 0,
		speakerR: 0,
	}
	_vely = {
		speakerL: 0,
		set: 0,
		speakerR: 0,
	}
	
	_showlight = 0;
	_lightsource = noone;
	_lightoffset = [0,0];
	_light_scalex = 1.4;
	_light_alpha = 1;
	
	_eyesframe = 0;
	_switchoffset = [156,-252];
	
	_setlankpos = false;
	
	_makeobj = false;
	_bossintro = noone;
	
	_minetimer = 0;
	_minethrow = false;
	_minethrow_timer = 0;
	_curmine = 0;
	
	_mine_phaseind_cur = 0;
	_mine_phaseind = [0, 4] //phase 1 first mine index, phase 2 first mine index
	
	_mineds = ds_map_create();
	_mineds[? 0] = [1, 700, 3]; //phase, time, mines
	_mineds[? 1] = [1, 1450, 2];
	_mineds[? 2] = [1, 1900, 4];
	_mineds[? 3] = [1, 2700, 4];
	
	_mineds[? 4] = [2, 650, 4];
	_mineds[? 5] = [2, 1100, 5];
	_mineds[? 6] = [2, 1300, 1];
	_mineds[? 7] = [2, 1600, 3];
	_mineds[? 8] = [2, 2000, 3];
	
	_minestothrow = 0;
	_curmine_show = false;
	_curminepos = [x,y];
	_curminespd = [0,0];
	_spawnmine = true;
	
	_easteregg_active = false;
	
	_easteregg_timer = 14400;
	_easteregg_soundtimer = 0;
	_easteregg_voicetimer = 0;
	
	_easteregg_speakers = true;
	_easteregg_speakers_snd = false;
	
	_easteregg_act = 0;
	_easteregg_acttimer = 0;
	
	_easteregg_stop = false;
	_easteregg_stoptimer = 0;
	
	_easteregg_startdialogue_init = false;
	_easteregg_startdialogue = false;
	_easteregg_startdialogue_timer = 0;
	
	_delete_offscreen_obj = false;
}