extends Node

var coinScene: PackedScene = load("res://Scenes/Basic/coin.tscn")

func _ready() -> void:
	Events.enemyDied.connect(drop_loot)

func get_folder(name) -> Node2D:
	return get_tree().get_first_node_in_group("TemporaryObjects").get_node(name)

func drop_loot(enemy: EnemyBase):
	var drop = enemy.dropTable.get_drop()
	if drop is Coin:
		drop_coin(enemy, drop)
		
func drop_coin(enemy: EnemyBase, coinDrop: Coin):
	var coin: Node2D = coinScene.instantiate()
	coin.position = enemy.position + Vector2(randf_range(-10, 10), randf_range(-10, 10))
	coin.frame = randi_range(0, 3)
	get_folder("Coins").add_child(coin)
	
