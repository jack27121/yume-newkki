///@description Returns the direction of the given vector
///@arg vector
function vec2_dir(argument0) {
	var _vec = argument0;
	if(_vec[0]==0 && _vec[1]==0) return no_direction;

	return point_direction(0,0,_vec[0],_vec[1]);


}
