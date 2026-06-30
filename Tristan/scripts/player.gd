



#----------------------
#MOVEMENT SECTION
#----------------------

extends CharacterBody2D

const SPEED = 300.0

var can_move = true
var is_attacking=false
var last_direction:Vector2= Vector2.RIGHT

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func process_movement(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")	
	var direction := Input.get_vector("left","right","up","down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction=direction
	else:
		velocity=Vector2.ZERO
	
	if !can_move:
		velocity=Vector2.ZERO
		return
#var direction := Input.get_vector("left","right","up","down")

	#velocity = direction * SPEED
	process_animation(last_direction)

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	process_movement(delta)
	move_and_slide()

func process_animation(direction) -> void:
	if is_attacking:
		return
	if velocity != Vector2.ZERO:
		play_animation ("run", direction)
	else:
		play_animation ("idle", direction)


func play_animation(prefix: String, dir:Vector2) -> void:
	if dir.x>0:
		animated_sprite_2d.play(prefix + "_right")
	elif dir.x<0:
		animated_sprite_2d.play(prefix + "_left")
	elif dir.y>0:
		animated_sprite_2d.play(prefix + "_down")
	elif dir.y<0:
		animated_sprite_2d.play(prefix + "_up")




#----------------------
#ATTACK SECTION
#----------------------

func attack()->void:
	is_attacking=true
	play_animation("attack1", last_direction)
	print("Attack")





func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking=false
