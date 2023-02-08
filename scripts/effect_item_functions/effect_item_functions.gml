/// @function effect_get
/// @description returns if current effect is enabled or disabled
function effect_get(effect_id){
	return global.user_data.effects_enabled[effect_id];
}


/// @function item_get
/// @description gets item returns -1 if it doesn't exist
function item_get(name){
	var items = global.user_data.items;
	
	for (var i = 0; i < array_length(items); ++i) {
		var item = items[i];
	    if(name == item[$"name"]){
			return item;
		}
	}
	return -1;
}

/// @function init_effect
/// @description adds effect to list
function init_effect(effect_id,name_,description_){
	var effect = { name: name_, description: description_};
	global.effects[effect_id] = effect;
	
}

/// @function enable_effect(effect_id,enable)
/// @description enable or disable an effect
function enable_effect(effect_id,enable = true){
	global.user_data.effects_enabled[effect_id] = enable;
}

/// @function effect_get_enabled()
/// @description get array with only enabled effects
function effect_get_enabled(){
	var enabled_effects = [];
	for (var i = 0; i < effects_id.total; ++i) {
	    if (global.user_data.effects_enabled[i]){
			array_push(enabled_effects,i);	
		}
	}
	return enabled_effects;
}

/// @function effect_get_count()
/// @description get amount of enabled effects
function effect_get_count(){
	return array_length(effect_get_enabled());
}

/// @function init_item
/// @description adds item to list
//function init_item(name_,description_){
//	var item = { name: name_, description: description_ };
//	array_push(global.user_data.items,item);
//}