extends CharacterBody2D

<<<<<<< Updated upstream
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D
const SPEED = 180
=======
@onready var detection_icon = $DetectionIcon
@onready var detection_timer = $DetectionTimer
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D
const SPEED = 180


>>>>>>> Stashed changes

<<<<<<< Updated upstream
func _physics_process(delta: float) -> void:
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
	move_and_slide()
=======

var speed = 30
var player_chase = false
var player = null
var health: int = 100
var max_health := 100
<<<<<<< Updated upstream
var knockback=Vector2.ZERO
=======
var knockback = Vector2.ZERO

>>>>>>> Stashed changes

func _ready():
	$healthbar.visible = false
	detection_icon.visible = false


func _physics_process(delta):
	global_position += knockback * delta
	knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)
<<<<<<< Updated upstream
	
	global_position += knockback * delta
	knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)
	
=======
>>>>>>> Stashed changes
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
	
func take_damage(damage : int, knockback_force: Vector2) -> void:
	$healthbar.visible = true
	health -= damage
	health = max(0, health)
	print(health)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
	
	knockback=knockback_force
	
>>>>>>> Stashed changes
=======
	
	knockback=knockback_force
		
>>>>>>> Stashed changes
	if health <= 0:
		die()

	knockback=knockback_force


func die():
	queue_free()

	
>>>>>>> Stashed changes
