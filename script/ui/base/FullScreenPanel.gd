"""
全屏界面，会隐藏其它层的UI
"""

extends BasePanel

var hide_layer_mask:Array = []

func show():
	.show()
	for layer in hide_layer_mask:
		layer.hide()

func hide():
	.hide()
	for layer in hide_layer_mask:
		layer.show()
