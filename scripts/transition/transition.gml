/// @function transition(room_index,duration)
/// @param	room_index the room to transition to
/// @description pixelates screen and switches room
function transition(room_index){
	instance_create_depth(x,y,0,obj_transition,{
		room_index: room_index,
	});
}