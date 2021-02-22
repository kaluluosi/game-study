extends StateTranslation
class_name ExpressionStateTranslation

var condition:String setget set_condition
var expression:Expression

func _init(_code:String="true", to_state:String="", mode=SwitchMode.Immediate):
	condition = _code
	to = to_state
	expression = Expression.new()
	var err = expression.parse(_code)
	if err:
		push_error(condition+' 表达式错误 code:'+err) 
	
func set_condition(value):
	condition = value

func is_valid(state) -> bool:
	# 如果条件是空，那么默认为true
	if condition.empty():
		return true
	expression.parse(condition)
	return expression.execute([], state)
