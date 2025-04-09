class_name OrCondition extends WaveCondition

@export var condition: WaveCondition

func check_condition(data: Dictionary) -> bool:
	return not condition.check_condition(data)
