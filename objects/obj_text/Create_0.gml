/// @description
width = global.view_w-20;
height = global.view_h /3;

x = global.view_w/2;
y = height*2;

font[0] = "something went wrong fucko. listen you son of a bitch";
message[0] = "something went wrong fucko";
autoskip[0] = false;
still[0] = false;
goto[0] = -1;
close[0] = false;

message_current = 0;

initialDelay = 1;
delay = initialDelay;
cutoffSpeed = 1;

i = 1;

timer = 0;
cutoff = 0;

t = 0;
amplitude = 2;
freq = 2;

//port
port[0] = "something went wrong fucko";
portX = 0;
portY = 0;

//choice
choiceDone = false;
question[0] = false;
choices[0,0] = "";

choiceXY[0,0] = 100;		//x
choiceXY[0,1] = global.view_h-60;	//y
choiceXY[0,2] = false; 

choiceXY[1,0] = 320;
choiceXY[1,1] = global.view_h-60;
choiceXY[1,2] = false; 

choiceXY[2,0] = 210;
choiceXY[2,1] = global.view_h-75;
choiceXY[2,2] = false; 

choiceXY[3,0] = 210;
choiceXY[3,1] = global.view_h-40;
choiceXY[3,2] = false;

//execute
execute[0] = false;

//sound
sound[0] = "something went wrong fucko";
playonce[0] = false;
soundLoop[0] = true;
soundLoopI = false;

#region states
state = new SnowState("start");

state.event_set_default_function("step", function() {

});

state.event_set_default_function("draw_gui", function() {

	t++;

	#region portrait
	if(port[@ message_current] != "port_none")
	{
		draw_sprite(asset_get_index(port[@ message_current]),0, portX, portY)
	}
	#endregion
	
	//variables
	var line = 0;
	var charWidth = 0;
	var lineShift = 0;
	var modifierDelay = false;
	var modifierShaky = false;
	var modifierWavey = false;
	var modifierColor = false;
	var modifierTiny = false;
	var modifierBig = false;
	var modifierBreak = false;
	
	#region Typewriter
	if (cutoff < string_length(message[@ message_current]))
	{
		if (timer >= delay)
		{
			cutoff += cutoffSpeed;
			timer = 0;
		}
		else timer++;	
	}
	#endregion
	
	#region Sound
	if(sound[@ message_current] != undefined){
		if (!audio_is_playing(sound[@ message_current]) && !soundLoopI) {
			audio_play_sound(sound[@ message_current],1,soundLoop[@ message_current]);
			if (!soundLoop[@ message_current]) soundLoopI = true;
		}
		
		if (cutoff >= string_length(message[@ message_current]) && soundLoop[@ message_current])
		{
			if audio_is_playing(sound[@ message_current]) {
				audio_stop_sound(sound[@ message_current]);
			}
			if (!soundLoop[@ message_current]) soundLoopI = false;
		}
	}
	#endregion
	
	#region Draw text
	i = 1;
	
	//if it's a choice sequence the question will be drawn in the top middle
	if (question[@ message_current]){
		tX = (global.view_w / 2) - (string_width(message[@ message_current]) / 2);
		tY = (global.view_h - 110);
	}
	draw_box(tX,tY,width,height);
	
	while(i <= string_length (message[@ message_current]) && i <= cutoff){
		#region modifier
		while (string_char_at(message[@ message_current], i) == "/" && i <= string_length (message[@ message_current])){
			var modifier = string_char_at(message[@ message_current], ++i);
			i++;
			
			switch (modifier){
				//toggles color modifier on/off and saves the color name in a string
				case "c":
					if (!modifierColor){
						var textColor = "";
						modifierColor = true;	
						while(string_char_at(message[@ message_current], i+1) != ")"){
							textColor = string_insert(string_char_at(message[@ message_current],i),textColor,i++);
						}
						i+=2;
					} else modifierColor = false;
					break;
				//toggles delay modifier on/off and saves the delay number
				case "d":
					if (modifierDelay == false){
						var textDelay = ""
						modifierDelay = true;
						while(string_char_at(message[@ message_current], i+1) != ")"){
							textDelay = string_insert(string_char_at(message[@ message_current],i),textDelay,i++);
						}
						i+=2;
					} else modifierDelay = false;
					break;
				//toggles Shaky modifier on/off
				case "s": if (!modifierShaky) modifierShaky = true; else modifierShaky = false; break;
				//toggles Wavey modifier on/off
				case "w": if (!modifierWavey) modifierWavey = true; else modifierWavey = false; break;
				//toggles Tiny modifier on/off
				case "t": if (!modifierTiny) modifierTiny = true; else modifierTiny = false; break;
				//toggles Big modifier on/off
				case "b": if (!modifierBig) modifierBig = true; else modifierBig = false; break;
				//Break modifier
				case "/": modifierBreak = true; break;
			}		
		}
		//With all the modifiers, we make sure cutoff, can keep up
		cutoff = max(cutoff, i);
		
		//Shaky modifier
		if (modifierShaky == true)
		{
			var shakeX = random_range(-0.5,0.5);
			var shakeY = random_range(-0.5,0.5);
		}
		else
		{
			var shakeX = 0;
			var shakeY = 0;
		}
		
		//Wavey modifier
		if (modifierWavey == true)
		{
			var so = (t + i);
			var shift = sin((so*pi*freq)/room_speed)*amplitude;
		}
		else var shift = 0;
		
		//Tiny/Big modifier
		var size = "";
		if (modifierTiny == true) size = "_tiny";
		else if (modifierBig == true) size = "_big";
		draw_set_font(asset_get_index(font[@ message_current] + size));
		
		
		//Color modifier
		if (modifierColor == true) {
			switch textColor {	
				case "red": draw_set_colour(red); break;
				case "blue": draw_set_colour(blue); break;
				case "green": draw_set_colour(green); break;
				case "pink": draw_set_colour(pink); break;
				case "purple": draw_set_colour(purple); break;
				case "cyan": draw_set_colour(cyan); break;
				case "yellow": draw_set_colour(yellow); break;
				case "orange": draw_set_colour(orange); break;
				case "brown": draw_set_colour(brown); break;
				case "rainbow":
				{
					var hue = ((((t+i)*255)/room_speed)*0.5)%255;
					var rainbowColor = make_color_hsv(hue,255,255);
					draw_set_colour(rainbowColor); break;
				}
			}
		}else draw_set_colour(white);
		
		if (modifierDelay){
			delay = int64(textDelay); 	
		} else delay = initialDelay;
		#endregion
		
		//Go to next line
		var length = 0;
		var wordWidth = 0;
	
		//Reads the width of the current word
		while (string_char_at(message[@ message_current], i) != " " && i <= string_length(message[@ message_current])){
			wordWidth += string_width(string_char_at(message[@ message_current], i));
			i++;
			length++;
		}
		//This sets i back. to before it checked the remainder of the word
		i -= length;
		
	
		//if the current word exedes the lineEnd we go to a new line
		if (wordWidth+charWidth > lineEnd || modifierBreak == true){
			charWidth = 0;
			line += lineShift + 5;
			lineShift = 0;
			modifierBreak = false;
		}
		wordWidth = 0;
	
		//Text
		//draws the actual text
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_text_style(	(tX + charWidth + shakeX) , (tY + line + shift + shakeY) , string_char_at(message[@ message_current], i),purple_light,purple);
			
		//Checks all the letters on the current line, and saves the biggest character as the line height. So the next line will be placed perfectly under it.
		lineShift = max(lineShift,string_height(string_char_at(message[@ message_current], i)));
		
		charWidth += string_width(string_char_at(message[@ message_current], i++));
	}
	#endregion
});

