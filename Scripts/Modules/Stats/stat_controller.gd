class_name StatController extends Resource


@export var dirty = true
@export var lastCalcValue = 0
#@export var lastBaseStat = 0
@export var augments: Array[StatModification] = []
@export var oneTimeAugments: Array[StatModification] = []
@export var base: float

signal statChanged

func Tick(delta: float):
	for expirationModifier in augments:
		if not expirationModifier is ExpirationModification:
			continue
		expirationModifier.expirationTime -= delta
		if expirationModifier.expirationTime <= 0:
			RemoveModifier(expirationModifier.name)

func GetSortedStats():
	var sortedStats = []

	for statValue in augments:
		sortedStats.push_back(statValue)
	for statValue in oneTimeAugments:
		sortedStats.push_back(statValue)
	
	if sortedStats.size() == 1:
		return sortedStats
	
	sortedStats.sort_custom(func(a:StatModification, b:StatModification): return a.priority < b.priority)
	return sortedStats


func CalcBaseStat():
	
	var baseValue = 0
	for stat: StatModification in augments.filter(func(s: StatModification): return s.priority < 0) :
		baseValue += base * stat.modification
	
	baseValue += base
	return baseValue


func GetStatVar(baseStat):
	var sortedStats = GetSortedStats()

	var statValue = base #CalcBaseStat(baseStat)
	for stat in sortedStats:
		match stat.type:
			Enums.StatModifyerType.MULTIPLY:
				statValue *= stat.modification
			Enums.StatModifyerType.ADD:
				statValue += stat.modification
			Enums.StatModifyerType.OVERRIDE:
				statValue = stat.modification
	return statValue


func GetStatValue():
	if not dirty :
		return lastCalcValue
		
	var sortedStats = GetSortedStats()
	var statValue = CalcBaseStat()

	for stat: StatModification in sortedStats.filter(func(s: StatModification): return s.priority >= 0):
		match stat.type:
			Enums.StatModifyerType.MULTIPLY:
				statValue *= stat.modification
			Enums.StatModifyerType.ADD:
				statValue += stat.modification
			Enums.StatModifyerType.OVERRIDE:
				statValue = stat.modification
		
	lastCalcValue = statValue
	if oneTimeAugments.size() == 0:
		dirty = false
	else:
		oneTimeAugments.clear()
	return statValue

func AddOneTimeModifier(modifierName: String, modifierValue: float, modifierPriority: int, operation: Enums.StatModifyerType):
	if oneTimeAugments.any(func(stat: StatModification): return stat.name == modifierName):
		return
	
	var statValue = StatModification.new()
	statValue.name = modifierName
	statValue.modification = modifierValue
	statValue.priority = modifierPriority
	statValue.type = operation
	
	oneTimeAugments.push_back(statValue)
	dirty = true
	
	statChanged.emit()

func AddExpirationModifier(modifierName: String, modifierValue: float, modifierPriority: int, operation: Enums.StatModifyerType, expirationTime: float):
	if ProlongExpirationStat(modifierName, expirationTime):
		return
	
	var statValue = ExpirationModification.new()
	statValue.name = modifierName
	statValue.modification = modifierValue
	statValue.priority = modifierPriority
	statValue.type = operation
	statValue.expirationTime = expirationTime
	
	augments.push_back(statValue)
	dirty = true
	
	statChanged.emit()

func AddModifier(modifierName: String, modifierValue: float, modifierPriority: int, operation: Enums.StatModifyerType):
	if augments.any(func(stat: StatModification): return stat.name == modifierName):
		print("MODIFIER EXISTS WITH NAME: " + modifierName)
		#warn("MODIFIER EXISTS WITH NAME: " .. modifierName)
		return
	
	var statValue = StatModification.new()
	statValue.name = modifierName
	statValue.modification = modifierValue
	statValue.priority = modifierPriority
	statValue.type = operation
	
	augments.push_back(statValue)
	#if isBase :
		#statValue:SetAttribute("Base", true)
	dirty = true
	
	statChanged.emit()
	#if duration :
		#delay(duration, func()
			#RemoveModifier(modifierName)
		#)
	
func AddedAugment(augmentName, value):
	dirty = true


func ChangeModifier(modifierName, newValue):
	if not augments.any(func(stat: StatModification): return stat.name == modifierName) :
		return
	for stat: StatModification in augments:
		if stat.name != modifierName:
			continue
		stat.modification = newValue
	dirty = true
	statChanged.emit()

func RemoveModifier(modifierName):
	if augments.any(func(stat: StatModification): return stat.name == modifierName) :
		augments = augments.filter(func(stat: StatModification): return stat.name != modifierName)
		dirty = true
		statChanged.emit()
		
func ProlongExpirationStat(modifierName, time):
	for stat: StatModification in augments:
		if stat.name != modifierName:
			continue
		stat.expirationTime = time
		return true
	return false
