/// @description
global.t++;

if(game_active){
	global.user_data.time_played++;
}

state.step();