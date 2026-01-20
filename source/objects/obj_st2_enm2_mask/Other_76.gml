{
	if(!global._pause){
		if(_sequence_hop_obj == noone){
			switch(event_data[? "message"]){
				case "yolobones_sfx_skate":
					sfx_play_proximity(snd_yolobones_skate);
				break;
				case "yolobones_sfx_swish":
					sfx_play_choose_proximity(global._swishsounds[0]);
					sfx_stop(snd_yolobones_skate);
				break;
				case "yolobones_sfx_board_spin":
					sfx_play_proximity(snd_yolobones_board_spin);
				break;
				case "yolobones_sfx_land":
					sfx_play_choose_proximity([asset_get_index("snd_land1_"+_floortype),asset_get_index("snd_land2_"+_floortype)]);
				break;
				case "yolobones_sfx_gulp":
					sfx_play_proximity(snd_gulp);
					sfx_stop(snd_yolobones_board_spin);
				break;
				case "yolobones_sfx_arm_rise":
					sfx_play_proximity(snd_yolobones_arm_rise);
					sfx_pitch(snd_yolobones_arm_rise, random_range(0.7, 1.3));
				break;
				case "yolobones_sfx_arm_place":
					sfx_play_proximity(snd_yolobones_arm_place);
					sfx_pitch(snd_yolobones_arm_place, random_range(0.7, 1.3));
				break;
			}
		}
	}
}