extends Resource
class_name State

enum SwitchMode{
	Immediate,
	AtEnd
}

var name:String
var parameters:Dictionary = {}
var target:Node2D
var finished:bool setget set_finished,get_finished

var translations = []

signal finished

func _init(target=null, name:String=''):
	self.target = target
	self.name = name
	
func set_finished(value):
	if finished != value and finished==true:
		emit_signal("finished")
	finished = value

func get_finished():
	return finished
	
func enter():
	pass
	
func exit():
	finished = false
	
func add_translation(to:State, condition:String="finished", mode=SwitchMode.Immediate):
	var expression = Expression.new()
	var translation = {
		from=self,
		to=to,
		condition=expression,
		mode=mode
	}
	translations.append(translation)
	
func _physics_process(delta):
	pass
	
func _process(delta):
	pass
	
func _unhandled_input(event):
	pass
	
func _input(event):
	pass
