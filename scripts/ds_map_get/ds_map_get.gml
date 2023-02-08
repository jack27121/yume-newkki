/// @function ds_map_get(map_id, key);
/// @description validates key exists, and then returns it
function ds_map_get(map_id, key){
	if (ds_map_exists(map_id,key)){
		return ds_map_find_value(map_id,key);
	}
}