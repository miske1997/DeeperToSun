extends WeaponBase

@export var trap: PackedScene
@export var trapMark: PackedScene
@export var trapCooldown: float = 3
@export var trapRange: float = 300

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var spawnPos: Node2D = $Sprite2D/SpawnPos
@onready var timer: Timer = $Timer
@onready var secondaryTimer: Timer = $SecondaryTimer
@onready var player: Player = get_parent()

var secondartOnCooldown := false
var onCooldown := false
var bulletsInMagasine: int

func _ready() -> void:
	activate.connect(activate_weapon)
	secondary.connect(activate_secondary)
	secondaryTimer.wait_time = trapCooldown
	bulletsInMagasine = await get_bullets()
	weaponConfig.damageData.damageDealer = player

func _physics_process(delta: float) -> void:
	look_at_target()
	sprite.flip_v = sprite.global_position.x - global_position.x > 0

func activate_secondary():
	if secondartOnCooldown:
		return
	secondartOnCooldown = true
	secondaryTimer.start()
	placeTrap()
	await secondaryTimer.timeout
	secondartOnCooldown = false
	
func placeTrap():
	var mousePos = get_global_mouse_position()
	var dist = (mousePos - get_parent().global_position).length()
	if dist < trapRange:
		spawn_trap(mousePos)
	else:
		spawn_trap(get_parent().global_position + (mousePos - get_parent().global_position).normalized() * trapRange)
		
func spawn_trap(pos: Vector2):
	var trapClone: Node2D = trap.instantiate()
	trapClone.position = pos
	trapClone.cooldown = 0.5
	trapClone.scale = Vector2(0.3, 0.3)
	trapClone.damageData.damageDealer = get_parent()
	trapClone.frendly = true
	trapClone.oneTime = true
	get_tree().get_first_node_in_group("TemporaryObjects").add_child(trapClone)
	trapClone.onProck.connect(attach_mark, CONNECT_ONE_SHOT)
	
func attach_mark(body: Node2D):
	var markClone = trapMark.instantiate()
	markClone.damageData.damageDealer = get_parent()
	markClone.position = Vector2.ZERO
	body.add_child(markClone)

func activate_weapon():
	if onCooldown:
		return
	timer.wait_time = weaponConfig.fireSpeed
	onCooldown = true
	fire()
	use_bullet()
	timer.start()
	await timer.timeout
	if bulletsInMagasine == 0:
		bulletsInMagasine = await get_bullets()
	onCooldown = false

func fire():
	ProjectileEmitter.spawn_projectile(weaponConfig.projectileConfig, weaponConfig.damageData, spawnPos.global_position, rotation, Vector2(cos(rotation), sin(rotation)))

func use_bullet():
	bulletsInMagasine -= 1
	if bulletsInMagasine == 0:
		timer.wait_time =  get_reload_time()

func get_reload_time():
	var baseTime: float = weaponConfig.reloadTime
	var scaling := weaponConfig.weaponScaling.attackSpeedScaling
	var attackSpeed: float = player.playerData.stats.GetStat("AttackSpeed")
	
	var reloadTime := baseTime
	var attackSpeedContribution = Utills.map_range(attackSpeed * (1/ scaling), 0.1, 1, 0.5, 1)
	reloadTime *= attackSpeedContribution
	reloadTime = clampf(reloadTime, weaponConfig.reloadTime / 2, weaponConfig.reloadTime)
	print(reloadTime)
	return reloadTime

func get_bullets():
	while not player.playerData or not player.playerData.stats:
		await get_tree().process_frame
	return weaponConfig.bullets + floor(player.playerData.stats.GetStat("Amount") * weaponConfig.weaponScaling.amountScaling)

func look_at_target():
	look_at(lookAtTaret)
