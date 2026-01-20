///function diff_abs(p1, p2)
function diff_abs(p1, p2){
	if(p2 > p1){
		return abs(p2)-abs(p1);
	} else if(p1 > p2){
		return abs(p1)-abs(p2);
	} else {
		return 0;
	}
}