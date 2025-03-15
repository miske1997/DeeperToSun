extends Node

var health := 10.0 
var parent: EnemyBase
var sprite: Sprite2D

func _ready() -> void:
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
	parent.takeDamage.connect(on_damage_delt)
	health = parent.enemyConfig.health
	
func on_damage_delt(damage: float):
	health -= damage
	if health <= 0:
		parent.get_node("CollisionShape2D").disabled = true
		#play death animation
		#destroy enemy
		parent.queue_free()
	flash()
func flash():
	if not sprite.use_parent_material:
		return
	sprite.use_parent_material = false
	await get_tree().create_timer(0.1).timeout
	sprite.use_parent_material = true
	
