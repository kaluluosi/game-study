"""
视图基类
"""

extends Object
class_name BaseView

var UIName:String setget , _get_ui_name
var ui:Control
var layer:Control

signal ready
signal hide
signal close

# 在_init里面设置UIName
func _init():
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
		if not tscn:
			push_error("%s 不存在"%UIName)
			return
		ui = tscn.instance() as Control
		ui.connect("ready", self, '_ready')
		ui.connect("ready", self, 'emit_signal', ['ready'])
		ui.connect("tree_entered", self, '_enter_tree')
		ui.connect("tree_exiting", self, '_exiting_tree')
		ui.connect("tree_exited", self, '_exit_tree')

		UiManager.add_ui_to_layer(self, layer)
		_on_show()
	else:
		# 如果界面已加载就显示界面
		ui.show()
		_on_show()

func hide():
	"""
	隐藏界面，但是不会销毁ui对象，因此图集资源仍然会在现存里
	"""
	if ui:
		ui.hide()
		emit_signal("hide")
	
func close():
	"""
	隐藏界面，并释放界面对象和资源
	"""
	if ui:
		_on_close()
		hide()
		destroy()
		emit_signal("close")
	
func _ready():
	# 这时候ui才初始化完成，必须在这里找控件引用
	pass

func _enter_tree():
	pass

func _exit_tree():
	pass

func _exiting_tree():
	pass
	
func _on_show():
	# ui加入场景树显示后会调用，可以重写做自己的处理
	pass
	
func _on_close():
	# ui被关闭和销毁后会调用
	pass
	

func destroy():
	"""
	释放对象
	由于BaseView是继承自Object的，不属于资源，不会被自动回收。
	"""
	if ui:
		ui.queue_free()
	call_deferred('free')
