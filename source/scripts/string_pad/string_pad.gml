function string_pad(num, digit, amount){
	return string_replace_all(string_format(num, amount, 0), " ", digit);
}