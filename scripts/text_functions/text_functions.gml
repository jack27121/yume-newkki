///@func text_box(text)
///@param text_array
///@desc writes text in a textbox
function text_box(text_array){
	var text_object = instance_create_layer(0,0,"Instances",obj_text);
	text_init(text_array, text_object);
}

///@func text_init(array, text_object)
///@param  array
///@param  text_object
///@param  x
///@param  y
///@param  width
///@param  height
///@desc   creates text object
function text_init(input, obj, x_ = global.view_w/2, y_ = global.view_h-50,width = global.view_w-50, height = global.view_h /3) {
	
	obj.x = x_;
	obj.y = y_;
	obj.width = width;
	obj.height = height;
	
	obj.font[@ 0] = "";

	for (i = 0; i < array_length(input); i++) {
	//Font indicator
		if string_pos("#f_",input[@ i]) != 0 {
			//Font_indicator position
			var font_start = string_pos("#f_",input[@ i]);
			//Counts the characters from after font_start to the next space
			var font_end = string_pos("#",string_copy(input[@ i],font_start+1,  string_width(input[@ i])-(font_start+1)));
		
			//Copies the font name, and makes sure to leave out indicator and space seperator
			obj.font[@ i] = string_copy(input[@ i],font_start+1,font_end-1);
		}
		//If there's no indicator to be found, the textbox will re-use the previously chosen one.
		else if (i > 0) obj.font[@ i] = obj.font[@ i-1];
		//If there is no indicator to be found, and it's the first message, it'll default to this
		else obj.font[@ i] = "f_pixel";
	
	//Portrait indicator
		if string_pos("#port_",input[@ i]) != 0 {
			//port_indicator position
			var port_start = string_pos("#port_",input[@ i])+1;
			//Counts the characters from after port_start to the next #
			var port_end = string_pos("#",string_copy(input[@ i],port_start,  string_width(input[@ i])-(port_start)));
		
			//Copies the port name, and makes sure to leave out indicator and #
			obj.port[@ i] = string_copy(input[@ i],port_start,port_end-1);
		}
		//If there's no indicator to be found, the textbox will re-use the previously chosen one.
		else if (i > 0) obj.port[@ i] = obj.port[i-1];
		//If there is no indicator to be found, and it's the first message, it'll default to this
		else obj.port[@ i] = "port_none"

	//Still indicator. (Makes portrait not bop up and down, default is on)
		if string_pos("#still#",input[@ i]) != 0 {
			obj.still[@ i] = true;
		}
		//If there's no indicator to be found, still will be set to false.
		else obj.still[@ i] = false;
	
	//Nosound indicator. self-explanatory. (if used the sound indicator won't do anything)
		if string_pos("#nosound#", input[@ i]) != 0 {
			obj.sound[@ i] = undefined;
		}
		
	//Sound indicator. (The sound to play when letters are typed, will take sound from portrait by default)
		else {
			if string_pos("#sound_", input[@ i]) != 0 {
				//sound_indicator position
				var sound_start = string_pos("#sound_",input[@ i])+7;
				//Counts the characters from after sound_start to the next #
				var sound_end = string_pos("#",string_copy(input[@ i],sound_start,  string_width(input[@ i])-(sound_start)));
			
				var sound_string = string_copy(input[@ i],sound_start,sound_end-1);
			
				//If the sound indicator ends in _playonce the sound will simply play once
				//Good for a dog making a bark noise or similar.
				if(string_pos("_playonce",sound_string)) {
					obj.soundLoop[@ i] = false;		
					sound_string = string_replace(sound_string,"_playonce","");
				}
				else obj.soundLoop[@ i] = true;	
			
				//Copies the soundname, and makes sure to leave out indicator
				obj.sound[@ i] = asset_get_index(sound_string);
			}
			//if there is no indicator to be found, it will simply play the sound associated with the portrait
			else
			{
				obj.soundLoop[@ i] = true;	
				var sound = obj.port[@ i];
				//deletes the leading port_ from the string
				sound = string_replace(sound,"port_","");
			
				if(string_pos("_",sound) != 0) {
					var deletion_start = string_pos("_",sound);
					sound = string_delete(sound,deletion_start,string_length(sound));
				}
				obj.sound[@ i] = asset_get_index("snd_" + sound);
			}
		}

	//Choice indicator. Starts a choice prompt in the box. (If used, none of the following indicators will have effect)
		if string_pos("#choice",input[@ i]) !=0 {
			//Makes a copy of the text to mess with
			var text = input[@ i];
		
			var choices = [];
		
			var ii_count =  string_count("#choice",text);
		
			for (ii = 0; ii < ii_count; ii++ ) {
				//choice indicator position
				var choice_start = string_pos("#choice",text);
			
				//removes the initial #choice text from the string
				text = string_replace(text,"#choice_","");
			
			//finds the goto number	
				var seperator = string_pos(";",text)-choice_start;
			
				var goto = string_copy(text,choice_start,seperator);
			
				text = string_delete(text,choice_start,seperator+1);
			
			//finds the script to execute
				var seperator = string_pos(";",text)-choice_start;
			
				var script_name = string_copy(text,choice_start,seperator);
			
				text = string_delete(text,choice_start,seperator+1);
		
			//finds the choice text
				var seperator = string_pos("#",text)-choice_start;
		
				var choice_text = string_copy(text,choice_start,seperator);
			
				text = string_delete(text,choice_start,seperator+1);
			
			//assigns the choice variables to choices array			
				choices[ii, 0] = real(goto);
				choices[ii, 1] = script_name;
				choices[ii, 2] = choice_text;
			}			
		//message_indicator position
			var question_start = string_pos(";",text);
		//Counts the characters from the start to the end
			var question_end = string_length(text) - question_start;
		
			obj.question[@ i] = true;	
			obj.message[@ i] = string_copy(text,question_start+1,question_end);
			obj.choices[@ i] = choices;
		
			obj.autoskip[@ i] = false;
		
		}
		else {
			obj.question[@ i] = false;
			obj.choices[@ i] = "";
	
	//Autoskip indicator. (Skips message automaticly and types it faster)
			if string_pos("#autoskip#",input[@ i]) != 0 {
				obj.autoskip[@ i] = true;
			}
			//If there's no indicator to be found, Autoskip will be set to false.
			else obj.autoskip[@ i] = false;
	//Message Indicator
			if string_pos(";",input[@ i]) != 0 {
				//message_indicator position
				var message_start = string_pos(";",input[@ i]);
				//Counts the characters from the start to the end
				var message_end = string_length(input[@ i]) - message_start;
				//Copies the message
				obj.message[@ i] = string_copy(input[@ i],message_start+1,message_end);
			}
			//If there's no indicator to be found, the message will be blank.
			else obj.message[@ i] = "";
	
	//Goto Indicator (goes to the stated message after the current message is completed)
			if string_pos("#goto_", input[@ i]) != 0 {
				//goto_indicator position
				var goto_start = string_pos("#goto_",input[@ i])+1;
				//Counts the characters from after goto_start to the next #
				var goto_end = string_pos("#",string_copy(input[@ i],goto_start,  string_width(input[@ i])-(goto_start)));
			
				//Copies the goto number, and makes sure to leave out indicator and #
				var goto_number = string_digits(string_copy(input[@ i],goto_start,goto_end-1))
				obj.goto[@ i] = real(goto_number);
			}
			//if there is no indicator to be found, it will simply go to the following message when done
			else obj.goto[@ i] = -1;
	
	//Execute indicator (executes the stated function after this message )
			if string_pos("#execute_",input[@ i]) != 0 {
				//goto_indicator position
				var execute_start = string_pos("#execute_",input[@ i])+9;
				//Counts the characters from after goto_start to the next #
				var execute_end = string_pos("#",string_copy(input[@ i],execute_start,  string_width(input[@ i])-(execute_start)));
			
				//Copies the goto number, and makes sure to leave out indicator and #
				obj.execute[@ i] = string_copy(input[@ i],execute_start,execute_end-1);
			}
			//if there is no indicator to be found, it will simply go to the following message when done
			else obj.execute[@ i] = false;
		
	//Close indicator. (Close the dialouge after this message)
			if string_pos("#close#",input[@ i]) != 0 {
				obj.close[@ i] = true;
			}
			//If there's no indicator to be found, close will be set to false.
			else obj.close[@ i] = false;
		}
	}
}