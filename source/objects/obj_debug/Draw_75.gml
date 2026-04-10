{
	if(global._debug){
		var buildver = "";
		switch(global._buildver){
			case WINDOWS:
				buildver = "WINDOWS";
			break;
			case HTML:
				buildver = "HTML";
			break;
		}
		scr_textrender_switchfont(global._defaultFont);
		if(global._showDebug == 0){
			scr_textrender_type(0, 0, "DEBUG MODE ON\nBUILD VER: "+buildver+"\nTAB: show debug help   ALT+Q: toggle hitbox view\nALT+E: free roam\nSHIFT+1: debug room select\nALT+D: death\nALT+B: battlezone maker\nALT+T: loaded texgroups\nALT+M: memory debug", true, #FFFF00);
		} else if(global._showDebug == 1) {
			scr_textrender_type(0, 0, "DEBUG MODE ON", true, #FFFF00);
		}
		if(global._buildver == WINDOWS){
			if(global._showDebug == 0 || global._showDebug == 1){
				var mem = debug_event("DumpMemory");
				scr_textrender_type(0, HEIGHT - 40, "FPS:" + string(fps) + " | MEM:" + bytes_get_size(mem.totalUsed), true, #FFFF00);
				if(global._showTexGroupDebug){
					var loadedgroups = "";
					var groupnames = texturegroup_get_names();
					for(var i = 0; i < array_length(groupnames); ++i){
						if(texturegroup_get_status(groupnames[i]) == texturegroup_status_loaded || texturegroup_get_status(groupnames[i]) == texturegroup_status_fetched){
							if(string_pos("fallbacktexture", groupnames[i]) == 0){
								loadedgroups += "\n" + groupnames[i];
							}
						}
					}
					scr_textrender_halign("right");
					scr_textrender_type(WIDTH, 48, "loaded texture groups:" + loadedgroups, true);
					scr_textrender_halign("left");
				}
				if(global._showMemoryDebug){
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
					scr_textrender_type(WIDTH / 2, HEIGHT - 128, "Total DS Maps:" + string(_dbg_mapcount) + " | Total MP Grids:" + string(global._mpGridCount) + "\nSequence Layer Count:" + string(_dbg_layercount)+"\npress ALT+M again to update", true);
					scr_textrender_halign("left");
					scr_textrender_valign("top");
				}
			}
		}
	}
}