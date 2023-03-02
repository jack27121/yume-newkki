/// @description
game_active = false;
global.t = 0;
global.save_slot = 0;

//loads settings or initializes the default ones
settings_load();

//lexicon / languages
if (file_exists("local_en.json")){
	lexicon_index_declare_from_json("local_en.json");
	lexicon_index_declare_from_json("local_da.json");
	lexicon_index_declare_from_json("local_ru.json");
} else show_error("no language file", true);

lexicon_index_fallback_language_set("English");

enum LANGUAGES {
	English,
	Danish,
	Russian,
	TOTAL
}

var lang_array = lexicon_languages_get_array();
lexicon_language_set(lang_array[global.settings.language][0]);

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
#macro yellow #f3b500
#macro yellow_light #ffdd36

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

effects = ds_map_create();
ds_map_add(effects,effects_id.ancient,"ancient");
ds_map_add(effects,effects_id.stick,"stick");
ds_map_add(effects,effects_id.meemo,"meemo");
ds_map_add(effects,effects_id.nose,"nose");
ds_map_add(effects,effects_id.scrimblo,"scrimblo");
ds_map_add(effects,effects_id.penguin,"penguin");
ds_map_add(effects,effects_id.tv,"tv");

global.effects = [];
for (var i = 0; i < effects_id.total; ++i) {
	var name = effects[? i];
    init_effect(i,name);
}

#region menu states

