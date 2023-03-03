/// @description

// Inherit the parent event
event_inherited();

script = function(){
	var pitch = random_range(0.6,1.4);
	audio_play_sound(snd_phone_ring,0,0,,,pitch);	
}