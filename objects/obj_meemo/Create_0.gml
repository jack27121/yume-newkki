/// @description
event_inherited();

script = function(){
	if(alarm[0] == -1){
		audio_play_sound(snd_guh,0,0);
		image_index = 1;
		alarm[0] = 40;
	}
}
