/// @description
if(can_move){
	if(animate){
		subimg += sprite_get_speed(sprite_index);
	}
	hspd = (input_check("right") - input_check("left"));
	vspd = (input_check("down") - input_check("up"));
	
	if(hspd != 0 || vspd != 0){
		dir = point_direction(0,0,hspd,vspd);
		
		//corrects speed for diagonal movement
		hspd = lengthdir_x(spd,dir);
		vspd = lengthdir_y(spd,dir);
	}
	
	collision(); //movement and collision
	
	if(input_check_pressed("action")){
		var check_x = x+lengthdir_x(2, dir);
		var check_y = y+lengthdir_y(2, dir);
		var object = instance_place(check_x, check_y, obj_interactable);
			if (object == noone) object = instance_place(check_x, check_y, obj_interactable_nonSolid);
			if (object != noone){
				object.trigger = true;
		};
	}
	
	if((hspd != 0 || vspd != 0) && footstep_t = 0){
		audio_play_sound(snd_footstep_regular,0,0,,,sound_pitch);
		footstep_t = footstep_tmax;
	} else if(footstep_t > 0) footstep_t--;
	
	depth = -y;
	
	state.step();
}