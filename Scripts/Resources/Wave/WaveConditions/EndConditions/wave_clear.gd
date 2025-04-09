class_name WaveClear extends WaveCondition


func check_condition(data: Dictionary):
	if not enabled:
		return
	var enemyFolder: Node2D = data.room.get_node("Enemies")
	if enemyFolder.get_children().size() > 0:
		return false
	
	if oneTime:
		enabled = false
	return true
	
