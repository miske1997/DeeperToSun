class_name OrCondition extends WaveCondition

@export var conditions: Array[WaveCondition]


func check_condition(data: Dictionary) -> bool:
	if not enabled:
		return false
	
	if conditions.size() == 0:
		return false
	if conditions.size() == 1:
		return conditions[0].check_condition(data)
	var result = conditions[0].check_condition(data)
	for index in conditions.size() - 2:
		result = result or conditions[index + 1]
	
	if result and oneTime:
		enabled = false
	
	return result
