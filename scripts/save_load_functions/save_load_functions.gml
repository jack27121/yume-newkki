#region save slots

//creates a save directory if one doesn't exists
if !directory_exists("saves"){
	directory_create("saves");
}

function user_new(path) {
	global.user_data = new user_data_struct();
	user_save(path);
}

function user_save(path){
	save_json(global.user_data, "saves/"+path+".json");
}

function user_load(path) {
	if (file_exists("saves/"+path+".json")){
		global.user_data = new user_data_struct();
	    var user_data = load_json("saves/"+path+".json");
	    global.user_data.load_values(user_data);
		return true;
	} else return false;
}

function user_delete(path) {
    file_delete("saves/"+path+".json");
}

//return string array with names of each of the saves
function user_get_all(){
	var files = array_create(4,"");
	var file_name = file_find_first("saves/*.json", fa_none);
	
	while (file_name != ""){
		var index = int64(string_digits(file_name));
		array_insert(files,index,file_name);
	    file_name = file_find_next();
	}
	file_find_close();
	
	return files;
}

function user_data_struct() constructor {

    // Set default values for empty save file

    time_played = 0;
	money = 0;
    effects_enabled = array_create(effects_id.total,false);
    items = [];

    // load values
    load_values = function(data) {
		//Sets each variable in the struct to match the data input
        var fields = variable_struct_get_names(data);
        for (var i = 0; i < array_length(fields); i++){
			variable_struct_set(self, fields[i], variable_struct_get(data,fields[i]));
        }
    }
}
#endregion

#region settings

function settings_new() {
	global.settings = new settings_struct();
	settings_save();
}

function settings_save(){
	save_json(global.settings, "settings.json");
}

function settings_load() {
	if (file_exists("settings.json")){
		global.settings = new settings_struct();
	    var settings = load_json("settings.json");
	    global.settings.load_values(settings);
	} else settings_new();
}

function settings_struct() constructor {

    // Set default values for empty settings file

    fullscreen = false;
	stretching = false;
	resolution = RES_LIB.DESKTOP_4_3_960_X_720;
	volume_master = 1;
	volume_fx = 1;
	volume_music = 1;
	language = LANGUAGES.English

    // load values
    load_values = function(data) {
		//Sets each variable in the struct to match the data input
        var fields = variable_struct_get_names(data);
        for (var i = 0; i < array_length(fields); i++){
			variable_struct_set(self, fields[i], variable_struct_get(data,fields[i]));
        }
    }
}
#endregion

#region json
function save_json(_data, _name) {

    var json_string = json_stringify(_data);
    var buffer      = buffer_create(string_byte_length(json_string) + 1, buffer_fixed, 1);
    buffer_write(buffer, buffer_string, json_string);
    buffer_save(buffer, _name);
    buffer_delete(buffer);

}

function load_json(_name) {

    var buffer = buffer_load(_name);

    if (buffer != -1) {
        var json_string = buffer_read(buffer, buffer_string);

        buffer_delete(buffer);

        return json_parse(json_string);
    } else {
        return undefined;
    }
}
#endregion