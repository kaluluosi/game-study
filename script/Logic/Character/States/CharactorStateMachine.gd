extends StateMachine
class_name CharacterStateMachine

var motion_state:State

func _init():
	motion_state = load("res://script/Logic/Character/States/Motion.gd").new()
	add_state(motion_state)
	start.add_translation('motion')
