//The different types of transition effects
enum transition_type{
	pixelate,
	fade
}

/// @function transition(room_index,duration)
/// @param	room_index the room to transition to
/// @param	function to call after the room transition. by default nothing happens
/// @param	duration for transition
/// @param	transition type
/// @description pixelates screen and switches room
function transition(room_index,callback = function(){},duration = room_speed,transition_type_ = transition_type.fade){
	instance_create_depth(x,y,0,obj_transition,{
		room_index: room_index,
		callback: callback,
		duration: duration,
		transition_type_: transition_type_,
	});
}