/// @description if the vector exceeds the given length, it will be returned truncated to max length.
/// @param vector
/// @param max_length
function vec2_truncate(_vec, _len) {
	if(vec2_length(_vec) > _len)
	    _vec=vec2_scale(_vec,_len);
	return _vec;
}