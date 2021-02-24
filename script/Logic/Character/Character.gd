tool
extends KinematicBody2D
class_name Character

export var move_speed:float = 100 setget , _get_move_speed
export var jump_speed:float = 1
export var gravity:float = -1
var velocity:Vector2 #移动速度
var direction:Vector2 #移动方向
var attrs = {}

var _state_machine:StateMachine

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var animation_tree:AnimationTree = $AnimationTree
onready var state_machine_player:StateMachinePlayer = $StateMachinePlayer


func _ready():
	_state_machine = load("res://script/Logic/Character/States/CharactorStateMachine.gd").new()
	_state_machine.name = 'root'
	state_machine_player.state_machine = _state_machine
	scale.x = -1

func _get_configuration_warning():
	if get_node("AnimationPlayer") == null:
		return "Character必须包含一个AnimationPlayer"
	
	if get_node("StateMachinePlayer") == null:
		return "Character必须包含一个StateMachinePlayer"
	
	return ''

func _get_move_speed() -> float:
	# 以后可以改为从attr里面获取move_speed
	return move_speed

func move(_direction:Vector2):
	direction = _direction.normalized()

func facing(_direction:Vector2):
	
	if _direction == Vector2.LEFT:
		scale.x = -1
	elif _direction == Vector2.RIGHT:
		scale.x = 1
