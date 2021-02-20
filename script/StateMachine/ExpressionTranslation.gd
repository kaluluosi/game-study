extends StateTranslation
class_name ExpressionStateTranslation

var code:String
var expression:Expression

func _init(_code:String, to_state:State):
	code = _code
	to = to_state
	expression = Expression.new()
	var err = expression.parse(_code)
	if err:
		push_error(_code+' 表达式错误 code:'+err) 

func is_valid() -> bool:
	return expression.execute([], from)
