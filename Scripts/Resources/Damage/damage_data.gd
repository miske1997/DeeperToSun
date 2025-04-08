class_name DamageData extends Resource

@export var damage_scale: float = 1.0
@export var damage: float = 1.0
@export var stagger: float = 0.0
@export var damageSource: Enums.DamageSource = Enums.DamageSource.AUTO_ATTACK 
@export var fixed := false
var damageDealer
