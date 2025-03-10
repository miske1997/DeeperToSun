extends WeaponBase


@onready var hilt: Node2D = $Hilt
@onready var sprite: Sprite2D = $Hilt/Sprite2D
@onready var timer: Timer = $Timer
@onready var area := $Hilt/Area2D
@onready var damageOnHit := $DamageOnAreaHit

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
	attacking = true
	detect()
	swing_sword()

func look_at_target():
	look_at(lookAtTaret)
	
func swing_sword():
	var prevPos = hilt.position
	var tween = get_tree().create_tween()
	tween.tween_property(hilt, "position", hilt.position + Vector2(60, 0), weaponConfig.attackSpeed / 2)
	tween.tween_property(hilt, "position", prevPos, weaponConfig.attackSpeed / 2)
	await tween.finished
	
	stop_detect()
	onCooldown = false
	attacking = false

func detect():
	damageOnHit.process_mode = ProcessMode.PROCESS_MODE_INHERIT
	damageOnHit.hitBodies = []

func stop_detect():
	damageOnHit.process_mode = ProcessMode.PROCESS_MODE_DISABLED
