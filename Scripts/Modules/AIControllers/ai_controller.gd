extends Node

@onready var enemy: EnemyBase = get_parent()

func _process(delta: float) -> void:
	if get_tree().get_node_count_in_group("Player") == 0:
		return
	var player: Player = get_tree().get_nodes_in_group("Player")[0]
	enemy.velocity = (player.position - enemy.position).normalized() * 	enemy.enemyConfig.movementSpeed
	enemy.move_and_slide()
