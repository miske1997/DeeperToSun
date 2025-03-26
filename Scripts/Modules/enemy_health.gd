extends Node


var parent: EnemyBase

func _ready() -> void:
	parent = get_parent()
	parent.takeDamage.connect(on_damage_delt)
	parent.health = parent.enemyConfig.health
	
func on_damage_delt(damageData: DamageData):
	parent.health -= damageData.damage
	if parent.health <= 0:
		parent.get_node("CollisionShape2D").disabled = true
		#play death animation
		#destroy enemy
		Events.enemyDied.emit(parent)
	else:
		flash()
		
func flash():
	if not parent.sprite.use_parent_material:
		return
	parent.sprite.use_parent_material = false
	await get_tree().create_timer(0.1).timeout
	parent.sprite.use_parent_material = true
	
