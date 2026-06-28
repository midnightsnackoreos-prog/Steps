extends CharacterBody2D

const SPEED = 300.0

var can_move = true

func _physics_process(delta: float) -> void:
	if !can_move:
		velocity = Vector2.ZERO
		#move_and_slide()
		return

	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * SPEED
	move_and_slide()
