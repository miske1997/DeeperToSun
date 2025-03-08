class_name Player extends CharacterBody2D

var player_direction: Vector2
var push_force = 1

func _physics_process(delta: float) -> void:
	get_input()
	process_movement()


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
	velocity = player_direction.normalized() * 100
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
