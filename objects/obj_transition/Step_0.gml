/// @description

obj_camera.post_processing = function(){
	shader_set(sh_pixelate);
	shader_set_uniform_f(u_dimensions, global.game_w,global.game_h);
	shader_set_uniform_f(u_cell_size,((t / duration)*cell_size));
}

if(in_out == 0){
	t++;
	if(t == duration){
		in_out = 1;	
		room_goto(room_index);
	}
} else {
	t--;
	if (t == 0){
		obj_camera.post_processing = -1;
		instance_destroy();
	}
}