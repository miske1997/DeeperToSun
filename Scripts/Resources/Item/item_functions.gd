extends Resource


var blackjackCount = 0
var glassArmorBroken = false

func bigFShot(data):
	Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
	Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)

func seeingDouble(data):
	Players.player.stats.SetStat("Amount", "seeingDouble", 1, 0, Enums.StatModifyerType.ADD, false)

func seeingDoubleDouble(data):
	Players.player.stats.SetStat("Amount", "seeingDoubleDouble", 2, 0, Enums.StatModifyerType.ADD, false)

func blackjack(data):
	blackjackCount += 1
	if blackjackCount == 3:
		blackjackCount = 0
		Players.player.stats.SetStat("Damage", "thirdHit", 2, 0, Enums.StatModifyerType.MULTIPLY, true)

func airbag(data):
	var player: Player = data.enemy
	if player.playerData.health <= data.damageData.damage:
		data.damageData.damage = 0
		print("added 2 shields")
		player.shealdUp.emit(2)
		for item in player.playerData.collectedItems:
			if item.name == "Airbag":
				item.state = "Used"

func fungalInfection(data):
	var pool = preload("res://Scenes/Basic/dot_poll.tscn").instantiate()
	var enemy: EnemyBase = data.enemy
	var tempFolder = enemy.get_tree().get_first_node_in_group("TemporaryObjects")
	if not tempFolder:
		print("NO TEMP FOLDER")
		return
	pool.dotName = "Poisoned"
	pool.position = enemy.position
	tempFolder.add_child(pool)
	
func pinCushion(data):
	var enemy: EnemyBase = data.enemy
	if enemy.has_node("PinChusion"):
		return
	var cushion = preload("res://Scenes/ItemScenes/pin_chusion.tscn").instantiate()
	enemy.add_child(cushion)
	
func splitPersonalities(data):
	Players.player.stats.ClearAllAugmentsWithName("splitPersonalities")
	var roll := randi_range(0, 100)
	if roll < 20:
		Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
		Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)
	elif roll < 40:
		Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
		Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)
	elif roll < 60:
		Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
		Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)
	elif roll < 80:
		Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
		Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)
	else:
		Players.player.stats.SetStat("Damage", "BigFShot", 3, 0, Enums.StatModifyerType.ADD, false)
		Players.player.stats.SetStat("AttackSpeed", "BigFShot", 0.5, 0, Enums.StatModifyerType.MULTIPLY, false)

func snakeFang(data):
	var enemyHit: EnemyBase = data.enemy
	Utills.set_status_effect(enemyHit, "Poisoned", 3.0, true)
	
func tungstenBalls(data):
	if data.damageData.damageSource != Enums.DamageSource.AUTO_ATTACK:
		return
	var enemyHit: EnemyBase = data.enemy
	enemyHit.speedController.AddExpirationModifier("TungstenBalls", 0.5, 0, Enums.StatModifyerType.MULTIPLY, 3.0)

func molotov(data):
	var pool = preload("res://Scenes/Basic/dot_poll.tscn").instantiate()
	var enemy: EnemyBase = data.enemy
	var tempFolder = enemy.get_tree().get_first_node_in_group("TemporaryObjects")

	pool.dotName = "Burning"
	pool.position = enemy.position
	tempFolder.add_child(pool)
	
func glassShield(data):
	var shields = preload("res://Scenes/ItemScenes/glass_shields.tscn").instantiate()
	var player: Player = Players.player.character
	player.add_child(shields)
	
func fragileGlass(data):
	var projectileConfig: ProjectileConfig = preload("res://Data/Configs/Projectiles/GlassShard.tres").duplicate()
	var damageData: DamageData = preload("res://Data/Configs/Damage/glassShard.tres").duplicate()
	damageData.damageDealer = Players.player.character
	ProjectileEmitter.spawn_in_random_dir(projectileConfig, damageData, data.enemy.position, 8)

func oilyRag(data):
	var enemyHit: EnemyBase = data.enemy
	Utills.set_status_effect(enemyHit, "Burning", 3.0, true)

func tickingBomb(data):
	var bomb = preload("res://Scenes/ItemScenes/ticking_bomb.tscn").instantiate()
	var enemy: EnemyBase = data.enemy

	var tempFolder = enemy.get_tree().get_first_node_in_group("TemporaryObjects")
	bomb.position = enemy.position
	tempFolder.add_child(bomb)


