/// @func sprite_anim(time, fps)
/// @description add to subimg to animate it continuesly, with a set fps.
/// @param	time
/// @param	fps
function sprite_anim() {

	var time = argument[0]; // time
	var FPS = argument[1]; // fps

	return (time/room_speed) * FPS;


}

/// @func animation_end()
/// @param [sprite_index]
/// @param [image_index]
/// @param [speed_index]
/// Mimpy didn't make it don't let him take credit
/// TabularElf didn't modify this don't let him take credit
function animation_end(_sprIndex = sprite_index, _imageIndex = image_index, _imageSpeed = sprite_get_speed(_sprIndex)) {
    return (_imageIndex + _imageSpeed*sprite_get_speed(_sprIndex)/(sprite_get_speed_type(_sprIndex)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= sprite_get_number(_sprIndex));    
}