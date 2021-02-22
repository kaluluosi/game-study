extends Node
class_name StateMachinePlayer

export(Resource) var state_machine setget set_state_machine
export(NodePath) var target
var _target

func set_state_machine(value):
	state_machine = value
	_target = get_node(target)
	state_machine.enter(_target)

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
