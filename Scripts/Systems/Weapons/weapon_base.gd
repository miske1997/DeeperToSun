class_name WeaponBase extends Node2D

@export var weaponConfig: WeaponConfig
var lookAtTaret: Vector2
var attacking = false

signal activate
signal secondary
