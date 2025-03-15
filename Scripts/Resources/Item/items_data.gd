extends Resource

var items = {
	"Duble" = {
		function = "double",
		procs = ["playerHit"],
		cost = 20,
		sprite = "glasses"
	},
	"DoubleDouble" = {
		function = "double_double",
		procs = ["playerHit"],
		cost = 30,
		sprite = "glasses"
	},
	"thirdHit" = {
		function = "thirdHit",
		procs = Enums.ItemProcs.ENEMY_HIT,
		cost = 30,
		sprite = "thirdHit"
	},
	"SnakeFang" = {
		function = "snakeFang",
		procs = Enums.ItemProcs.ENEMY_HIT,
		cost = 30,
		sprite = "snakeFang"
	},
	"OilyRag" = {
		function = "oilyRag",
		procs = Enums.ItemProcs.ENEMY_HIT,
		cost = 30,
		sprite = "oilyRag"
	}
}
