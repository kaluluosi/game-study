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
	bottom = $bottom,
	hud = $hud,
	base = $base,
	popup = $popup,
	top = $top
}

func add_ui_to_layer(panel:BasePanel, layer:Control):
	layer.add_child(panel.ui)
