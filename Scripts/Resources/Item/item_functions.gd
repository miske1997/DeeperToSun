extends Resource


var thirdHitCount = 0

func double():
	print("double")
	
func double_double():
	print("double")
	
func thirdHit(enemyHit):
	thirdHitCount += 1
	if thirdHitCount == 3:
		thirdHitCount = 0
		Players.player.stats.SetStat("Damage", "thirdHit", 2, 0, Enums.StatModifyerType.MULTIPLY, true)
	
func snakeFang(enemyHit: EnemyBase):
	enemyHit.add_to_group("Poisoned")
	if enemyHit.has_meta("PoisonedDuration"):
		enemyHit.set_meta("PoisonedDuration", enemyHit.get_meta("PoisonedDuration") + 3.0)
	else:
		enemyHit.set_meta("PoisonedDuration", 3.0)

func oilyRag(enemyHit: EnemyBase):
	enemyHit.add_to_group("Burning")
	if enemyHit.has_meta("BurningDuration"):
		enemyHit.set_meta("BurningDuration", enemyHit.get_meta("BurningDuration") + 3.0)
	else:
		enemyHit.set_meta("BurningDuration", 3.0)
