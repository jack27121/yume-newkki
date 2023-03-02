/// @description

script = function(){
	user_save("save"+string(global.save_slot));
	
	var text = [];
	text[0] = ";Game has been saved";
	text_box(text);
}