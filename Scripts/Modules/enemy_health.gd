extends Node

var health := 10 
var parent: EnemyBase

func _ready() -> void:
	parent = get_parent()
	parent.takeDamage.connect(on_damage_delt)
	
func on_damage_delt(damage):
	health -= damage
	if health <= 0:
		parent.get_node("CollisionShape2D").disabled = true
		#play death animation
		#destroy enemy
		queue_free()
	
