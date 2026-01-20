{
	if(!_init){
		global._groovylights[? self.id] = ds_map_create();
		global._groovylights[? self.id][? "draw"] = true;
		global._groovylights[? self.id][? "x"] = x;
		global._groovylights[? self.id][? "y"] = y;
		global._groovylights[? self.id][? "scalex"] = image_xscale;
		global._groovylights[? self.id][? "scaley"] = image_yscale;
		global._groovylights[? self.id][? "bbox"] = [bbox_left-global._cameraX,bbox_top-global._cameraY,sprite_width,sprite_height];
		_init = true;
	}
}