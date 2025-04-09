class_name AreaWaveConfig extends WaveConfig

@export var area: Shape2D
@export var areaPosition: Vector2 = Vector2.ZERO
@export var enemyName: String
@export var enemySpawnRange: Vector2

func get_enemy_spawns():
	spawnCount += 1
	var spawns = []
	var enemyCount = randi_range(enemySpawnRange.x, enemySpawnRange.y)
	for i in enemyCount:
		if area is RectangleShape2D:
			spawns.push_back(get_rectangle_spawn())
		
	return spawns

func get_rectangle_spawn():
	var x = randf_range(0, area.size.x) - area.size.x / 2
	var y = randf_range(0, area.size.y) - area.size.y / 2
	var enemySpawn = EnemySpawn.new()
	enemySpawn.enemy = enemyName
	enemySpawn.localPosition = false
	enemySpawn.spawn = Vector2(areaPosition.x + x, areaPosition.y + y)
	
	return enemySpawn
