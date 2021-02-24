extends State
class_name StateMachine

export var states = []

var start:State
var end:State
var any:State

var active_state:State
var counter:int # 记录每次从entry开始的次数

func _init():
	start = State.new('start')
	end = State.new('end')
	any = State.new('any')
	
	add_state(start)
	add_state(end)
	add_state(any)
	
	active_state = start # 设置start为 活动状态
	
	end.connect("finished", self, '_on_end_finished')
	start.connect("finished", self, "_on_start_entered")
	
	end.add_translation('start')
	
func enter(target):
	counter = 0
	active_state.enter(target)
	
func _on_start_entered():
	counter += 1
	finished = false
	
func _on_end_finished():
	finished = true
	
func add_state(state:State):
	states.append(state)
	state.parameters = parameters # 共享参数表
	
func exit(target):
	pass

func _physics_process(target, delta):
	_check_translation(target)
	active_state._physics_process(target, delta)
	
func _process(target, delta):
	active_state._process(target, delta)
	
func _unhandled_input(target,event):
	active_state._unhandled_input(target,event)
	
func _input(target,event):
	active_state._input(target, event)

func _flush_triggers():
	# 清理trigger类型条件参数
	for param in parameters:
		if parameters[param] == null:
			parameters.erase(param)

func get_state(name:String) -> State:
	for state in states:
		if state.name == name:
			return state
	
	return null

func _check_translation(target):
	# 转换检查
	var translations = active_state.translations + any.translations
	for tr in translations:
		tr = tr as StateTranslation
		var can_translate = tr.is_valid(target, active_state)
		if tr.mode == StateTranslation.SwitchMode.AtEnd:
			can_translate &= active_state.finished
		
		if can_translate:
			prints(name,':',active_state.name, ' -> ', tr.to)
			active_state.exit(target)
			var next_state = get_state(tr.to)
			active_state = next_state
			active_state.enter(target)
	
	_flush_triggers() # 清理trigger
