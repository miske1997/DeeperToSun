extends Node

var character: RigidBody2D
@export var speed := 40
@export var target: Node2D

func _ready() -> void:
	if not get_parent() is RigidBody2D:
		return
	character = get_parent()

func _physics_process(delta: float) -> void:
	var currentTarget: Node2D = target
	if not currentTarget:
		currentTarget = get_tree().get_nodes_in_group("Player").pick_random()
	if (character.position - currentTarget.position).length() < 25:
		#character.linear_velocity = Vector2.ZERO
		return
	character.look_at(currentTarget.position)
	character.linear_velocity = (character.position - currentTarget.position).normalized() * -speed
