extends AnimatedSprite2D

func _process(delta):
	translate(Vector2(0,-1) * 1000 * delta)
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

pass
	
