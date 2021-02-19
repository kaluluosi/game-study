extends KinematicBody2D
class_name Character

export var gravity:float = 800
export var move_speed:float = 400
export var jump_speed:float = 400
var max_jump_times:int = 2
var cur_jump_time:int = 0
var velocity:Vector2 

func _physics_process(delta):
	
	velocity.y += gravity*delta
	velocity.x = lerp(velocity.x, 0, 0.2)

func move(direction:Vector2):
	velocity.x = direction.x
	
func jump():
	cur_jump_time+=1
	if cur_jump_time >= max_jump_times:
		cur_jump_time = 0
		return

	velocity.y -= jump_speed
