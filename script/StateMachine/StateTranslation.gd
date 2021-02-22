extends Resource
class_name StateTranslation


enum SwitchMode{
	Immediate,
	AtEnd
}

var to:String
var mode

func is_valid(state) -> bool:
	return false
	
