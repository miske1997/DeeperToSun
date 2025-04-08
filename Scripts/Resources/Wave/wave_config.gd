class_name WaveConfig extends Resource

@export var waveType := ""
@export var spawns: Array[EnemySpawn] = []
@export var randomSpawn := false
@export var waveTimeout: float = 10.0
@export var spawnDelayRange: Vector2 = Vector2.ZERO

func get_enemy_spawns():
	return spawns
