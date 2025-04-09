extends Sprite2D

var sprite
var enemy: EnemyBase

func _ready() -> void:
	enemy = get_parent()
	sprite = get_parent().get_node("Sprite2D")
	enemy.speedController.AddModifier("spawn", 0, 0, Enums.StatModifyerType.MULTIPLY)
	set_size()
	await get_tree().create_timer(0.3).timeout 
	await get_tree().create_timer(Utills.add_shader(self , "disolve") - 0.7).timeout 
	enemy.speedController.RemoveModifier("spawn")
	queue_free()

func set_size():
	var size = get_rect().size
	var enemySize = get_sprite_size()
	var xScale = enemySize.x / size.x
	var yScale = enemySize.y / size.y
	global_scale = Vector2(xScale, yScale)
	
func get_sprite_size():
	if sprite is Sprite2D:
		return sprite.get_rect().size
	if sprite is AnimatedSprite2D:
		return sprite.sprite_frames.get_frame_texture("idle", 0).get_size()
