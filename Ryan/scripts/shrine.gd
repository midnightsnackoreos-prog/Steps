extends Area2D

@onready var panel = $"../CanvasLayer/Panel"
@onready var dialogue = $"../CanvasLayer/Panel/DialogueLabel"
@onready var interact_label = $InteractLabel
@onready var teleport_marker = $"../../SecondArea"


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
			
			panel.visible = false
			interact_label.text = "[E] Restore Energy"
			if player:
				player.global_position = teleport_marker.global_position
			return


		if !panel.visible:
			panel.visible = true
			dialogue.text = ("Your energy has been restored.\n Press [E] to continue your journey.")
			interact_label.text = "[E] Continue"
		if player:
			player.can_move = false
				
		waiting_to_teleport = true
			
