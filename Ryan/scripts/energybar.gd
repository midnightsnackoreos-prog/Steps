extends ProgressBar

@onready var energy_manager = $"../../../../EnergyManager"

func _ready():
	max_value = energy_manager.max_energy
	value = energy_manager.energy
	
func _process(_delta):
	value = energy_manager.energy
