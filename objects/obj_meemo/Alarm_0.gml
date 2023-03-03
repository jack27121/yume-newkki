/// @description
image_index = 0;

var effect = effect_get(effects_id.nose);
if(effect == false){
	var text;
	text[0] = ";Got Nose!";
	text_box(text);
	
	enable_effect(effects_id.nose);
}
