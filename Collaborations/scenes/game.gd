extends Node2D

@onready var player = $Player
@onready var energy_manager = $EnergyManager
@onready var animation_player = $GlobalUI/AnimationPlayer
@onready var death_label = $GlobalUI/DeathLabel


func _ready():
	energy_manager.player_died.connect(_on_player_died)
	

func _on_player_died():
	player.can_move = false
	
	animation_player.play("death")
	death_label.visible = true
	await animation_player.animation_finished
	death_label.visible = false
	
	if energy_manager.checkpoint:
		player.global_position = energy_manager.checkpoint.global_position
	
	energy_manager.restore(energy_manager.max_energy)
	
	animation_player.play("fadein")
	
	player.can_move = true
