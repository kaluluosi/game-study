"""
UI 管理器
"""
"""
UI管理器
[1] 负责插入UI到具体层级
[2] 管理层级的显示
[3] 
"""

extends Control

# 层
onready var Layers = {
	bottom = $Layers/bottom,
	hud = $Layers/hud,
	base = $Layers/base,
	popup = $Layers/popup,
	top = $Layers/top
}

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

var global_value = {}


func add_ui_to_layer(panel:BaseView, layer:Control):
	layer.add_child(panel.ui)