func sharperThanYouThought(data):
	var enemyHit: EnemyBase = data.enemy
	Utills.set_status_effect(enemyHit, "Bleading", 3.0, true)
	
func maledictio(data):
	var enemyHit: EnemyBase = data.enemy
	Utills.set_status_effect(enemyHit, "Cursed", 3.0, true)
	
func backShots(data):
	Players.player.stats.SetStat("Damage", "BackShots", 2, -1, Enums.StatModifyerType.MULTIPLY, false)
	Players.player.invertAim = true
		
func thornMail(data):
	if data.damageData.damageSource != Enums.DamageSource.CONTACT:
		return
	var enemyHitting: EnemyBase = data.damageData.damageDealer
	Utills.set_status_effect(enemyHitting, "Bleading", 3.0, true)

		
func glassAmour(data):
	if data.damageData.damageSource != Enums.DamageSource.CONTACT:
		return
	var enemyHitting: EnemyBase = data.damageData.damageDealer
	Utills.set_status_effect(enemyHitting, "Bleading", 3.0, true)

func shortFuse(data):
	var player: Player = data.enemy
	Players.player.stats.SetExpiraitonStat("AttackSpeed", "shortFuse", 1.5, 1, Enums.StatModifyerType.MULTIPLY, 2.0)
	Players.player.stats.SetExpiraitonStat("MovementSpeed", "shortFuse", 1.5, 1, Enums.StatModifyerType.MULTIPLY, 2.0)
	var bomb = preload("res://Scenes/ItemScenes/aoe_burn.tscn").instantiate()
	var tempFolder = player.get_tree().get_first_node_in_group("TemporaryObjects")
	bomb.position = player.position
	tempFolder.add_child(bomb)

func kamikaze(data):
	if data.dashing:
		return
	var player: Player = data.player
	var bomb = preload("res://Scenes/ItemScenes/ticking_bomb.tscn").instantiate()
	var tempFolder = player.get_tree().get_first_node_in_group("TemporaryObjects")
	bomb.position = player.position
	tempFolder.add_child(bomb)
	
func tempo(data):
	if data.dashing:
		return
	Players.player.stats.SetExpiraitonStat("AttackSpeed", "tempo", 5, -1, Enums.StatModifyerType.MULTIPLY, 2.0)
	
func smokeBomb(data):
	var player: Player = data.player
	if data.dashing:
		player.iframes = true
	else:
		player.iframes = false
		
func airflow(data):
	if data.dashing:
		return
	var player: Player = data.player
	var enemies = player.get_tree().get_nodes_in_group("Enemy")

	for body: EnemyBase in enemies:
		if (body.position - player.position).length() < 150:
			body.get_node("Dash").begin_dash((body.position - player.position).normalized())
	
		
func hiddenDagger(data):
	if data.dashing:
		return
	var player: Player = data.player
	var projectileConfig: ProjectileConfig = preload("res://Data/Configs/Projectiles/HiddenDagger.tres").duplicate()
	var damageData: DamageData = preload("res://Data/Configs/Damage/hiddenDagger.tres").duplicate()
	damageData.damageDealer = Players.player.character
	var enemies = player.get_tree().get_nodes_in_group("Enemy")
	if enemies.size() == 0:
		return
	var clossestEnemy: EnemyBase = null
	var minDistance := 100000
	for enemy: EnemyBase in enemies:
		if (enemy.position - player.position).length() < minDistance:
			clossestEnemy = enemy
			minDistance = (enemy.position - player.position).length()
	ProjectileEmitter.target_projectile_at(projectileConfig, damageData, damageData.damageDealer.position, clossestEnemy.position)

func push(data):
	var enemy: EnemyBase = data.enemy
	var enemies = enemy.get_tree().get_nodes_in_group("Enemy")

	for body: EnemyBase in enemies:
		if body == enemy:
			continue
		if (body.position - enemy.position).length() < 300:
			#print("pushed")
			body.get_node("Dash").begin_dash((body.position - enemy.position).normalized())

func glassArmorNegate(data):
	if glassArmorBroken:
		data.damageData.damage *= 2
		return
		
	if data.damageData.damage > 0:
		glassArmorBroken = true
		data.damageData.damage = 0
	
func glassArmorReset(data):
	glassArmorBroken = false
