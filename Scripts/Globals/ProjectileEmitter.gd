extends Node

@export var projectile: PackedScene
var projectileSprites: Dictionary = {}
func _ready() -> void:
	projectile = load("res://Scenes/Components/projectile.tscn")
	projectileSprites.bullet = load("res://Assets/Projectiles/GunProjectile.png")
	projectileSprites.redBall = load("res://Assets/Projectiles/EnemiesProjectile.png")
	projectileSprites.yellowBall = load("res://Assets/Projectiles/YellowProjectile.png")
	projectileSprites.arrow = load("res://Assets/Projectiles/ArrowProjectile.png")
	projectileSprites.glass = load("res://Assets/Projectiles/BlueMagicProjectile.png")
	projectileSprites.knife = load("res://Assets/Weapons/Dager.png")

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

func target_projectile_at(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, target: Vector2):
	var direction = (target - origin).normalized()
	spawn_projectile(projectileConfig, damageData, origin, direction.angle(), direction)
	
func spawn_projectiles_cone(projectile, origin, direction, angle):
	pass
	
	
func spawn_projectile_sphere(projectileConfig, damageData, origin, count):
	var step = 360.0 / count
	for i in count:
		spawn_projectile(projectileConfig, damageData, origin, step, Vector2(cos(step), sin(step)))

func spawn_in_random_dir(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, amount):
	var rotation: float
	for i in amount:
		rotation = randf_range(0, 360)
		spawn_projectile(projectileConfig, damageData, origin, rotation, Vector2(cos(rotation), sin(rotation)))
