{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_parentobj = noone;
	
	_dhfollow = noone;
	
	_xspd = 0;
	_height = 16;
	_dispoffset = [0,-64];
	
	_damage = ATK_NORM;
	_add_damage = 3;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [0.9,0.9];
	
	_candodge = {
		roll: true,
		down: true,
		atk: true
	}
	
	_canparry = true;
	
	_shadsize = [0.55, 0.45];
	_shadoffset = 120;
	
	_enmtype = -1;
	
	_alt_tutorial = false;
	
	_maxcolors = 1;
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	function dead() {
		var p = instance_create_depth(x-12, y-72-_dispoffset[1], depth, obj_particle);
		p._type = "item";
		
		var p = instance_create_depth(x-64, y-120-_dispoffset[1], depth, obj_particle);
		p._type = "vanish";
			
		if(_allsounds != undefined && _allsounds != -1){
			sfx_stop(snd_swinging);
			sfx_play(snd_milksplat);
		}
		
		with(obj_st2_milkpunch){
			instance_destroy();
		}
			
		if(_parentobj != noone && instance_exists(_parentobj)){
			var dh = instance_nearest(x,y,obj_dh_mask);
			if(instance_exists(dh)){
				if(!dh._shield || (dh._shield && dh._successparry > 0)){
					with(obj_camera){
						_ampX = 36;
					}
					
					global._hits += 1;
					global._hitmeter = 50;
					with(obj_game){
						hitjump();
					}
					
					with(_parentobj){
						sfx_play_proximity(snd_yolo_dodge2);
						
						add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
						
						_attack = false;
						_attacktype = "";
						
						_yolob_milk = false;
						_yolob_milkact = 0;
						_yolob_milktimer = 0;
						_yolob_heal = false;
						
						_yolob_milkstun = true;
						_yolob_milkhits = 0;
						_yolob_milkstun_inactive = 0;
					}
				}
			}
		}
					
		instance_destroy();
	}
}