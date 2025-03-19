extends Node

var items_data = load("res://Data/Items/items_data.tres").items
var item_functions = load("res://Data/Items/item_functions.tres")


func deal_damage(damageData: DamageData, target):
	if not target or not is_instance_valid(target):
		return
	if not damageData.damageDealer or not is_instance_valid(damageData.damageDealer):
		return
	
	if damageData.damageDealer.is_in_group("Player"):
		damage_enemy(damageData, target)
	else:
		damage_player(damageData, target)

func damage_player(damageData: DamageData, enemy: Player):
	if enemy.iframes:
		return
	damageData.damage = damageData.damage_scale * 1
	prok(damageData, enemy, Enums.ItemProcs.PRE_PLAYER_HIT)
	enemy.takeDamage.emit(damageData)
	Events.playerHit.emit(enemy, damageData)
	prok(damageData, enemy, Enums.ItemProcs.POST_PLAYER_HIT)
	

func damage_enemy(damageData: DamageData, enemy: EnemyBase):
	if not damageData.damageSource == Enums.DamageSource.BURN and not damageData.damageSource == Enums.DamageSource.POISON:
		prok(damageData, enemy, Enums.ItemProcs.PRE_ENEMY_HIT)
	
	if not damageData.fixed:
		damageData.damage = damageData.damage_scale * Players.player.stats.GetStat("Damage")
	if enemy.is_in_group("Cursed") and (damageData.damageSource == Enums.DamageSource.BURN or damageData.damageSource == Enums.DamageSource.POISON):
		damageData.damage *= 2
	if enemy.is_in_group("Bleading") and damageData.damageSource == Enums.DamageSource.AUTO_ATTACK:
		damageData.damage *= 1.1
	if damageData.damageSource == Enums.DamageSource.POISON and damageData.damage > enemy.health:
		return

	Events.enemyHit.emit(enemy, damageData)
	enemy.takeDamage.emit(damageData)
	if not damageData.damageSource == Enums.DamageSource.BURN and not damageData.damageSource == Enums.DamageSource.POISON:
		prok(damageData, enemy, Enums.ItemProcs.POST_ENEMY_HIT)
	

func prok(damageData: DamageData, enemy, prockType: Enums.ItemProcs):
	for item: PassiveItem in Players.player.collectedItems:
		if not item is PassiveItem:
			continue
		if items_data.has(item.name) and items_data[item.name].procs == prockType:
			#print(item_functions.get_method_list())
			if not item_functions.get_method_list().any(func(f): return f.name == items_data[item.name].function + item.state) :
				return
			item_functions[items_data[item.name].function + item.state].call({enemy = enemy, damageData = damageData})
