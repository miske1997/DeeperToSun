extends Node

@export var burningDamageData: DamageData
@export var poisonDamageData: DamageData

var dotTimer = 0.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	dotTimer += delta
	burningDamageData.damageDealer = Players.player.character
	poisonDamageData.damageDealer = Players.player.character
	process_poisoned(delta)
	process_bleading(delta)
	process_burning(delta)
	process_cursed(delta)
	process_slowed(delta)
	if dotTimer >= 1:
		dotTimer = 0.0

func process_poisoned(delta: float):
	var poisoned = get_tree().get_nodes_in_group("Poisoned")
	for poisonedEnemy in poisoned:
		decrement_timer(delta, poisonedEnemy, "Poisoned")
		if dotTimer >= 1:
			DealDamage.deal_damage(poisonDamageData,  poisonedEnemy)

func process_bleading(delta: float):
	var bleading = get_tree().get_nodes_in_group("Bleading")
	for bleadingEnemy in bleading:
		decrement_timer(delta, bleadingEnemy, "Bleading")

func process_burning(delta: float):
	var burning = get_tree().get_nodes_in_group("Burning")
	for burningEnemy in burning:
		decrement_timer(delta, burningEnemy, "Burning")
		if dotTimer >= 1:
			DealDamage.deal_damage(burningDamageData,  burningEnemy)

func process_cursed(delta: float):
	var cursed = get_tree().get_nodes_in_group("Cursed")
	for cursedEnemy in cursed:
		decrement_timer(delta, cursedEnemy, "Cursed")

func process_slowed(delta: float):
	var slowed = get_tree().get_nodes_in_group("Slowed")
	for slowedEnemy in slowed:
		decrement_timer(delta, slowedEnemy, "Slowed")
	
func decrement_timer(delta: float, enemy, dotName: String):
	var duration = enemy.get_meta(dotName + "Duration")
	duration -= delta
	if duration <= 0:
		enemy.remove_meta(dotName + "Duration")
		enemy.remove_from_group(dotName)
	else:
		enemy.set_meta(dotName + "Duration", duration)
