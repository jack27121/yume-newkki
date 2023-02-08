/// @description
var effect = effect_get(effects_id.stick);
if(effect == false){
	var text;
	text[0] = ";Got Stick!";
	text_box(text);
	
	enable_effect(effects_id.stick);
}
