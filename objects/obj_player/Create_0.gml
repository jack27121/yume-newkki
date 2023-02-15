/// @description
hspd = 0;
vspd = 0;
dir = 270;
controlled = true;
xDest = undefined;
yDest = undefined;

spd_base = 1;
spd = spd_base;

animate = 1;

footstep_t = 0;
footstep_tmax = 20;

current_effect = "normal";

state = new SnowState("normal");
wakee_state = -1;
walking_state = -1;
idle_state = -1;

subimg = 0;
xscale = 1;
yscale = 1;

sound_pitch = 0;
ping_pong = true;

choose_direction = function (){
	if (dir == 0)		 sprite_index = right;
	else if (dir == 90)  sprite_index = back;
	else if (dir == 180) sprite_index = left;
	else if (dir == 270) sprite_index = forward;	
}

wake_check = function(){
	if(input_check_pressed("wake")){
		if(wake_state != -1){
			state.change(wake_state);
		} else {
			audio_play_sound(snd_ui_decline,0,0);	
		}
	}
}

#region normal
state.add("normal", {
	enter: function(){
		
		right = spr_player_right;
		back = spr_player_back;
		left = spr_player_left;
		forward = spr_player_forward;
		
		choose_direction();
		
		sound_pitch = 1;
		spd = 1;
		wake_state = "wake";
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
		collision(hspd,vspd); //movement and collision
		wake_check();
	}
});

state.add("walking", {
	enter: function(){
		animate = true;
		subimg = 0;
		idle_state = "idle";
	},
	step: function(){
		choose_direction();
		
		if(footstep_t = 0){
			audio_play_sound(snd_footstep_regular,0,0,,,sound_pitch);
			footstep_t = footstep_tmax;
		} else if(footstep_t > 0) footstep_t--;

		if(hspd == 0 && vspd == 0){
			state.change(idle_state);
		}
		collision(hspd,vspd); //movement and collision
		wake_check();
	}
});

state.add("wake", {
	enter: function(){
		animate = true;
		subimg = 0;
		ping_pong = false;
		sprite_index = spr_player_wake;
	},
	step: function(){		
		subimg = clamp(subimg,0,sprite_get_number(sprite_index));
		if(animation_end(sprite_index,subimg) && !instance_exists(obj_transition)){
			transition(rm_bedroom);
		}
	},
	leave: function(){
		ping_pong = true;
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

#region penguin
state.add_child("normal","Penguin", {
	enter: function(){	
		state.inherit();
		
		right	=	spr_player_penguin_right;
		back	=	spr_player_penguin_back;
		left	=	spr_player_penguin_left;
		forward =	spr_player_penguin_forward;
		
		sprite_index = forward;
		
		sound_pitch = 1;
		spd = 0.5;
	},
	step: function(){
		state.change("penguin_idle");
	}
});

state.add_child("idle","penguin_idle", {
	enter: function(){
		state.inherit();
		spd = 0.5;
		walking_state = "penguin_walking";
	},
	step: function(){
		state.inherit();
		if(input_check_pressed("special")){
			state.change("penguin_slide");
		}	
	}
});

state.add_child("walking","penguin_walking", {
	enter: function(){
		state.inherit();
		idle_state = "penguin_idle";
	},
	step: function(){
		state.inherit();
		if(input_check_pressed("special")){
			state.change("penguin_slide");
		}	
	}
});

state.add("penguin_slide", {
	enter: function(){
		sprite_index = spr_player_penguin_slide;
		ping_pong = false;
		subimg = dir / 30;
		slide_dir = dir;
		slide_hspd = hspd;
		slide_vspd = vspd;
		spd = 3;
		audio_play_sound(snd_footstep_regular,0,0,,,2);
		xscale = 1.2;
		yscale = 0.8;
	},
	step: function(){
		
		slide_dir += angle_difference(dir,slide_dir) * 0.06;
		subimg = round(slide_dir / 30);
		
		slide_hspd = lerp(slide_hspd,hspd,0.04);
		slide_vspd = lerp(slide_vspd,vspd,0.04);
		
		if(input_check_pressed("special")){
			state.change("penguin_idle");
		};
		collision(slide_hspd,slide_vspd);
	},
	leave: function(){
		ping_pong = true;
		dir = round(dir / 90) * 90;
		if (dir == 360) dir = 0;
		choose_direction();
		spd = spd_base;
		audio_play_sound(snd_footstep_regular,0,0,,,2);
		xscale = 0.8;
		yscale = 1.2;
	}
});
#endregion


enable_effect(effects_id.stick);
enable_effect(effects_id.penguin);