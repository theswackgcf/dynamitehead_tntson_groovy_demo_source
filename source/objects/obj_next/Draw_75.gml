{
	var camzoom = instance_find(obj_camera,0)._cameraZoom;
	if(camzoom <> 0){
		draw_sprite_ext(sprite_index, image_index, (x-(global._cameraX)+_offset[0])/camzoom, (y-(global._cameraY)+_offset[1])/camzoom, image_xscale/camzoom, image_yscale/camzoom, 0, #FFFFFF, 1);
	}
}