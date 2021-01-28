extends RigidBody2D
class_name Player

export var enable_control:bool = true
export var acc:float = 20 # 移动速度
export var air_acc_damp:float = 0.9 # 空中移动速度，在空中按方向键能够少量调整
export var max_speed:float  = 400 # 最高速度

export var jump_acc:float = 100 # 跳跃速度，按住jump键后会持续增加速度
var _temp_jump_acc:float = jump_acc # 临时跳跃速度
export var jump_damp:float = 0.8 # 跳跃速度衰减，每次增加ump_acc的衰减率
export var max_jump_speed:float = 800 # 最高跳跃速度

var on_ground = false
var climbable = false setget _set_climbable

onready var animated_sprite:AnimatedSprite = $AnimatedSpriteEx
onready var grounded:RayCast2D = $grounded

func _ready():
	connect("body_entered", self, "_body_entered")
	
func _set_climbable(value):
	climbable = value
	
	if !climbable:
		gravity_scale = 1 

func _get_input():
	
	var inputs = {
		right=false,
		left=false,
		down=false,
		jump=false
	}
	if !enable_control:
		return inputs
	
	inputs.right = Input.is_action_pressed("right")
	inputs.left = Input.is_action_pressed("left")
	inputs.down = Input.is_action_pressed("down")
	inputs.jump = Input.is_action_pressed("jump")
	
	return inputs
	
func _check_grounded():
	if grounded.is_colliding():
		on_ground = true
	else:
		on_ground = false
	
	
func _switch_collision(duck:bool = false):
	$BodyCollision.visible = !duck
	$BodyDuckCollision.visible = duck
	
	
func _integrate_forces(state):
	
	var inputs = _get_input()
	_check_grounded()
	
	var linear_v = linear_velocity
	
	if inputs.right and !inputs.down:
		linear_v.x += acc
		linear_v.x = min(linear_v.x, max_speed)
	elif inputs.left and !inputs.down:
		linear_v.x -= acc
		linear_v.x = max(linear_v.x, -max_speed)
		
	if inputs.jump:
		if !climbable:
			linear_v.y -= _temp_jump_acc
			_temp_jump_acc *= jump_damp
			linear_v.y = max(-max_jump_speed, linear_v.y)
		else:
			linear_v = Vector2.ZERO
	
	if inputs.down and on_ground:
		var collider = grounded.get_collider() as Node2D
		if collider and 'one_way_platform' in collider.get_groups():
			add_collision_exception_with(collider)
			yield(get_tree().create_timer(1), "timeout")
			remove_collision_exception_with(collider)
	
	if on_ground:
		_temp_jump_acc = jump_acc
	else:
		linear_v.x = sign(linear_v.x)*abs(linear_v.x)*air_acc_damp
		
	
	linear_velocity = linear_v
	
	if abs(linear_v.x) > 0.5 and on_ground:
		animated_sprite.flip_h = linear_v.x < 0
		
		
	if on_ground:
		if linear_v.x != 0:
			if !inputs.down:
				animated_sprite.play('walk')
				_switch_collision()
			else:
				animated_sprite.play('duck')
				_switch_collision(true)
			animated_sprite.speed_scale = abs(linear_v.x) / max_speed
		else:
			if !inputs.down:
				animated_sprite.play('stand')
				_switch_collision()
			else:
				animated_sprite.play('duck')
				_switch_collision(true)
			animated_sprite.speed_scale = 1
	else:
		animated_sprite.play('jump')

func _process(delta):
	var input = _get_input()
	if input.jump and climbable:
		gravity_scale = 0
		translate(Vector2.UP*200*delta)
	
