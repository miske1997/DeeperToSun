extends Node

@export var projectileProps: ProjectileProps

var body: RigidBody2D

func _ready() -> void:
	body = get_parent()

func _physics_process(delta: float) -> void:
	body.linear_velocity = projectileProps.direction.normalized() * projectileProps.speed
	
