extends Node

@export var projectile: PackedScene
var projectileSprites: Dictionary = {}
func _ready() -> void:
	projectile = load("res://Scenes/Components/projectile.tscn")
	projectileSprites.bullet = load("res://Assets/Projectiles/GunProjectile.png")
	projectileSprites.redBall = load("res://Assets/Projectiles/EnemiesProjectile.png")
	projectileSprites.yellowBall = load("res://Assets/Projectiles/YellowProjectile.png")
	projectileSprites.arrow = load("res://Assets/Projectiles/ArrowProjectile.png")

func spawn_projectile(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, rotation: float, direction: Vector2):
	var bullet:Projectile = projectile.instantiate()
	bullet.get_node("Sprite2D").texture = projectileSprites[projectileConfig.spriteName]
	bullet.rotation = rotation
	bullet.scale = projectileConfig.size
	bullet.position = origin
	bullet.damageData = damageData
	bullet.projectileConfig = projectileConfig.duplicate()
	bullet.projectileConfig.direction = direction
	get_node("/root").add_child(bullet)
	
	
func spawn_projectiles_cone(projectile, origin, direction, angle):
	pass
	
	
func spawn_projectile_sphere(projectile, origin, count):
	pass
