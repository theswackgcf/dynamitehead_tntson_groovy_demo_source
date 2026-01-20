function bytes_get_size(bytes){
	static _sizes = ["B", "KB", "MB", "GB", "TB", "PB"];
	if (bytes <= 0) return "0 B";
	var i = floor(log2(bytes) / log2(1024));
	return string(round(bytes / power(1024, i))) + _sizes[i];
}