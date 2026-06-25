extends CharacterBody2D

@onready var target=$"../PLAYERPH"
var speed=150
func _physics_process(_delta):
		var direction =(target.position-position).normalized()
		velocity=direction * speed
		look_at(target.position)
		move_and_slide()
func _on_timer_timeout() -> void:
	velocity = Vector2.ZERO
