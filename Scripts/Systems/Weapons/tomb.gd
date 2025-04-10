extends WeaponBase

@export var secondaryProjectile: ProjectileConfig

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var leftTrajectory := $LeftTrajectory/PathFollow2D
@onready var rightTrajectory := $RightTrajectory/PathFollow2D
@onready var player = get_parent()

var onCooldown = false
var prevPath : PathFollow2D
var arcana: float = 0.0


func _ready() -> void:
	activate.connect(activate_weapon)
	secondary.connect(activate_secondary)
	weaponConfig.damageData.damageDealer = get_parent()

func _physics_process(delta: float) -> void:
	look_at_target()
	if arcana >= 100:
		return
	if get_parent().velocity == Vector2.ZERO:
		arcana += delta * 40
	else:
		arcana += delta * 10

func activate_secondary():
	if arcana < 100:
		return
	arcana = 0
	var projectileDir = (sprite.global_position - global_position).normalized()
	ProjectileEmitter.spawn_projectile(secondaryProjectile, weaponConfig.damageData, sprite.global_position + projectileDir * 10, projectileDir.angle() + deg_to_rad(-135), projectileDir)


func activate_weapon():
	if onCooldown:
		return
	timer.wait_time = get_attack_speed()
	onCooldown = true
	for i in get_projectile_amount():
		fire()
		await get_tree().physics_frame
	timer.start()
	await timer.timeout
	onCooldown = false

func fire():
		var pathFolow
		if prevPath == leftTrajectory:
			pathFolow = rightTrajectory
		else:
			pathFolow = leftTrajectory
		prevPath = pathFolow
		play_path()
		
func play_path():
	var path = duplicate_path()
	var projectileSprite: Sprite2D = path.get_node("Sprite2D")
	projectileSprite.visible = true
	path.progress_ratio = 0
	await create_tween().tween_property(path, "progress_ratio", 1, 0.5).finished
	projectileSprite.visible = false
	emmit_projectile(projectileSprite, path.get_parent())
	#path.queue_free()
	path.get_parent().queue_free()

func duplicate_path():
	var pathDup: Path2D = prevPath.get_parent().duplicate()
	pathDup.rotation = rotation + deg_to_rad(90)
	pathDup.scale = global_scale
	var path = pathDup.get_node("PathFollow2D")
	get_tree().get_first_node_in_group("TemporaryObjects").add_child(pathDup)
	pathDup.position = prevPath.global_position
	return path
	
func duplicate_folow():
	var path = prevPath.duplicate()
	prevPath.get_parent().add_child(path)
	return path
	

func emmit_projectile(projectileSprite: Sprite2D, path: Path2D):
	weaponConfig.damageData.damage_scale = weaponConfig.weaponScaling.damageScaling
	var projectileTarget: Vector2 = global_position + Vector2.from_angle(path.global_rotation - deg_to_rad(90)) * 250
	var projectileDir = (projectileTarget - projectileSprite.global_position).normalized()
	ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, projectileSprite.global_position, projectileDir.angle(), projectileDir)

func look_at_target():
	look_at(lookAtTaret)
	
func get_attack_speed():
	var scaling := weaponConfig.weaponScaling.attackSpeedScaling
	var attackSpeed: float = player.playerData.stats.GetStat("AttackSpeed")
	return attackSpeed * (1/ scaling)
	
func get_projectile_amount():
	return floor(player.playerData.stats.GetStat("Amount") * weaponConfig.weaponScaling.amountScaling)
