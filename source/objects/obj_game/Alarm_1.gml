{
	//center window
	if(alarm_get(1) == 0){
		window_center();
		alarm_set(1, -1);
	}
}