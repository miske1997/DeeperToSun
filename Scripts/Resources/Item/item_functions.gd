extends Resource


var thirdHitCount = 0

func double():
	print("double")
	
func double_double():
	print("double")
	
func thirdHit(data):
	thirdHitCount += 1
	if thirdHitCount == 3:
		thirdHitCount = 0
		Players.player.stats.SetStat("Damage", "thirdHit", 2, 0, Enums.StatModifyerType.MULTIPLY, true)
	
func snakeFang(data):
	var enemyHit: EnemyBase = data.enemy
	enemyHit.add_to_group("Poisoned")
	if enemyHit.has_meta("PoisonedDuration"):
		enemyHit.set_meta("PoisonedDuration", enemyHit.get_meta("PoisonedDuration") + 3.0)
	else:
		enemyHit.set_meta("PoisonedDuration", 3.0)

func oilyRag(data):
	var enemyHit: EnemyBase = data.enemy
	enemyHit.add_to_group("Burning")
	if enemyHit.has_meta("BurningDuration"):
		enemyHit.set_meta("BurningDuration", enemyHit.get_meta("BurningDuration") + 3.0)
	else:
		enemyHit.set_meta("BurningDuration", 3.0)

func sharperThanYouThought(data):
	var enemyHit: EnemyBase = data.enemy
	enemyHit.add_to_group("Bleading")
	if enemyHit.has_meta("BleadingDuration"):
		enemyHit.set_meta("BleadingDuration", enemyHit.get_meta("BleadingDuration") + 3.0)
	else:
		enemyHit.set_meta("BleadingDuration", 3.0)
		
func maledictio(data):
	var enemyHit: EnemyBase = data.enemy
	enemyHit.add_to_group("Cursed")
	if enemyHit.has_meta("CursedDuration"):
		enemyHit.set_meta("CursedDuration", enemyHit.get_meta("CursedDuration") + 3.0)
	else:
		enemyHit.set_meta("CursedDuration", 3.0)
		
func thornMail(data):
	if data.damageData.damageSource != Enums.DamageSource.CONTACT:
		return
	var enemyHitting: EnemyBase = data.damageData.damageDealer
	enemyHitting.add_to_group("Bleading")
	if enemyHitting.has_meta("BleadingDuration"):
		enemyHitting.set_meta("BleadingDuration", enemyHitting.get_meta("BleadingDuration") + 3.0)
	else:
		enemyHitting.set_meta("BleadingDuration", 3.0)
		
func glassAmour(data):
	if data.damageData.damageSource != Enums.DamageSource.CONTACT:
		return
	var enemyHitting: EnemyBase = data.damageData.damageDealer
	enemyHitting.add_to_group("Bleading")
	if enemyHitting.has_meta("BleadingDuration"):
		enemyHitting.set_meta("BleadingDuration", enemyHitting.get_meta("BleadingDuration") + 3.0)
	else:
		enemyHitting.set_meta("BleadingDuration", 3.0)
