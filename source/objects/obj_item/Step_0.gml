{
	visible = true;
	if(global._finalhit > 0 && !global._finalhit_phase){
		visible = false;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
			_checkdelete = true;
		}
	}
	if(!_init){
		switch(_item){
			case ITEM_CORN:
				//restore HP
				_restore = 20;
				_restore_type = 0;
			break;
			case ITEM_TOMATO:
				//restore more HP
				_restore = 50;
				_restore_type = 0;
			break;
			case ITEM_CHOCO:
				//add TNT points
				_restore = 24;
				_restore_type = 1;
			break;
		}
		
		sprite_index = asset_get_index("spr_item"+string(_item));
		mask_index = asset_get_index("spr_item"+string(_item));
		
		_color = _itemcolor[_item-1];
		
		_init = true;
	}
	
	if(!global._pause){
		image_speed = 1;
		_timer ++;
		
		//arc code
		if(_hopping){
			_hop_time = clamp(_hop_time + _hop_spd, 0, 1);
			x = lerp(_hop_startpos[0], _jumptopos[0], _hop_time);
			_hop_base_y = lerp(_hop_startpos[1], _jumptopos[1], _hop_time);

			_hop_arc = _hop_archeight * _hop_time * (_hop_time - 1);
			if(_hop_arc <= -8){
				_hop_arcstart = true;
			}
			y = _hop_base_y;
			
			//finish arc
			if(_hop_arcstart && _hop_arc >= 0){
				_hopping = false;
				_hop_arc = 0;
			}
		}
	} else {
		image_speed = 0;
	}
}