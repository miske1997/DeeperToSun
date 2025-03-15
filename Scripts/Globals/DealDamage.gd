extends Node

var items_data = preload("res://Data/Items/items_data.tres").items
var item_functions = preload("res://Data/Items/item_functions.tres")


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
	prok_on_player_hit(damageData, enemy)
	enemy.takeDamage.emit(damageData.damage_scale * 1)
	Events.playerHit.emit(enemy, damageData)
	

func damage_enemy(damageData: DamageData, enemy: EnemyBase):
	if not damageData.damageSource == Enums.DamageSource.BURN and not damageData.damageSource == Enums.DamageSource.POISON:
		prok_on_enemy_hit(damageData, enemy)
	var damage = damageData.damage_scale * Players.player.stats.GetStat("Damage")
	if enemy.is_in_group("Cursed") and (damageData.damageSource == Enums.DamageSource.BURN or damageData.damageSource == Enums.DamageSource.POISON):
		damage *= 2
	if damageData.damageSource == Enums.DamageSource.POISON and damage > enemy.get_node("EnemyHealth").health:
		return
	print(str(damage))
	Events.enemyHit.emit(enemy, damage)
	enemy.takeDamage.emit(damage)
	
	
func prok_on_player_hit(damageData: DamageData, enemy):
	for item: PassiveItem in Players.player.collectedItems:
		if not item is PassiveItem:
			continue
		if items_data.has(item.name) and items_data[item.name].procs == Enums.ItemProcs.PLAYER_HIT:
			item_functions[items_data[item.name].function + item.state].call()
	
func prok_on_enemy_hit(damageData: DamageData, enemy):
	for item: PassiveItem in Players.player.collectedItems:
		if not item is PassiveItem:
			continue
		if items_data.has(item.name) and items_data[item.name].procs == Enums.ItemProcs.ENEMY_HIT:
			item_functions[items_data[item.name].function + item.state].call(enemy)
