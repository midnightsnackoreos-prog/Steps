extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func process_movement(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")	
	
	var direction := Input.get_vector("left","right","up","down")
	print(direction)
	if direction.x != 0 || direction.y != 0:
		position += direction * SPEED * delta
	play_animation(direction)

func _physics_process(delta: float) -> void:
	process_movement(delta)
	move_and_slide()

func play_animation(dir:Vector2) -> void:
	if dir.x>0:
		animated_sprite_2d.play("idle_right")
	elif dir.x<0:
		animated_sprite_2d.play("idle_left")
	elif dir.y>0:
		animated_sprite_2d.play("idle_down")
	elif dir.y<0:
		animated_sprite_2d.play("idle_up")
