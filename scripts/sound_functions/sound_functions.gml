gml_pragma("global", "__sound_init()");

function __sound_init(){
	conductor_reset();
	global.playing = false;
	global.song = undefined;
	global.bpm = 0;
}

///@description resets all conductor beat variables
function conductor_reset() {
	global.process = 0;
	global.step = 0;
	global.steps = 0;

	global.on_bar = false;
	global.on_half_bar = false;
	global.on_beat = false;
	global.on_half_beat = false;
	global.on_quad_beat = false;
	global.on_eighth_beat = false;
}

function song_stop(){
	if(global.song != undefined){
		audio_stop_sound(global.song);
	}
	global.playing = false;
	global.song = undefined;
}

function song_play(song_name,bpm = 0){
	if(global.song != song_name){
		conductor_reset();
		song_stop();
		global.playing = true;
		global.song = song_name;
		global.bpm = bpm;
		audio_play_sound(global.song,100,true);
	}
}

/// @function pitch_change(semitones)
/// @param	semitones
/// @description use with audio_sound_pitch to pitch up x amount of semitones
function pitch_change() {
	var semitones = argument[0]; // semitones
	return power(power(2, (1/12)),semitones);
}
