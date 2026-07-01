extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@onready var energy_manager = $"../../../../EnergyManager"


var health = 0.0
