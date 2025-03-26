class_name Projectile extends Node2D

@export var projectileConfig: ProjectileConfig
@export var damageData: DamageData

var projectileOwner
var prevLoaction: Vector2
var distanceTraveled := 0.0
var lifeTime = 0.0

signal onDestroyed

func _ready() -> void:
	$CollisionShape2D.shape.radius = projectileConfig.radius

func _physics_process(delta: float) -> void:
	prevLoaction = position
	position += projectileConfig.direction.normalized() * projectileConfig.speed * delta
	distanceTraveled += (position - prevLoaction).length()
	projectileConfig.speed += projectileConfig.acceleration * delta
	projectileConfig.speed -= projectileConfig.drag * delta
	projectileConfig.speed = max(0, projectileConfig.speed)
	check_range_reached()
	check_life_time(delta)
	
func check_range_reached():
	if distanceTraveled >= projectileConfig.range:
		onDestroyed.emit()
		queue_free()
	
func check_life_time(delta: float):
	lifeTime += delta
	if lifeTime >= projectileConfig.duration:
		onDestroyed.emit()
		queue_free()
