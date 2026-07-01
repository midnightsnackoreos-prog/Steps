extends Node

var max_energy = 100.0
var energy = 100.0

func spend(amount):
	energy = max(0, energy - amount)
	
func restore(amount):
	energy = min(max_energy, energy + amount)
