extends Node2D


export(Resource) var test_resource
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class RunState extends State:
	
	func enter(target):
		prints(target.name, 'run')
		finished = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var fsm = StateMachine.new()
	var idle = State.new()
	idle.name = 'idle'
	fsm.add_state(idle)
	fsm.start.add_translation('idle')
	
	var run = RunState.new()
	run.name = 'run'
	fsm.add_state(run)
	idle.add_translation('run')
	
	run.add_translation('end')
	
	$StateMachinePlayer.state_machine = fsm
