{
	if(!global._pause){
		_random = random(480);
	} else {
		_random = 0;
	}
	
	if(global._state != "game"){
		//shake screen only
		if(!global._pause){
			if(_ampX > 0){
				global._screenOffsetX = sin(_random)*(_ampX*global._shakevals[global._shakeval]);
				_ampX --;
			} else if(_ampX < 0){
				_ampX = 0;
			}
			if(_ampX <= 0){
				global._screenOffsetX = 0;
			}
			if(_ampY > 0){
				global._screenOffsetY = cos(_random)*(_ampY*global._shakevals[global._shakeval]);
				_ampY --;
			} else if(_ampY < 0){
				_ampY = 0;
			}
			if(_ampY <= 0){
				global._screenOffsetY = 0;
			}
		}
	}
	
	if(!global._pause){
		if(_once){
			if(!global._pauseReturn){
				_ampX = _saveAmp[0];
				_ampY = _saveAmp[1];
			} else {
				_ampX = 15;
				_ampY = 15;
				global._pauseReturn = false;
			}
			_saveAmp = [0,0];
			_once = false;
		}
	
		global._cameraX = camera_get_view_x(global._camera);
		global._cameraY = camera_get_view_y(global._camera);
	
		_cameraoffsetLerp[0] = lerp(_cameraoffsetLerp[0], global._cameraOffset[0], 0.04);
		_cameraoffsetLerp[1] = lerp(_cameraoffsetLerp[1], global._cameraOffset[1], 0.04);
	
		camera_set_view_size(global._camera, WIDTH*_cameraZoom, HEIGHT*_cameraZoom);
		_cameraZoom = _cameraZoom + (global._cameraZoom - _cameraZoom) * global._camZoomSpd;
	
		if(!_setPlayer){
			//setup player
			if(instance_number(obj_dh_mask) > 0){
				_objectTarget = instance_find(obj_dh_mask, 0);
				_setPlayer = true;
			}
		} else {
			if(instance_exists(_objectTarget)){
				if(!_init){
					//snap to player's pos
					_cameraoffsetLerp[0] = global._cameraOffset[0];
					_cameraoffsetLerp[1] = global._cameraOffset[1];
					
					x = _objectTarget.x+_cameraoffsetLerp[0];
					y = _objectTarget.y+_cameraoffsetLerp[1];
				
					_init = true;
				}
			
				var offsetX = 0;
				var offsetY = 0;
				
				var inside = [false,false];
				
				_cameraview = [global._cameraX,global._cameraY];
				
				if(_cameraview[0] > _cameraborders[0] && _cameraview[0] < _cameraborders[2]){
					inside[0] = true;
				} else {
					inside[0] = false;
				}
				
				if(_cameraview[1] > _cameraborders[1] && _cameraview[1] < _cameraborders[3]){
					inside[1] = true;
				} else {
					inside[1] = false;
				}
				
				if(!global._winscreen){
					if(!global._pause){
						if(_ampX > 0){
							if(inside[0]){
								offsetX = sin(_random)*(_ampX*global._shakevals[global._shakeval]);
							} else {
								global._screenOffsetX = sin(_random)*(_ampX*global._shakevals[global._shakeval]);
							}
							_ampX --;
						} else if(_ampX < 0){
							_ampX = 0;
						}
						if(_ampX <= 0){
							global._screenOffsetX = 0;
						}
						if(_ampY > 0){
							if(inside[1]){
								offsetY = cos(_random)*(_ampY*global._shakevals[global._shakeval]);
							} else {
								global._screenOffsetY = cos(_random)*(_ampY*global._shakevals[global._shakeval]);
							}
							_ampY --;
						} else if(_ampY < 0){
							_ampY = 0;
						}
						if(_ampY <= 0){
							global._screenOffsetY = 0;
						}
					}
				} else {
					if(!global._pause){
						if(_ampX > 0){
							global._screenOffsetX = sin(_random)*(_ampX*global._shakevals[global._shakeval]);
							_ampX --;
						} else if(_ampX < 0){
							_ampX = 0;
						}
						if(_ampX <= 0){
							global._screenOffsetX = 0;
						}
						if(_ampY > 0){
							global._screenOffsetY = cos(_random)*(_ampY*global._shakevals[global._shakeval]);
							_ampY --;
						} else if(_ampY < 0){
							_ampY = 0;
						}
						if(_ampY <= 0){
							global._screenOffsetY = 0;
						}
					}
				}
				
				if(!global._mashZoom){
					if(_mode <> 1){
						_camLocked = false;
					}
					if(_mode == 0){
						//follow player
						x = ((x + ((_objectTarget.x+_cameraoffsetLerp[0]) - x) * _spd[0])+offsetX);
						y = ((y + ((_objectTarget.y+_cameraoffsetLerp[1]) - y) * _spd[1])+offsetY - 7);
					} else if(_mode == 1){
						//follow battle zone
						if(_battleTarget != noone && instance_exists(_battleTarget)){
							var targetpos = [0,0];
							targetpos[0] = clamp(_battlezone.bbox_left+(WIDTH/2), _battleTarget.x, _battlezone.bbox_right-(WIDTH/2));
							targetpos[1] = clamp(_battlezone.bbox_top+(HEIGHT/2), _battleTarget.y, _battlezone.bbox_bottom-(HEIGHT/2));
							x = (x + (((targetpos[0]+_battlezone._camOffsetX)+_cameraoffsetLerp[0]) - x) * _spd[0])+offsetX
							y = (y + (((targetpos[1]+_battlezone._camOffsetY)+_cameraoffsetLerp[1]) - y) * _spd[1])+offsetY;
							
							if(!_camLocked){
								if(diff(x, _battleTarget.x) <= 6 && diff(y, _battleTarget.y) <= 6){
									_camLocked = true;
								}
							}
						}
					} else if(_mode == 2){
						//follow final hit instance
						if(_finalhitTarget != noone && instance_exists(_finalhitTarget)){
							x = (x + ((_finalhitTarget.x+_cameraoffsetLerp[0]) - x) * _spd[0])+offsetX;
							y = (y + ((_finalhitTarget.y+_cameraoffsetLerp[1]) - y) * _spd[1])+offsetY;
						}
					}
				}
				
				//mash follow
				if((global._mashZoom || global._tntZoom) && global._mashinst != noone && instance_exists(global._mashinst)){
					x = (x + ((global._mashinst.x+_cameraoffsetLerp[0]) - x) * _spd[0])+offsetX;
					y = (y + ((global._mashinst.y+_cameraoffsetLerp[1]) - y) * _spd[1])+offsetY;
				}
			}
		}
	
		//lock X or Y
		with(obj_dh_mask){
			if(place_meeting(x,y,obj_lockcamera)){
				var obj = instance_place(x,y,obj_lockcamera);
				other._lockX = obj._lockX;
				other._lockY = obj._lockY;
				other._lockobj = obj;
			} else {
				other._lockX = false;
				other._lockY = false;
				other._lockobj = noone;
			}
		}
	
		if(_lockobj != noone && instance_exists(_lockobj)){
			if(_lockX){
				if(y <> (_lockobj.y+_lockobj._offsetY)){
					y = y + ((_lockobj.y+_lockobj._offsetY) - y) * 0.2;
				}
			}
			if(_lockY){
				if(x <> (_lockobj.x+_lockobj._offsetX)){
					x = x + ((_lockobj.x+_lockobj._offsetX) - x) * 0.2;
				}
			}
		}
	} else {
		if(!_once){
			_saveAmp = [_ampX,_ampY];
			_ampX = 0;
			_ampY = 0;
			_once = true;
		}
		if(_ampX > 0){
			global._screenOffsetX = sin(random(480))*(_ampX*global._shakevals[global._shakeval]);
			_ampX --;
		} else if(_ampX < 0){
			_ampX = 0;
		}
		if(_ampX <= 0){
			global._screenOffsetX = 0;
		}
		if(_ampY > 0){
			global._screenOffsetY = cos(random(480))*(_ampY*global._shakevals[global._shakeval]);
			_ampY --;
		} else if(_ampY < 0){
			_ampY = 0;
		}
		if(_ampY <= 0){
			global._screenOffsetY = 0;
		}
	}
}