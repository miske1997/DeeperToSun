class_name StatManager extends Resource

@export var controllers: Dictionary = {}


func InitFromConfig(playerConfig: PlayerConfig):
	controllers["Damage"] = StatController.new()
	controllers["Damage"].base = 1 
	controllers["MovementSpeed"] = StatController.new()
	controllers["MovementSpeed"].base = playerConfig.movementSpeed 
	controllers["Range"] = StatController.new()
	controllers["Range"].base = 1 
	controllers["Amount"] = StatController.new()
	controllers["Amount"].base = 1 
	controllers["AttackSpeed"] = StatController.new()
	controllers["AttackSpeed"].base = 1
	controllers["Luck"] = StatController.new()
	controllers["Luck"].base = 0
	controllers["ProjectileSpeed"] = StatController.new()
	controllers["ProjectileSpeed"].base = 1
	controllers["Size"] = StatController.new()
	controllers["Size"].base = 1
	
	#ResourceSaver.save(self, "res://Data/Configs/Player/PlayerData.tres")

func GetController(statName: String):
	if not controllers.has(statName):
		controllers[statName] = StatController.new()
	return controllers[statName]
	
func GetStatFromController(statName: String):
	return GetController(statName).GetStatValue()
	
func GetStat(statName: String):
	if controllers.has(statName):
		return GetStatFromController(statName)
	else:
		return 1
	

func SetAugment(augmentName):
	GetController(augmentName).AddedAugment(augmentName)


func GetStatLocal(statName):
	if controllers.has(statName):
		return GetStatFromController(statName)
	else:
		return 1
	


func SetStat(statName, valueName, value, priority, operation, isOneTime):
	if not controllers.has(statName):
		return
	if isOneTime:
		GetController(statName).AddOneTimeModifier(valueName, value, priority, operation)
	else:
		GetController(statName).AddModifier(valueName, value, priority, operation)

func SetExpiraitonStat(statName, valueName, value, priority, operation, expirationTime):
	if not controllers.has(statName):
		return
	GetController(statName).AddExpirationModifier(valueName, value, priority, operation, expirationTime)


func UpdateStat(statName, valueName, value):
	if not controllers.has(statName): 
		#wait("No stat with name: " .. statName)
		return
	
	GetController(statName).ChangeModifier(valueName, value)

func ClearAllAugmentsWithName(name):
	for key in controllers:
		controllers[key].RemoveModifier(name)

func RegisterEvent(eventObject):
	#table.insert(registerdEvents, eventObject)
	pass
