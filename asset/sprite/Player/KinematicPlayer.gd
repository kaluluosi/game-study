extends KinematicBody2D

export (int) var run_speed = 400
export (int) var jump_speed = -800
export (int) var gravity = 1200

var velocity = Vector2()
var duck:bool = false

func get_input():
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var down = Input.is_action_pressed("ui_down")
	var jump = Input.is_action_just_pressed("ui_up")

	if jump and is_on_floor():
		velocity.y = jump_speed
	
	if down and is_on_floor():	
		duck = true
		$CollisionShape2D.disabled = true
		return
	else:
		$CollisionShape2D.disabled = false
		duck = false
		
	if right:
		velocity.x = run_speed
	if left:
		velocity.x = -run_speed

func _physics_process(delta):
	velocity.x = lerp(velocity.x, 0, 0.2)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if abs(velocity.x) > run_speed*0.2 and is_on_floor() and !duck:
		$AnimatedSpriteEx.flip_h = velocity.x < 0
		$AnimatedSpriteEx.play('walk')
	else:
		if is_on_floor():
			if !duck:
				$AnimatedSpriteEx.play('stand')
			else:
				$AnimatedSpriteEx.play('duck')
		else:
			$AnimatedSpriteEx.play('jump')
	
func _process(delta):
	get_input()
