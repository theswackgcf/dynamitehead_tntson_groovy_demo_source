{
	if(!global._pause){
		if(_sequence_hop_obj == noone){
			switch(event_data[? "message"]){
				case "gostlik_sfx_cloud":
					sfx_play_proximity(snd_gostlik_cloud, 0.8);
				break;
				case "gostlik_sfx_spawn":
					sfx_play_proximity(snd_gostlik_spawn, 0.65);
				break;
			}
		}
	}
}