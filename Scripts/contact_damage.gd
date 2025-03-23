class_name ContactDetect extends ShapeCast2D

var collider: CollisionShape2D
var parent

signal hit
var prevLoacation: Vector2

func _ready() -> void:
	if not get_parent().has_node("CollisionShape2D"):
		return
	parent = get_parent()
	position = parent.position
	prevLoacation = parent.position
	collider = parent.get_node("CollisionShape2D")
	shape = collider.shape
	enabled = true
	
func _physics_process(delta: float) -> void:
	position = parent.position
	target_position = (position - prevLoacation) * 1.3
	prevLoacation = parent.position
	#drawDebugLine(target_position)
	if not is_colliding():
		return
	hit.emit(get_collider(0))
	
func drawDebugLine(targetPos: Vector2):
	$Line2D.clear_points()
	$Line2D.add_point(Vector2.ZERO)
	$Line2D.add_point(targetPos * 10)
	
