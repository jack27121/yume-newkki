/// @description

// Inherit the parent event
event_inherited();

transition_spd = room_speed * 0.1;

script = function(){
	image_index = 1;	
	audio_play_sound(snd_open_door,0,0,,,0.8);
	obj_player.controlled = false;
	
	transition(room_index,function(){
		//moves player to target
		if(spawn_target != -1){
			obj_player.x = spawn_target.x + offset_x;	
			obj_player.y = spawn_target.y + offset_y;
		}
		
		//decides which direction player is facing when spawned
		switch (player_direction) {
		    case "back":
		        with(obj_player) sprite_index = back;
		        break;
		    case "left":
		        with(obj_player) sprite_index = left;
		        break;
			case "right":
		        with(obj_player) sprite_index = right;
		        break;
			case "forward":
		        with(obj_player) sprite_index = forward;	
		        break;
		}
	},transition_spd,transition_type.fade);
}