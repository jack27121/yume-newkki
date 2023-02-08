/// @description
image_index = 0;

var effect = effect_get(effects_id.meemo);
if(effect == false){
	var text;
	text[0] = ";Got Meemo!";
	text_box(text);
	
	enable_effect(effects_id.meemo);
}
