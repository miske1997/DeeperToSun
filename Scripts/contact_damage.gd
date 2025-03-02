extends ShapeCast2D

var collider: CollisionShape2D
@onready var line := $Line2D
var parent

func _ready() -> void:
	if not get_parent().has_node("CollisionShape2D"):
		return
	parent = get_parent()
	collider = get_parent().get_node("CollisionShape2D")
	shape = collider.shape
	enabled = true
	
func _physics_process(delta: float) -> void:
	target_position = parent.velocity * delta
	position = parent.position
	if not is_colliding():
		return
	print(get_collider(0))
	
