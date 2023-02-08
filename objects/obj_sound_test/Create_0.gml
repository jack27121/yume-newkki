/// @description loads the name of all the instrument sounds
fade1 = noone;
volume = 0;
init_sound_i = 0;

//easily initialises sound, and loop points if applicable
init_sound = function(path,loop_start_,loop_end_){
	sound[init_sound_i] = path;
	if(argument_count > 1){
		loop_start[init_sound_i] = loop_start_;
		loop_end[init_sound_i] = loop_end_;
	}
	init_sound_i++
}

//loads the sound
load_sound = function(){
	var path = working_directory + @"audio\instruments\" + sound[sound_selected];
	sound_loaded = FMODGMS_Snd_LoadSound(path);
	if(loop_end[sound_selected] > 0){
		var sample_start = sample_rate * loop_start[sound_selected];
		var sample_end = sample_rate * loop_end[sound_selected];
		FMODGMS_Snd_Set_LoopPoints(sound_loaded, sample_start, sample_end);
		FMODGMS_Snd_Set_LoopMode(sound_loaded,1,-1);
	}
}


//percussion
init_sound("percussion_606_1.wav");
init_sound("percussion_606_2.wav");
init_sound("percussion_606_3.wav");
init_sound("percussion_606_4.wav");
init_sound("percussion_606_5.wav");

//strings
init_sound("string_piano_1.wav");
init_sound("string_piano_2.wav");

//wind
init_sound("wind_trumpet_1.wav");
init_sound("wind_trumpet_2.wav",1,2);


sound_selected = 0;
channel[0] = FMODGMS_Chan_CreateChannel();

load_sound();