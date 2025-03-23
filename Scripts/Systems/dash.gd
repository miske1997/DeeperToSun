extends Node

var dashStart: Vector2
var dashDir: Vector2
@export var dashSpeed := 1000.0
@export var dashDistance := 250.0
@export var disableMaskNumbers: Array[int] = [1]
@export var disableMask := false

@onready var contactDetect = $"../ContactDetect"
@onready var character: CharacterBody2D = $".."
var timout: float = 0

signal dash

func _ready() -> void:
	contactDetect.hit.connect(collided)
	dash.connect(begin_dash)

func collided(body):
	if body.get_collision_mask_value(1):
		return
	if character.dashing:
		end_dash()

func begin_dash(dash_direction: Vector2):
	
	if disableMask:
		for nmb in disableMaskNumbers:
			character.set_collision_mask_value(nmb, false)
		await get_tree().physics_frame
	character.dashing = true
	dashStart = character.position
	dashDir = dash_direction
	timout = dashDistance / dashSpeed


func end_dash():
	if disableMask:
		for nmb in disableMaskNumbers:
			character.set_collision_mask_value(nmb, true)
	character.dashing = false

func _physics_process(delta: float) -> void:
	if not character.dashing:
		return
	if timout <= 0 or (character.position - dashStart).length() > dashDistance:
		end_dash()
		return
	timout -= delta
	character.velocity = dashDir * dashSpeed
	character.move_and_slide()
