/// @function	collision();
/// @description   collission
function collision() {
	//decimals under 1, are too small to do collission detection, so they're checking minimum 1 pixel ahead
	var hspd_ = sign(hspd) * max(1,abs(hspd));
	var vspd_ = sign(vspd) * max(1,abs(vspd));	
	
	// Horizontal collisions
	//Checks if the player will hit the wall on the next frame
	if (place_meeting(x+hspd_, y, obj_wall)) {
		//moves the player one pixel closer until it's just next to the wall, and then stop moving
		while(!place_meeting(x+sign(hspd_), y, obj_wall)) {
			x += sign(hspd);
		}
		hspd = 0;
	} else x+= hspd;
	
	// Vertical collisions
	if (place_meeting(x, y+vspd_, obj_wall)) {
		while(!place_meeting(x, y+sign(vspd_), obj_wall)) {
			y += sign(vspd);
		}
		vspd = 0;
	} else	y+= vspd;
}