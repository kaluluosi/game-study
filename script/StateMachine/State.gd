extends Resource
class_name State

# 状态名字
var name:String

# 条件参数，会被父状态机的parameter覆盖
var parameters:Dictionary = {}

# 结束标志，这个标志主要用于translation里用作跳转条件
var finished:bool setget set_finished,get_finished

# 跳转规则
var translations = []

signal finished

func _init(name:String=''):
	self.name = name
	
func set_finished(value):
	if finished != value and finished==true:
		emit_signal("finished")
	finished = value

func get_finished():
	return finished
	
func enter(target):
	finished = true
	
func exit(target):
	finished = false
	
func add_translation(to_state_name:String, condition:String="finished", mode=StateTranslation.SwitchMode.Immediate):
	var translation = ExpressionStateTranslation.new(condition, to_state_name, mode)
	translations.append(translation)
	
func add_translation_obj(translation:StateTranslation):
	translations.append(translation)
	
func _physics_process(target, delta):
	pass
	
func _process(target, delta):
	pass
	
func _unhandled_input(target,event):
	pass
	
func _input(target, event):
	pass
