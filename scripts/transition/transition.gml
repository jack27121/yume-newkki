/// @function transition(room_index,duration)
/// @param	room_index the room to transition to
/// @param	function to call after the room transition. by default nothing happens
/// @description pixelates screen and switches room
function transition(room_index,callback = function(){}){
	instance_create_depth(x,y,0,obj_transition,{
		room_index: room_index,
		callback: callback
	});
}