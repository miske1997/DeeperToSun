extends Node

var dashStart: Vector2
var dashDir: Vector2
@export var dashSpeed := 1000.0
# Called when the node enters the scene tree for the first time.
@onready var contactDetect = $"../ContactDetect"
@onready var character: CharacterBody2D = $".."

func _ready() -> void:
	contactDetect.hit.connect(collided)

func collided(body):
	if character.dashing:
		end_dash()

func begin_dash(dash_direction: Vector2):
	character.dashing = true
	dashStart = character.position
	dashDir = dash_direction

func end_dash():
	character.dashing = false

func _physics_process(delta: float) -> void:
	if not character.dashing:
		return
	if (character.position - dashStart).length() > 250:
		end_dash()
		return
	character.velocity = dashDir * dashSpeed
	character.move_and_slide()
