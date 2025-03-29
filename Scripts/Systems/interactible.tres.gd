class_name Interactible extends Node2D

@export var interactDistance: float = 10.0
@export var interactText := "BUY"
var inRange := false
var active = true
var selected := false

signal interacted
