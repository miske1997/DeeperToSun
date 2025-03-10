extends Node


func deal_damage(damageData: DamageData, target):
	if not target or not is_instance_valid(target):
		return
	if not damageData.damageDealer or not is_instance_valid(damageData.damageDealer):
		return
	
	if damageData.damageDealer.is_in_group("Player"):
		damage_enemy(damageData, target)
	else:
		damage_player(damageData, target)

func damage_player(damageData: DamageData, enemy):
	#enemy.takeDamage.emit(damageData.damage)
	pass
	

func damage_enemy(damageData: DamageData, enemy):
	enemy.takeDamage.emit(damageData.damage)
