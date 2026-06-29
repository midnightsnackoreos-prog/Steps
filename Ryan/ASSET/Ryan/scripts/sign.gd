extends Area2D

@onready var dialogue = $"../CanvasLayer/Panel/DialogueLabel"
@onready var panel = $"../CanvasLayer/Panel"
@onready var interact_label = $InteractLabel


var player_near = false
var player = null

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
		panel.visible = false
		dialogue.visible = false
		
		
		
func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		if panel.visible:
			panel.visible = false
			interact_label.text = "[E] Interact"
			interact_label.visible = true
			if player:
				player.can_move = true
		else: 
			panel.visible = true
			dialogue.text = ("Welcome, traveler.\nLegends say that the one who reaches the top has their wish granted.\nContinue up the path to begin your ascent.")
			interact_label.text = "[E] Close"
			if player:
				player.can_move = false
