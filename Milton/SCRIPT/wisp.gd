extends CharacterBody2D

@onready var detection_icon = $DetectionIcon
@onready var detection_timer = $DetectionTimer

var speed = 30
var player_chase = false
var player = null
var health: int = 100

func _physics_process(delta):
	
	if player_chase:
		global_position += (player.global_position - global_position) / speed
		$AnimatedSprite2D.play("CHASE")
	else:
		$AnimatedSprite2D.play("slumber")
		




func _on_detection_area_body_entered(body):
	if body.name != "Player":
		return
		
	player = body
	player_chase = true
	
	detection_icon.visible = true
	detection_timer.start()
	


func _on_detection_area_body_exited(body):
	
	player = null
	player_chase = false


func _on_detection_timer_timeout() -> void:
	detection_icon.visible = false

# DAMAGE AND HEALTH---------------------

func take_damage(damage : int) -> void:
	health -= damage
	print(health)
