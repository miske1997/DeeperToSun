extends Node

func object_has_signal( object: Object, signal_name: String ) -> bool:
	var list = object.get_signal_list()
	
	for signal_entry in list:
		if signal_entry["name"] == signal_name:
			return true
		
	return false
