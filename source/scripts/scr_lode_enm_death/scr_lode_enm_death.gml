function scr_lode_enm_death(){
	if(!_getup){
		if(_hurtbox != noone && instance_exists(_hurtbox)){
			if(_hurtbox._hurttimer > 0){
				_hurtbox._hurttimer = 0;
				var ghost = instance_create_depth(x,y,0,obj_lode_ghost);
				ghost._codename = _codename;
				
				var plr = instance_nearest(x,y,obj_lode_plr);
				var lode = instance_find(obj_mg_lode,0);
				if(instance_exists(plr) && instance_exists(lode)){
					var amp = (lode._disp_dim[0]-distance_to_object(plr))/lode._disp_dim[0];
					lode._scr_shake_x = 7*amp;
					lode._scr_shake_y = 7*amp;
				}
				
				global._lode_score += global._lode_score_add.enm;
				var scoreobj = instance_create_depth(x,y-global._lode_tilesize,0,obj_lode_score);
				scoreobj._score = global._lode_score_add.enm;
				
				var offset = 0;
				if(_is_stuck){
					offset = -1;
				}
				spawn_collect(offset);
				
				if(_snd.death != -1){
					sfx_play_proximity(_snd.death,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				}
				sfx_play_proximity(snd_lode_ghost,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				
				instance_destroy(_hurtbox.id);
				_project = false;
			}
		}
	}
}