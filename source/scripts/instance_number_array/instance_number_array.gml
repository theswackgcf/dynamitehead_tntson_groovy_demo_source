///function instance_number_array(array)
function instance_number_array(arr){
	var curnum = 0;
	for(var i = 0; i < array_length(arr); i++){
		curnum += instance_number(arr[i]);
	}
	return curnum;
}