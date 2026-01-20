{
	if(!global._pause){
		if(global._lightsout){
			if(!_setspr){
				var sprite = asset_get_index("spr_glass_shatter"+string(_type));
				if(sprite_exists(sprite)){
					sprite_index = sprite;
				} else {
					sprite_index = spr_glass_shatter1;
				}
				
				_setspr = true;
			}
			with(obj_fade){
				_instmap[? other.id] = [other._active,other.sprite_index,other.x+sprite_get_xoffset(sprite_index),other.y+sprite_get_yoffset(sprite_index)];
			}
		}
	}
}