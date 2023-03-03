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
wake_state = -1;
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

state.event_set_default_function("draw", function() {
	
});

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
		walking_state = "walking";
		idle_state = "idle";
		
		mask_index = spr_player_mask;
	},
	step: function(){
		state.change("idle");
	}
});

state.add("idle", {
	enter: function(){
		animate = false;
		subimg = 1;
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
			if(room != rm_bedroom && room != rm_balcony){
				transition(rm_bedroom, function(){
					obj_bedroom_bed.state.change("wake1");
				},,transition_type.pixelate);
			} else { //if it's already in the real bedroom it goes back to idle state
				state.change("normal");
			}
		}
	},
	leave: function(){
		ping_pong = true;
	}
});

state.add("shake", {
	enter: function(){
		animate = true;
		subimg = 0;
		sprite_index = spr_player_shake;
		audio_play_sound(snd_nope,0,0);
		controlled = false;
	},
	step: function(){
		if(animation_end(sprite_index,subimg)){
			state.change(idle_state);
			controlled = true;
		}
	}
});
#endregion

#region stick
state.add_child("normal","stick", {
	enter: function(){	
		state.inherit();
		
		right = spr_player_stick_right;
		back = spr_player_stick_back;
		left = spr_player_stick_left;
		forward = spr_player_stick_forward;
		wake_state = -1;
		walking_state = "stick_walking";
		idle_state = "stick_idle";
		
		sprite_index = forward;
		
		sound_pitch = 2;
		spd = 0.6;
		
		mask_index = spr_player_stick_mask;
	},
	step: function(){
		state.change("stick_idle");
	}
});

state.add_child("idle","stick_idle", {});

state.add_child("walking","stick_walking", {});
#endregion

#region penguin
state.add_child("normal","penguin", {
	enter: function(){	
		state.inherit();
		
		right	=	spr_player_penguin_right;
		back	=	spr_player_penguin_back;
		left	=	spr_player_penguin_left;
		forward =	spr_player_penguin_forward;
		wake_state = -1;
		walking_state = "penguin_walking";
		idle_state = "penguin_idle";
		
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
	},
	step: function(){
		state.inherit();
		if(input_check_pressed("special")){
			state.change("penguin_slide");
		}	
	}
});

state.add_child("walking","penguin_walking", {
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

#region tv
tv_screen_draw = function(frame){
	if(tv_on){
		var _subimg = PingPongImage(sprite_index,subimg);
		switch (sprite_index) {
		    case back:
		        
		        break;
		    case forward:
				var screen_pos_x = -6;
				var screen_pos_y = [-22,-21,-22];
		        draw_sprite(spr_player_tv_screen_static,screen_subimg,x+screen_pos_x,y+screen_pos_y[_subimg])
		        break;
			case left:
				var screen_pos_x = -6;
				var screen_pos_y = [-24,-25,-24];
		        draw_sprite_stretched(spr_player_tv_screen_static,screen_subimg,x+screen_pos_x,y+screen_pos_y[_subimg],4,14);
		        break;
			case right:
				var screen_pos_x = 2;
				var screen_pos_y = [-24,-25,-24];
		        draw_sprite_stretched(spr_player_tv_screen_static,screen_subimg,x+screen_pos_x,y+screen_pos_y[_subimg],4,14);
		        break;
		}
		screen_subimg+= sprite_get_speed(spr_player_tv_screen_static);
	}
}

tv_screen_toggle = function(){
	if(input_check_pressed("special")){
		tv_on = !tv_on;
	}		
}

state.add_child("normal","tv", {
	enter: function(){
		screen_subimg = 0;
		state.inherit();
		
		right =   spr_player_tv_right;
		back =    spr_player_tv_back;
		left =    spr_player_tv_left;
		forward = spr_player_tv_forward;
		wake_state = -1;
		walking_state = "tv_walking";
		idle_state = "tv_idle";
		tv_on = false;
		
		sprite_index = forward;
		
		sound_pitch = 1;
		spd = 1;
	},
	step: function(){
		state.change("tv_idle");
	}
});

state.add_child("idle","tv_idle", {
	step: function(){
		state.inherit();
		tv_screen_toggle();
	},
	draw: function(){
		tv_screen_draw();	
	}
});

state.add_child("walking","tv_walking", {
	step: function(){
		state.inherit();
		tv_screen_toggle();
	},
	draw: function(){
		tv_screen_draw();	
	}
});
#endregion

#region nose
state.add_child("normal","nose", {
	enter: function(){	
		state.inherit();
		
		right =   spr_player_nose_right;
		back =    spr_player_nose_back;
		left =    spr_player_nose_left;
		forward = spr_player_nose_forward;
		wake_state = -1;
		walking_state = "nose_walking";
		idle_state = "nose_idle";
		
		sprite_index = forward;
		
		sound_pitch = 0.8;
		spd = 0.8;
	},
	step: function(){
		state.change("nose_idle");
	}
});

state.add_child("idle","nose_idle", {});

state.add_child("walking","nose_walking", {});
#endregion