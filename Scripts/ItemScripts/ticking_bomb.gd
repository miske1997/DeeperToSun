extends Node2D

@export var damageData: DamageData

func _ready() -> void:
	$InCircleDetect.detected.connect(enemiesHit)

func enemiesHit(enemies):
	damageData.damageDealer = Players.player.character
	for enemy: EnemyBase in enemies:
		DealDamage.deal_damage(damageData, enemy)
		Utills.set_status_effect(enemy, "Burning", 3.0, true)
	
	queue_free()
