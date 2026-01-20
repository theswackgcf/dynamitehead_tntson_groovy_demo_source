{
	ds_map_delete(global._bzone_fx, self.id);

	ds_map_destroy(_allsounds);
	_allsounds = -1;
}