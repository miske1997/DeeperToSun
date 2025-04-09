extends Node

@export var enemyFolder: Node2D
@onready var enemyBuilder = $EnemyBuilder
@onready var roomStart: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomStart").position
@onready var roomEnd: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomEnd").position
@onready var roomSize = roomEnd - roomStart

func spawn_enemies(waveConfig: WaveConfig):
	var i = 0
	for enemySpawn: EnemySpawn in  waveConfig.get_enemy_spawns():
		var delay: float = randf_range(waveConfig.spawnDelayRange.x, waveConfig.spawnDelayRange.y)
		var enemyPos: Vector2 = get_enemy_position(enemySpawn.spawn, enemySpawn.localPosition)
		if not waveConfig.spawnCondition:
			spawn_enemy(enemyPos, enemySpawn.enemy)
		if waveConfig.spawnCondition and waveConfig.spawnCondition.check_condition({enemyPos = enemyPos, player = Players.player.character}):
			spawn_enemy(enemyPos, enemySpawn.enemy)
		i += 1
		await get_tree().create_timer(delay).timeout
		
func spawn_enemy(location: Vector2, enemyName: String):

	var enemy = enemyBuilder.construct_enemy(enemyName)
	enemy.position = location
	#add spawn animation
	enemyFolder.add_child(enemy)
	
func get_enemy_position(location: Vector2, localSpawn: bool):
	if localSpawn:
		return Vector2(location.x * roomSize.x, location.y * roomSize.y) + roomStart
	else:
		return location

func spawn_global_wave(wave: WaveConfig):
	pass
