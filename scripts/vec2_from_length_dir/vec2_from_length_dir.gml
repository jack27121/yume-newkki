/// @description Creates a 2D vector array based on a length and direction
/// @param length
/// @param direction
function vec2_from_length_dir(argument0, argument1) {

	var _v;
	_v[0] = lengthdir_x(argument0,argument1);
	_v[1] = lengthdir_y(argument0,argument1);
	return _v;


}
