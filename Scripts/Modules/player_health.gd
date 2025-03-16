extends Node

var parent: Player
var sprite: Sprite2D

func _ready() -> void:
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
	parent.health = parent.playerConfig.health
	parent.takeDamage.connect(on_damage_delt)
	
func on_damage_delt(damage):
	if parent.iframes:
		return
	parent.iframes = true
	sprite.use_parent_material = false
	damage = min(damage, parent.health)
	parent.health -= damage
	Events.playerHit.emit(damage)
	if parent.health <= 0:
		parent.get_node("CollisionShape2D").disabled = true
		#play death animation
		#destroy enemy
		parent.queue_free()
	
	i_frames()
	
	
func i_frames():
	await get_tree().create_timer(1).timeout
	parent.iframes = false
	sprite.use_parent_material = true
	
