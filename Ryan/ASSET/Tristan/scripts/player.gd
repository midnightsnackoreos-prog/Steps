extends CharacterBody2D

const SPEED = 300.0

func _process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")	
	
	var direction := Input.get_vector("left","right","up","down")
	if direction.x != 0 || direction.y != 0:
		position += direction * SPEED * delta
