///function add_trait(trait, [object])
function add_trait(trait, object = noone){
	//add a trait to an enemy
	var array_;
	if(object == noone){
		array_ = _enemytraits;
	} else {
		array_ = object._enemytraits;
	}
	if(!is_array(trait)){
		if(!array_contains(array_, trait)){
			array_push(array_, trait);
		}
	} else {
		for(var o = 0; o < array_length(trait); o++){
			if(!array_contains(array_, trait[o])){
				array_push(array_, trait[o]);
			}
		}
	}
}