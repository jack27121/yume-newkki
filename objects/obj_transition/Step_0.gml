/// @description
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