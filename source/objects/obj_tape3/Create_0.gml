{
	_allsounds = ds_map_create();
	
	_init = false;
	
	_scene = 0;
	
	_squareoffset = 315;
	
	_tv_timer = 0;
	_tv_act = 0;
	_tv_frame = 0;
	
	_tv_offset = 0;
	_tv_amp = 0;
	
	_tv_punch = [false,false,false,false];
	_tv_talk1 = false;
	_tv_talk2 = false;
	
	_mus = false;
	
	_sky_frame = 0;
	
	_scene1_timer = 0;
	_scene1_act = 0;
	
	_phonering_state = false;
	_phonering_timer = 0;
	_showphone = true;
	
	_handframe = 0;
	_handpos = -WIDTH;
	_handzip = false;
	
	_scrollpos = 0;
	
	_scene2_timer = 0;
	_scene2_act = 0;
	
	_nomio_frame = 0;
	_scene2_talk1 = false;
	_scene2_talk2 = false;
	_scene2_talk3 = false;
	_scene2_talk4 = false;
	
	_nomio_sprite = spr_tape3_nomio1;
	
	_pitchmult = 1;
	
	_nomio_showmouth = true;
	_nomio_talktimer = 0;
	_nomio_mouthsprite = -1;
	_nomio_mouthframe = 0;
	_nomio_mouthoffset = 0;
	
	_nomio_handoffset = 0;
	_nomio_handamp = 0;
	
	_nomio_scaley = 1;
	
	_caller_appear = false;
	_caller_static = 48;
	_callerx = WIDTH*2;
	_callerframe = 0;
	
	_endtimer = 0;
	_scene3_timer = 0;
	_scene3_alp = 1;
	
	_skipall_act = 1;
	_skipall_timer = 0;
	_skipall_xstart = -WIDTH;
	_skipall_x = _skipall_xstart;
	_skip = false;
	
	//crt effect
	horrifi_enable(true);

	horrifi_bloom_set(false,0,0,0);
	horrifi_chromaticab_set(true,0.12);
	horrifi_scanlines_set(true,0.03);
	horrifi_vhs_set(true,0.05);
	horrifi_vignette_set(false,0,0);
	horrifi_crt_set(false,0);
	horrifi_noise_set(true,0.1);
}