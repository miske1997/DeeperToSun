class_name RepeatCondition extends WaveCondition

@export var repeatLimit: int = 1

func check_condition(data: Dictionary):
	return data.waveConfig.spawnCount >= repeatLimit
	
