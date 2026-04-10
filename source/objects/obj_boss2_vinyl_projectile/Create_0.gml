{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_xspd = 1.5;
	_startheight = 0;
	_height = _startheight;
	_timer = 0;
	_dispoffset = [0,-24];
	_heightdiff = [90,70];
	
	_startoffset = _dispoffset[1];
	
	_damage = ATK_NORM;
	_add_damage = 2;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [0.9,0.9];
	
	_candodge = {
		roll: true,
		down: false,
		atk: true
	}
	
	_canparry = true;
	_canhit = ["idle","air","upper","doublekick"];
	
	_shadsize = [0.8, 0.5];
	
	_parentobj = noone;
	
	function dead() {
		var p = instance_create_depth(x-128, y-128-_dispoffset[1], depth, obj_particle);
		p._type = "vanish";
			
		with(obj_camera){
			_ampX = 12;
			_ampY = 12;
		}
																		
		global._pad_vibrate = 2;
		
		with(_parentobj){
			if(_hp >= _phasehp[_phase]+8){
				var dh = instance_nearest(x,y,obj_dh_mask);
				if(instance_exists(dh)){
					if(!dh._shield || (dh._shield && dh._successparry > 0)){
						//combo
						var timer = 42;
				
						if(global._hitscd <= 0){
							global._hits += 1;
							global._hitscd = 2;
							global._hitmeter = 50;
							with(obj_game){
								hitjump();
							}
						}
				
						_hurt_combotime = timer;
						_hurts ++;
											
						_hitadd += 0.4;
						_hitadd_timer = timer;
				
						_hp -= 3*_dmgmultiplier*_combohit;
				
						_hurttimer = 14;
				
						other._freeze = global._freezeFrames.vshort_freeze;
						_freeze = global._freezeFrames.vshort_freeze;
				
						_hurtanim ++;
						if(_hurtanim > _hurtanims){
							_hurtanim = 1;
						}
				
						var p = instance_create_depth(x, y, 0, obj_particle);
						p._type = "fx"+string(choose(1,2));
						p._curdir = _curdir;
				
						var dmgnums = instance_create_depth(x+_dmgoffset[0], y-((sprite_height * 2)+150)+_dmgoffset[1], 0, obj_nums);
						dmgnums._num = max(1,floor(_hplastframe - _hp));
						_hplastframe = _hp;	
				
						voice_play_choose_proximity([snd_lanky_grunt1,snd_lanky_grunt2,snd_lanky_grunt3,snd_lanky_grunt4,snd_lanky_grunt5], global._bossvoices, 1);
				
						sfx_stop_array(global._punchsounds[0]);
						sfx_play_choose(global._punchsounds[0]);
				
						_show_hits = true;
					}
				}
			}
		}
								
		instance_destroy();
	}
}