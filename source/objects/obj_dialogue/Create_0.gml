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
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
	
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
	
	function draw_gui(){
		if(_diagstate > 0){
			//draw dialogue box
			draw_set_alpha(_diagfadereal);
			draw_sprite(sprite_index, image_index, _drawX,_drawY);
			draw_set_alpha(1);
		}
		
		switch(_diagstate){
			case 1:
				if(image_index >= image_number-1){
					scr_textrender_switchfont("dh_font1");
				}
			break;
			case 2:
				if(_noise <= 0){
					//draw text
					scr_textrender_halign("left");
					scr_textrender_switchfont("dh_font1");
					scr_textrender_type(_drawX-300, _drawY-56, _typetext, false, #FFFFFF, _diagfadereal);
					scr_textrender_switchfont("dh_font2");
					if(_canSkip && _curchar >= string_length(_curtext)+1){
						//draw confirm text
						scr_textrender_switchfont("dh_font2");
						scr_textrender_valign("middle");
						scr_textrender_type(_drawX-326, _drawY+110, "PRESS keycode@CONFIRMkeycode", true, #FFFFFF, _diagfadereal);
						scr_textrender_valign("top");
						scr_textrender_switchfont(global._defaultFont);
					}
				
					//draw dialogue head
					if(_curhead != -1){
						draw_sprite_ext(_curhead, _headframe, _drawX - 440, _drawY, _scaleX, _scaleY, -5+(sin(_sintimer/48)*2), #FFFFFF, _diagfadereal);
					}
				}
			break;
			case 3:
				sprite_index = spr_diag_popout;
				if(image_index >= image_number-1){
					_diagstate = 0;
				}
			break;
		}
	
		//static noise
		if(_noise > 0){
			draw_set_alpha(_diagfadereal);
			draw_sprite(spr_diag_noise, _noiseframe, _drawX,_drawY);
			draw_set_alpha(1);
		}
	}
}