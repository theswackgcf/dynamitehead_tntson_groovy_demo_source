{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_parentobj = noone;
	
	_xspd = 1.7;
	_startheight = 32;
	_height = _startheight;
	_dispoffset = [0,-30];
	
	_startoffset = _dispoffset[1];
	
	_timer = 0;
	
	_damage = ATK_NORM;
	_add_damage = 3;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [1,1];
	
	_candodge = {
		roll: true,
		down: false,
		atk: true
	}
	
	_canparry = true;
	_canhit = ["idle","air","upper","doublekick"];
	
	_shadsize = [0.7, 0.45];
	
	_maxcolors = 1;
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	function dead() {
		var p = instance_create_depth(x-128, y-128-_dispoffset[1], depth, obj_particle);
		p._type = "vanish";
			
		if(_parentobj != noone && instance_exists(_parentobj)){
			with(obj_camera){
				_ampX = 12;
				_ampY = 12;
			}
																		
			global._pad_vibrate = 2;

			for(var i = 0; i < irandom_range(6,8); i++){
				var p = instance_create_depth(x-48,y-48,depth-8,obj_particle);
				p._type = "gost_smoke"+string(choose(1,2,3));
				p._move = true;
				p._frameend = false;
				p._alpha = true;
				p._alpha_spd = 0.06;
				p._xspd = random_range(5,9);
				p._yspd = random_range(5,9);
			}

			//ui
			with(_parentobj._hitobj){
				if(instance_exists(_parentobj)){
					if(has_trait(TRAIT_HP, _parentobj)){
						ui_hp_stuff(_parentobj);
					}
				}
			}
					
			with(_parentobj){
				var dh = instance_nearest(x,y,obj_dh_mask);
				if(instance_exists(dh)){
					if(!dh._shield || (dh._shield && dh._successparry > 0)){
						//combo
						var timer = 42;
				
						_hurt_combotime = timer;
						_hurts ++;
											
						_hitadd += 0.4;
						_hitadd_timer = timer;
				
						_hp -= (3+_gl_hpadd)*_dmgmultiplier*_combohit;
						_gl_hpadd += 1;
				
						if(_hp >= 4){
							global._hits += 1;
							global._hitscd = 2;
							global._hitmeter = 50;
							with(obj_game){
								hitjump();
							}
						}
				
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
				
						sfx_play(snd_gostlik_hurt);
						sfx_pitch(snd_gostlik_hurt, (_hp/_maxhp)+0.45);
				
						sfx_play(snd_grinzy_ghostgone);
						sfx_pitch(snd_grinzy_ghostgone, (_hp/_maxhp)+0.45);
				
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