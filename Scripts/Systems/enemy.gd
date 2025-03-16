class_name EnemyBase  extends CharacterBody2D



@onready var sprite := $Sprite2D
@export var enemyConfig: EnemyConfig
@export var damageData: DamageData

signal takeDamage

func _ready() -> void:
	damageData = damageData.duplicate()
	damageData.damageDealer = self

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
