extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D

@export var speed = 50

func _physics_process(delta):
	var direction: Vector2
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	var movement = speed * direction * delta
	
	move_and_collide(movement)

func player_animations(direction : Vector2):
	if direction != Vector2.ZERO:
		new_direction = direction
		animation =
		animation_sprite.play(animation)
	else:
		animation = 
		animation_sprite.play(animation)
