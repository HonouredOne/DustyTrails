extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D

@export var speed = 50
var is_attacking = false

var new_direction : Vector2
var animation : String

func _physics_process(delta):
	var direction: Vector2
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	if Input.is_action_pressed("ui_sprint"):
		speed = 100
	elif Input.is_action_just_released("ui_sprint"):
		speed = 50
	
	var movement = speed * direction * delta
	if is_attacking == false:
		move_and_collide(movement)
		player_animations(direction)
	
	if not Input.is_anything_pressed():
		if is_attacking == false:
			animation = "idle_" + returned_direction(new_direction)

func _input(event):
	if event.is_action_pressed("ui_attack"):
		is_attacking = true
		animation = "attack_" + returned_direction(new_direction)
		animation_sprite.play(animation)

func player_animations(direction : Vector2):
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + returned_direction(new_direction)
		animation_sprite.play(animation)
	else:
		animation = "idle_" + returned_direction(new_direction)
		animation_sprite.play(animation)

func returned_direction(direction : Vector2):
	var normalized_direction = direction.normalized()
	var default_return = "down"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		animation_sprite.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		animation_sprite.flip_h = true
		return "side"
	
	return default_return

func _on_animated_sprite_2d_animation_finished():
	is_attacking = false
