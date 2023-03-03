script = function(){
	var effect = effect_get(effects_id.penguin);
	if(effect == false){
		var text;
		text[0] = ";Got Penguin!";
		text_box(text);
		
		enable_effect(effects_id.penguin);
	}
}