



#----------------------
#MOVEMENT SECTION
#----------------------

extends CharacterBody2D

const SPEED = 300.0

var can_move = true
var is_attacking: bool=false
var last_direction:Vector2= Vector2.RIGHT
var hitbox_offset: Vector2
var strength: int=20
var damage:int

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var swing_sword: AudioStreamPlayer2D = $SwingSword
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	hitbox_offset=hitbox.position

func process_movement(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")	
	var direction := Input.get_vector("left","right","up","down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction=direction
		update_hitbox_offset()
	else:
		velocity=Vector2.ZERO
	
	if !can_move:
		velocity=Vector2.ZERO
		return
#var direction := Input.get_vector("left","right","up","down")

	#velocity = direction * SPEED
	process_animation(last_direction)

func _physics_process(delta: float) -> void:
	hitbox.monitoring=false
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	if Input.is_action_just_pressed("attack2") and not is_attacking:
		attack2()
	
	
	if is_attacking:
		velocity=Vector2.ZERO
		return
	
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
	hitbox.monitoring=true
	damage=strength
	swing_sword.play()
	play_animation("attack1", last_direction)
	print("Attack")

func attack2()->void:
	is_attacking=true
	hitbox.monitoring=true
	damage=strength*2
	swing_sword.play()
	play_animation("attack2", last_direction)
	print("Attack2")





func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking=false




#-------------------
#HITBOX
#-------------------

func update_hitbox_offset()->void:
	print(last_direction)

	var r = hitbox_offset.x
	
	hitbox.position = last_direction * r
	#var x := hitbox_offset.x
	#var y := hitbox_offset.y
	#
	#match last_direction:
		#Vector2.LEFT:
			#hitbox.position = Vector2(-x,y)
		#Vector2.RIGHT:
			#hitbox.position = Vector2(x,y)
		#Vector2.UP:
			#hitbox.position = Vector2(y,-x)
		#Vector2.DOWN:
			#hitbox.position = Vector2(-y,x)






func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_attacking and body.name.begins_with("wisp"):
		body.take_damage(damage)
		print(body.take_damage)
