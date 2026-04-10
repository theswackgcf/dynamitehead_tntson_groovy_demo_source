function scr_culling(timer = 12){
	_cullingtimer ++;
	
	var dont = [
		obj_screen_tr,
		
		obj_game,
		
		obj_camera,
		obj_audio,
		obj_music,
		obj_input,
		obj_colors,
		
		obj_debug,
		obj_bz_maker,
		
		obj_battleborder,
		obj_gui_enemynear,
		obj_bzone_fx,
		
		obj_finish,
		
		obj_stageentrance,
		obj_startstar,
		
		obj_dh_display,
		obj_dh_mask,
		obj_dh_hurtbox,
		obj_dh_prompts,
		obj_spawn_dh_here,
		obj_tnt,
		
		obj_results,
		obj_stareffect,
		obj_winhellyeah,
		obj_windh,
		obj_winbg,
		
		obj_optbtn,
		obj_menuclickable,
		obj_options,
		obj_menu_desc,
		obj_menu_enabled,
		
		obj_gui,
		obj_pause,
		obj_prompts,
		obj_vsscreen,
		obj_bg,
		
		obj_fade,
		obj_enemyzone,
		
		obj_dialogue,
		obj_lighting,
		obj_kohit,
		obj_enm_manager,
		obj_layers,
		obj_shadows,
		
		obj_stage_secret,
		obj_stage_secret_solid,
		
		obj_st2_fogzone,
		obj_st2_rain,
		obj_st2_rain_floor,
		obj_st2_wall,
		obj_st2_walltrigger,
		obj_wallsolid,
		obj_st2_redlake_henchie,
		obj_st2_thingupthere,
		
		obj_tutr_rocks,
		obj_fridge_display,
		obj_fridge_mask,
		obj_fridge_hurtbox,
	];
	
	if(_cullingtimer >= timer){
		var size = [WIDTH/2,HEIGHT/2];
		var threshold = WIDTH;
		
		var region = [global._cameraX,global._cameraY,WIDTH,HEIGHT]; //left top width height
		if(global._battlezone){
			var bzone = global._battleobj;
			if(bzone != noone && instance_exists(bzone)){
				region = [bzone.bbox_left,bzone.bbox_top,bzone.sprite_width,bzone.sprite_height];
				bzone = noone;
			}
		}
		
		instance_deactivate_region(region[0]-size[0],region[1]-size[1],region[2]+(size[0]*2),region[3]+(size[0]*2),false,true);
		instance_activate_region(region[0]-(size[0]+threshold),region[1]-(size[1]+threshold),region[2]+((size[0]*2)+threshold),region[3]+((size[1]*2)+threshold),true);
		
		//reactivate important objects
		for(var d = 0; d < array_length(dont); d++){
			instance_activate_object(dont[d]);
		}
		
		_cullingtimer = 0;
	}
}