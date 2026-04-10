{
	_allsounds = ds_map_create();
	
	_show = false;
	_scrindex = "";
	_scrdir = "u";
	_curpg = 0;
	_diag_init = false;
	_diag_act = 0;
	_stopmove = false;
	
	_tips_active = "";
	
	_diagfadereal = 1;
	_diagfadeto = 1;
	
	_starttimer = 0;
	
	_sintimer = 0;
	_timer = 0;
	_diagstate = 0;
	_noise = 0;
	_noisetimer = 0;
	_noiseframe = 0;
	
	_drawX = 0;
	
	_pos = [0, 0];
	
	_drawYTo = _pos[0];
	_drawY = _drawYTo;
	
	_defScale = 0.75;
	
	_scaleX = _defScale;
	_scaleY = _defScale;
	_scaleXTo = _defScale;
	_scaleYTo = _defScale;
	
	_wrap = 550;
	_diagtimer = 0;
	_curtext = "";
	_typetext = "";
	_curchar = 1;
	
	_curhead = 0;
	_headframe = 0;
	
	_textarray = [];
	
	_canSkip = true;
	_diagend = false;
	
	_keysArray = [];
	
	_lockcamera = false;
	_borders = [noone,noone];
	_lockobj = noone;
	_savecammode = 0;
	
	_fix_cooldown = 60;
	
	_pitchmult = 1;
	
	_bossinfoexists = false;
	_bossinfostart = 0;
	_bossinfoend = 0;
	_bossaction = [false,false];
	
	_fx = false;
	
	function setPg() {
		if(_bossinfoexists){
			if(_curpg >= _bossinfostart){
				if(!_bossaction[0]){
					with(obj_bountyhead_info){
						_infoshow = true;
					}
					_bossaction[0] = true;
				}
			}
			if(_curpg >= _bossinfoend){
				if(!_bossaction[1]){
					with(obj_bountyhead_info){
						_infohide = true;
					}
					_bossaction[1] = true;
				}
			}
		}
		scr_textrender_switchfont("dh_font1");
		_curtext = scr_wordwrap(_textarray[_curpg][0], _wrap, "\n", false);
		_typetext = "";
		_curchar = 1;
		scr_dialogue_setkeys(_curtext, _keysArray);
	}
}