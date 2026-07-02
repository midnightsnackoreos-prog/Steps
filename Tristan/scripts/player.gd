extends CharacterBody2D

#----------------------
# MOVEMENT SECTION
#----------------------

const SPEED = 300.0

var can_move = true
var is_attacking: bool = false
var last_direction: Vector2 = Vector2.RIGHT
var hitbox_offset: Vector2
var strength: int = 20
var damage: int
var health:= 100.0
var invincible = false


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var swing_sword: AudioStreamPlayer2D = $SwingSword
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	hitbox_offset = hitbox.position


func process_movement(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
		update_hitbox_offset()
	else:
		velocity = Vector2.ZERO

	if !can_move:
		velocity = Vector2.ZERO
		return

	process_animation(last_direction)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

	if Input.is_action_just_pressed("attack2") and not is_attacking:
		attack2()

	if is_attacking:
		velocity = Vector2.ZERO
		return

	process_movement(delta)
	move_and_slide()


func process_animation(direction) -> void:
	if is_attacking:
		return

	if velocity != Vector2.ZERO:
		play_animation("run", direction)
	else:
		play_animation("idle", direction)


func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play(prefix + "_right")
	elif dir.x < 0:
		animated_sprite_2d.play(prefix + "_left")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")


#----------------------
# ATTACK SECTION
#----------------------

func attack() -> void:
	is_attacking = true
	hitbox.monitoring = true
	damage = strength
	swing_sword.play()
	play_animation("attack1", last_direction)


func attack2() -> void:
	is_attacking = true
	hitbox.monitoring = true
	damage = strength * 2
	swing_sword.play()
	play_animation("attack2", last_direction)


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking = false
		hitbox.monitoring = false


#-------------------
# HITBOX
#-------------------

func update_hitbox_offset() -> void:
	var r = hitbox_offset.x
	hitbox.position = last_direction * r


func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if is_attacking and body.name.begins_with("wisp"):
		body.take_damage(damage)
