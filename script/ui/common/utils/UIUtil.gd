extends Object
class_name UIUtil

static func debounce(time_sec:float=0.5):
	var timer = Timer.new()
	timer.one_shot = true
	timer.start(time_sec)
	yield(timer, "timeout")

static func messagebox(title:String, msg:String, type) -> MessageBox:
	var msgbox = MessageBox.new(title, msg, type)
	msgbox.show()
	return msgbox

static func pop_hint(msg:String, stay_time_sec:float=0.2) -> PopHint:
	var pophint = PopHint.new(msg, stay_time_sec)
	pophint.show()
	return pophint
