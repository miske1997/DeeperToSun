class_name WaveConfig extends Resource

@export var waveType := ""
@export var spawns: Array[EnemySpawn] = []
@export var waveTimeout: float = 10.0
## delay interval when spawning individual enemies in the wave
@export var spawnDelayRange: Vector2 = Vector2.ZERO
@export var startCondition: WaveCondition
@export var endCondition: WaveCondition
@export var spawnCondition: WaveCondition
var spawnCount = 0


func get_enemy_spawns():
	spawnCount += 1
	return spawns
