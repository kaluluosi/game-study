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

var history = {
	pre=[],
	post=[],
	cur=null
}

func add_ui_to_layer(panel:BasePanel, layer:Control):
	layer.add_child(panel.ui)
	if panel.navitable:
		if history.cur:
			history.pre.push_front(history.cur)
		history.cur = panel
		history.post.clear()

func record(panel):
	history.pre.push_front(history.cur)
	history.cur = panel

func back():
	var post = history.cur as BasePanel
	var panel = history.pre.pop_front()
	history.cur = panel
	history.post.push_front(post)
	post.close()
	panel.show()

