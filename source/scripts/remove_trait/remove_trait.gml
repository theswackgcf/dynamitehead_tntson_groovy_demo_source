///function remove_trait(trait, [object])
function remove_trait(trait, object = noone){
	//remove a trait of an enemy
	var array_;
	if(object == noone){
		array_ = _enemytraits;
	} else {
		array_ = object._enemytraits;
	}
	
	if(!is_array(trait)){
		if(array_contains(array_, trait)){
			for(var i = 0; i < array_length(array_); i++){
				if(array_[i] == trait){
					array_delete(array_, i, 1);
				}
			}
		}
	} else {
		for(var o = 0; o < array_length(trait); o++){
			if(array_contains(array_, trait[o])){
				for(var i = 0; i < array_length(array_); i++){
					if(array_[i] == trait[o]){
						array_delete(array_, i, 1);
					}
				}
			}
		}
	}
}