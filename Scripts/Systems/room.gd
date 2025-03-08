extends Node

@export var roomConfig: RoomConfig

@onready var enemyFolder := $Enemies
@onready var spawner := $Spawner


var waveCount = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_room_bg()
	spawn_player()
	#wait
	spawn_enemies(roomConfig.waves[0])
	enemyFolder.child_exiting_tree.connect(on_enemy_killed)

func on_enemy_killed(enemy):
	if enemyFolder.get_children().size() == 0:
		wave_compleated()

func wave_compleated():
	pass


func set_room_bg():
	pass

func spawn_enemies(waveConfig):
	spawner.spawn_enemies(waveConfig)

func spawn_player():
	pass
