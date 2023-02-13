function sprite_get_speed_pingpong(subimg = image_index,_sprIndex = sprite_index){
	
	if (!variable_instance_exists(self,"ping_pong")) ping_pong = 1;
	
	show_debug_message(subimg);
	if (((subimg div sprite_get_number(_sprIndex)) mod 2) == 0){
		show_debug_message("flip");	
		ping_pong = -ping_pong;
	}
	
	return sprite_get_speed(sprite_index) * ping_pong;
}

/// @param sprite
/// @param image

function PingPongImage(_sprite, _image)
{
    if (_image < 1) return 0;
    
    var _count = sprite_get_number(_sprite)-1;
    if (_count <= 0) return 0;
    
    _image = (_image - 0.5) mod (2*_count);
    if (_image > _count) _image = 2*_count - _image;
    
    return floor(_image + 0.5);
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