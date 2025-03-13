extends Node

@export var enemyFolder: Node2D
@onready var enemyBuilder = $EnemyBuilder
@onready var roomStart: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomStart").position
@onready var roomEnd: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomEnd").position
@onready var roomSize = roomEnd - roomStart

func spawn_enemies(waveConfig: WaveConfig):
	var i = 0
	for enemySpawn: EnemySpawn in  waveConfig.spawns:
		spawn_enemy(enemySpawn.spawn, enemySpawn.enemy)
		i += 1
		
		
func spawn_enemy(location: Vector2, enemyName: String):

	var enemy = enemyBuilder.construct_enemy(enemyName)
	enemy.position = Vector2(location.x * roomSize.x, location.y * roomSize.y) + roomStart
	#add spawn animation
	enemyFolder.add_child(enemy)
	
