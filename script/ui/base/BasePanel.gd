"""
界面基类
"""

extends BaseView
class_name BasePanel

var _animation_player:AnimationPlayer

func _init():
	_animation_player = AnimationPlayer.new()
	connect("ready",self, 'ready')
	
func ready():
	ui.add_child(_animation_player)
	
	var _in = load("res://asset/ui/common/animation/ScaleUp.tres") as Animation
	_animation_player.add_animation('_in', _in)
	
	resized()
	ui.connect("resized", self, 'resized')
	
func resized():
	var new_pivot = Vector2(ui.rect_size.x/2, ui.rect_size.y/2)
	ui.rect_pivot_offset = new_pivot

func show():
	.show()
	_animation_player.play('_in')
