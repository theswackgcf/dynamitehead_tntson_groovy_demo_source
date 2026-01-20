{
	if(global._gameshadows != undefined && global._gameshadows != -1){
		ds_map_destroy(global._gameshadows);
		global._gameshadows = -1;
	}
}