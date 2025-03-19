extends Node

var parent: Player
var sprite: Sprite2D

func _ready() -> void:
	parent = get_parent()
	sprite = parent.get_node("Sprite2D")
	parent.takeDamage.connect(on_damage_delt)
	parent.shealdUp.connect(on_sheald_up)
	parent.healthUp.connect(on_health_up)
	parent.takeDamage.connect(on_damage_delt)
	while not Players.player:
		await get_tree().process_frame
	parent.playerData.health = parent.playerConfig.health

func on_health_up(healing: int):
	parent.playerData.health += healing

func on_sheald_up(healing: int):
	parent.playerData.shields += healing

func on_damage_delt(damageData: DamageData):
	if parent.iframes:
		return
	parent.iframes = true
	sprite.use_parent_material = false
	var damage = damageData.damage
	if damageData.damage < parent.playerData.shields:
		damage = 0
		parent.playerData.shields -= damageData.damage
	else:
		damage -= parent.playerData.shields
		parent.playerData.shields = 0
	parent.playerData.health -= damage
	if parent.playerData.health <= 0:
		parent.get_node("CollisionShape2D").disabled = true
		#play death animation
		#destroy enemy
		parent.queue_free()
	
	i_frames()
	
	
func i_frames():
	await get_tree().create_timer(1).timeout
	parent.iframes = false
	sprite.use_parent_material = true
	
