/// @desc timer_check(timer) checks if timer has reached 0
/// @arg timer
function timer_check(timer_) {
	if (instance_exists(timer_)){
		if (timer_.timer == 0) return true;	
	}
	return false;
}

/// @desc timer_create (seconds) creates object with var "timer", that counts down to 0
/// @arg seconds
function timer_create(seconds) {
	var object = create_object(obj_timer);
	object.timer = seconds * room_speed;
	return object;
}