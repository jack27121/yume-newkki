/// @description
global.t = 0;

//sets text
draw_set_font(f_pixel);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#macro can_move !instance_exists(obj_text) && obj_init.state.state_is("idle")

#macro text_height 14

//colors
#macro black c_black
#macro white c_white
#macro purple #5e0629
#macro purple_light #b3768e

color1 = purple_light;
color2 = purple;

//effects
enum effects_id{
	ancient,
	stick,
	meemo,
	nose,
	scrimblo,
	penguin,
	tv,
	total
}

global.effects = [];
init_effect(effects_id.ancient,"Ancient","Ancient being that once held immense power");
init_effect(effects_id.stick,"Stick","Very stick like");
init_effect(effects_id.meemo,"Meemo","Guh?");
init_effect(effects_id.nose,"Nose","A big sniffer");
init_effect(effects_id.scrimblo,"Scrimblo","????");
init_effect(effects_id.penguin,"Penguin","Known to slide around on it's belly");
init_effect(effects_id.tv,"TV","Rarely anything worth watching");


#region menu states
state = new SnowState("idle");

state.add("idle", {
	enter: function(){
		
	},
	step: function(){
		if (can_move && input_check_pressed("back")){
			audio_play_sound(snd_ui_confirm,0,0);
			state.change("pause_menu");	
		}
	}
});

state.add("start_menu", {
	enter: function(){
		selection = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,2);
		}
		
		if(input_check_pressed("action")){
			audio_play_sound(snd_ui_confirm,0,0);
			if(selection == 0){
				save_new();
				state.change("idle");
				room_goto_next();
			}
			if(selection == 1){
				if(save_load()){
					state.change("idle");
					room_goto_next();
				}
			}
			else if(selection == 2) game_end(); 
		}
	},
	draw: function(){
		draw_clear(c_black);
		var middle = global.game_w/2;
		
		var w = 80;
		var h = 60;
		var x_ = middle-(w/2);
		var y_ = (global.game_h/3)*2;
		
		draw_box(x_,y_,w,h,0);
		
		draw_text_style(x_,y_,"New Game",color1,color2);
		draw_text_style(x_,y_+text_height,"Load Game",color1,color2);
		draw_text_style(x_,y_+text_height*2,"Exit",color1,color2);
		
		draw_selection(x_,y_+(text_height*selection),w);
	}

})
	
state.add("pause_menu",{
	enter: function(){
		selection = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,1);
		}
		
		if(input_check_pressed("action")){
			audio_play_sound(snd_ui_confirm,0,0);
			if(selection == 0){
				state.change("effects");
			} else if(selection == 1){
				//state.change("items");
			}
		}
		
		if(input_check_pressed("back")){
			audio_play_sound(snd_ui_decline,0,0);
			state.change("idle");
		}
	},
	draw: function(){		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.game_w,global.game_h,0);
		draw_reset_color();
		
		var col = global.game_w/3;
		
		draw_box(0,0,col,text_height*3,0);
		draw_box(0,global.game_h-(text_height*2),col,text_height*2,0);
		
		draw_box(col,0,col*2,global.game_h,0);
		
		draw_text_style(0,0,"Effects",color1,color2);
		draw_text_style(0,text_height,"Items",color1,color2);
		
		draw_selection(0,text_height*selection,col);
		
	}
});

effects_selection = 0;
state.add("effects",{
	enter: function(){
		held_effects = effect_get_enabled();
		effect_num = effect_get_count();
	},
	step: function(){
		if(effect_num > 0){
			if(input_check_pressed("down") || input_check_pressed("up") || input_check_pressed("left") || input_check_pressed("right")){
				audio_play_sound(snd_ui_hover,0,0);
				if(input_check_pressed("down")) effects_selection+=2;
				else if(input_check_pressed("up")) effects_selection-=2;
				else if(input_check_pressed("right")) effects_selection++;
				else if(input_check_pressed("left")) effects_selection--;
				effects_selection = clamp(effects_selection,0,effect_num-1);
			}
			
			if(input_check_pressed("action")){
				audio_play_sound(snd_ui_confirm,0,0);
				
				//equips the effect for the player
				//if you equip the effect that's already equipped it unequips it and goes to normal
				var current_effect = obj_player.current_effect;
				var new_effect = global.effects[held_effects[effects_selection]].name;
				if(current_effect != new_effect){
					obj_player.state.change(new_effect);
					obj_player.current_effect = new_effect;
				} else {
					obj_player.state.change("normal");
					obj_player.current_effect = "normal";
				}
				state.change("idle");
			}
		}
		
		if(input_check_pressed("back")){
			audio_play_sound(snd_ui_decline,0,0);
			state.change("pause_menu");
		}
	},
	draw: function(){
		draw_clear_alpha(black,0.5);

		var col = global.game_w/2;
		
		//draws boxes
		draw_box(0,0,global.game_w,text_height*2,0);
		draw_box(0,text_height*2,global.game_w,global.game_h-text_height,0);
		
		if(effect_num > 0){
			//draws effect description
			draw_text_style(0,0,global.effects[held_effects[effects_selection]].description,color1,color2);
			
			//draws effect names
			for (var i = 0; i < effect_num; ++i) {
				
				var x_ = (i mod 2)*col;
				var y_ = (floor(i/2)*text_height)+(text_height*2);
				
				var name = global.effects[held_effects[i]].name
			    draw_text_style(x_,y_,name,color1,color2);
				
				//draws selection on equipped effect
				if(obj_player.current_effect == name){
					draw_selection(x_,y_,col,,0.2,0.4);
				}
			}
			
			//draws selection
			var x_ = (effects_selection mod 2)*col;
			var y_ = (floor(effects_selection/2)*text_height)+(text_height*2);
			draw_selection(x_,y_,col);
		}
		
	}
});
#endregion

state.change("start_menu");