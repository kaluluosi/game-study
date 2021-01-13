extends BasePanel
class_name TestPanel

var btn:Button

func _init():
	UIName = "TestPanel.tscn"
	layer = UiManager.Layers.base

func _enter_tree():
	btn = ui.get_node("Panel/Button")

func _ready():
	btn.connect('pressed', self, 'hello')

func hello():
	print('hello')
