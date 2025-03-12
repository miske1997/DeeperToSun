extends Node2D

var player_direction: Vector2
var push_force = 1

@onready var player:Player = get_parent()
@onready var weapon:WeaponBase = null

func _ready() -> void:
	for node in player.get_children():
		if node.is_in_group("Weapon"):
			weapon = node
			break

func _physics_process(delta: float) -> void:
	get_input()
	process_movement()
	set_weapon_look_target()
	activate_weapon()

func set_weapon_look_target():
	weapon.lookAtTaret = get_global_mouse_position()

func activate_weapon():
	if Input.is_action_pressed("Click"):
		weapon.activate.emit()

func get_input():
	player_direction = Vector2.ZERO
	if Input.is_action_pressed("Up"):
		player_direction += Vector2.UP
	if Input.is_action_pressed("Down"):
		player_direction += Vector2.DOWN
	if Input.is_action_pressed("Left"):
		player_direction += Vector2.LEFT
	if Input.is_action_pressed("Right"):
		player_direction += Vector2.RIGHT

func process_movement():
	player.velocity = player_direction.normalized() * player.playerConfig.movementSpeed
	player.move_and_slide()
	
	for i in player.get_slide_collision_count():
		var c = player.get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
