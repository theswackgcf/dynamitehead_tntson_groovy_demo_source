{
	if(!global._pause){
		if(_freeze <= 0){
			image_speed = 1;
			
			_sptimer = 80;
			_increase_mult_amnt = 0.02;
			if(_total_ailevel >= 3){
				_sptimer = 75;
				_increase_mult_amnt = 0.03;
			}
			if(_total_ailevel >= 5){
				_sptimer = 45;
				_increase_mult_amnt = 0.05;
			}
			if(_total_ailevel >= 7){
				_sptimer = 25;
				_increase_mult_amnt = 0.07;
			}
			if(_total_ailevel >= 9){
				_sptimer = 15;
				_increase_mult_amnt = 0.12;
			}
			
			_timer ++;
			if(!_hand){
				if(!_snd){
					if(_dh == noone){
						_dh = instance_nearest(x,y,obj_dh_mask);
						if(instance_exists(_dh)){
							sfx_play_proximity(snd_land1_dirt, 1, false, _dh.x, _dh.y);
						}
						_dh = noone;
					}
					_snd = true;
				}
				if(_timer >= 60 && !_out){
					_out = true;
					sprite_index = spr_st2_enm2_ground2;
					if(global._lightsout){
						sprite_index = spr_st2_enm2_ground2_lights;
					}
					image_index = 0;
				}
			} else {
				switch(_act){
					case 0:
						if(!_spawnwarn){
							if(_alt_tutorial){
								_prompts = instance_create_depth(x,y,0,obj_dh_prompts);
								_prompts._parentobj = self;
							}
							
							var warn = instance_create_depth(x,y,-WIDTH,obj_boss2_mine_warning);
							warn._do_y = true;
							warn._lerp = true;
							warn._lerp_amnt = _lerp_amnt;
							warn._parentobj = _obj;
							warn._maxtimer = _sptimer;
							warn._increase = true;
							warn._increase_mult_amnt = _increase_mult_amnt;
							_spawnwarn = true;
						}
				
						if(_alt_tutorial){
							with(_obj){
								if(_prompts != noone && instance_exists(_prompts)){
									_prompts._help_prompt = global._help_prompt_time;
									_prompts._prompt_type = "jump";
								}
							}
						}
				
						image_index = 0;
						visible = false;
					
						x = lerp(x,_obj.x,_lerp_amnt);
						y = lerp(y,_obj.y+48,_lerp_amnt);
					
						if(_timer >= _sptimer){
							_timer = 0;
							_act = 1;
						}
					break;
					case 1:
						if(!_snd){
							sfx_play_proximity(snd_redcap_arm);
							_snd = true;
						}
					
						visible = true;
						if(_timer >= 8){
							var pj = instance_create_depth(x,y-42,depth,obj_projectile);
							pj._cangetdamage = false;
							pj._visible = false;
							pj._temp = true;
							pj._deathtimer = 4;
							pj._scale2 = [2.5, 3];
							pj._heightdiff = [140,70];
							pj._damage = ATK_KO;
						
							image_index = 0;
							_showhand = true;
							_timer = 0;
							_act = 2;
						}
					break;
					case 2:
						sprite_index = spr_st2_enm2_ground_popin;
						if(image_index >= image_number-1){
							image_index = 5;
						}
						
						if(_alt_tutorial){
							_timer = 0;
						}
						
						if(_parentobj != noone && instance_exists(_parentobj)){
							if(_parentobj._falling || _parentobj._standup || _parentobj._grabdodge){
								_parentobj._yolob_man_handgone = true;
								
								image_index = 0;
								_timer = 0;
								_act = 3;
							}
						}
						
						if(!_dead && _timer >= scr_ailevel(70, random_range(70, 90))){
							sfx_play_proximity(snd_redcap_arm_out);
							
							image_index = 0;
							_timer = 0;
							_act = 3;
						}
					
						if(!_dead){
							if(_prompts != noone && instance_exists(_prompts)){
								_prompt_timer ++;
								if(_prompt_timer >= 180){
									_prompts._help_prompt = global._help_prompt_time;
									_prompts._prompt_type = "smackdown_b";
								}
							}
						}
					
						//get damaged
						if(!_dead && place_meeting(x,y,obj_punchhitbox)){
							var hbox = instance_place(x,y,obj_punchhitbox);
							if(instance_exists(hbox)){
								if(hbox._ptype == "pl"){
									if(hbox._damage == ATK_KO && (hbox._type == "crouch" || hbox._type == "air")){
										//crumble
										var hbox_p = hbox._parentobj;
										if(instance_exists(hbox_p)){
											with(obj_camera){
												_ampX = 36;
											}
										
											_blocktimer = 0;
										
											hbox_p._freeze = global._freezeFrames.long_freeze;
										
											if(_parentobj != noone && instance_exists(_parentobj)){
												with(_parentobj){
													sfx_play_proximity(snd_kd5);
													_freeze = global._freezeFrames.long_freeze;
													_yolob_man_lowkick_end = false;
													_yolob_man_lowkick = true;
												}
											}
										
											global._hits += 1;
											global._hitmeter = 50;
											with(obj_game){
												hitjump();
											}
										
											_freeze = global._freezeFrames.long_freeze;
											_dead = true;
										}
									} else if(hbox._type == ""){
										//block
										if(_blocktimer <= 0){
											var hbox_p = hbox._parentobj;
											if(instance_exists(hbox_p)){
												var p = instance_create_depth(x, y, 0, obj_particle);
												p._type = "fx"+string(choose(1,2));
												p._curdir = hbox_p._curdir;
											
												sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
												_blocktimer = 12;
											}
										}
									}
								}
							}
						}
						
						if(_blocktimer > 0){
							_blocktimer --;
						}
						
						if(_dead){
							var p = instance_create_depth(x-64,y-64,-32, obj_particle);
							p._type = "vanish";
							
							sfx_play(snd_skullcrack);
								
							instance_destroy();
						}
					break;
					case 3:
						if(_prompts != noone && instance_exists(_prompts)){
							instance_destroy(_prompts.id);
						}
					
						sprite_index = spr_st2_enm2_ground_popout;
						if(image_index >= image_number-1){
							var p = instance_create_depth(x-64,y-210,-32, obj_particle);
							p._type = "vanish";
							
							if(_parentobj != noone && instance_exists(_parentobj)){
								_parentobj._yolob_man_handgone = true;
							}
							instance_destroy();
						}
					break;
				}
			}
		
			if(!_showhand){
				if(image_index >= image_number-1){
					if(!_out){
						image_index = 3;
					} else {
						instance_destroy();
					}
				}
			}
		} else {
			image_speed = 0;
			_freeze --;
		}
	} else {
		image_speed = 0;
	}
}