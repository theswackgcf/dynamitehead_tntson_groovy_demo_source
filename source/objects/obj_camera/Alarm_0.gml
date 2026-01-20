{
	//center window
	if(global._buildver == WINDOWS){
		if(alarm_get(0) == 0){
			if(!global._dowindow){
				window_center();
				global._dowindow = true;
			}
			alarm_set(0, -1);
		}
	}
}