class_name PlayerProxy extends WaveCondition

@export var distanceToPlayer: float
@export var invertad: bool

func check_condition(data: Dictionary):
	var enemyPos: Vector2 = data.enemyPos
	var player: Player = data.player
	
	var result
	if invertad:
		result = (player.position - enemyPos).length() > distanceToPlayer
	else:
		result = (player.position - enemyPos).length() < distanceToPlayer
	
	return result
	
