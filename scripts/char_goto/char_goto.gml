/// @desc char_goto (npc,dest) Tells npc to go to position
/// @arg npc
/// @arg dest
function char_goto(argument0, argument1) {
	var npc = argument0
	var dest = argument1

	npc.xDest = dest.x;
	npc.yDest = dest.y;
	npc.dest_reached = false;

	var dir = dest.image_angle;
	if (dir<0){
		npc.dir_facing = dir + 360;
	} else if(dir > 360){
		npc.dir_facing = dir - 360;
	} else{
		npc.dir_facing = dir;
	}


}
