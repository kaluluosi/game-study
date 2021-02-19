extends Node
class_name State

signal entered

var target:Node
var translations = [] 
var finished:bool = false
var parameters:Dictionary = {}

func enter():
	finished = false
	emit_signal("entered")
	pass
	
func exit():
	pass
	
func _unhandled_input(event):
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func add_translation(condition:String, to_state:State):
	var expression = Expression.new()
	expression.parse(condition)
	translations.append({
		state=self,
		condition=expression,
		to_state=to_state
	})
