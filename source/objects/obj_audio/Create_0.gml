{
	_allsounds = ds_map_create();
	
	//sound effects
	global._swishsounds = [
		[snd_swish1,snd_swish2,snd_swish3,snd_swish4,snd_swish5,
		snd_swish6,snd_swish7],
		[snd_swishup1,snd_swishup2,snd_swishup3],
		[snd_swishdown1,snd_swishdown2,snd_swishdown3]
	];
	global._punchsounds = [
		[snd_punch1,snd_punch2,snd_punch3,snd_punch4,
		snd_punch5,snd_punch6,snd_punch7,snd_punch8,snd_punch9],
		[snd_punch4,snd_punch5,snd_punch6,snd_punch7]
	];
	global._kdsounds = [
		snd_kd1,snd_kd2,snd_kd3,snd_kd4,snd_kd5
	];
	
	//voices
	global._testvoices = [
		snd_dh_ko,
	];
	
	global._dhvoices = [
		snd_dh_voice_eugh1,
		snd_dh_voice_eugh2,
		snd_dh_voice_eugh3,
		snd_dh_voice_idle1,
		snd_dh_voice_idle2,
		snd_dh_voice_idle3,
		snd_dh_voice_idle4,
		snd_dh_voice_idle5,
		snd_dh_voice_idle6,
		snd_dh_voice_ko1,
		snd_dh_voice_ko2,
		snd_dh_voice_ko3,
		snd_dh_voice_ko4,
		snd_dh_voice_ko5,
		snd_dh_voice_ko6,
		snd_dh_voice_ko7,
		snd_dh_voice_ko8,
		snd_dh_voice_ko9,
		snd_dh_voice_ko10,
		snd_dh_voice_ready1,
		snd_dh_voice_ready2,
		snd_dh_voice_ready3,
		snd_dh_voice_ready4,
		snd_dh_voice_ready5,
		snd_dh_voice_ready6,
		snd_dh_voice_laugh1,
		snd_dh_voice_laugh2,
		snd_dh_voice_win1,
		snd_dh_voice_win2,
		snd_dh_voice_win3,
		snd_dh_voice_win4,
		snd_dh_voice_win5,
		snd_dh_voice_chuckle1,
		snd_dh_voice_chuckle2,
		snd_dh_voice_chuckle3,
		snd_dh_voice_grunt1,
		snd_dh_voice_grunt2,
		snd_dh_voice_grunt3,
		snd_dh_voice_grunt4,
	];
	
	global._bossvoices = [
		snd_boss1_growl,
		snd_boss1_tnt,
		snd_boss1_ko,
		
		snd_lanky_hurry,
		snd_lanky_grunt1,
		snd_lanky_grunt2,
		snd_lanky_grunt3,
		snd_lanky_grunt4,
		snd_lanky_grunt5,
		snd_lanky_intro1,
		snd_lanky_intro2,
		snd_lanky_intro3,
		snd_lanky_intro4,
		snd_lanky_intro5,
		snd_lanky_intro6,
		snd_lanky_lights1,
		snd_lanky_lights2,
		snd_lanky_lights3,
		snd_lanky_lights4,
		snd_lanky_lights5,
		snd_lanky_phasehit1,
		snd_lanky_phasehit2,
		snd_lanky_phasehit3,
		snd_lanky_phasehit4,
		snd_lanky_tnthit1,
		snd_lanky_tnthit2,
		snd_lanky_tnthit3,
		snd_lanky_tnthit4,
		snd_lanky_seethe1,
		snd_lanky_seethe2,
		snd_lanky_spotlight1,
		snd_lanky_spotlight2,
		snd_lanky_spotlight3,
		snd_lanky_spotlight4,
		snd_lanky_spotlight5,
		snd_lanky_dizzy,
		snd_lanky_screamspin,
		snd_lanky_defeated,
	];
	
	global._allvoices = ds_map_create();
	
	for(var i = 0; i < array_length(global._testvoices); i++){
		global._allvoices[? global._testvoices[i]] = 1;
	}
	for(var i = 0; i < array_length(global._dhvoices); i++){
		global._allvoices[? global._dhvoices[i]] = 1;
	}
}