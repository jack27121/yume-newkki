/// @description buttons
//plays sound
if(global.xKeyPressed){
	if(instance_exists(fade1)){
		instance_destroy(fade1);
		FMODGMS_Chan_StopChannel(0);
	}
	FMODGMS_Snd_PlaySound(sound_loaded,0);
	FMODGMS_Chan_Set_Volume(0,1);
	FMODGMS_Chan_Set_Position(0,0);
}

if(global.xKeyReleased){
	//FMODGMS_Chan_StopChannel(0);
	fade1 = FMODGMS_Chan_Fade_Volume(0,0,15);
}
volume = FMODGMS_Chan_Get_Volume(0);
if(volume <= 0) FMODGMS_Chan_StopChannel(0);

if(global.lKeyReleased){
	sound_selected--;
	if (sound_selected < 0) sound_selected = array_length(sound)-1;
	load_sound();
}

if(global.rKeyReleased){
	sound_selected++;
	if (sound_selected > array_length(sound)-1) sound_selected = 0;
	load_sound();
}

