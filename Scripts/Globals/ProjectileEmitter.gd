extends Node

var items_data = load("res://Data/Items/items_data.tres").items
var item_functions = load("res://Data/Items/item_functions.tres")

@export var projectileTemplate: PackedScene
@export var trailTemplate: PackedScene

var projectileSprites: Dictionary = {}
var componentsDir := "res://Scenes/ProjectileComponents/"

func _ready() -> void:
	projectileTemplate = load("res://Scenes/ProjectileComponents/projectile.tscn")
	trailTemplate = load("res://Scenes/Components/trail.tscn")
	
	projectileSprites.bullet = load("res://Assets/Projectiles/GunProjectile.png")
	projectileSprites.redBall = load("res://Assets/Projectiles/EnemiesProjectile.png")
	projectileSprites.yellowBall = load("res://Assets/Projectiles/YellowProjectile.png")
	projectileSprites.arrow = load("res://Assets/Projectiles/ArrowProjectile.png")
	projectileSprites.glass = load("res://Assets/Projectiles/BlueMagicProjectile.png")
	projectileSprites.boulder = load("res://Assets/Projectiles/Boulder.png")
	projectileSprites.knife = load("res://Assets/Weapons/Dager.png")
	projectileSprites.purpleProjectile = load("res://Assets/Projectiles/PurpleProjectile.png")
	projectileSprites.purpleMagicProjectile = load("res://Assets/Projectiles/PurpleMagicProjectile.png")

func spawn_projectile(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, rotation: float, direction: Vector2):
	var projectile:Projectile = projectileTemplate.instantiate()
	projectile.get_node("Sprite2D").texture = projectileSprites[projectileConfig.spriteName]
	projectile.rotation = rotation
	projectile.scale = projectileConfig.size
	projectile.position = origin
	projectile.damageData = damageData
	projectile.projectileConfig = projectileConfig.duplicate()
	projectile.projectileConfig.direction = direction
	attach_trail(projectile)
	if damageData.damageDealer == Players.player.character:
		prock_items(projectile.projectileConfig, damageData, Enums.ItemProcs.PROJECTILE_EMMIT)
	add_components(projectile)
	get_node("/root").add_child(projectile)

func target_projectile_at(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, target: Vector2):
	var direction = (target - origin).normalized()
	spawn_projectile(projectileConfig, damageData, origin, direction.angle(), direction)
	
func spawn_projectiles_cone(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, direction: Vector2, angle: float, amount: int):
	var step = angle / (amount + 1)
	var currentAngle = rad_to_deg(direction.angle())
	var startAngle = currentAngle - (angle / 2)
	for i in amount:
		var rotation = deg_to_rad(startAngle + (step * (i + 1)))
		spawn_projectile(projectileConfig, damageData, origin, rotation, Vector2.from_angle(rotation))

	
func spawn_projectiles_cone_middle(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, direction: Vector2, angle: float, amount: int):
	var step = angle / (amount + 1)
	var baseRotation = direction.angle()
	var divideVec = Vector2.from_angle(baseRotation + deg_to_rad(90)) * 10
	var currentAngle = rad_to_deg(direction.angle())
	var startAngle = currentAngle - (angle / 2)
	for i in amount:
		if amount % 2 == 0 and (i + 1 == amount / 2 or i + 1 == (amount / 2) + 1):
			spawn_projectile(projectileConfig, damageData, origin + divideVec, baseRotation, direction)
			divideVec *= -1
		else:
			var rotation = deg_to_rad(startAngle + (step * (i + 1)))
			spawn_projectile(projectileConfig, damageData, origin, rotation, Vector2.from_angle(rotation))
	
	
func spawn_projectile_sphere(projectileConfig, damageData, origin, count):
	var step = 360.0 / count
	for i in count:
		spawn_projectile(projectileConfig, damageData, origin, step, Vector2(cos(step), sin(step)))

func spawn_in_random_dir(projectileConfig: ProjectileConfig, damageData: DamageData, origin: Vector2, amount):
	var rotation: float
	for i in amount:
		rotation = randf_range(0, 360)
		spawn_projectile(projectileConfig, damageData, origin, rotation, Vector2(cos(rotation), sin(rotation)))

func attach_trail(projectile: Projectile):
	if not projectile.projectileConfig.trailConfig:
		return
	var trailConfig: TrailConfig = projectile.projectileConfig.trailConfig
	var trail = trailTemplate.instantiate()
	projectile.add_child(trail)
	trail.trailConfig = trailConfig

func add_components(projectile: Projectile):
	for addonName in projectile.projectileConfig.addons:
		var addon = load(componentsDir + addonName + ".tscn").instantiate()
		projectile.add_child(addon)
		
func prock_items(projectileConfig: ProjectileConfig, damageData: DamageData, prockType: Enums.ItemProcs):
	for item: PassiveItem in Players.player.collectedItems:
		if not item is PassiveItem:
			continue
		if items_data.has(item.name) and items_data[item.name].procs.has(prockType):
			if not item_functions.get_method_list().any(func(f): return f.name == items_data[item.name].procs[prockType] + item.state) :
				return
			item_functions[items_data[item.name].procs[prockType] + item.state].call({projectileConfig = projectileConfig, damageData = damageData})
