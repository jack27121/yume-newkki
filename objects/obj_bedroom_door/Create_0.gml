/// @description
script = function(){
	if(dreaming){ //opens door and goes to nexus
		image_index = 1;
		
		audio_play_sound(snd_open_door,0,0,,,0.8);
		
		alarm[0] = room_speed;
		
	} else {
		//player shakes head
	}
}