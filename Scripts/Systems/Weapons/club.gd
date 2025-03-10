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
	if (lookAtTaret - global_position).x < 0:
		scale = Vector2(abs(scale.x) * -1  , scale.y)
	else:
		scale = Vector2(abs(scale.x)  , scale.y)
		
	
func swing_sword():
	var tween = get_tree().create_tween()
	tween.tween_property(hilt, "rotation_degrees", 179, weaponConfig.attackSpeed)
	await tween.finished
	attacking = false
	get_tree().create_tween().tween_property(hilt, "rotation_degrees", -40, 0.3)
	stop_detect()
	await get_tree().create_timer(2).timeout
	onCooldown = false

func detect():
	damageOnHit.hitBodies = []
	damageOnHit.process_mode = ProcessMode.PROCESS_MODE_INHERIT

func stop_detect():
	damageOnHit.process_mode = ProcessMode.PROCESS_MODE_DISABLED
