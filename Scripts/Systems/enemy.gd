class_name EnemyBase  extends CharacterBody2D



@onready var sprite := $Sprite2D
@export var enemyConfig: EnemyConfig
@export var damageData: DamageData
var speedController = StatController.new()
var health := 10.0 

signal takeDamage

func _ready() -> void:
	speedController.base = enemyConfig.movementSpeed
	damageData = damageData.duplicate()
	damageData.damageDealer = self

func _process(delta: float) -> void:
	speedController.Tick(delta)

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
