script = function(){
	var effect = effect_get(effects_id.tv);
	if(effect == false){
		var text;
		text[0] = ";Got TV!";
		text_box(text);
		
		enable_effect(effects_id.tv);
	}
}