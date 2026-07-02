extends CharacterBody2D

@onready var detection_icon = $DetectionIcon
@onready var detection_timer = $DetectionTimer
@onready var player = $"../../Player"
@onready var energy_manager = $"../../EnergyManager"


var speed = 30
var player_chase = false
var health: int = 100
var max_health := 100
var player_near = false



func _ready():
	$healthbar.visible = false
	detection_icon.visible = false


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


# DAMAGE AND HEALTH ---------------------

func take_damage(damage: int) -> void:
	$healthbar.visible = true
	health -= damage
	health = max(0, health)
	print(health)

	if health <= 0:
		die()


func die():
	queue_free()


func _on_deathbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.invincible:
			return
		energy_manager.spend(15)
		
		
