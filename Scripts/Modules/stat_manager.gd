extends Node2D


func _process(delta: float) -> void:
	for key in Players.player.stats.controllers:
		Players.player.stats.controllers[key].Tick(delta)
