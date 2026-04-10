{
	if(global._battlezone){
		//if battlezone, get current battlezone object
		_bzone = instance_place(x,y,obj_battlezone);
		if(_bzone != noone && instance_exists(_bzone)){
			//find out if the current wave matches
			if(array_contains(_waves, _bzone._curwave)){
				for(var i = 0; i < instance_number(obj_dh_mask); i++){
					var pl = instance_find(obj_dh_mask,i);
					//get players' hp
					if(instance_exists(pl)){
						if(!_spawn && pl._hp < 32){
							//low enough, spawn item
							_itemobj = instance_create_depth(x,y,depth,obj_item);
							_itemobj._item = _item;
							_itemobj._falloff = true;
							_itemobj._height = HEIGHT;
							
							_spawn = true;
						}
					}
				}
			}
		}
		
		//spawned item no longer exists, reset
		if(_spawn && _itemobj != noone && !instance_exists(_itemobj)){
			_spawn = false;
			_itemobj = noone;
		}
	} else {
		_bzone = noone;
		_itemobj = noone;
	}
}