#region menu off
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
#endregion
#region start menu
state.add("start_menu", {
	enter: function(){
		selection = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,3);
		}
		
		if(input_check_pressed("action")){
			audio_play_sound(snd_ui_confirm,0,0);
			if(selection == 0){
				state.change("new_save");
				//user_new(string());
				//state.change("idle");
				//room_goto_next();
			}
			if(selection == 1){
				state.change("load_save");
				//var loaded = user_load();
				//if(loaded){
				//	state.change("idle");
				//	room_goto_next();
				//}
			}
			if(selection == 2){
				state.change("settings");
			}
			else if(selection == 3) game_end(); 
		}
	},
	draw: function(){		
		var middle = global.game_w/2;
		
		var w = 80;
		var h = text_height*5;
		var x_ = middle-(w/2);
		var y_ = (global.game_h/5)*3;
		
		draw_box(x_,y_,w,h,0);
		
		draw_text_style(x_,y_,				lexicon_text("gui.menu.new_game_name"),color1,color2);
		draw_text_style(x_,y_+text_height,	lexicon_text("gui.menu.load_game_name"),color1,color2);
		draw_text_style(x_,y_+text_height*2,lexicon_text("gui.menu.settings_name"),color1,color2);
		draw_text_style(x_,y_+text_height*3,lexicon_text("gui.menu.quit"),color1,color2);
		
		draw_selection(x_,y_+(text_height*selection),w);
	}

})
#endregion
#region parent save menu
state.add("parent_save", {
	enter: function(){
		selection = 0;
		popup = false;
		popup_text = lexicon_text("gui.menu.new_game.override");
		popup_selection = 0;
		
		save_files = user_get_all();
		
		middle_ = global.game_w/2;
		w_ = global.game_w/1.5;
		h_ = text_height*5;
		x_ = middle_-(w_/2);
		y_ = (global.game_h/5)*3.5;
	},
	step: function(){
		//if popup active we move its selection
		if(popup && (input_check_pressed("left") || input_check_pressed("right"))){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("right"))		popup_selection++;
			else if(input_check_pressed("left"))	popup_selection--;
			popup_selection = clamp(popup_selection,0,1);
			
		} else if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,3);
		}	
		
		if(input_check_pressed("back")){
			audio_play_sound(snd_ui_decline,0,0);
			//if popup is active we exit it
			if(popup) popup = false
			else state.change(state.get_previous_state());			
		}
	},
	draw: function(){
		
		//draws boxes and saves
		draw_box(x_,y_-text_height*2,w_,text_height*2,0);
		draw_box(x_,y_,w_,h_,0);
		
		draw_text_style(x_,y_-text_height*2,header_text,color1,color2);
		
		for (var i = 0; i < 4; ++i) {
			var save  = save_files[i];
			var text  = "Save #"+string(i);
			var alpha = save != "" ? 1 : 0.5;
			draw_text_style(x_,y_+(text_height*i),text,color1,color2,alpha);
		}
		
		//draws popup confirmation box
		if(popup){
			draw_set_color(black);
			draw_set_alpha(0.5);
			draw_rectangle(0,0,global.game_w,global.game_h,0);
			draw_reset_color();
			
			var popup_h = text_height*2;
			var popup_w = (global.game_h/5)*3;
			var popup_x = middle_-(popup_w/2);
			var popup_y = y_+text_height;
			
			draw_box(popup_x,popup_y-text_height*2,popup_w,text_height*2,0);
			draw_box(popup_x,popup_y,popup_w,popup_h,0);
			
			draw_text_style(popup_x,popup_y-text_height*2,popup_text,color1,color2);
			
			draw_text_style(popup_x,popup_y,lexicon_text("gui.no"),color1,color2);
			draw_text_style(popup_x+(popup_w/2),popup_y,lexicon_text("gui.yes"),color1,color2);
			
			draw_selection(popup_x+(popup_w/2*popup_selection),popup_y,popup_w/2);
		}
	}
});
#endregion
#region new save menu
state.add_child("parent_save","new_save", {
	enter: function(){
		state.inherit();
		selection = 0;
		
		header_text = lexicon_text("gui.menu.new_game.text");
		
		popup = false;
		popup_text = lexicon_text("gui.menu.new_game.popup_confirm");
		popup_selection = 0;
		
		save_files = user_get_all();
		action = function(){
			
		}
	},
	step: function(){
		state.inherit();
		
		if(input_check_pressed("action")){
			//override popup
			if(popup){
				if(popup_selection == 0){
					audio_play_sound(snd_ui_decline,0,0);
					popup = false;
				} else if(popup_selection == 1){
					audio_play_sound(snd_ui_confirm,0,0);
					user_new("save"+string(selection));
					global.save_slot = selection;
					game_active = true;
					state.change("idle");
					room_goto_next();
				}
			} else { 
				//if selected save slot is empty starts new save
				if(save_files[selection] == ""){
					audio_play_sound(snd_ui_confirm,0,0);
					user_new("save"+string(selection));
					state.change("idle");
					room_goto_next();
				//if selected save is taken, popup to override it
				} else {
					audio_play_sound(snd_ui_confirm,0,0);
					popup = true;
					popup_selection = 0;
				}
			}
		}
	},
	draw: function(){		
		state.inherit();
		//draws selection
		if(!popup) draw_selection(x_,y_+(text_height*selection),w_);
	}
});
#endregion
#region load save menu
state.add_child("parent_save","load_save", {
	enter: function(){
		state.inherit();
		load_delete = 0; //0 is load, 1 is delete
		header_text = lexicon_text("gui.menu.load_game.text");
		popup_text = lexicon_text("gui.menu.load_game.popup_confirm")
	},
	step: function(){
		state.inherit();
		
		//toggles wether saves should be loaded or deleted
		if(!popup && input_check_pressed("left") && load_delete == 1){
				audio_play_sound(snd_ui_hover,0,0);
				load_delete = 0;
				
		}
		if(!popup && input_check_pressed("right") && load_delete == 0){
				audio_play_sound(snd_ui_hover,0,0);
				load_delete = 1;
		}
		
		if(input_check_pressed("action")){
			//override popup
			if(popup){
				if(popup_selection == 0){
					audio_play_sound(snd_ui_decline,0,0);
					popup = false;
				} else if(popup_selection == 1){
					audio_play_sound(snd_ui_confirm,0,0);
					user_delete("save"+string(selection));
					save_files = user_get_all();
					popup = false;
				}
			}
			//checks if selected slot has a save file
			else if(save_files[selection] != ""){
				if(load_delete == 0){
					audio_play_sound(snd_ui_confirm,0,0);
					user_load("save"+string(selection));
					global.save_slot = selection;
					game_active = true;
					state.change("idle");
					room_goto_next();
				} else if(load_delete == 1){
					audio_play_sound(snd_ui_confirm,0,0);
					popup = true;
					popup_selection = 0;
				}
			} else {
				audio_play_sound(snd_ui_decline,0,0);
			}
		}

	},
	draw: function(){		
		state.inherit();
		//draws selection
		if(!popup){
			var y_select = y_+(text_height*selection);
			draw_selection(x_,y_select,w_);
			
			var load_delete_x = x_+(w_/3);
			var load_delete_w = ((w_/3)*2)/4;
			
			draw_set_halign(fa_center);
			
			if(load_delete == 1){
				var load_color1   = color1;
				var load_color2   = color2;
				var delete_color1 = yellow;
				var delete_color2 = yellow_light;
			} else {
				var load_color1   = yellow;
				var load_color2   = yellow_light;
				var delete_color1 = color1;
				var delete_color2 = color2;	
			}
			
			draw_text_style(load_delete_x+(load_delete_w*1)-8,y_select,lexicon_text("gui.menu.load_game.load"),	load_color1,load_color2);
			draw_text_style(load_delete_x+(load_delete_w*2)-8,y_select,"/",										color1,color2);
			draw_text_style(load_delete_x+(load_delete_w*3)-8,y_select,lexicon_text("gui.menu.load_game.delete"),delete_color1,delete_color2);

			
			draw_set_halign(fa_left);
		}
		//draw_selection(x_+(w*load_delete),y_+(text_height*selection),w);
	}
});
#endregion
#region pause menu
state.add("pause_menu",{
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
				state.change("effects");
			} else if(selection == 1){
				state.change("settings");
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
		
		draw_text_style(0,0,lexicon_text("gui.menu.effects"),color1,color2);
		draw_text_style(0,text_height,lexicon_text("gui.menu.settings_name"),color1,color2);
		
		draw_selection(0,text_height*selection,col);
		
	}
});
#endregion
#region effects menu
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
				var new_effect = global.effects[held_effects[effects_selection]];
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
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.game_w,global.game_h,0);
		draw_reset_color();

		var col = global.game_w/2;
		
		//draws boxes
		draw_box(0,0,global.game_w,text_height*2,0);
		draw_box(0,text_height*2,global.game_w,global.game_h-text_height,0);
		
		if(effect_num > 0){
			//draws effect description
			var effect_description = lexicon_text("effects."+global.effects[held_effects[effects_selection]]+".description");
			draw_text_style(0,0,effect_description,color1,color2);
			
			//draws effect names
			for (var i = 0; i < effect_num; ++i) {
				
				var x_ = (i mod 2)*col;
				var y_ = (floor(i/2)*text_height)+(text_height*2);
				
				var name =  lexicon_text("effects."+ global.effects[held_effects[i]]+ ".name");
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
#region settings menu
state.add("settings",{
	enter: function(){
		selection = 0;
		enum MENU_SETTINGS {
			resolution,
			fullscreen,
			stretching,
			language,
			TOTAL
		}
		
		resolution_new = global.settings.resolution;
		language_new = global.settings.language;
		languages = lexicon_languages_get_array();

	},
	step: function(){
		//can't leave until new settings are confirmed
		if(resolution_new == global.settings.resolution && language_new == global.settings.language){
			if(input_check_pressed("down") || input_check_pressed("up")){
				audio_play_sound(snd_ui_hover,0,0);
				if(input_check_pressed("down")) selection++;
				else if(input_check_pressed("up")) selection--;
				selection = clamp(selection,0,MENU_SETTINGS.TOTAL-1);
			}
		}
		
		var side_input = 0;
		if(input_check_pressed("left") || input_check_pressed("right")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("left")) side_input = -1;
			if(input_check_pressed("right")) side_input = 1;
		}
		
		var action = false;
		if(input_check_pressed("action")){
			action = true
			audio_play_sound(snd_ui_confirm,0,0);
		}
		
		switch (selection) {
		    case MENU_SETTINGS.resolution:
				if(!global.settings.fullscreen){ //can't change res if it's in fullscreen
				    resolution_new+= side_input;
					if (resolution_new < 0) resolution_new = RES_LIB.TOTAL-1;
					if (resolution_new >= RES_LIB.TOTAL) resolution_new = 0;
					
					if(action){
						var new_res = global.resLib[resolution_new];
						stanncam_set_resolution(new_res.width,new_res.height);
						global.settings.resolution = resolution_new;
						settings_save();
					}
				}
		        break;
		    case MENU_SETTINGS.fullscreen:
		        if(action || side_input != 0){
					stanncam_toggle_fullscreen();
					global.settings.fullscreen = window_get_fullscreen();
					settings_save();
				}
		        break;
			case MENU_SETTINGS.stretching:
		        if(action || side_input != 0){
					stanncam_toggle_stretching();
					global.settings.stretching = !global.settings.stretching;
					settings_save();
				}
		        break;
			case MENU_SETTINGS.language:
				language_new+= side_input;
				if (language_new < 0) language_new = LANGUAGES.TOTAL-1;
				if (language_new >= LANGUAGES.TOTAL) language_new = 0;
				
				if(action){
					var new_lang = languages[language_new][0];
					lexicon_language_set(new_lang);
					global.settings.language = language_new;
					settings_save();
				}
		        break;
		}
		
		if(input_check_pressed("back")){
			audio_play_sound(snd_ui_decline,0,0);
			if(resolution_new != global.settings.resolution || language_new != global.settings.language){
				//if new settings aren't confirmed "back" resets them
				resolution_new = global.settings.resolution;
				language_new = global.settings.language
			} else {
				state.change(state.get_previous_state());	
			}			
		}
	},
	draw: function(){		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.game_w,global.game_h,0);
		draw_reset_color();
		
		var col = global.game_w/2;
		
		//draws boxes
		draw_box(0,0,global.game_w,text_height*2,0);
		draw_box(0,text_height*2,global.game_w,global.game_h-text_height,0);
		
		//draws description
		//draw_text_style(0,0,global.effects[held_effects[effects_selection]].description,color1,color2);
		
		//resolution
		var res_color1 = color1;
		var res_color2 = color2;
		if(resolution_new != global.settings.resolution){
			var res_color1 = yellow;
			var res_color2 = yellow_light;
		}
		var alpha = global.settings.fullscreen ? 0.5 : 1;
		draw_text_style(0,text_height*2,lexicon_text("gui.menu.settings.resolution"),color1,color2,alpha);
		var res = string(global.resLib[resolution_new].width) + " / " + string(global.resLib[resolution_new].height);
		draw_text_style(col,text_height*2,res,res_color1,res_color2,alpha);
		
		//fullscreen
		draw_text_style(0,text_height*3,lexicon_text("gui.menu.settings.fullscreen"),color1,color2);
		var fullscreen = global.settings.fullscreen ? lexicon_text("gui.on") : lexicon_text("gui.off");
		draw_text_style(col,text_height*3,fullscreen,color1,color2);
		
		//stretching
		draw_text_style(0,text_height*4,lexicon_text("gui.menu.settings.stretching"),color1,color2);
		var stretching = global.settings.stretching ? lexicon_text("gui.on") : lexicon_text("gui.off");
		draw_text_style(col,text_height*4,stretching,color1,color2);
		
		//language
		var res_color1 = color1;
		var res_color2 = color2;
		if(language_new != global.settings.language){
			var res_color1 = yellow;
			var res_color2 = yellow_light;
		}
		draw_text_style(0,text_height*5,lexicon_text("gui.menu.settings.language"),color1,color2);
		draw_text_style(col,text_height*5,languages[language_new][0],res_color1,res_color2);
		
		//draws selection
		var y_ = (selection*text_height)+(text_height*2);
		draw_selection(0,y_, global.game_w);
		
	}
});
#endregion

#endregion

state.change("start_menu");