state.add("start", {
	enter: function(){	
		t = 0;
		height_ = 0;
	},
	step: function(){
		height_ = ease_out(t++,0,height,room_speed/3);
		
		if(t>=room_speed/3){
			state.change("new_message"); //starts a new message	
		}
		
	},
	draw_gui: function(){
		draw_box(x-(width/2),y-(height_/2),width,height_);
	}
});

state.add("new_message", {
	enter: function(){
		message_end = array_length(message);
		
		#region text position
		tY = y-height/2;
		tX = x-width/2;
		lineEnd = x+(width/2)-100;
		
		portY = y;
		portX = tX +10;
		if (port[@ message_current] != "port_none" || question[@ message_current])
		{
			tX+= 50;
			lineEnd-= 50;
		}
		#endregion
	},
	
	step: function(){
		#region Next message
		if ((input_check_pressed("action")) || autoskip[@ message_current]){
			//If autoskip is enabled the messages go through faster
			if (autoskip[@ message_current]){
				delay = 1;
			} else {
				delay = 0;
				cutoffSpeed = 5;
			}
			if (i >= string_length(message[@ message_current])){
				if ((message_current < message_end-1) && !close[@ message_current]){
					delay = initialDelay;
					
					if(execute[@ message_current] != false){
						script_execute(asset_get_index(execute[@ message_current]));
					}
					
					//also stops the sound if autoskip is used
					if (sound[@ message_current] != undefined && audio_is_playing(sound[@ message_current])) {
						audio_stop_sound(sound[@ message_current]);
					}
					
					//The next message is indicated by the goto indicator if it's used.
					//Else it will simply be the following message
					if (goto[@ message_current] != -1){
						message_current = goto[@ message_current];
					}
					else message_current++;
					
					cutoff = 0;
					cutoffSpeed = 1;
		
				}else{ //is done
					state.change("stop");
				}
			}
		}
		#endregion
	}
});

state.add("stop", {
	enter: function(){	
		t = 0;
		height_ = height;
	},
	step: function(){
		height_ = ease_out(t++,height_,-height,room_speed/3);
		
		if(t>=room_speed/3){
			instance_destroy();
		}
		
	},
	draw_gui: function(){
		draw_box(x-(width/2),y-(height_/2),width,height_);
	}
});

#endregion