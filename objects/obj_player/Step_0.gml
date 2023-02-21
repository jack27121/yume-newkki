/// @description
if(can_move){
	if(animate){
		subimg += sprite_get_speed(sprite_index);
	}
	
	//lets user move and interact the player
	if(controlled){
		hspd = (input_check("right") - input_check("left"));
		vspd = (input_check("down") - input_check("up"));
		
		if(input_check_pressed("action")){
			var check_x = x+lengthdir_x(6, dir);
			var check_y = y+lengthdir_y(6, dir);
			var object = instance_place(check_x, check_y, obj_interactable);
			if (object == noone) object = instance_place(check_x, check_y, obj_interactable_nonSolid);
			if (object != noone){
					object.trigger = true;
			};
		}
	} else if(xDest != undefined || yDest != undefined){ //can be turned on and be made to move externally
		if(abs(x - xDest) < 1) x = xDest;
		if(abs(y - yDest) < 1) y = yDest;
		hspd = xDest - x;
		vspd = yDest - y;
	}
	
	if(hspd != 0 || vspd != 0){
		dir = point_direction(0,0,hspd,vspd);
		
		//corrects speed for diagonal movement
		hspd = lengthdir_x(spd,dir);
		vspd = lengthdir_y(spd,dir);
	} 
	
	depth = -y;
	
	xscale = lerp(xscale,1,0.1);
	yscale = lerp(xscale,1,0.1);
	
	state.step();
}