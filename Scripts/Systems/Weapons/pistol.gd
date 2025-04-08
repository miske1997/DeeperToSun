extends WeaponBase

@export var secondaryProjectile: ProjectileConfig

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var spawnPos: Node2D = $Sprite2D/SpawnPos
@onready var timer: Timer = $Timer

var onCooldown = false

func _ready() -> void:
	activate.connect(activate_weapon)
	secondary.connect(activate_secondary)
	timer.wait_time = weaponConfig.attackSpeed
	weaponConfig.damageData.damageDealer = get_parent()

func _physics_process(delta: float) -> void:
	look_at_target()

func activate_secondary():
	pass

func activate_weapon():
	if onCooldown:
		return
	sprite.speed_scale = Players.player.stats.GetStat("AttackSpeed")
	#timer.wait_time = Players.player.stats.GetStat("AttackSpeed")
	onCooldown = true
	fire()
	timer.start()
	await timer.timeout
	onCooldown = false

func fire():
	ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, spawnPos.global_position, rotation, Vector2(cos(rotation), sin(rotation)))

func look_at_target():
	look_at(lookAtTaret)
