extends WeaponBase


@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var timer: Timer = $Timer

var onCooldown = false

func _ready() -> void:
	activate.connect(activate_weapon)
	timer.wait_time = weaponConfig.attackSpeed
	sprite.frame_changed.connect(on_frame_change)
	weaponConfig.damageData.damageDealer = get_parent()

func _physics_process(delta: float) -> void:
	look_at_target()

func activate_weapon():
	if onCooldown:
		return
	sprite.speed_scale = 1 / Players.player.stats.GetStat("AttackSpeed")
	onCooldown = true
	sprite.play("shoot")
	timer.start()
	await timer.timeout
	onCooldown = false

func on_frame_change():
	if sprite.frame == 4:
		var amount = Players.player.stats.GetStat("Amount")
		#ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, sprite.global_position, rotation, Vector2(cos(rotation), sin(rotation)))
		ProjectileEmitter.spawn_projectiles_cone_middle(weaponConfig.projectileConfig, weaponConfig.damageData, sprite.global_position, Vector2(cos(rotation), sin(rotation)), 20.0 * amount, amount)

func look_at_target():
	look_at(lookAtTaret)
