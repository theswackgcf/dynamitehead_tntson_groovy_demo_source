function scr_bigpunch(){
	global._tntjuice = 0;
	with(obj_dh_mask){
		var rock = instance_nearest(x,y,obj_tutr_rocks);
		if(instance_exists(rock) && distance_to_object(rock) <= WIDTH){
			sfx_play(snd_mashko, 0.65);
			global._bigpunch = 40;
			_punch_lerpx = rock.x - 520;
			rock._trigger = true;
			rock._timer = global._bigpunch;
			_height = _groundlevel;
			_bigpunch_amp = global._bigpunch;
			_curdir = DIR_R;
			_mashobj = noone;
			_mashact = 0;
			var sprinfo = asset_get_index("spr_dh_bigpunch");
			_bigpunch_frame = irandom_range(0,sprite_get_info(sprinfo).num_subimages-1);
		}
	}
}