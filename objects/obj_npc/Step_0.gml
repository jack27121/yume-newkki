/// @description
event_inherited();

if(can_move){
	if(animate){
		subimg += sprite_get_speed(sprite_index);
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