extends Node

@onready var enemy: EnemyBase = get_parent()
@onready var weapon: WeaponBase = get_parent().get_node("Dagger")

func _process(delta: float) -> void:
	if get_tree().get_node_count_in_group("Player") == 0:
		return
	var player: Player = get_tree().get_nodes_in_group("Player")[0]
	if not weapon.attacking:
		move_to_target(player)
	set_weapon_look_target(player.position)
	hit_target_chack(player)

func set_weapon_look_target(target: Vector2):
	weapon.lookAtTaret = target
	
func hit_target_chack(target:Node2D):
	if (target.position - enemy.position).length() < 28:
		weapon.activate.emit()

func move_to_target(player: Node2D):
	if enemy.dashing:
		return
	enemy.velocity = (player.position - enemy.position).normalized() * enemy.speedController.GetStatValue()
	enemy.velocity += enemy.collisionInfluence
	enemy.move_and_slide()
