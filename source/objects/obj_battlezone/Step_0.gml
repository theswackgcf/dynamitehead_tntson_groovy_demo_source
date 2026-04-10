{
	if(!global._pause){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
				_checkdelete = true;
			}
		}
		
		if(_act == 1 && !_init){
			global._battlezone = true;
			global._bzactive = false;
			global._bzone_enemies = [[]];
			global._battleobj = self.id;
			global._enmorder = 0;
			
			if(_resize){
				if(image_xscale < 1){
					image_xscale = 1;
				}
				if(image_yscale < 1){
					image_yscale = 1;
				}
			}
			
			_bzSize = [sprite_width, sprite_height];
			
			//create borders
			var pos = [[x-(_bzSize[0]/2),y],[x+(_bzSize[0]/2),y],[x,y-(_bzSize[1]/2)],[x,y+(_bzSize[1]/2)]];
			var sX = sprite_get_width(spr_battleborder);
			var sY = sprite_get_height(spr_battleborder);
			var size = [[1, _bzSize[1]/(sY/2)],[1, _bzSize[1]/(sY/2)],[_bzSize[0]/(sX/2), 1],[_bzSize[0]/(sX/2), 1]];
			var bds = ["l","r","u","d"];
			for(var i = 0; i < 4; i++){
				var b = instance_create_depth(pos[i][0], pos[i][1], 0, obj_battleborder);
				b.image_xscale = size[i][0];
				b.image_yscale = size[i][1];
				if(bds[i] == "u"){
					b.image_yscale = size[i][1]*_border_top_size;
				}
				if(bds[i] == "d"){
					b.image_yscale = size[i][1]*_border_bottom_size;
				}
				b._side = bds[i];
				_borders[i] = b.id;
			}
			_enemies[array_length(_enemies)] = [];
		
			with(obj_dh_mask){
				_occupied = [noone, noone];
			}
		
			_init = true;
		}
		
		if(_activated && !_deleteenm){
			for(var i = 0; i < array_length(global._enemyArray); i++){
				//delete off screen, non battlezone enemies
				with(global._enemyArray[i]){
					if(variable_instance_exists(self.id, "_finalko_obj")){
						if(!_finalko_obj){
							if(variable_instance_exists(self.id, "_inactive")){
								if(_inactive){
									killself();
								}
							}
							if(variable_instance_exists(self.id, "_battlezone")){
								if(!_battlezone && !place_meeting(x, y, obj_battlezone)){
									_forcedeath = true;
									_hp = 0;
									_despawndeath = true;
									_death = true;
									_falling = true;
									_fixwall = true;
									_jump = true;
									_height = _groundlevel + 1;
									_falls = 0;
									_vspd = 18;
								}
							}
						}
					}
				}
			}
			_deleteenm = true;
		}
		
		if(_act == 1){
			if(!_activated){
				if(!global._bzmaker){
					if(_cutscene != noone){
						with(_cutscene){
							_start = true;
						}
					}
				}
				
				_tutr_bigpunch = false;
				
				_curwave = 0;
				_activated = true;
				_waveinit = false;
			} else {
				if(!global._bzmaker){
					if(ds_map_size(global._bzone_fx) == 0){
						if(instance_number_array(global._enemyArray) == 0 && instance_number(obj_enmspawn) == 0){
							global._enmorder = 0;
							_curwave ++;
							_waveinit = false;
						}
					}
				}
			}
			
			if(!global._bzmaker && _curwave >= array_length(_enemies)-1){
				if(_act == 1){
					if(!global._bossstart){
						var gonext = true;
						
						if(global._tutorial){
							if(place_meeting(x,y,obj_tutr_rocks)){
								var rocks = instance_place(x,y,obj_tutr_rocks);
								if(instance_exists(rocks) && !rocks._throw && !_tutr_bigpunch){
									scr_bigpunch();
									_tutr_bigpunch = true;
								}
								gonext = false;
							}
						}
						
						if(gonext){
							_gonext_xpos = 0;
						
							scr_gonext_update("x", true);
						
							var startposy = global._cameraY-290;
							if(_side == "d"){
								startposy = global._cameraY+global._camerasize[1]+290;
							}
							_gonext_inst = instance_create_depth(_gonext_xpos, startposy, -9999, obj_next);
							_gonext_inst._parentobj = self.id;
						
							scr_gonext_update("y", true);
						
							_gonext_inst._type = _type;
							_gonext_inst._side = _side;
						
							global._battlezone = false;
							global._battleobj = noone;
						
							global._deletedStuff[? self.id] = self.id;
					
							ds_map_destroy(_allsounds);
							_allsounds = -1;
						}
					} else {
						//winnage
						with(obj_fade){
							_fadeTo = 0;
							_fadeSpd = 0.04;
						}
					}
						
					_curwave = array_length(_enemies)-1;
					_act = 2;
					if(global._tutorial){
						if(place_meeting(x,y,obj_tutr_rocks)){
							_act = 1;
						}
					}
					_waveinit = true;
				}
			}
			
			//finishing in battlezone maker
			if(global._bzmaker && global._bzactive && instance_number_array(global._enemyArray) == 0 && instance_number(obj_bzone_enemy) == 0 && instance_number(obj_enmspawn) == 0){
				if(ds_map_size(global._bzone_fx) == 0){
					global._enmorder = 0;
					_curwave ++;
					if(_curwave >= array_length(global._bzone_enemies)){
						array_push(global._bzone_enemies, []);
					}
					global._bzactive = false;
				}
			}
			
			if(!_waveinit && _curwave < array_length(_enemies)){
				for(var i = 0; i < array_length(_enemies[_curwave]); i++){
					//spawn enemy
					if(array_length(_enemies[_curwave][i]) >= 4){
						var enmindex = _enemies[_curwave][i][3];
						var enmtospawn = 0;
						var enmtype = -1;
						var enmobj = false;
						var fx = false;
						if(is_array(enmindex)){
							enmtospawn = enmindex[0];
							if(!is_string(enmindex[1])){
								enmtype = enmindex[1];
							} else {
								switch(enmindex[1]){
									case "obj":
										enmobj = true;
									break;
									case "fx":
										fx = true;
									break;
								}
								if(array_length(enmindex) == 3){
									enmtype = enmindex[2];
								}
							}
						} else {
							enmtospawn = enmindex;
						}
					
						var spawnX = 0;
						var spawnY = 0;
						var offscreenspawn = [];
						var addoffset = [0,0,0,0];
						if(ds_map_exists(global._sequenceOffset, enmtospawn)){
							addoffset = [
							global._sequenceOffset[? enmtospawn][0],
							global._sequenceOffset[? enmtospawn][1],
							global._sequenceOffset[? enmtospawn][2],
							global._sequenceOffset[? enmtospawn][3]
							];
						}
						var offscreen_offset = [-96+addoffset[0],-96+addoffset[1],-100+addoffset[2],30+addoffset[3]]; //l r u d
						var onscreen_offset = [global._cameraX-128+addoffset[0],(global._cameraX+WIDTH)+128+addoffset[1],global._cameraY+128+addoffset[2],(global._cameraY+HEIGHT)+128+addoffset[3]];
						
						var borderoffset = 0;
						
						switch(_enemies[_curwave][i][0]){
							case "l":
								spawnX = x-(_bzSize[0]/2)+global._battlezonerange;
								spawnY = y-(_bzSize[1]/2)+_enemies[_curwave][i][1];
								offscreenspawn[0] = x-(_bzSize[0]/2)-offscreen_offset[0];
								offscreenspawn[1] = spawnY;
								if(image_xscale < 1){
									offscreenspawn[0] = onscreen_offset[0];
								}
							break;
							case "r":
								spawnX = x+(_bzSize[0]/2)-global._battlezonerange;
								spawnY = y-(_bzSize[1]/2)+_enemies[_curwave][i][1];
								offscreenspawn[0] = x+(_bzSize[0]/2)+offscreen_offset[1];
								offscreenspawn[1] = spawnY;
								if(image_xscale < 1){
									offscreenspawn[0] = onscreen_offset[1];
								}
							break;
							case "u":
								borderoffset = sprite_get_height(spr_battleborder)*(_border_top_size-1);
							
								spawnX = x-(_bzSize[0]/2)+_enemies[_curwave][i][1];
								spawnY = y-(_bzSize[1]/2)+global._battlezonerange+borderoffset;
								offscreenspawn[0] = spawnX;
								offscreenspawn[1] = y-(_bzSize[1]/2)-offscreen_offset[2]+borderoffset;
								if(image_yscale < 1){
									offscreenspawn[1] = onscreen_offset[2]+borderoffset;
								}
							break;
							case "d":
								borderoffset = -(sprite_get_height(spr_battleborder)*(_border_bottom_size-1));
							
								spawnX = x-(_bzSize[0]/2)+_enemies[_curwave][i][1];
								spawnY = y+(_bzSize[1]/2)-global._battlezonerange+borderoffset;
								offscreenspawn[0] = spawnX;
								offscreenspawn[1] = y+(_bzSize[1]/2)+offscreen_offset[3]+borderoffset;
								if(image_yscale < 1){
									offscreenspawn[1] = onscreen_offset[3]+borderoffset;
								}
							break;
							case "c":
								spawnX = x-(_bzSize[0]/2)+_enemies[_curwave][i][1][0];
								spawnY = y-(_bzSize[1]/2)+_enemies[_curwave][i][1][1];
								offscreenspawn[0] = spawnX;
								offscreenspawn[1] = spawnY;
							break;
						}
				
						//fade
						var fade = false;
						if(array_length(_enemies[_curwave][i]) >= 5 && _enemies[_curwave][i][4] == true){
							fade = true;
						}
						var spawntype = 0;
						if(array_length(_enemies[_curwave][i]) >= 6){
							spawntype = _enemies[_curwave][i][5];
						}
					
						if(!fx){
							var en = instance_create_depth(spawnX, spawnY+borderoffset, 0, obj_enmspawn);
							en._spawnnum = i;
							en._asset = asset_get_index("obj_"+enmtospawn+"_mask");
							en._spawnX = spawnX;
							en._spawnY = spawnY;
							en._spawndir = _enemies[_curwave][i][0];
							en._order = _enemies[_curwave][i][2]; //
							en._spawnpos = [spawnX, spawnY];
							en._offscreenpos = [offscreenspawn[0], offscreenspawn[1]];
							if(variable_instance_exists(en, "_enmtype")){
								en._doenmtype = true; //
								en._enmtype = enmtype;
							}
							if(variable_instance_exists(en, "_startTimer")){
								en._dostarttimer = true; //
								var multnum = 24;
								en._startTimer = en._spawnnum*multnum;
								if(global._delayspawn > 0){
									en._startTimer = (en._spawnnum*multnum)+global._delayspawntime;
								}
							}
							en._battlezone = true;
							en._bzobj = self.id;
							en._enmobj = enmobj; //
							en._spawntype = spawntype; //
							if(!enmobj){
								en._ailevel += global._progress;
								en._bzstart = 120;
								en._bzstart_offset = [random_range(-350,350),random_range(-350,350)];
								if(spawntype == SPAWN_NORMAL){
									en._curstate = STATE_WALK;
									en._walkto = [x,y];
								}
								en._startFade = fade;
								if(spawntype == SPAWN_FALLPLANKS){
									en._fallabove = true;
									en._height = 10;
									en._vspd = -8;
									en._jump = true;
									en._standup = true;
								}
							}
						} else {
							//spawn bg or fg effects
							var en = instance_create_depth(spawnX, spawnY, 0, enmindex[0]);
							en._delay = _enemies[_curwave][i][1];
							en._order = _enemies[_curwave][i][2];
							if(array_length(enmindex) >= 3){
								en._spawndir = enmindex[2];
							}
							if(array_length(enmindex) >= 4){
								en._enmtype = enmindex[3];
							}
						}
					}
				}
			}
			
			_waveinit = true;
		}
	}
	
	if(_clear && !_bzcleared){
		_enemies = [];
		_bzcleared = true;
	}
	
	if(global._debug){
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
	}
}