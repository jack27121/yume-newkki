/// @function	collision();
/// @description   collission
function collision(_hspd,_vspd) {
	//decimals under 1, are too small to do collission detection, so they're checking minimum 1 pixel ahead
	var _hspd_ = sign(_hspd) * max(1,abs(_hspd));
	var _vspd_ = sign(_vspd) * max(1,abs(_vspd));	
	
	// Horizontal collisions
	//Checks if the player will hit the wall on the next frame
	if (place_meeting(x+_hspd_, y, obj_wall)) {
		//moves the player one pixel closer until it's just next to the wall, and then stop moving
		while(!place_meeting(x+sign(_hspd_), y, obj_wall)) {
			x += sign(_hspd);
		}
		_hspd = 0;
	} else x+= _hspd;
	
	// Vertical collisions
	if (place_meeting(x, y+_vspd_, obj_wall)) {
		while(!place_meeting(x, y+sign(_vspd_), obj_wall)) {
			y += sign(_vspd);
		}
		_vspd = 0;
	} else	y+= _vspd;
}