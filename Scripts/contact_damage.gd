extends ShapeCast2D

var collider: CollisionShape2D
var parent

signal hit
var prevLoacation: Vector2

func _ready() -> void:
	if not get_parent().has_node("CollisionShape2D"):
		return
	parent = get_parent()
	prevLoacation = position
	collider = get_parent().get_node("CollisionShape2D")
	shape = collider.shape
	enabled = true
	
func _physics_process(delta: float) -> void:
	target_position = (prevLoacation - position)
	prevLoacation = position
	position = parent.position
	if not is_colliding():
		return
	hit.emit(get_collider(0))
	
