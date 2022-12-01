extends Actor

export var move_range := Vector2()
onready var direction = -1
onready var starting_pos := Vector2(position.x, position.y)

func _physics_process(delta):
	direction = get_direction(direction)
	velocity.x = speed * direction * delta
	
	move_and_slide(velocity, Vector2.UP)
	
 
func get_direction(var direction: float):
	if is_on_wall():
		direction *= -1
		
	elif direction == -1 and position.x - starting_pos.x  < -move_range.x:
		direction = 1
	
	elif direction == 1 and   position.x - starting_pos.x > move_range.x:
		direction = -1
		
	return direction	
