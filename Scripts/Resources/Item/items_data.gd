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
		procs = Enums.ItemProcs.POST_ENEMY_HIT,
		cost = 30,
		sprite = "thirdHit"
	},
	"SnakeFang" = {
		function = "snakeFang",
		procs = Enums.ItemProcs.POST_ENEMY_HIT,
		cost = 30,
		sprite = "snakeFang"
	},
	"OilyRag" = {
		function = "oilyRag",
		procs = Enums.ItemProcs.POST_ENEMY_HIT,
		cost = 30,
		sprite = "oilyRag"
	},
	"SharperThanYouThought" = {
		function = "sharperThanYouThought",
		procs = Enums.ItemProcs.POST_ENEMY_HIT,
		cost = 30,
		sprite = "sharperThanYouThought"
	},
	"ThornMail" = {
		function = "thornMail",
		procs = Enums.ItemProcs.POST_PLAYER_HIT,
		cost = 30,
		sprite = "thornMail"
	},
	"Maledictio" = {
		function = "maledictio",
		procs = Enums.ItemProcs.POST_PLAYER_HIT,
		cost = 30,
		sprite = "maledictio"
	},
	"GlassAmour" = {
		function = "glassAmour",
		procs = Enums.ItemProcs.POST_PLAYER_HIT,
		cost = 30,
		sprite = "glassAmour"
	}
}
