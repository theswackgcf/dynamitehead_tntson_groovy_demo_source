function array_max(_array, _offset = 0, _length = undefined) {
    // resolving the offset and length
    var _arrlength = array_length(_array);
    _length ??= _arrlength;
    
    if (_offset < 0)
        _offset = max(_arrlength + _offset, 0);
    
    if (_length < 0) {
        _length = min(_offset + 1, -_length);
        _offset -= _length - 1;
    }
    
    _length = min(_arrlength - _offset, _length);
    if (_length <= 0)
        return 0;
    
    // performing the actual calculation
    if (_length <= 10000)
        return script_execute_ext(max, _array, _offset, _length);
    
    var _max = -infinity;
    for (var i = 0; i < _length; i += 10000) {
        var _partial_max = script_execute_ext(max, _array, _offset + i, min(10000, _length - i));
        _max = max(_max, _partial_max);
    }
    return _max;
} 