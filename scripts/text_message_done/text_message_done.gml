///@func text_message_done(obj, message)
///@desc Checks if specified text message is done writing
///@param obj
///@param message
function text_message_done(obj, message) {
	if (instance_exists(obj) && obj.message_current == message && obj.cutoff >= string_length(obj.message[message])){
		return true;
	}
	return false;
}