extends KinematicBody2D


var gravity = ProjectSettings.get("physics/2d/default_gravity")
var velocity = Vector2.ZERO
var move_speed = 300
var battle_mode = true
var direction
var state_machine_playback:AnimationNodeStateMachinePlayback
var balance:bool = true setget _set_balance
var hurt:bool = false
var recover:bool = true

signal hit_ground

func _ready():
	state_machine_playback = $AnimationTree["parameters/playback"]

func _physics_process(delta):
	$State.text = state_machine_playback.get_current_node()
	$Position.text = String(velocity)
	
	_handle_move(delta)
	# 假定 F=ma,m=1,F=a,Ft=at=v
	velocity.y += gravity *delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	set_up_animation_tree()

	if is_on_floor():
		emit_signal("hit_ground")
	
func _set_balance(value:bool):
	balance = value
	
func set_up_animation_tree():
	var tree = $AnimationTree
	tree.set("parameters/conditions/in_battle", battle_mode)
	tree.set("parameters/conditions/un_battle", !battle_mode)
	
	if battle_mode:
		tree.set("parameters/motion/conditions/move", abs(direction)>0)
		tree.set("parameters/conditions/move", abs(direction)>0)
		tree.set("parameters/motion/conditions/stop", abs(direction)==0)
		
	tree.set("parameters/conditions/on_ground", is_on_floor())
	
	tree.set("parameters/conditions/falling", velocity.y>100)
	tree.set('parameters/conditions/jump', velocity.y<-10)
	tree.set("parameters/conditions/unbalance", !balance)
	tree.set("parameters/conditions/hurt", hurt)
	tree.set("parameters/conditions/recover", recover)
	tree.set("parameters/conditions/standup", balance)

func _handle_move(delta):
	
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction*move_speed
	
	if Input.is_action_just_pressed("ui_up"):
		jump()
		
	if Input.is_action_just_pressed("ui_down"):
		hurt()

func jump():
	velocity.y -= 800
	
func hurt():
	var timer = get_tree().create_timer(0.5)
	hurt = true
	recover = false
	var hurt_type = ['h1', 'h2']
	var hurt_t = randi()%hurt_type.size()
	$AnimationTree.set("parameters/hurt/Transition/current", hurt_t)
	yield(timer,"timeout")
	hurt = false
	recover = true

func break_balance():
	balance = false
	$AnimationTree["parameters/conditions/standup"] = false
	yield(self, 'hit_ground')
	var timer = get_tree().create_timer(1)
	yield(timer, 'timeout')
	balance = true
	$AnimationTree["parameters/conditions/standup"] = false
