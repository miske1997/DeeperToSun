class_name PlayerProxy extends WaveCondition

@export var distanceToPlayer: float
@export var invertad: bool

func check_condition(data: Dictionary):
	var enemyPos: Vector2 = data.enemyPos
	if not is_instance_valid(data.player):
		return
	var player: Player = data.player
	
	var result
	if invertad:
		result = (player.position - enemyPos).length() > distanceToPlayer
	else:
		result = (player.position - enemyPos).length() < distanceToPlayer
	
	return result
	
