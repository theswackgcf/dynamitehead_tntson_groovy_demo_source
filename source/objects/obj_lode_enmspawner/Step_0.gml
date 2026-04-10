{
	visible = false;
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			_spawn_enemy = false;
			
			_tilepos = [_parentobj._tilepos[0],_parentobj._tilepos[1]];
			_tilelayer = _parentobj._tilelayer;
			_id = _parentobj._id;
		}
		if(_parentobj != noone && !instance_exists(_parentobj)){
			_respawn_timer ++;
			if(_respawn_timer >= 120){
				if(!_spawn_enemy){
					var enm = instance_create_depth(x-_spawn_offsets[0],y-_spawn_offsets[1],0,_enmindex);
					enm._spawnagain = true;
					enm._tilepos = [_tilepos[0],_tilepos[1]];
					enm._tilelayer = _tilelayer;
					enm._id = _id;
					enm._spawning = true;
					enm.image_alpha = 0;
					enm.image_blend = _spawnblend;
				
					_parentobj = enm;
					_respawn_timer = 0;
					
					_spawn_enemy = true;	
				}
			}
		}
	}
}