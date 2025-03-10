extends WeaponBase


@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var timer: Timer = $Timer

var onCooldown = false

func _ready() -> void:
	activate.connect(activate_weapon)
	sprite.frame_changed.connect(on_frame_change)
	timer.wait_time = weaponConfig.attackSpeed
	weaponConfig.damageData.damageDealer = get_parent()

func _physics_process(delta: float) -> void:
	look_at_target()

func activate_weapon():
	if onCooldown:
		return
	sprite.speed_scale = 1 / weaponConfig.attackSpeed
	onCooldown = true
	sprite.play("shoot")
	timer.start()
	await timer.timeout
	onCooldown = false

func on_frame_change():
	if sprite.frame == 4:
		ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, sprite.global_position, rotation, Vector2(cos(rotation), sin(rotation)))


func look_at_target():
	look_at(lookAtTaret)
