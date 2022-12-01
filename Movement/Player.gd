extends "res://Actor.gd"

const MAX_JUMP_COUNTER = 2
var jump_counter = MAX_JUMP_COUNTER
export var jump_force = 220
export var gravity = 400

onready var max_screen_size = get_viewport_rect().size

func _physics_process(delta):
	velocity.x = get_move_velocity(velocity) * speed
	velocity.y = get_vertical_velocity(velocity,delta)
	move_and_slide(velocity, Vector2.UP)
	
	if position.y > max_screen_size.y:
		position = Vector2(position.x,0)
		
	if position.x > max_screen_size.x:
		position = Vector2(0,position.y)
		
	if position.x < 0:
		position = Vector2(max_screen_size.x - 1,position.y)
	
func get_move_velocity(move_velocity: Vector2):
	move_velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	return move_velocity.x
	
func get_vertical_velocity(vertical_velocity: Vector2, delta: float):
	print(jump_counter)
	if is_on_floor():
		vertical_velocity.y = 0
		jump_counter = 0
		#print(jump_counter)
	
	if jump_counter <= MAX_JUMP_COUNTER:
		if Input.is_action_just_pressed("jump"):
			jump_counter += 1
			vertical_velocity.y = -jump_force
	
	
		vertical_velocity.y -= jump_force if Input.is_action_just_pressed("jump") else 0
	if !is_on_floor():
		if jump_counter < MAX_JUMP_COUNTER:
			vertical_velocity.y += gravity  * delta
		else:
			vertical_velocity.y += gravity * delta
	
	#if vertical_velocity.y > MAX_VELOCITY:
	#	vertical_velocity.y = MAX_VELOCITY
	
	return vertical_velocity.y
