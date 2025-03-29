class_name EnemyBase  extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var enemyConfig: EnemyConfig
@export var damageData: DamageData
@export var dropTable: DropTable

var speedController = StatController.new()
var health := 10.0 
var collisionInfluence = Vector2.ZERO
var dashing = false
var died := false

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
	
	if get_slide_collision_count() == 0:
		return
	for collisionIndex in get_slide_collision_count():
		var collision := get_slide_collision(collisionIndex)
		if not collision.get_collider() or not collision.get_collider() is CharacterBody2D:
			continue
		position += -collision.get_normal() - collision.get_collider().velocity.normalized()
