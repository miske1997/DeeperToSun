extends Node

@export var roomConfig: RoomConfig
@export var door: PackedScene
@export var itemOnGround: PackedScene
var mapNode: MapNode

@onready var enemyFolder := $Enemies
@onready var spawner := $Spawner
@onready var waveTimer := $Spawner/WaveTimeout
@onready var roomStart: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomStart").position
@onready var roomEnd: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomEnd").position

var waveCount = 0
var roomStarted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_node("RoomSerializer") and get_node("RoomSerializer").process_mode != PROCESS_MODE_DISABLED:
		return
	waveTimer.timeout.connect(on_wave_timeout)
	set_room_bg()
	spawn_player()
	
	if roomConfig.roomType == Enums.RoomType.SPAWN:
		roomStarted = true
		spawn_enemies(roomConfig.waves[waveCount])
	if roomConfig.roomType == Enums.RoomType.ITEM:
		spawn_item()
		Events.itemCollected.connect(func(itemOnGround): room_compleated(), CONNECT_ONE_SHOT)
	if roomConfig.roomType == Enums.RoomType.SHOP:
		spawn_item()
	if roomConfig.roomType == Enums.RoomType.TRAP:
		spawn_item()
		Events.itemCollected.connect(func(itemOnGround): roomStarted = true; spawn_enemies(roomConfig.waves[waveCount]), CONNECT_ONE_SHOT)
	#room_compleated()

func _process(delta: float) -> void:
	if has_node("RoomSerializer") and get_node("RoomSerializer").process_mode != PROCESS_MODE_DISABLED:
		return
	if enemyFolder.get_children().size() == 0 and roomStarted:
		wave_compleated()


func wave_compleated():
	waveCount += 1
	if roomConfig.waves.size() > waveCount:
		spawn_enemies(roomConfig.waves[waveCount])
	else:
		room_compleated()

func on_wave_timeout():
	if roomConfig.waves.size() > waveCount + 1:
		wave_compleated()

func room_compleated():
	if not mapNode:
		return
	var step = (roomEnd.x - roomStart.x) / (mapNode.get_neighbours().size() + 1.0)
	var i := 1
	for neighbourRoom: MapNode in mapNode.get_neighbours():
		spawn_door(step * i, neighbourRoom.roomNode.roomConfig.roomType)
		i += 1
		
func spawn_door(offset, type):
	var doorClone: Node2D = door.instantiate()
	doorClone.roomType = type
	doorClone.position = Vector2(roomStart.x + offset, roomStart.y - 20)
	add_child(doorClone)
	

func set_room_bg():
	pass

func spawn_item():
	var rolledItem = roomConfig.dropTable.get_drop()
	print(rolledItem.name)
	var itemPickup: Node2D = itemOnGround.instantiate()
	itemPickup.position = roomStart + (roomEnd - roomStart) / 2
	itemPickup.item = rolledItem
	add_child(itemPickup)

func spawn_shop():
	pass

func spawn_enemies(waveConfig):
	waveTimer.stop()
	waveTimer.wait_time = waveConfig.waveTimeout
	waveTimer.start()
	spawner.spawn_enemies(waveConfig)

func spawn_player():
	pass
