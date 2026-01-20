{
	visible = false;
	if(place_meeting_array(x, y, _enmarray)){
		var enm = place_meeting_array(x, y, _enmarray, true);
		enm._idiot = true;
	}
}