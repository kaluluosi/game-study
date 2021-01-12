"""
UI 管理器
"""
extends Control

enum MsgType {Info, Warning, Error}

# 层
onready var layers = {
	bottom = $bottom,
	default = $default,
	dialog = $dialog,
	top = $top
}

var navigation_stack = []
var uimap = {}


func alert(title:String, msg:String):
	"""
	警告提示
	"""
	pass
	
func messagebox(msgtype:int, title:String, msg:String):
	"""
	消息盒子
	"""
	pass
	
func show_panel(ui_tscn_path:String):
	if ui_tscn_path in uimap:
		(uimap[ui_tscn_path] as BasePanel).show()
	else:
		var ui:BasePanel = load(ui_tscn_path).instance()
		layers.default.add_child(ui)
	
	if len(navigation_stack) == 0:
		navigation_stack.push_front(
			{
				from=null,
				to=ui_tscn_path
			}
		)
	else:
		var navi_data = navigation_stack[0]
		navigation_stack.push_front(
			{
				from=navi_data.to,
				to=ui_tscn_path
			}
		)
