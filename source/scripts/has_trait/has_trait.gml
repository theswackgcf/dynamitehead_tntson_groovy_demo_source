///function has_trait(trait, [object])
function has_trait(trait, object = noone){
	//check enemy trait
	if(object == noone){
		if(array_contains(_enemytraits, trait)){
			return true;
		} else {
			return false;
		}
	} else {
		if(array_contains(object._enemytraits, trait)){
			return true;
		} else {
			return false;
		}
	}
}