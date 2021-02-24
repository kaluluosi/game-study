extends State

var gravity:int
var friction:float = 0.2

func _init().('motion'):
	pass

func enter(_target:Character):
	if _target.gravity == -1:
		gravity = ProjectSettings.get('physics/2d/default_gravity')
	else:
		gravity = _target.gravity

func _physics_process(target:Character, delta:float):
	target.velocity.y += gravity
	target.velocity.x = target.direction.x * target.move_speed
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)
	target.velocity.x = move_toward(target.velocity.x, 0, friction)

	var animation_tree = target.animation_tree 
	
	animation_tree.set("parameters/conditions/idle", target.velocity.x == 0)
	animation_tree.set("parameters/conditions/walk", target.velocity.x != 0)
	
	target.facing(target.direction)
