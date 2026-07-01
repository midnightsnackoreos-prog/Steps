extends Node

signal energy_changed(current, maximum)

var max_energy := 100.0
var energy := 100.0

func spend(amount):
	energy = max(0, energy - amount)
	energy_changed.emit(energy, max_energy)
	
func restore(amount):
	energy = min(max_energy, energy + amount)
	energy_changed.emit(energy, max_energy)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		spend(10)
