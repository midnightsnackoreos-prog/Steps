extends Node


signal player_died
signal energy_changed(current, maximum)

var max_energy := 100.0
var energy := 100.0
var checkpoint: Marker2D = null


func spend(amount):
	energy = max(0, energy - amount)
	energy_changed.emit(energy, max_energy)
	
	if energy <= 0:
		player_died.emit()
	
func restore(amount):
	energy = min(max_energy, energy + amount)
	energy_changed.emit(energy, max_energy)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		spend(10)
