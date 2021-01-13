"""
界面基类
"""

extends Object
class_name BasePanel

var UIName:String setget , _get_ui_name
var ui:Control
var layer:Control

func _init():
	print('在_init里面设置UIName')
	pass

func _get_ui_name()->String:
	"""
	获取UI名字 tscn资源路径（相对于asset/ui，不含res：//）
	"""
	return UIName


func show():
	"""
	显示界面
	"""
	if not ui :
		# 如果界面没有加载，那么就加载界面
		var res_path = "res://asset/ui/%s"%UIName
		var tscn = load(res_path)
		ui = tscn.instance() as Control
		ui.connect("ready", self, '_ready')
		ui.connect("tree_entered", self, '_enter_tree')
		ui.connect("tree_exiting", self, '_exiting_tree')
		ui.connect("tree_exited", self, '_exit_tree')

		UiManager.add_ui_to_layer(ui, layer)
	else:
		# 如果界面已加载就显示界面
		ui.show()

func hide():
	"""
	隐藏界面，但是不会销毁ui对象，因此图集资源仍然会在现存里
	"""
	ui.hide()
	
func close():
	"""
	隐藏界面，并释放界面对象和资源
	"""
	hide()
	ui.queue_free()
	
func _ready():
	pass

func _enter_tree():
	pass

func _exit_tree():
	pass

func _exiting_tree():
	pass

func destroy():
	"""
	释放对象
	"""
	ui.queue_free()
	call_deferred('free')
