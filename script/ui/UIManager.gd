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
	base = $default,
	popup = $dialog,
	top = $top
}

enum Layer {bottom, hud, default, popup, top}

func add_ui_to_layer(ui:Control, layer:Control):
	layer.add_child(ui)
