extends State

class_name StateMachine

var states = []

var active_state:State
var entry:State
var exit:State
var any:State

func _init(target=null):
	self.target = target
	
	entry = State.new()
	entry.name = 'entry'
	exit = State.new()
	exit.name = 'exit'
	exit.connect("entered", self, "_finished")
	any = State.new()
	any.name = 'any'
	
	add_state(entry)
	add_state(exit)
	add_state(any)
	active_state = entry
	
func _ready():
	self.target =get_parent()
	
func _finished():
	finished = true
		
func get_active_state():
	return active_state
		
func add_state(state:State):
	if target:
		state.target = target
	state.parameters = parameters
	states.append(state)
	
func _physics_process(delta):
	check_transition()
	active_state._physics_process(delta)
	
func _unhandled_input(event):
	active_state._unhandled_input(event)

func _process(delta):
	active_state._process(delta)

func check_transition():
	"""
	检查转换条件
	"""
	var translations = active_state.translations + any.translations
	for tr in translations:
		if tr.condition.execute([], tr.state):
			active_state = active_state as State
			print(active_state.name, ' -> ', tr.to_state.name)
			active_state.exit()
			active_state = tr.to_state
			active_state.enter()
			
	_flush_trigger_parameters()
			
func _flush_trigger_parameters():
	for param in parameters:
		if parameters[param] == null:
			parameters.erase(param)
