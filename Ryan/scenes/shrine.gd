extends Area2D

@onready var panel = $"../CanvasLayer/Panel"
@onready var dialogue = $"../CanvasLayer/Panel/DialogueLabel"
@onready var interact_label = $InteractLabel


var used = false
var player_near = false

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		interact_label.visible = true
		dialogue.visible = true
		

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		interact_label.visible = false
		dialogue.visible = false
		panel.visible = false
		
		
func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		if panel.visible:
			panel.visible = false
			interact_label.visible = true
		else: 
			panel.visible = true
			dialogue.text = ("You have regained 25 energy.")
			interact_label.visible = false
			
			
func _activate(player):
	if used:
		return
	used = true
	print("Shrine activated")
	
func do_effect(player):
	player.health = player.max_health
