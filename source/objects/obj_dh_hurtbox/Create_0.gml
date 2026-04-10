{
	visible = false;
	
	_allsounds = ds_map_create();
	
	_parentobj = noone;
	_offset = [0,46];
	_curscale = 0;
	_scales = [1, 0.3];
	_once = false;
	
	_curdir = DIR_R;
	
	function fall(e_obj, pnt_obj, hbox) {
		if(!pnt_obj._falling){
			with(obj_camera){
				_ampX = 24;
				_ampY = 24;
			}
			
			global._weirdmusic = 120;
			
			global._knockouts ++;
			voice_play_choose([snd_dh_voice_eugh1,snd_dh_voice_eugh2,snd_dh_voice_eugh3], global._dhvoices, 1);
		
			var dmgnums = instance_create_depth(x, y-((pnt_obj.sprite_height * 2))-180, 0, obj_nums);
			dmgnums._nocked = true;
		}
		
		global._pad_vibrate = 6;
		
		pnt_obj._height += 4;
		pnt_obj._vspd = 16;
		pnt_obj._jump = true;
		
		if(pnt_obj.x < e_obj.x){
			pnt_obj._curdir = DIR_L;
		} else {
			pnt_obj._curdir = DIR_R;
		}
		
		hbox._success = true;
		
		pnt_obj._falling = true;
	}
	
	function parry_addhp() {
		//add hp from parrying
		if(!_parentobj._parry_hpheal){
			if(_parentobj._parry_mult > 0){
				if(_parentobj._hp < _parentobj._maxhp){
					var prevnum = _parentobj._hp;
					_parentobj._hp += _parentobj._parry_hpamnt*_parentobj._parry_mult;
								
					var diffs = diff_abs(prevnum,_parentobj._hp);
												
					if(diffs > 0){
						var num = instance_create_depth(x, y - 220, 0, obj_nums);
						num._num = diffs;
						num._plus = true;
					}
				}
				_parentobj._parry_mult -= 0.2;
				_parentobj._parry_timer = _parentobj._parry_timer_max;
											
				with(obj_gui){
					ui_fade("dh", 1);
				}
			}
			_parentobj._parry_hpheal = true;
		}
	}
}