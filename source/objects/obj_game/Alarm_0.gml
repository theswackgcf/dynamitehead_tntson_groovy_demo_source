{
	if(alarm_get(0) > 0){
		scr_adjustguiscale();
		alarm_set(0, -1);
	}
}