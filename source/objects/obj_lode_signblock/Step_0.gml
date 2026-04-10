{
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_signimg += 0.3;

		if(!_init){
			_textid = string(_tilepos[0])+string(_tilepos[1]);
			
			if(global._lode_editor && global._sign_load_done){
				if(!ds_map_exists(global._sign_layout,_textid)){
					_text = get_string("sign text","");
					global._sign_layout[? _textid] = _text;
				} else {
					_text = global._sign_layout[? _textid];
				}
			}
			if(!global._lode_editor && global._sign_load_done){
				if(ds_map_exists(global._sign_layout,_textid)){
					_text = global._sign_layout[? _textid];
				}
			}
			_text_wrapped = scr_wordwrap(_text,600,"/n",false);
			
			_init = true;
		} else {
			if(global._lode_editor && global._sign_load_done){
				var lode = instance_find(obj_mg_lode,0);
				if(instance_exists(lode)){
					if(lode._editor_mousetile[0] == _tilepos[1] && lode._editor_mousetile[1] == _tilepos[0]){
						_drawdeletetext = true;
					} else {
						_drawdeletetext = false;
					}
				}
				
				if(_drawdeletetext && keyboard_check_pressed(ord("R"))){
					_text = get_string("sign text",_text);
					global._sign_layout[? _textid] = _text;
					
					_text_wrapped = scr_wordwrap(_text,600,"/n",false);
				}
			}
			
			if(!global._lode_editor){
				if(_readtimer > 0){
					_readtimer --;
				}
			
				if(!_showtext){
					_out = false;
					_textscale = 0;
					if(place_meeting(x,y,obj_lode_plr)){
						_readtimer = 2;
						var plr = instance_place(x,y,obj_lode_plr);
						if(instance_exists(plr)){
							with(plr){
								if(keypress("confirm")){
									sfx_play(snd_mg_popnext);
									other._showtext = true;
								}
							}
						}
					}
				} else {
					if(!_out){
						_textscale += 0.12;
						if(_textscale >= 1){
							_textscale = 1;
						}
					} else {
						_textscale -= 0.12;
						if(_textscale <= 0){
							_textscale = 0;
							_showtext = false;
						}
					}
					var plr = instance_nearest(x,y,obj_lode_plr);
					if(instance_exists(plr) && distance_to_object(plr) >= 64){
						if(!_out){
							sfx_play_proximity(snd_mg_popaway,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
							_out = true;
						}
					}
				}
			}
			
			if(global._lode_editor){
				_textscale = 1;
				_showtext = true;
			}
		}
		
		scr_lode_overtile();
	} else {
		image_speed = 0;
	}
}