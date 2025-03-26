extends EnemyBase


@onready var rayCast := $"../RayCast2D"
@export var chargeSpeed := 350.0
@onready var weapon: WeaponBase = get_node("BossClub")

var chargeDir := Vector2.ZERO
var target: Player
var walking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $AnimatedSprite2D
	speedController.base = enemyConfig.movementSpeed
	damageData = damageData.duplicate()
	damageData.damageDealer = self
	while not Players.player or Players.player.character == null:
		await get_tree().process_frame
	target = Players.player.character

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not target:
		return
	set_weapon_look_target(target.position)

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func chargeStart(speed: float):
	$AnimatedSprite2D.speed_scale = speed / speedController.GetStatValue()
	sprite.play("walk")
func chargeEnd():
	sprite.stop()
func walkStart():
	$AnimatedSprite2D.speed_scale = 1
	sprite.play("walk")
func walkEnd():
	sprite.stop()

func set_weapon_look_target(target: Vector2):
	weapon.lookAtTaret = target
	
