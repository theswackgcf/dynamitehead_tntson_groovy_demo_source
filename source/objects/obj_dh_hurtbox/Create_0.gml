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
			global._knockouts ++;
			voice_play_choose([snd_dh_voice_eugh1,snd_dh_voice_eugh2,snd_dh_voice_eugh3], global._dhvoices, 1);
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
}