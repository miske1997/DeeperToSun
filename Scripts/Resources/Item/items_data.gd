extends Drop

var items = {
	"BigFShot" = {
		procs = {Enums.ItemProcs.PICKUP: "bigFShot"},
		cost = 20,
		sprite = "bigFShot"
	},
	"SeeingDouble" = {
		procs = {Enums.ItemProcs.PICKUP: "seeingDouble"},
		cost = 20,
		sprite = "seeingDouble"
	},
	"SeeingDoubleDouble" = {
		procs = {Enums.ItemProcs.PICKUP: "seeingDoubleDouble"},
		cost = 30,
		sprite = "seeingDoubleDouble"
	},
	"FungalInfection" = {
		procs = {Enums.ItemProcs.ENEMY_DEATH: "fungalInfection"},
		cost = 30,
		sprite = "fungalInfection"
	},
	"Blackjack" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "blackjack"},
		cost = 30,
		sprite = "blackjack"
	},
	"Airbag" = {
		procs = {Enums.ItemProcs.PRE_PLAYER_HIT: "airbag"},
		cost = 30,
		sprite = "airbag"
	},
	"PinCushion" = {
		procs = {Enums.ItemProcs.PRE_ENEMY_HIT: "pinCushion"},
		cost = 30,
		sprite = "pinCushion"
	},
	"FragileGlass" = {
		procs = {Enums.ItemProcs.ENEMY_DEATH: "fragileGlass"},
		cost = 30,
		sprite = "fragileGlass"
	},
	"GlassShield" = {
		procs = {Enums.ItemProcs.ROOM_LOAD: "glassShield"},
		cost = 30,
		sprite = "glassShield"
	},
	"SplitPersonalities" = {
		procs = {Enums.ItemProcs.PRE_ENEMY_HIT: "splitPersonalities"},
		cost = 30,
		sprite = "splitPersonalities"
	},
	"SnakeFang" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "snakeFang"},
		cost = 30,
		sprite = "snakeFang"
	},
	"FootFungus" = {
		procs = {Enums.ItemProcs.ROOM_LOAD: "footFungus"},
		cost = 30,
		sprite = "FootFungus"
	},
	"TungstenBalls" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "tungstenBalls"},
		cost = 30,
		sprite = "tungstenBalls"
	},
	"Molotov" = {
		procs = {Enums.ItemProcs.ENEMY_DEATH: "molotov"},
		cost = 30,
		sprite = "molotov"
	},
	"OilyRag" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "oilyRag"},
		cost = 30,
		sprite = "oilyRag"
	},
	"FireSoul" = {
		procs = {Enums.ItemProcs.ENEMY_DEATH: "fireSoul"},
		cost = 30,
		sprite = "FireSoul"
	},
	"SharperThanYouThought" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "sharperThanYouThought"},
		cost = 30,
		sprite = "sharperThanYouThought"
	},
	"ThornMail" = {
		function = "thornMail",
		procs = {Enums.ItemProcs.POST_PLAYER_HIT: "thornMail"},
		cost = 30,
		sprite = "thornMail"
	},
	"Maledictio" = {
		procs = {Enums.ItemProcs.POST_ENEMY_HIT: "maledictio"},
		cost = 30,
		sprite = "maledictio"
	},
	"GlassArmour" = {
		procs = {Enums.ItemProcs.POST_PLAYER_HIT: "glassArmour"},
		cost = 30,
		sprite = "GlassArmour"
	},
	"ShortFuse" = {
		procs = {Enums.ItemProcs.POST_PLAYER_HIT: "shortFuse"},
		cost = 30,
		sprite = "shortFuse"
	},
	"SlimeBlessing" = {
		procs = {Enums.ItemProcs.PROJECTILE_EMMIT: "slimeBlessing"},
		cost = 30,
		sprite = "SlimeBlessing"
	},
	"BackShots" = {
		procs = {Enums.ItemProcs.PICKUP: "backShots"},
		cost = 30,
		sprite = "backShots"
	},
	"Kamikaze" = {
		procs = {Enums.ItemProcs.DASH: "kamikaze"},
		cost = 30,
		sprite = "kamikaze"
	},
	"Tempo" = {
		procs = {Enums.ItemProcs.DASH: "tempo"},
		cost = 30,
		sprite = "tempo"
	},
	"SmokeBomb" = {
		procs = {Enums.ItemProcs.DASH: "smokeBomb"},
		cost = 30,
		sprite = "smokeBomb"
	},
	"HiddenDagger" = {
		procs = {Enums.ItemProcs.DASH: "hiddenDagger"},
		cost = 30,
		sprite = "hiddenDagger"
	},
	"Airflow" = {
		procs = {Enums.ItemProcs.DASH: "airflow"},
		cost = 30,
		sprite = "airflow"
	},
	"GlassArmor" = {
		procs = {
			Enums.ItemProcs.PRE_PLAYER_HIT: "glassArmorNegate",
			Enums.ItemProcs.ROOM_LOAD: "glassArmorReset",
		},
		cost = 30,
		sprite = "push"
	},
}

var activeItems = {
	
	"PressTheAttack" = {
		procs = {},
		cooldown = 5.0,
		function = "pressTheAttack",
		cost = 30,
		sprite = "push"
	},
	"Smite" = {
		procs = {},
		cooldown = 5.0,
		function = "smite",
		cost = 30,
		sprite = "push"
	}
}

var consumables = {
	
}

func get_item(itemName):
	if items.has(itemName):
		return items[itemName]
	if activeItems.has(itemName):
		return activeItems[itemName]
	if consumables.has(itemName):
		return consumables[itemName]
	return null

func get_drop():
	var roll = randi_range(0, items.size() + activeItems.size() + consumables.size() - 1)
	var item
	if roll < items.size():
		item = PassiveItem.new()
		item.name = items.keys()[roll] 
		item.cost = items[item.name].cost
	elif roll - items.size() < activeItems.size():
		item = ActiveItem.new()
		item.name = activeItems.keys()[roll - items.size()]
		item.cooldown = activeItems[item.name].cooldown
		item.function = activeItems[item.name].function
		item.sprite = activeItems[item.name].sprite
		item.cost = activeItems[item.name].cost
	else:
		item = ConsumableItem.new()
		item.name = consumables.keys()[roll - items.size() - activeItems.size()]
		item.function = consumables[item.name].function
		item.sprite = consumables[item.name].sprite
		item.cost = consumables[item.name].cost
	
	return item
