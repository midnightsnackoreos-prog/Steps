extends Area2D

@onready var panel = $"../CanvasLayer/Panel"
@onready var dialogue = $"../CanvasLayer/Panel/DialogueLabel"
@onready var interact_label = $InteractLabel
@onready var teleport_marker = $"../../SecondArea"
@onready var animation_player = $"../../GlobalUI/AnimationPlayer"
@onready var energy_manager = $"../../EnergyManager"
@onready var sfx_shrine = $"../sfx_shrine"
@onready var whoosh_sfx = $"../whoosh_sfx"

var used = false
var player_near = false
var player = null
var waiting_to_teleport = false


func _on_body_entered(body):
	if body.name == "Player":
		player = body
		player_near = true
		interact_label.visible = true
		dialogue.visible = true
		

func _on_body_exited(body):
	if body.name == "Player":
		player = null
		player_near = false
		interact_label.visible = false
		dialogue.visible = false
		panel.visible = false
		
		
func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		if waiting_to_teleport:
			waiting_to_teleport = false
			whoosh_sfx.play()
			panel.visible = false
			interact_label.text = "[E] Restore Energy"
			
			if player:
				animation_player.play("Fade to black")
				energy_manager.checkpoint = teleport_marker
				await animation_player.animation_finished
				player.global_position = teleport_marker.global_position
				animation_player.play("fadein")
				player.can_move = true
			return


		if !panel.visible:
			panel.visible = true
			sfx_shrine.play()
			energy_manager.restore(energy_manager.max_energy)
			dialogue.text = ("Your energy has been restored.\n Press [E] to continue your journey.")
			interact_label.text = "[E] Continue"
		if player:
			player.can_move = false
				
		waiting_to_teleport = true
		
			
