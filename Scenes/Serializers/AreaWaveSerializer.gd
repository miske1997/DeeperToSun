extends WaveSerializer

@export var waveTimeout: float = 10.0
@export var enemyName: String = "Gnome"
@export var enemySpawnRange: Vector2 = Vector2.ONE
@export var spawnDelayRange: Vector2 = Vector2.ZERO
@export var startCondition: WaveCondition
@export var endCondition: WaveCondition
@export var spawnCondition: WaveCondition

func get_wave_config():
	
	var waveConfig := AreaWaveConfig.new()
	waveConfig.waveTimeout = waveTimeout
	waveConfig.enemyName = enemyName
	waveConfig.enemySpawnRange = enemySpawnRange
	waveConfig.spawnDelayRange = spawnDelayRange
	waveConfig.startCondition = startCondition
	waveConfig.endCondition = endCondition
	waveConfig.spawnCondition = spawnCondition
	
	waveConfig.area = get_node("SpawnArea").shape
	waveConfig.areaPosition = get_node("SpawnArea").position
	return waveConfig

func serialize_wave():
	return get_wave_config()
	
func convert_position(enemyPosition):
	var roomStart: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomStart").position
	var roomEnd: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomEnd").position
	
	var roomSize:Vector2 = roomEnd - roomStart
	enemyPosition -= roomStart
	return Vector2(enemyPosition.x / roomSize.x, enemyPosition.y / roomSize.y)
