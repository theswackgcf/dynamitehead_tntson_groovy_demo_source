{	
	if(!global._pause){
		if(_sequence_hop_obj == noone){
			switch(event_data[? "message"]){
				case "henchie_sfx_swish":
					sfx_play_choose_proximity(global._swishsounds[0]);
				break;
				case "henchie_sfx_bone":
					sfx_play_proximity(snd_bonecrack);
					sfx_pitch(snd_bonecrack, random_range(0.7,1.1));
				break;
				case "henchie_sfx_notice":
					sfx_play_proximity(snd_henchie_notice);
				break;
				case "henchie_sfx_land":
					sfx_play_choose_proximity([asset_get_index("snd_land1_"+_floortype),asset_get_index("snd_land2_"+_floortype)]);
				break;
				case "henchie_particles":
					var p = instance_create_depth(layer_sequence_get_x(_sequence)-190,layer_sequence_get_y(_sequence)+70,-16,obj_particle);
					p._type = "run4";
					p._move = true;
					p._xspd = -6;
					var p2 = instance_create_depth(layer_sequence_get_x(_sequence)+48,layer_sequence_get_y(_sequence)+70,-16,obj_particle);
					p2._type = "run5";
					p2._move = true;
					p2._xspd = 6;
				break;
			}
		}
	}
}