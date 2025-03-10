extends WeaponBase


@onready var sprite: Sprite2D = $Sprite2D
@onready var spawnPos: Node2D = $Sprite2D/SpawnPos
@onready var timer: Timer = $Timer

var onCooldown = false

func _ready() -> void:
	activate.connect(activate_weapon)
	timer.wait_time = weaponConfig.attackSpeed
	weaponConfig.damageData.damageDealer = get_parent()

func _physics_process(delta: float) -> void:
	look_at_target()

func activate_weapon():
	if onCooldown:
		return
	onCooldown = true
	ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, spawnPos.global_position, rotation, Vector2(cos(rotation), sin(rotation)))
	timer.start()
	await timer.timeout
	onCooldown = false

func look_at_target():
	look_at(lookAtTaret)
