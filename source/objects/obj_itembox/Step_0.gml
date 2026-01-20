{
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? self.id] = ds_map_create();
		global._gameshadows[? self.id][? "draw"] = false;
		global._gameshadows[? self.id][? "x"] = x;
		global._gameshadows[? self.id][? "y"] = y;
		global._gameshadows[? self.id][? "scalex"] = 0;
		global._gameshadows[? self.id][? "scaley"] = 0;
		
		_shadowsinit = true;
	}
	
	if(!_init){
		_intimer ++;
		if(_intimer >= 2){
			var sprite = asset_get_index("spr_itembox"+string(global._location+1));
			if(sprite_exists(sprite)){
				sprite_index = sprite;
			} else {
				sprite_index = spr_itembox1;
			}
		
			if(!_boxonly){
				var wireoffset = [0,0];
				var xscale = 1;
				var yscale = 1;
				var angle = 0;
				switch(_dir){
					case "r":
						wireoffset = [-36,-6];
					break;
					case "l":
						wireoffset = [36,-6];
						xscale = -1;
					break;
					case "d":
						wireoffset = [-6,-112];
						angle = 270;
						yscale = -1;
					break;
					case "u":
						wireoffset = [-6,0];
						angle = 90;
						yscale = -1;
					break;
				}
				_wire = instance_create_depth(x+wireoffset[0],y+wireoffset[1],1000,obj_itembox_wire);
				_wire.image_xscale = xscale;
				_wire.image_yscale = yscale;
				_wire.image_angle = angle;
				_wire._parentobj = self;
			}
			
			_init = true;
		}
	}
	
	if(!global._pause){
		if(_active){
			_vtimer ++;
			if(_vtimer >= 1){
				visible = true;
			}
		
			image_speed = 1;
		
			if(_parentobj != noone && instance_exists(_parentobj)){
				_parentpos = [_parentobj.x, _parentobj.y];
			}
		
			if(_spawn8dir){
				//clockwise starting from top
				var dirs = [
					[0,-2],
					[3,-2],
					[4,0],
					[3,2],
					[0,2],
					[-3,2],
					[-4,0],
					[-3,-2],
				];
				for(var i = 0; i < array_length(dirs); i++){
					var p = instance_create_depth(x+dirs[i][0]*32,y+dirs[i][1]*32,1000,obj_particle);
					p._type = "itemexp_1";
					p.image_index = random_range(0,1);
					p._move = true;
					p._xspd = dirs[i][0];
					p._yspd = dirs[i][1];
				}
				_spawn8dir = false;
			}
		
			var addframe = 0;
			if(global._lightsout){
				addframe = 2;
			}
		
			if(_trigger = 0){
				image_index = addframe;
			}
		
			switch(_trigger){
				case 1:
					if(!_parentobj._boxonly){
						var p = instance_create_depth(_parentpos[0]-64, _parentpos[1]-46, 0, obj_particle);
						p._type = "vanish";
					}
			
					image_index = addframe;
				
					_trigger = 2;
				break;
				case 2:
					image_index = 1+addframe;
					if(_wire != noone && instance_exists(_wire)){
						_wire._fuse = true;
						if(_wire._frame >= 3){
							with(obj_camera){
								_ampY = 30;
							}
					
							_spawn8dir = true;
							_spawncount_bottom ++;
					
							sfx_play_proximity(snd_itemexplode, 1);
							_showself = false;
							_nukeactive = true;
							_trigger = 3;
						}
					} else {
						_boxonlytimer ++;
						if(_boxonlytimer >= 5){
							with(obj_camera){
								_ampY = 30;
							}
					
							_spawn8dir = true;
							_spawncount_bottom ++;
					
							sfx_play_proximity(snd_itemexplode, 1);
							_showself = false;
							_nukeactive = true;
							_trigger = 3;
						}
					}
				break;
				case 3:
					_timer ++;
					if(_timer >= _timermax){
						//destroy box & spawn items
						var pos = [0];
						switch(array_length(_parentobj._itemarray)){
							case 1:
								pos = [[42,-56]];
							break;
							case 2:
								pos = [[-24,-56],[120,-56]];
							break;
							case 3:
								pos = [[-24,-36],[120,-36],[42,-76]];
							break;
						}
						var xoffset_ = -64;
						for(var i = 0; i < array_length(_parentobj._itemarray); i++){
							var it = instance_create_depth(x, y, depth+1, obj_item);
							it._jumptopos = [x+pos[i][0]+xoffset_, y+pos[i][1]];
							it._frombox = true;
							it._hopping = true;
							it._item = _parentobj._itemarray[i];
						}
				
						//var p = instance_create_depth(x, y-120, 0, obj_particle);
						//p._type = "explosion";
						//sfx_play_proximity(snd_explosion);
						instance_create_depth(x, y, 9000, obj_itemboxgone);
						if(_wire != noone && instance_exists(_wire)){
							instance_destroy(_wire.id);
						}
					
						_active = false;
						y = -HEIGHT;
				
						global._deletedStuff[? _parentobj.id] = _parentobj.id;
						instance_destroy(_parentobj.id);
					} else {
						//nuke
						_nukeframe += 0.2;
						if(_nukeframe >= 4){
							if(_nukeloop){
								_nukeframe = 2;
							}
						}
						if(_nukeframe >= 6){
							if(!_nukeloop){
								_nukeactive = false;
							}
						}
						if(_nukeloop && _timer >= _timermax-15){
							_nukeframe = 4;
							_nukeloop = false;
						}
						with(obj_camera){
							if(_ampY < 12){
								_ampY = 12;
							}
						}
					
						//bottom 8 dir explosion
						if(_timer % 12 == 0){
							if(_spawncount_bottom <= 4){
								_spawn8dir = true;
								_spawncount_bottom ++;
							}
						
							var p = instance_create_depth(x,y+_spawntop_offset,0,obj_particle);
							p._type = "itemexp_2";
							p._forcedepth = -1000;
							p._scale = 1.35;
						}
					
						//top explosion
						_spawntop_offset -= 24;
						var topmax = -280;
						if(_spawntop_offset <= topmax){
							_spawntop_offset = topmax;
						}
					}
				break;
			}
		} else {
			_deadtimer ++;
			if(!sfx_isplaying(snd_itemexplode) || _deadtimer >= 220){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}