class_name DelayCondition extends WaveCondition

@export var delayTime: float = 5.0
var startTime: float

func check_condition(data: Dictionary):
	if not startTime:
		startTime = delayTime
		
	if not enabled:
		return false
	delayTime -= data.delta
	if delayTime > 0:
		return false
	if oneTime:
		enabled = false
		return true
	delayTime = startTime
	return true
	
