/// @description
hspd = 0;
vspd = 0;
dir = 0;
spd = 1;

animate = 1;

footstep_t = 0;
footstep_tmax = 20;

current_effect = "normal";

state = new SnowState("normal");

subimg = 0;

sound_pitch = 0;

#region normal
state.add("normal", {
	enter: function(){
		
		right = spr_player_right;
		back = spr_player_back;
		left = spr_player_left;
		forward = spr_player_forward;
		
		sprite_index = forward;
		
		sound_pitch = 1;
		spd = 1;
	},
	step: function(){
		state.change("idle");
	}
});

state.add("idle", {
	enter: function(){
		animate = false;
		subimg = 1;
		walking_state = "walking";
	},
	step: function(){		
		if(hspd != 0 || vspd != 0){
			state.change(walking_state);
		}
	}
});

state.add("walking", {
	enter: function(){
		animate = true;
		subimg = 0;
		idle_state = "idle";
	},
	step: function(){
		if (dir == 0)		 sprite_index = right;
		else if (dir == 90)  sprite_index = back;
		else if (dir == 180) sprite_index = left;
		else if (dir == 270) sprite_index = forward;

		if(hspd == 0 && vspd == 0){
			state.change(idle_state);
		}
	}
});
#endregion

#region stick
state.add_child("normal","Stick", {
	enter: function(){	
		state.inherit();
		
		right = spr_player_stick_right;
		back = spr_player_stick_back;
		left = spr_player_stick_left;
		forward = spr_player_stick_forward;
		
		sprite_index = forward;
		
		sound_pitch = 2;
		spd = 0.6;
	},
	step: function(){
		state.change("stick_idle");
	}
});

state.add_child("idle","stick_idle", {
	enter: function(){
		state.inherit();
		walking_state = "stick_walking";	
	},
});

state.add_child("walking","stick_walking", {
	enter: function(){
		state.inherit();
		idle_state = "stick_idle";
	},
});
#endregion