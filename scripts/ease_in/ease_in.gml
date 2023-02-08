/// @function ease_in(time,begin,change,duration)
/// @description Takes a number and eases it in, stopping at a specified destination
/// @param time
/// @param start_number
/// @param change
/// @param duration_in_frames
function ease_in() {

	var t = argument[0]; // time
	var b = argument[1]; // begin
	var c = argument[2]; // change
	var d = argument[3]; // duration

	t /= d;

	return c*t*t*t+ b;




}
