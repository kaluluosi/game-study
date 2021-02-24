extends Node
class_name StateMachinePlayer

"""
状态机播放器
"""

export(Resource) var state_machine setget _set_state_machine
export(NodePath) var target
var _target

func _ready():
	_target = get_node(target)

func _set_state_machine(value):
	state_machine = value
	state_machine.enter(target)

func _physics_process(delta):
	if state_machine and _target:
		state_machine._physics_process(_target, delta)
	
func _process(delta):
	if state_machine and _target:
		state_machine._process(_target,delta)
	
func _unhandled_input(event):
	if state_machine and _target:
		state_machine._unhandled_input(_target, event)
	
func _input(event):
	if state_machine and _target:
		state_machine._input(_target, event)

func set_param(key:String, value):
	state_machine.parameters[key] = value

func set_trigger(key:String):
	state_machine.parameters[key] = null
