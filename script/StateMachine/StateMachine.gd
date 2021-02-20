extends State
class_name StateMachine

var states = {}

var entry:State
var exit:State
var any:State

var active_state:State

func _init():
	entry = State.new(target,'engry')
	exit = State.new(target, 'exit')
	any = State.new(target, 'any')
	
	add_state(entry)
	add_state(exit)
	add_state(any)
	
	exit.connect("finished", self, '_on_finished')
	
func _on_finished():
	finished = true
	
func add_state(state:State):
	states[state.name] = state
	state.target = target
	state.parameters = parameters # 共享参数表
	
func enter():
	active_state = entry
	
func exit():
	pass

func _physics_process(delta):
	_check_translation()
	
	active_state._physics_process(delta)
	
func _process(delta):
	active_state._process(delta)
	
func _unhandled_input(event):
	active_state._unhandled_input(event)
	
func _input(event):
	active_state._input(event)

func _flush_triggers():
	# 清理trigger类型条件参数
	for param in parameters:
		if parameters[param] == null:
			parameters.erase(param)

func _check_translation():
	# 转换检查
	var translations = active_state.translations + any.translations
	for tr in translations:
		
		var can_translate = tr.condition.execute([],self)
		if tr.mode == SwitchMode.AtEnd:
			can_translate &= active_state.finished
		
		if can_translate:
			print(tr.from.state.name, ' -> ', tr.to.state.name)
			active_state.exit()
			active_state = tr.to
			active_state.enter()
	
	_flush_triggers() # 清理trigger
